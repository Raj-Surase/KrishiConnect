from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    # Database settings
    DATABASE_URL: str = "mysql+mysqlconnector://user:password@db:3306/farmer_platform_db"

    # JWT settings
    SECRET_KEY: str = "super-secret-key"
    ALGORITHM: str = "HS256"
    # 525600 minutes = 1 year (for no expiry as requested)
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 525600

    # API Keys (placeholders, will be fetched from DB)
    GEMINI_API_KEY: str = "your_gemini_api_key"
    WEATHER_API_KEY: str = "your_weather_api_key"

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

settings = Settings()
