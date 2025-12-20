from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime

class UserBase(BaseModel):
    username: str
    role: str = Field(..., pattern="^(farmer|admin)$")

class UserCreate(UserBase):
    password: str

class UserInDBBase(UserBase):
    id: Optional[int] = None
    is_active: bool = True
    created_at: datetime

    class Config:
        from_attributes = True

class User(UserInDBBase):
    pass

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class TokenData(BaseModel):
    username: Optional[str] = None
    role: Optional[str] = None # Added role to token data for easy access control
