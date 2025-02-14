import os
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Column, Integer, String, DateTime, Text, func, create_engine
from sqlalchemy.dialects.postgresql import ARRAY

DB_URL = os.getenv("DATABASE_URL")

# Create the engine and session
engine = create_engine(DB_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

class Recipe(Base):
    __tablename__ = "recipes"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    name = Column(String, nullable=False, unique=True)
    minutes = Column(Integer, nullable=False)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)
    steps = Column(ARRAY(String), nullable=False)
    description = Column(Text, nullable=False)
    ingredients = Column(ARRAY(String), nullable=False)


Base.metadata.create_all(engine)