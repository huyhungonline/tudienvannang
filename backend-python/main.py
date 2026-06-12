import asyncio
import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import db
from routes import words, audio, auth, history, macro_news, reading_posts
from services import macro_news_service

logger = logging.getLogger(__name__)


async def scheduled_refresh():
    """Background task that refreshes macro news every 12 hours (EN + JA)."""
    while True:
        await asyncio.sleep(12 * 3600)  # 12 hours
        try:
            logger.info("Running scheduled macro news refresh (EN)...")
            await macro_news_service.refresh_news("en")
            logger.info("Running scheduled macro news refresh (JA)...")
            await macro_news_service.refresh_news("ja")
            logger.info("Scheduled macro news refresh completed.")
        except Exception as e:
            logger.error(f"Scheduled macro news refresh failed: {e}")


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: initialize DB pool
    await db.get_pool()

    # Run migration for macro_news table
    try:
        await db.execute("""
            CREATE TABLE IF NOT EXISTS macro_news (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                category VARCHAR(50) NOT NULL,
                title VARCHAR(255) NOT NULL,
                content TEXT NOT NULL,
                updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
            )
        """)
        await db.execute(
            "CREATE INDEX IF NOT EXISTS idx_macro_news_category ON macro_news(category)"
        )
    except Exception as e:
        logger.error(f"Failed to run macro_news migration: {e}")

    # Initial refresh disabled temporarily
    # try:
    #     if await macro_news_service.is_db_empty():
    #         logger.info("Macro news DB is empty, triggering initial refresh (EN + JA)...")
    #         asyncio.create_task(macro_news_service.refresh_news("en"))
    #         asyncio.create_task(macro_news_service.refresh_news("ja"))
    # except Exception as e:
    #     logger.error(f"Failed to check/trigger initial macro news refresh: {e}")

    # Background scheduler disabled temporarily
    # refresh_task = asyncio.create_task(scheduled_refresh())

    yield

    # Shutdown
    # refresh_task.cancel()
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
app.include_router(macro_news.router)
app.include_router(reading_posts.router)


@app.get("/api/health")
async def health_check():
    return {"status": "ok"}
