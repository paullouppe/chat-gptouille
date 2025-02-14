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
    name: str
    minutes: int
    steps: List[str]
    description: str
    ingredients: List[str]

class RecipeCreate(RecipeBase):
    pass

class RecipeUpdate(BaseModel):
    name: Optional[str] = None
    minutes: Optional[int] = None
    steps: Optional[List[str]] = None
    description: Optional[str] = None
    ingredients: Optional[List[str]] = None

class RecipeOut(RecipeBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True

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
    recipes = db.query(Recipe).all()
    return recipes

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
    
    # Full update
    recipe.name = updated_recipe.name
    recipe.minutes = updated_recipe.minutes
    recipe.steps = updated_recipe.steps
    recipe.description = updated_recipe.description
    recipe.ingredients = updated_recipe.ingredients

    db.commit()
    db.refresh(recipe)
    return recipe

@router.patch("/{id}", response_model=RecipeOut)
def partial_update_recipe(id: int, recipe_update: RecipeUpdate, db: Session = Depends(get_db)):
    recipe = db.query(Recipe).filter(Recipe.id == id).first()
    if not recipe:
        raise HTTPException(status_code=404, detail="Recipe not found")
    
    if recipe_update.name is not None:
        recipe.name = recipe_update.name
    if recipe_update.minutes is not None:
        recipe.minutes = recipe_update.minutes
    if recipe_update.steps is not None:
        recipe.steps = recipe_update.steps
    if recipe_update.description is not None:
        recipe.description = recipe_update.description
    if recipe_update.ingredients is not None:
        recipe.ingredients = recipe_update.ingredients

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
