from fastapi import FastAPI
from app.api.routers import api_router
from app.core.database import engine, Base

from app.db import models

app = FastAPI(
    title="Farmer Platform API",
    description="API for farmers in Maharashtra with market rates, schemes, and AI advisory.",
    version="1.0.0",
)

@app.on_event("startup")
def create_tables():
    Base.metadata.create_all(bind=engine)

app.include_router(api_router, prefix="/api/v1")

@app.get("/")
def read_root():
    return {"message": "Welcome to the Farmer Platform API"}
