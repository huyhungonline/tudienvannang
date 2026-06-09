from fastapi import APIRouter, HTTPException, Query
from services import macro_news_service

router = APIRouter(prefix="/api/macro-news", tags=["macro-news"])


@router.get("")
async def get_macro_news(language: str = Query(default="en", regex="^(en|ja)$")):
    """Return latest content for all 5 categories in specified language."""
    try:
        news = await macro_news_service.get_all_news(language)
        return {"news": news}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch macro news: {str(e)}")


@router.get("/history")
async def get_macro_news_history(
    days: int = Query(default=20, le=90),
    language: str = Query(default="en", regex="^(en|ja)$"),
):
    """Return list of all news snapshots from the last N days."""
    try:
        history = await macro_news_service.get_history(days, language)
        dates: dict[str, int] = {}
        for item in history:
            date_key = item["updated_at"][:10]
            dates[date_key] = dates.get(date_key, 0) + 1
        sorted_dates = sorted(dates.keys(), reverse=True)
        return {"dates": sorted_dates, "items": history}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch history: {str(e)}")


@router.get("/by-date/{date_str}")
async def get_macro_news_by_date(
    date_str: str,
    language: str = Query(default="en", regex="^(en|ja)$"),
):
    """Return all news entries for a specific date."""
    try:
        news = await macro_news_service.get_news_by_date(date_str, language)
        return {"news": news}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch news for date: {str(e)}")


@router.post("/refresh")
async def refresh_macro_news(language: str = Query(default="en", regex="^(en|ja)$")):
    """Trigger manual refresh of all macro news categories in specified language."""
    try:
        news = await macro_news_service.refresh_news(language)
        return {"news": news, "message": f"Macro news refreshed successfully ({language})"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to refresh macro news: {str(e)}")
