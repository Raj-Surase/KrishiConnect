from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.db.models import User
from app.utils.dependencies import get_current_farmer_or_admin_user, get_current_farmer_user
from app.services import ai_service, content_service
from app.api.v1.schemas.content import Crop, GovernmentScheme, MarketRate
from app.api.v1.schemas.chatbot import ChatbotMessage, ChatbotResponse
from app.api.v1.schemas.advisory import SoilAdvisoryRequest, SoilAdvisoryResponse

router = APIRouter()

# --- Farmer Status ---
@router.get("/status")
def farmer_status(current_user: User = Depends(get_current_farmer_user)):
    return {"message": f"Welcome Farmer: {current_user.username}", "role": current_user.role}

# --- Content Access ---

@router.get("/crops", response_model=List[Crop])
def list_crops(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_farmer_or_admin_user)
):
    """List all available crops for advisory and market rates."""
    return content_service.get_crops(db, skip=skip, limit=limit)

@router.get("/schemes", response_model=List[GovernmentScheme])
def list_schemes(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_farmer_or_admin_user)
):
    """List all government schemes."""
    return content_service.get_schemes(db, skip=skip, limit=limit)


@router.post("/advisory/soil", response_model=SoilAdvisoryResponse)
def get_soil_and_crop_advisory(
    request: SoilAdvisoryRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_farmer_user)
):
    """Get AI-powered soil and crop advisory based on farmer input."""
    
    # 1. Get crop name for response model
    crop = content_service.get_crop(db, request.crop_id)
    if not crop:
        raise HTTPException(status_code=404, detail="Crop not found")

    # 2. Get advisory from AI service
    advisory_text = ai_service.get_soil_advisory(db, current_user, request)
    
    # 3. Check for errors from AI service
    if advisory_text.startswith("AI Service Error:") or advisory_text.startswith("An error occurred"):
        raise HTTPException(status_code=500, detail=advisory_text)

    return SoilAdvisoryResponse(
    crop_name=crop.name,
    advisory=advisory_text
    )


@router.post("/chatbot", response_model=ChatbotResponse)
def chatbot_query(
    message: ChatbotMessage,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_farmer_user)
):
    """Send a message to the AI Chatbot and get a response with updated history."""
    ai_response = ai_service.get_chatbot_response(db, current_user, message)
    
    # Retrieve the full history after the exchange
    full_history = ai_service.get_full_session_history(db, current_user.id, message.session_id)
    
    return ChatbotResponse(response=ai_response, history=full_history)

@router.get("/market_rates", response_model=List[MarketRate])
def list_market_rates(
    crop_id: int = None,
    location: str = None,
    date: str = None, # Use string for simple query param, validation happens in service/db
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_farmer_or_admin_user)
):
    """List daily market rates, with optional filters."""
    # Simple filtering logic can be added to content_service.get_market_rates
    # For now, we use the basic list all.
    return content_service.get_market_rates(db, skip=skip, limit=limit)

# Note: Weather API integration is front-end based, but the API key management is in phase 9.
# Note: AI Chatbot and Soil/Crop Advisory are in phases 7 and 8.
