import asyncio
from ollama import Client
from tqdm import tqdm
from sqlalchemy.orm import Session
from sqlalchemy import text

from ..models.recipe import Recipe

EMBEDDING_MODEL_NAME = "all-minilm"
CONVERSATIONAL_MODEL_NAME = "qwen2.5"
SYSTEM_PROMPT_RAG = """You are an intelligent and friendly recipe assistant.
You **must** use the provided recipe context to answer the user. If you are asked about something that isn't present in the context, say you don't have enough information.
Your output should be about only one of the provided recipe in the context. 
The message should be containing : 
- A short and engaging message
- The title of the proposed recipe
- Its ingredients in an inline list
- The cooking time in minutes
Context:\n
"""


client = Client(
    host='http://host.docker.internal:11434/'
)


def embed(query: str):
    return client.embeddings(model=EMBEDDING_MODEL_NAME, prompt=query).embedding


def update_recipe_embeddings(db: Session, recipes):
    print("Updating recipe embeddings in the database...")
    for recipe in tqdm(recipes, desc="Updating embeddings"):
        if recipe.embedding is None:
            ingredients_str = ", ".join(recipe.ingredients) if recipe.ingredients else ""
            steps_str = " ".join(recipe.steps) if recipe.steps else ""
            text_input = (
                f"Name: {recipe.name}. "
                f"Cooking time: {recipe.minutes} minutes. "
                f"Description: {recipe.description}. "
                f"Ingredients: {ingredients_str}. "
                f"Steps: {steps_str}."
            )
            try:
                recipe.embedding = embed(text_input)
            except Exception as e:
                print(f"Error processing recipe id {recipe.id}: {e}")
    db.commit()


def get_similar_recipes(db: Session, query: str, top_k=5):
    query_embedding = embed(query)
    sql = text("""
        SELECT *
        FROM recipes
        WHERE embedding IS NOT NULL
        ORDER BY embedding <=> CAST(:query_embedding AS vector)
        LIMIT :top_k
    """)
    results = db.execute(sql, {"query_embedding": query_embedding, "top_k": top_k}).fetchall()
    similar_recipes = []
    for row in results:
        ingredients = ", ".join(row.ingredients) if row.ingredients else ""
        similar_recipes.append({
            "name": row.name,
            "minutes": row.minutes,
            "description": row.description,
            "ingredients": ingredients,
        })
    return similar_recipes


def _ollama_stream(query: str, db: Session):
    similar_recipes = get_similar_recipes(db, query)
    system_msg = SYSTEM_PROMPT_RAG + "\n".join(
        [
            f"Recipe: {chunk['name']} Ingredients: {chunk['ingredients']} Cooking time: {chunk['minutes']}"
            for chunk in similar_recipes
        ]
    )
    response = client.chat(
        model=CONVERSATIONAL_MODEL_NAME,
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": query},
        ],
        stream=True,
    )
    return response


async def _async_chunk_generator(query: str, db: Session):
    loop = asyncio.get_running_loop()
    sync_gen = _ollama_stream(query, db)
    while True:
        chunk = await loop.run_in_executor(None, lambda: next(sync_gen, None))
        if chunk is None:
            break
        text = chunk.message.content
        yield text


class RAG:
    def load(self, db: Session):
        recipes = db.query(Recipe).all()
        update_recipe_embeddings(db, recipes)

    def ask(self, question: str, db: Session):
        return _async_chunk_generator(question, db)
