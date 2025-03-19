from sqlalchemy import Column, Integer, String, DateTime, Text, func
from sqlalchemy.dialects.postgresql import ARRAY
from pgvector.sqlalchemy import Vector  
from ..database import Base

class Recipe(Base):
    __tablename__ = "recipes"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable=True)
    minutes = Column(Integer, nullable=True)
    created_at = Column(DateTime, server_default=func.now(), nullable=True)
    steps = Column(ARRAY(String), nullable=True)
    description = Column(Text, nullable=True)
    ingredients = Column(ARRAY(String), nullable=True)
    embedding = Column(Vector(384), nullable=True)