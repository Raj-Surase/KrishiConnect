from typing import List, Optional
from sqlalchemy.orm import Session
from app.db.models import Crop, GovernmentScheme, MarketRate, User
from app.api.v1.schemas.content import CropCreate, CropUpdate, GovernmentSchemeCreate, GovernmentSchemeUpdate, MarketRateCreate, MarketRateUpdate

# --- Generic CRUD Functions ---

def get_all(db: Session, model, skip: int = 0, limit: int = 100):
    return db.query(model).offset(skip).limit(limit).all()

def get_by_id(db: Session, model, id: int):
    return db.query(model).filter(model.id == id).first()

def create_item(db: Session, model, item_in, creator_id: int):
    db_item = model(**item_in.model_dump(), created_by_id=creator_id)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def update_item(db: Session, model, db_item, item_in):
    update_data = item_in.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_item, key, value)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def delete_item(db: Session, db_item):
    db.delete(db_item)
    db.commit()

# --- Specific CRUD Wrappers ---

# Crops
def get_crops(db: Session, skip: int = 0, limit: int = 100) -> List[Crop]:
    return get_all(db, Crop, skip, limit)

def get_crop(db: Session, crop_id: int) -> Optional[Crop]:
    return get_by_id(db, Crop, crop_id)

def create_crop(db: Session, crop: CropCreate) -> Crop:
    db_crop = Crop(**crop.model_dump())
    db.add(db_crop)
    db.commit()
    db.refresh(db_crop)
    return db_crop

def update_crop(db: Session, db_crop: Crop, crop_in: CropUpdate) -> Crop:
    update_data = crop_in.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_crop, key, value)
    db.add(db_crop)
    db.commit()
    db.refresh(db_crop)
    return db_crop

# Schemes
def get_schemes(db: Session, skip: int = 0, limit: int = 100) -> List[GovernmentScheme]:
    return get_all(db, GovernmentScheme, skip, limit)

def create_scheme(db: Session, scheme: GovernmentSchemeCreate, creator_id: int) -> GovernmentScheme:
    return create_item(db, GovernmentScheme, scheme, creator_id)

def update_scheme(db: Session, db_scheme: GovernmentScheme, scheme_in: GovernmentSchemeUpdate) -> GovernmentScheme:
    return update_item(db, GovernmentScheme, db_scheme, scheme_in)

# Market Rates
def get_market_rates(db: Session, skip: int = 0, limit: int = 100) -> List[MarketRate]:
    return get_all(db, MarketRate, skip, limit)

def create_market_rate(db: Session, rate: MarketRateCreate, creator_id: int) -> MarketRate:
    return create_item(db, MarketRate, rate, creator_id)

def update_market_rate(db: Session, db_rate: MarketRate, rate_in: MarketRateUpdate) -> MarketRate:
    return update_item(db, MarketRate, db_rate, rate_in)
