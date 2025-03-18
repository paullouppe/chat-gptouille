import asyncio
import ollama
import numpy as np
import os
from tqdm import tqdm
from sklearn.metrics.pairwise import cosine_similarity

from sqlalchemy.orm import Session
from ..models.recipe import Recipe

EMBEDDING_PATH = "C:\\Users\\paull\\Documents\\CODE\\chat-gptouille\\api\\app\\services\\temp\\embedding.npy"

EMBEDDING_MODEL_NAME = "all-minilm"
CONVERSATIONAL_MODEL_NAME = "qwen2.5"
SYSTEM_PROMPT_RAG = """You are an intelligent and friendly recipe assistant.
You **must** use the provided recipe context to answer the user. If you are asked about something that isn't present in the context, say you don't have enough information.
Your output should be short and containing the title of the proposed recipe, its ingredients in form of an inline list, and the cooking time in minutes.
Context:\n
"""

def embed(query):
    return ollama.embeddings(model=EMBEDDING_MODEL_NAME, prompt=query).embedding

def load_or_build_embeddings_from_recipes(embedding_path, recipes):
    if os.path.exists(embedding_path):
        print(f"Loading embeddings from {embedding_path}...")
        embeddings = np.load(embedding_path, allow_pickle=True)
    else:
        print(f"Embeddings not found at {embedding_path}, creating new ones...")
        embeddings = []
        for recipe in tqdm(recipes, desc="Building embeddings"):
            # Build a string representation from the recipe object.
            # Ingredients and steps are joined if they exist.
            ingredients_str = ", ".join(recipe.ingredients) if recipe.ingredients else ""
            steps_str = " ".join(recipe.steps) if recipe.steps else ""
            text = (
                f"Name: {recipe.name}. "
                f"Cooking time: {recipe.minutes} minutes. "
                f"Description: {recipe.description}. "
                f"Ingredients: {ingredients_str}. "
                f"Steps: {steps_str}."
            )
            try:
                emb = embed(text)
                embeddings.append(emb)
            except Exception as e:
                print(f"Error processing recipe id {recipe.id}: {e}")
        embeddings = np.array(embeddings)
        np.save(embedding_path, embeddings)
        print(f"Embeddings saved to {embedding_path}.")
    return embeddings

def retriever(embedded_query, embeddings, recipes, top_k=5):
    try:
        similarities = cosine_similarity([embedded_query], embeddings)[0]
        top_k_indices = similarities.argsort()[::-1][:top_k]
        top_k_recipes = []
        for idx in top_k_indices:
            recipe = recipes[idx]
            ingredients = ", ".join(recipe.ingredients) if recipe.ingredients else ""
            top_k_recipes.append({
                "name": recipe.name,
                "minutes": recipe.minutes,
                "description": recipe.description,
                "ingredients": ingredients,
            })
        return top_k_recipes
    except Exception as e:
        print(f"Error during search: {e}")
        return []

def _ollama_stream(query, embeddings, recipes):
    embedded_query = embed(query)
    most_similar_chunks = retriever(embedded_query, embeddings, recipes)
    system_msg = SYSTEM_PROMPT_RAG + "\n".join(
        [
            f"Recipe: {chunk['name']} Ingredients: {chunk['ingredients']} Cooking time: {chunk['minutes']}"
            for chunk in most_similar_chunks
        ]
    )

    response = ollama.chat(
        model=CONVERSATIONAL_MODEL_NAME,
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": query},
        ],
        stream=True,
    )
    return response

async def _async_chunk_generator(query, embeddings, recipes):
    loop = asyncio.get_running_loop()
    sync_gen = _ollama_stream(query, embeddings, recipes)
    while True:
        chunk = await loop.run_in_executor(None, lambda: next(sync_gen, None))
        if chunk is None:
            break
        text = chunk.message.content 
        yield text

class RAG:
    def __init__(self):
        self.embeddings = None
        self.recipes = []

    def load(self, db: Session):
        self.recipes = db.query(Recipe).all()
        self.embeddings = load_or_build_embeddings_from_recipes(EMBEDDING_PATH, self.recipes)

    def ask(self, question):
        return _async_chunk_generator(question, self.embeddings, self.recipes)
