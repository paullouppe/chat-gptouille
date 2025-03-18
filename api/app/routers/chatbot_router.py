from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

from ..services.rag import RAG
from ..db import get_db
from ..models.recipe import Recipe

router = APIRouter(
    prefix="/chat",
    tags=["chat"]
)

# -------------------------------
# Pydantic Schema for Chat Request
# -------------------------------
class ChatRequest(BaseModel):
    user_message: str

rag = RAG()

@router.get("/load")
def load(db: Session = Depends(get_db)):
    rag.load(db)
    return {"response": "RAG loaded successfully"}


@router.post("/")
def chat(request: ChatRequest, db: Session = Depends(get_db)):
    user_message = request.user_message
    response_stream = rag.ask(user_message)

    return {"response": response_stream}
