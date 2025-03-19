import os
from datetime import datetime, timedelta, timezone
from typing import List, Optional

import jwt
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from passlib.context import CryptContext

from ..db import get_db
from ..models.user import User 

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

# -------------------------------------------------
# Password Hashing & JWT Settings
# -------------------------------------------------
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

# TODO : make this key in env
SECRET_KEY = os.getenv("SECRET_KEY", "your_secret_key")  
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    """Generates a JWT token."""
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# -------------------------------------------------
# Pydantic Schemas
# -------------------------------------------------
class UserBase(BaseModel):
    mail: str
    name: str

class UserCreate(UserBase):
    name: str
    mail: str
    password: str

class UserLogin(BaseModel):
    mail: str
    password: str

class UserUpdate(BaseModel):
    mail: Optional[str] = None
    password: Optional[str] = None

class UserOut(UserBase):
    id: int

    class Config:
        orm_mode = True

# -------------------------------------------------
# Authentication Endpoints
# -------------------------------------------------
@router.post("/signup", response_model=UserOut)
def signup(user: UserCreate, db: Session = Depends(get_db)):
    """
    Register a new user.
    """
    # Check if the email is already registered.
    existing_user = db.query(User).filter(User.mail == user.mail).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Create a new user with a hashed password.
    hashed_password = get_password_hash(user.password)
    new_user = User(name=user.name, mail=user.mail, password=hashed_password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.post("/login")
def login(credentials: UserLogin, db: Session = Depends(get_db)):
    """
    Authenticate a user and return a JWT token.
    """
    user = db.query(User).filter(User.mail == credentials.mail).first()
    if not user or not verify_password(credentials.password, user.password):
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": str(user.id), "mail": user.mail},
        expires_delta=access_token_expires 
    )
    return {"access_token": access_token, "token_type": "bearer", "mail":user.mail, "name":user.name, "id":user.id}

@router.post("/logout")
def logout():
    """
    Dummy logout endpoint. With JWT, logout is typically handled
    client-side by discarding the token.
    """
    return {"detail": "Successfully logged out"}

# -------------------------------------------------
# CRUD Endpoints (Optional)
# -------------------------------------------------
@router.get("/", response_model=List[UserOut])
def get_all_users(mail: Optional[str] = None, db: Session = Depends(get_db)):
    """
    Retrieve all users. Optionally filter by email.
    """
    query = db.query(User)
    if mail:
        query = query.filter(User.mail.ilike(f"%{mail}%"))
    return query.all()

@router.get("/{id}", response_model=UserOut)
def get_one_user(id: int, db: Session = Depends(get_db)):
    """
    Retrieve a user by ID.
    """
    user = db.query(User).filter(User.id == id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

@router.put("/{id}", response_model=UserOut)
def update_user(id: int, updated_user: UserCreate, db: Session = Depends(get_db)):
    """
    Fully update a user.
    """
    user = db.query(User).filter(User.id == id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    user.mail = updated_user.mail
    user.password = get_password_hash(updated_user.password)
    db.commit()
    db.refresh(user)
    return user

@router.patch("/{id}", response_model=UserOut)
def partial_update_user(id: int, user_update: UserUpdate, db: Session = Depends(get_db)):
    """
    Partially update a user.
    """
    user = db.query(User).filter(User.id == id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if user_update.mail is not None:
        user.mail = user_update.mail
    if user_update.password is not None:
        user.password = get_password_hash(user_update.password)
    db.commit()
    db.refresh(user)
    return user

@router.delete("/{id}")
def delete_user(id: int, db: Session = Depends(get_db)):
    """
    Delete a user by ID.
    """
    user = db.query(User).filter(User.id == id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    db.delete(user)
    db.commit()
    return {"detail": "User deleted successfully"}
