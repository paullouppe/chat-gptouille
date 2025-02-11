from fastapi import FastAPI, Response, APIRouter, HTTPException, Depends
from typing import Union

from sqlalchemy.orm import Session

from typing import List

from ..db import get_db

from datetime import datetime

router = APIRouter(
    prefix="/users",
    tags=["users"]
)


@router.post("/")
def create_item(db: Session = Depends(get_db)):
    # """
    # Création d'un item
    # """
    # try:
    #     return {"message": "To do"}
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=500)
    pass


# @router.get("/", response_model=List[Pizza])
def get_all_items(db: Session = Depends(get_db), name: str = None):
    # """
    # Lecture de tous les items
    # """
    # try:
    #     if name != None:
    #         return db.query(PizzaEntity).filter(PizzaEntity.name.ilike('%'+name+'%'))

    #     else:
    #         return db.query(PizzaEntity).all()
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=500)
    pass


# @router.get("/{id}", response_model=Pizza)
def get_one_item(id: int, db: Session = Depends(get_db)):
    # """
    # Lecture d'un item sélectionné selon son id
    # """
    # try:
    #     pizza = db.query(PizzaEntity).filter(PizzaEntity.id == id).first()
    #     if not pizza:
    #         raise HTTPException(status_code=404, detail="Pizza not found")
    #     else:
    #         return pizza
    # except Exception as e:
    #     print(e)
    #     if e.__eq__("404: Pizza not found"):
    #         raise e
    #     else:
    #         raise HTTPException(status_code=500)
    pass


@router.put("/{id}")
def update_item(id: int, db: Session = Depends(get_db)):
    # """
    # Mise à jour complète d'un item sélectionné selon son id
    # """
    # try:
    #     return {"message": "To do"}
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=500)
    pass

@router.patch("/{id}")
def update_item(id: int, db: Session = Depends(get_db)):
    # """
    # Mise à jour partielle d'un item sélectionné selon son id
    # """
    # try:
    #     return {"message": "To do"}
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=500)
    pass

@router.delete("/{id}")
def update_item(id: int, db: Session = Depends(get_db)):
    # """
    # Suppression d'un item sélectionné selon son id
    # """
    # try:
    #     return {"message": "To do"}
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(status_code=500)
    pass