from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.utils.dependencies import get_current_admin_user
from app.services import content_service
from app.db.models import (
    User,
    Crop as CropModel,
    GovernmentScheme as GovernmentSchemeModel,
    MarketRate as MarketRateModel,
)
from app.api.v1.schemas.content import (
    Crop as CropSchema,
    CropCreate,
    CropUpdate,
    GovernmentScheme as GovernmentSchemeSchema,
    GovernmentSchemeCreate,
    GovernmentSchemeUpdate,
    MarketRate as MarketRateSchema,
    MarketRateCreate,
    MarketRateUpdate,
)


router = APIRouter()

# --- Admin Status ---
@router.get("/status")
def admin_status(current_user: User = Depends(get_current_admin_user)):
    return {"message": f"Welcome Admin: {current_user.username}", "role": current_user.role}

# --- Crop Management ---
@router.post("/crops", response_model=CropSchema)
def create_new_crop(
    crop_in: CropCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_crop = content_service.get_crop(db, crop_id=None) # Check for existing crop name is handled by DB unique constraint
    try:
        return content_service.create_crop(db, crop_in)
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error creating crop: {e}")

@router.put("/crops/{crop_id}", response_model=CropSchema)
def update_existing_crop(
    crop_id: int,
    crop_in: CropUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_crop = content_service.get_by_id(db, CropModel, crop_id)
    if not db_crop:
        raise HTTPException(status_code=404, detail="Crop not found")
    return content_service.update_crop(db, db_crop, crop_in)

@router.delete("/crops/{crop_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_crop(
    crop_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_crop = content_service.get_by_id(db, CropModel, crop_id)
    if not db_crop:
        raise HTTPException(status_code=404, detail="Crop not found")
    content_service.delete_item(db, db_crop)
    return

# --- Government Scheme Management ---
@router.post("/schemes", response_model=GovernmentSchemeSchema)
def create_new_scheme(
    scheme_in: GovernmentSchemeCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    return content_service.create_scheme(db, scheme_in, current_user.id)

@router.put("/schemes/{scheme_id}", response_model=GovernmentSchemeSchema)
def update_existing_scheme(
    scheme_id: int,
    scheme_in: GovernmentSchemeUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_scheme = content_service.get_by_id(db, GovernmentSchemeModel, scheme_id)
    if not db_scheme:
        raise HTTPException(status_code=404, detail="Scheme not found")
    return content_service.update_scheme(db, db_scheme, scheme_in)

@router.delete("/schemes/{scheme_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_scheme(
    scheme_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_scheme = content_service.get_by_id(db, GovernmentSchemeModel, scheme_id)
    if not db_scheme:
        raise HTTPException(status_code=404, detail="Scheme not found")
    content_service.delete_item(db, db_scheme)
    return

# --- Market Rate Management ---
@router.post("/market_rates", response_model=MarketRateSchema)
def create_new_market_rate(
    rate_in: MarketRateCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    # Optional: Check if crop_id exists
    db_crop = content_service.get_by_id(db, CropModel, rate_in.crop_id)
    if not db_crop:
        raise HTTPException(status_code=404, detail="Crop not found")
        
    return content_service.create_market_rate(db, rate_in, current_user.id)

@router.put("/market_rates/{rate_id}", response_model=MarketRateSchema)
def update_existing_market_rate(
    rate_id: int,
    rate_in: MarketRateUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_rate = content_service.get_by_id(db, MarketRateModel, rate_id)
    if not db_rate:
        raise HTTPException(status_code=404, detail="Market Rate not found")
    
    # Optional: Check if crop_id exists if it's being updated
    if rate_in.crop_id:
        db_crop = content_service.get_by_id(db, CropModel, rate_in.crop_id)
        if not db_crop:
            raise HTTPException(status_code=404, detail="Crop not found")
            
    return content_service.update_market_rate(db, db_rate, rate_in)

@router.delete("/market_rates/{rate_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_market_rate(
    rate_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    db_rate = content_service.get_by_id(db, MarketRateModel, rate_id)
    if not db_rate:
        raise HTTPException(status_code=404, detail="Market Rate not found")
    content_service.delete_item(db, db_rate)
    return
