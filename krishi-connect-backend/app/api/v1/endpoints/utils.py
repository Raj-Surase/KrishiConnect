from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.db.models import User
from app.utils.dependencies import get_current_admin_user
from app.services import utility_service
from app.api.v1.schemas.apikey import ApiKey, ApiKeyCreate, ApiKeyUpdate

router = APIRouter()

@router.get("/keys", response_model=List[ApiKey])
def list_api_keys(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    """List all configured API keys (Admin only)."""
    return utility_service.get_all_api_keys(db)

@router.post("/keys", response_model=ApiKey)
def create_or_update_api_key(
    key_in: ApiKeyCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    """Create a new API key or update an existing one (Admin only)."""
    return utility_service.create_or_update_api_key(db, key_in, current_user.id)

@router.put("/keys/{service_name}", response_model=ApiKey)
def update_api_key(
    service_name: str,
    key_in: ApiKeyUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    """Update an existing API key's value or status (Admin only)."""
    db_key = utility_service.update_api_key_value(db, service_name, key_in, current_user.id)
    if not db_key:
        raise HTTPException(status_code=404, detail="API Key not found")
    return db_key

@router.delete("/keys/{service_name}", status_code=status.HTTP_204_NO_CONTENT)
def delete_api_key(
    service_name: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_admin_user)
):
    """Delete an API key (Admin only)."""
    if not utility_service.delete_api_key(db, service_name):
        raise HTTPException(status_code=404, detail="API Key not found")
    return
