from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

from ..db import get_db
from ..models.recipe import Recipe

router = APIRouter(
    prefix="/recipes",
    tags=["recipes"]
)

# -------------------------------
# Pydantic Schemas for Recipes
# -------------------------------
class RecipeBase(BaseModel):
    name: Optional[str] = None
    minutes: Optional[int] = None
    steps: Optional[List[str]] = None
    description: Optional[str] = None
    ingredients: Optional[List[str]] = None

class RecipeCreate(RecipeBase):
    pass

class RecipeUpdate(RecipeBase):
    pass

class RecipeOut(RecipeBase):
    id: int
    created_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class RecipeSearch(BaseModel):
    name: str
    n: Optional[int] = 10

# -------------------------------
# CRUD Endpoints for Recipes
# -------------------------------
@router.post("/", response_model=RecipeOut)
def create_recipe(recipe: RecipeCreate, db: Session = Depends(get_db)):
    new_recipe = Recipe(
        name=recipe.name,
        minutes=recipe.minutes,
        steps=recipe.steps,
        description=recipe.description,
        ingredients=recipe.ingredients,
    )
    db.add(new_recipe)
    db.commit()
    db.refresh(new_recipe)
    return new_recipe

@router.get("/", response_model=List[RecipeOut])
def get_all_recipes(db: Session = Depends(get_db)):
    try:
        recipes = db.query(Recipe).all()
        if not recipes:
            return []
        
        # Add logging to see what we're getting from the database
        for recipe in recipes:
            if recipe.name is None:
                print(f"Warning: Recipe with ID {recipe.id} has None name")
            if recipe.description is None:
                print(f"Warning: Recipe with ID {recipe.id} has None description")
        
        return recipes
    except Exception as e:
        print(f"Error in get_all_recipes: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/{id}", response_model=RecipeOut)
def get_recipe(id: int, db: Session = Depends(get_db)):
    recipe = db.query(Recipe).filter(Recipe.id == id).first()
    if not recipe:
        raise HTTPException(status_code=404, detail="Recipe not found")
    return recipe

@router.put("/{id}", response_model=RecipeOut)
def update_recipe(id: int, updated_recipe: RecipeCreate, db: Session = Depends(get_db)):
    recipe = db.query(Recipe).filter(Recipe.id == id).first()
    if not recipe:
        raise HTTPException(status_code=404, detail="Recipe not found")
    
    for key, value in updated_recipe.dict(exclude_unset=True).items():
        setattr(recipe, key, value)

    db.commit()
    db.refresh(recipe)
    return recipe

@router.patch("/{id}", response_model=RecipeOut)
def partial_update_recipe(id: int, recipe_update: RecipeUpdate, db: Session = Depends(get_db)):
    recipe = db.query(Recipe).filter(Recipe.id == id).first()
    if not recipe:
        raise HTTPException(status_code=404, detail="Recipe not found")
    
    for key, value in recipe_update.dict(exclude_unset=True).items():
        if value is not None:
            setattr(recipe, key, value)

    db.commit()
    db.refresh(recipe)
    return recipe

@router.delete("/{id}")
def delete_recipe(id: int, db: Session = Depends(get_db)):
    recipe = db.query(Recipe).filter(Recipe.id == id).first()
    if not recipe:
        raise HTTPException(status_code=404, detail="Recipe not found")
    db.delete(recipe)
    db.commit()
    return {"detail": "Recipe deleted successfully"}

@router.post("/search", response_model=List[RecipeOut])
def search_recipes(search: RecipeSearch, db: Session = Depends(get_db)):
    recipes = db.query(Recipe).filter(Recipe.name.ilike(f"%{search.name}%")).limit(search.n).all()
    
    if not recipes:
        raise HTTPException(status_code=404, detail="No recipes found with the given name")
    
    return recipes