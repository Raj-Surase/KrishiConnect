from typing import Optional, List
from pydantic import BaseModel
from datetime import datetime

class ChatbotMessage(BaseModel):
    session_id: str
    message_content: str

class ChatbotHistoryItem(BaseModel):
    session_id: str
    message_type: str # 'user' or 'ai'
    message_content: str
    timestamp: datetime

    class Config:
        from_attributes = True

class ChatbotResponse(BaseModel):
    response: str
    history: List[ChatbotHistoryItem]
