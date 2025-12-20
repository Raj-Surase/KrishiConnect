from sqlalchemy import Column, Integer, String, Boolean, DateTime, Text, ForeignKey, Enum, Date, DECIMAL, Float
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.core.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    role = Column(String(50), nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=func.now())

    # Relationships
    schemes_created = relationship("GovernmentScheme", back_populates="creator")
    rates_created = relationship("MarketRate", back_populates="creator")
    chatbot_history = relationship("ChatbotHistory", back_populates="user")
    api_keys_updated = relationship("ApiKey", back_populates="updater")

class Crop(Base):
    __tablename__ = "crops"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), unique=True, nullable=False)
    image_url = Column(String(512), nullable=True)
    details = Column(Text, nullable=True)
    context = Column(Text, nullable=True) # Context for AI advisory

    # Relationships
    market_rates = relationship("MarketRate", back_populates="crop")

class GovernmentScheme(Base):
    __tablename__ = "government_schemes"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(512), nullable=False)
    link = Column(String(512), nullable=False)
    image_url = Column(String(512), nullable=True)
    description = Column(Text, nullable=True)
    region = Column(String(255), default="Maharashtra")
    created_by_id = Column(Integer, ForeignKey("users.id"))
    created_at = Column(DateTime, default=func.now())

    creator = relationship("User", back_populates="schemes_created")

class MarketRate(Base):
    __tablename__ = "market_rates"

    id = Column(Integer, primary_key=True, index=True)
    crop_id = Column(Integer, ForeignKey("crops.id"), nullable=False)
    location = Column(String(255), nullable=False) # Local market unit (APMC)
    date = Column(Date, nullable=False)
    min_price = Column(Float, nullable=False)
    max_price = Column(Float, nullable=False)
    expected_price = Column(Float, nullable=True)
    unit = Column(String(50), default="Quintal")
    created_by_id = Column(Integer, ForeignKey("users.id"))
    created_at = Column(DateTime, default=func.now())

    crop = relationship("Crop", back_populates="market_rates")
    creator = relationship("User", back_populates="rates_created")

class ChatbotHistory(Base):
    __tablename__ = "chatbot_history"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    session_id = Column(String(255), nullable=False)
    message_type = Column(String(50), nullable=False)
    message_content = Column(Text, nullable=False)
    timestamp = Column(DateTime, default=func.now())

    user = relationship("User", back_populates="chatbot_history")

class ApiKey(Base):
    __tablename__ = "api_keys"

    id = Column(Integer, primary_key=True, index=True)
    service_name = Column(String(255), unique=True, nullable=False) # e.g., 'GEMINI_API_KEY', 'WEATHER_API_KEY'
    api_key_value = Column(Text, nullable=False)
    is_active = Column(Boolean, default=True)
    updated_by_id = Column(Integer, ForeignKey("users.id"))
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    updater = relationship("User", back_populates="api_keys_updated")
