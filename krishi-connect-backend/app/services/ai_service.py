import os
from typing import List
from sqlalchemy.orm import Session
from google import genai
from google.genai import types
from google.genai.errors import APIError

from app.core.config import settings
from app.db.models import ChatbotHistory, User, Crop
from app.api.v1.schemas.chatbot import ChatbotMessage, ChatbotHistoryItem
from app.api.v1.schemas.advisory import SoilAdvisoryRequest

# --- Gemini Client Initialization ---
def get_gemini_client():
    # In a real application, the API key would be dynamically loaded from the DB
    # For now, we use the environment variable/config setting.
    api_key = settings.GEMINI_API_KEY
    if api_key == "your_gemini_api_key":
        # Fallback to environment variable if placeholder is used
        api_key = os.environ.get("GEMINI_API_KEY", settings.GEMINI_API_KEY)
        
    if not api_key or api_key == "your_gemini_api_key":
        raise ValueError("GEMINI_API_KEY is not configured.")
        
    return genai.Client(api_key=api_key)

# --- History Management ---
def get_history_for_session(db: Session, user_id: int, session_id: str) -> List[ChatbotHistory]:
    return db.query(ChatbotHistory).filter(
        ChatbotHistory.user_id == user_id,
        ChatbotHistory.session_id == session_id
    ).order_by(ChatbotHistory.timestamp).all()

def save_message(db: Session, user_id: int, session_id: str, message_type: str, content: str):
    db_message = ChatbotHistory(
        user_id=user_id,
        session_id=session_id,
        message_type=message_type,
        message_content=content
    )
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    return db_message

# --- Chatbot Logic ---
def get_chatbot_response(db: Session, user: User, message: ChatbotMessage) -> str:
    try:
        client = get_gemini_client()
    except ValueError as e:
        return f"AI Service Error: {e}"

    # 1. Retrieve history
    history = get_history_for_session(db, user.id, message.session_id)

    # 2. Convert history to Gemini format (Content objects)
    contents = []
    for item in history:
        role = "user" if item.message_type == "user" else "model"
        contents.append(types.Content(role=role, parts=[types.Part.from_text(item.message_content)]))

    # 3. Add current user message
    contents.append(types.Content(role="user", parts=[types.Part.from_text(message.message_content)]))

    # 4. Define system instruction for the chatbot
    system_instruction = (
        "You are 'Krishi Mitra', an AI Chatbot specialized in agriculture for farmers in Maharashtra, India. "
        "Your responses must be helpful, concise, and relevant to farming practices, government schemes, "
        "and market rates in the region. Do not provide information outside of agriculture or Maharashtra unless "
        "specifically asked for general knowledge. Maintain a friendly and supportive tone."
    )

    # 5. Call Gemini API
    try:
        chat = client.chats.create(
            model="gemini-2.5-flash",
            system_instruction=system_instruction,
            history=contents[:-1] # Pass all but the last message as history
        )
        
        # Send the current message
        response = chat.send_message(message.message_content)
        ai_response = response.text

    except APIError as e:
        ai_response = f"An error occurred with the Gemini API: {e}"
    except Exception as e:
        ai_response = f"An unexpected error occurred: {e}"

    # 6. Save both user and AI messages
    save_message(db, user.id, message.session_id, "user", message.message_content)
    save_message(db, user.id, message.session_id, "ai", ai_response)

    return ai_response

# --- Advisory Logic ---
def get_soil_advisory(db: Session, user: User, request: SoilAdvisoryRequest) -> str:
    try:
        client = get_gemini_client()
    except ValueError as e:
        return f"AI Service Error: {e}"

    # 1. Get crop details and context
    crop = db.query(Crop).filter(Crop.id == request.crop_id).first()
    if not crop:
        return "Error: Selected crop not found in the database."

    # 2. Construct the prompt
    system_instruction = (
        "You are a highly experienced agricultural scientist and soil expert for the Maharashtra region of India. "
        "Your task is to provide a detailed, actionable, and localized advisory based on the farmer's input. "
        "The farmer is growing {crop_name}. "
        "The advisory must cover soil management, crop-specific recommendations, and weather-related precautions. "
        "Use the provided crop context to enhance your advice."
    ).format(crop_name=crop.name)

    prompt = (
        f"Farmer Advisory Request for {crop.name} in Maharashtra:\n"
        f"--- Farmer Input ---\n"
        f"Crop: {crop.name}\n"
        f"Soil Type: {request.soil_type}\n"
        f"pH Level: {request.ph_level}\n"
        f"Nutrient Levels (NPK/OC): {request.nutrient_levels}\n"
        f"Current/Expected Weather: {request.weather_conditions}\n"
        f"--- Crop Context for AI ---\n"
        f"{crop.context or 'No specific context provided.'}\n"
        f"--- Advisory Task ---\n"
        f"Provide a comprehensive advisory in clear, simple language. Structure your response with clear headings: "
        f"1. Soil Management, 2. Crop-Specific Guidance, 3. Weather-Related Precautions. "
        f"Ensure the advice is practical for a farmer in Maharashtra."
    )

    # 3. Call Gemini API
    try:
        response = client.models.generate_content(
            model="gemini-2.5-flash",
            contents=prompt,
            config=types.GenerateContentConfig(
                system_instruction=system_instruction
            )
        )
        return response.text

    except APIError as e:
        return f"An error occurred with the Gemini API: {e}"
    except Exception as e:
        return f"An unexpected error occurred: {e}"

def get_full_session_history(db: Session, user_id: int, session_id: str) -> List[ChatbotHistoryItem]:
    history = get_history_for_session(db, user_id, session_id)
    return [ChatbotHistoryItem.model_validate(item) for item in history]
