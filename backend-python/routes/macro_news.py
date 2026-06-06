from fastapi import APIRouter, HTTPException, Query
from services import macro_news_service

router = APIRouter(prefix="/api/macro-news", tags=["macro-news"])


@router.get("")
async def get_macro_news():
    """Return latest content for all 5 categories."""
    try:
        news = await macro_news_service.get_all_news()
        return {"news": news}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch macro news: {str(e)}")


@router.get("/history")
async def get_macro_news_history(days: int = Query(default=20, le=90)):
    """Return list of all news snapshots from the last N days (default 20)."""
    try:
        history = await macro_news_service.get_history(days)
        # Group by date for the sidebar
        dates: dict[str, int] = {}
        for item in history:
            date_key = item["updated_at"][:10]  # YYYY-MM-DD
            dates[date_key] = dates.get(date_key, 0) + 1
        sorted_dates = sorted(dates.keys(), reverse=True)
        return {"dates": sorted_dates, "items": history}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch history: {str(e)}")


@router.get("/by-date/{date_str}")
async def get_macro_news_by_date(date_str: str):
    """Return all news entries for a specific date (YYYY-MM-DD)."""
    try:
        news = await macro_news_service.get_news_by_date(date_str)
        return {"news": news}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch news for date: {str(e)}")


@router.post("/refresh")
async def refresh_macro_news():
    """Trigger manual refresh of all macro news categories."""
    try:
        news = await macro_news_service.refresh_news()
        return {"news": news, "message": "Macro news refreshed successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to refresh macro news: {str(e)}")
