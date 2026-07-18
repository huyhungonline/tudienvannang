import asyncio
import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import db
from routes import words, audio, auth, history, reading_posts, admin

logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: initialize DB pool
    await db.get_pool()
    yield
    # Shutdown
    await db.close_pool()


app = FastAPI(title="English Word Splitter API", lifespan=lifespan, redirect_slashes=False)

# CORS middleware - allow all origins for development
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(words.router)
app.include_router(audio.router)
app.include_router(auth.router)
app.include_router(history.router)
app.include_router(reading_posts.router)
app.include_router(admin.router)


@app.get("/api/health")
async def health_check():
    return {"status": "ok"}
