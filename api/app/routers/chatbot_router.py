from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from fastapi.responses import StreamingResponse

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
async def chat(request: ChatRequest, db: Session = Depends(get_db)):
    generator = rag.ask(request.user_message, db)
    return StreamingResponse(generator, media_type="text/plain")
