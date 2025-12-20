from typing import Optional
from pydantic import BaseModel, Field
from datetime import datetime

class ApiKeyBase(BaseModel):
    service_name: str = Field(..., description="e.g., GEMINI_API_KEY, WEATHER_API_KEY")
    api_key_value: str
    is_active: bool = True

class ApiKeyCreate(ApiKeyBase):
    pass

class ApiKeyUpdate(BaseModel):
    api_key_value: Optional[str] = None
    is_active: Optional[bool] = None

class ApiKey(ApiKeyBase):
    id: int
    updated_by_id: Optional[int] = None
    updated_at: datetime

    class Config:
        from_attributes = True
