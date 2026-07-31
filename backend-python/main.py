import asyncio
import logging
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.cron import CronTrigger

import db
from routes import words, audio, auth, history, reading_posts, admin, nhk_news, classroom
from services.nhk_mailer_service import send_daily_news

logger = logging.getLogger(__name__)


async def daily_news_job():
    """Wrapper for the daily NHK news job triggered by APScheduler."""
    logger.info("[NHK] Scheduler triggered daily_news_job")
    try:
        result = await send_daily_news()
        logger.info(
            f"[NHK] Daily job result: success={result.get('success')}, "
            f"sent={result.get('sent')}, failed={result.get('failed')}, "
            f"article_title={result.get('article_title')}"
        )
    except Exception as e:
        logger.error(f"[NHK] daily_news_job failed with exception: {e}")


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: initialize DB pool
    await db.get_pool()

    # Start APScheduler for daily NHK news job
    scheduler = AsyncIOScheduler()
    scheduler.add_job(
        daily_news_job,
        CronTrigger(hour=0, minute=0),  # 0:00 UTC = 7:00 AM UTC+7
        id="nhk_daily_news",
        replace_existing=True,
        misfire_grace_time=3600,
    )
    scheduler.start()
    logger.info("[NHK] APScheduler started — daily job scheduled at 0:00 UTC")

    yield

    # Shutdown scheduler
    scheduler.shutdown(wait=False)
    logger.info("[NHK] APScheduler shut down")
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
app.include_router(nhk_news.router)
app.include_router(classroom.router)


@app.get("/api/health")
async def health_check():
    return {"status": "ok"}
