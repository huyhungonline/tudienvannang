from fastapi import APIRouter, HTTPException
import logging

from nhk_models import SubscribeRequest, UnsubscribeRequest
import db
from services.nhk_mailer_service import send_daily_news

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/nhk", tags=["nhk-news"])


@router.post("/subscribe")
async def subscribe(req: SubscribeRequest):
    """Subscribe to NHK daily news emails.

    Upsert subscriber: if email exists, update target_language and set active.
    Pydantic validates email format (returns 422 if invalid).
    target_language is validated by SubscribeRequest model (must be 'en' or 'vi').
    """
    try:
        await db.execute(
            """
            INSERT INTO nhk_subscribers (email, target_language, is_active)
            VALUES ($1, $2, TRUE)
            ON CONFLICT (email) DO UPDATE SET target_language = $2, is_active = TRUE
            """,
            req.email,
            req.target_language,
        )
        return {"success": True, "message": f"Subscribed {req.email} for {req.target_language} news"}
    except Exception as e:
        logger.error(f"[NHK] Subscribe error: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to subscribe: {str(e)}")


@router.post("/unsubscribe")
async def unsubscribe(req: UnsubscribeRequest):
    """Unsubscribe from NHK daily news emails.

    Sets is_active=false for the given email. Idempotent: returns success
    even if email not found.
    """
    try:
        await db.execute(
            "UPDATE nhk_subscribers SET is_active = FALSE WHERE email = $1",
            req.email,
        )
        return {"success": True, "message": f"Unsubscribed {req.email}"}
    except Exception as e:
        logger.error(f"[NHK] Unsubscribe error: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to unsubscribe: {str(e)}")


@router.post("/trigger")
async def trigger():
    """Manual trigger scrape + send cycle.

    Calls send_daily_news() which orchestrates: scrape → get newest article →
    send to all active subscribers.
    """
    try:
        result = await send_daily_news()
        return result
    except Exception as e:
        logger.error(f"[NHK] Trigger error: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to trigger daily news: {str(e)}")


@router.get("/subscribers")
async def get_subscribers(limit: int = 20, offset: int = 0):
    """Get active subscribers with pagination for admin mail sending."""
    try:
        total_row = await db.query_one(
            "SELECT COUNT(*) as count FROM nhk_subscribers WHERE is_active = TRUE"
        )
        total = total_row["count"] if total_row else 0

        subscribers = await db.query(
            "SELECT id, email, target_language, is_active, created_at FROM nhk_subscribers WHERE is_active = TRUE ORDER BY created_at DESC LIMIT $1 OFFSET $2",
            limit, offset,
        )
        result = []
        for s in subscribers:
            result.append({
                "id": str(s["id"]),
                "email": s["email"],
                "target_language": s["target_language"],
                "created_at": s["created_at"].isoformat() if s["created_at"] else None,
            })
        return {"subscribers": result, "total": total}
    except Exception as e:
        logger.error(f"[NHK] Get subscribers error: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/send-manual")
async def send_manual(body: dict):
    """Send manual email to selected subscribers.

    Body: { subject: str, content: str, subscriber_emails: list[str] }
    """
    from services.email_service import send_email

    subject = body.get("subject", "").strip()
    content = body.get("content", "").strip()
    emails = body.get("subscriber_emails", [])

    if not subject:
        raise HTTPException(status_code=400, detail="Subject is required")
    if not content:
        raise HTTPException(status_code=400, detail="Content is required")
    if not emails:
        raise HTTPException(status_code=400, detail="At least one email is required")

    sent = 0
    failed = 0
    for email in emails:
        success = send_email(email, subject, content)
        if success:
            sent += 1
        else:
            failed += 1

    return {"success": True, "sent": sent, "failed": failed}
