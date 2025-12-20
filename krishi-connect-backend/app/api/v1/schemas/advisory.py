from pydantic import BaseModel, Field

class SoilAdvisoryRequest(BaseModel):
    crop_id: int = Field(..., description="ID of the selected crop.")
    soil_type: str = Field(..., description="e.g., Black soil, Red soil, Alluvial soil.")
    ph_level: float = Field(..., description="Soil pH level.")
    nutrient_levels: str = Field(..., description="e.g., NPK values, Organic Carbon content.")
    weather_conditions: str = Field(..., description="Current or expected weather conditions.")
    
class SoilAdvisoryResponse(BaseModel):
    crop_name: str
    advisory: str = Field(..., description="Detailed, localized advisory from the AI.")
