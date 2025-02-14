import os
import sqlalchemy as sa
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine, Column, Integer, String, Table

# Retrieve the database URL from your environment variables
DB_URL = os.getenv("DATABASE_URL")

# Create the engine and session
engine = create_engine(DB_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Association table for the many-to-many relationship between users and diets
user_diets = Table(
    "user_diets",
    Base.metadata,
    Column("user_id", Integer, sa.ForeignKey("users.id"), primary_key=True),
    Column("diet_id", Integer, sa.ForeignKey("diets.id"), primary_key=True)
)

# Association table for the many-to-many relationship between users and equipments
user_equipments = Table(
    "user_equipments",
    Base.metadata,
    Column("user_id", Integer, sa.ForeignKey("users.id"), primary_key=True),
    Column("equipment_id", Integer, sa.ForeignKey("equipments.id"), primary_key=True)
)

# Define the User model
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    mail = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    
    # Many-to-many relationships
    diets = relationship("Diet", secondary=user_diets, back_populates="users")
    equipments = relationship("Equipment", secondary=user_equipments, back_populates="users")

# Define the Diet model
class Diet(Base):
    __tablename__ = "diets"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    label = Column(String, unique=True, nullable=False)
    
    # Relationship back to users
    users = relationship("User", secondary=user_diets, back_populates="diets")

# Define the Equipment model
class Equipment(Base):
    __tablename__ = "equipments"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    label = Column(String, unique=True, nullable=False)
    
    # Relationship back to users
    users = relationship("User", secondary=user_equipments, back_populates="equipments")

Base.metadata.create_all(engine)
