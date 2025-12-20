from fastapi import APIRouter
from app.api.v1.endpoints import auth, admin, farmer, utils

api_router = APIRouter()

api_router.include_router(auth.router, tags=["Authentication"], prefix="/auth")
api_router.include_router(admin.router, tags=["Admin"], prefix="/admin")
api_router.include_router(farmer.router, tags=["Farmer"], prefix="/farmer")
api_router.include_router(utils.router, tags=["Utilities"], prefix="/utils")
