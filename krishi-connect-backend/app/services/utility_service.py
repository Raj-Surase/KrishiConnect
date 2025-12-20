from typing import List, Optional
from sqlalchemy.orm import Session
from app.db.models import ApiKey
from app.api.v1.schemas.apikey import ApiKeyCreate, ApiKeyUpdate

def get_api_key_by_name(db: Session, service_name: str) -> Optional[ApiKey]:
    return db.query(ApiKey).filter(ApiKey.service_name == service_name).first()

def get_all_api_keys(db: Session) -> List[ApiKey]:
    return db.query(ApiKey).all()

def create_or_update_api_key(db: Session, key_in: ApiKeyCreate, updater_id: int) -> ApiKey:
    db_key = get_api_key_by_name(db, key_in.service_name)
    
    if db_key:
        # Update existing key
        db_key.api_key_value = key_in.api_key_value
        db_key.is_active = key_in.is_active
        db_key.updated_by_id = updater_id
    else:
        # Create new key
        db_key = ApiKey(
            service_name=key_in.service_name,
            api_key_value=key_in.api_key_value,
            is_active=key_in.is_active,
            updated_by_id=updater_id
        )
        db.add(db_key)
        
    db.commit()
    db.refresh(db_key)
    return db_key

def update_api_key_value(db: Session, service_name: str, key_in: ApiKeyUpdate, updater_id: int) -> Optional[ApiKey]:
    db_key = get_api_key_by_name(db, service_name)
    if not db_key:
        return None
        
    update_data = key_in.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_key, key, value)
        
    db_key.updated_by_id = updater_id
    db.add(db_key)
    db.commit()
    db.refresh(db_key)
    return db_key

def delete_api_key(db: Session, service_name: str) -> bool:
    db_key = get_api_key_by_name(db, service_name)
    if db_key:
        db.delete(db_key)
        db.commit()
        return True
    return False
