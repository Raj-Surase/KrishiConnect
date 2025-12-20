from typing import Optional
from datetime import datetime, date
from pydantic import BaseModel, Field

# --- Crop Schemas ---
class CropBase(BaseModel):
    name: str = Field(..., max_length=255)
    image_url: Optional[str] = Field(None, max_length=512)
    details: Optional[str] = None
    context: Optional[str] = None # Context for AI advisory

class CropCreate(CropBase):
    pass

class CropUpdate(CropBase):
    pass

class Crop(CropBase):
    id: int
    
    class Config:
        from_attributes = True

# --- Government Scheme Schemas ---
class GovernmentSchemeBase(BaseModel):
    title: str = Field(..., max_length=512)
    link: str = Field(..., max_length=512)
    image_url: Optional[str] = Field(None, max_length=512)
    description: Optional[str] = None
    region: str = Field("Maharashtra", max_length=255)

class GovernmentSchemeCreate(GovernmentSchemeBase):
    pass

class GovernmentSchemeUpdate(GovernmentSchemeBase):
    pass

class GovernmentScheme(GovernmentSchemeBase):
    id: int
    created_by_id: int
    created_at: datetime

    class Config:
        from_attributes = True

# --- Market Rate Schemas ---
class MarketRateBase(BaseModel):
    crop_id: int
    location: str = Field(..., max_length=255)
    date: date
    min_price: float = Field(..., gt=0)
    max_price: float = Field(..., gt=0)
    expected_price: Optional[float] = Field(None, gt=0)
    unit: str = Field("Quintal", max_length=50)

class MarketRateCreate(MarketRateBase):
    pass

class MarketRateUpdate(MarketRateBase):
    pass

class MarketRate(MarketRateBase):
    id: int
    created_by_id: int
    created_at: datetime

    class Config:
        from_attributes = True
