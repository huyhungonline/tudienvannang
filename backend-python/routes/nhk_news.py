from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr, Field
from uuid import UUID
from routes.admin import require_admin
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


class ManualMailRequest(BaseModel):
    request_id: UUID
    subject: str = Field(min_length=1, max_length=200)
    content: str = Field(min_length=1, max_length=100000)
    subscriber_emails: list[EmailStr] = Field(min_length=1, max_length=5000)


@router.post("/send-manual", status_code=202)
async def send_manual(body: ManualMailRequest, _: str = Depends(require_admin)):
    """Send manual email to selected subscribers.

    Body: { subject: str, content: str, subscriber_emails: list[str] }
    """
    subject = body.subject.strip()
    content = body.content.strip()
    emails = sorted(set(str(email).strip().lower() for email in body.subscriber_emails))

    if not subject:
        raise HTTPException(status_code=400, detail="Subject is required")
    if not content:
        raise HTTPException(status_code=400, detail="Content is required")
    if not emails:
        raise HTTPException(status_code=400, detail="At least one email is required")

    pool = await db.get_pool()
    async with pool.acquire() as conn:
        async with conn.transaction():
            inserted = await conn.fetchval(
                'INSERT INTO mail_jobs (id,subject,content) VALUES ($1,$2,$3) ON CONFLICT DO NOTHING RETURNING id',
                body.request_id, subject, content,
            )
            if inserted:
                await conn.executemany('INSERT INTO mail_job_recipients (job_id,email) VALUES ($1,$2)',
                                       [(body.request_id, email) for email in emails])
            else:
                existing = await conn.fetchrow('SELECT subject,content FROM mail_jobs WHERE id=$1', body.request_id)
                recipients = await conn.fetch('SELECT email FROM mail_job_recipients WHERE job_id=$1 ORDER BY email', body.request_id)
                if existing['subject'] != subject or existing['content'] != content or [r['email'] for r in recipients] != emails:
                    raise HTTPException(status_code=409, detail='Request ID already used for different content')
    return {"jobId": str(body.request_id)}


@router.get('/mail-jobs')
async def list_mail_jobs(_: str = Depends(require_admin)):
    rows = await db.query('SELECT id FROM mail_jobs ORDER BY created_at DESC LIMIT 20')
    return {'jobs': [await mail_job_status(r['id']) for r in rows]}


async def mail_job_status(job_id: UUID):
    job = await db.query_one('SELECT id,subject,created_at FROM mail_jobs WHERE id=$1', job_id)
    if not job:
        raise HTTPException(status_code=404, detail='Mail job not found')
    counts = await db.query_one("""SELECT COUNT(*) AS total,
        COUNT(*) FILTER (WHERE status='sent') AS sent,
        COUNT(*) FILTER (WHERE status='failed') AS failed,
        COUNT(*) FILTER (WHERE status IN ('pending','sending')) AS pending
        FROM mail_job_recipients WHERE job_id=$1""", job_id)
    failures = await db.query('SELECT email,error FROM mail_job_recipients WHERE job_id=$1 AND status=$2 ORDER BY email', job_id, 'failed')
    return {'jobId': str(job_id), 'subject': job['subject'], **counts, 'failures': failures}


@router.get('/mail-jobs/{job_id}')
async def get_mail_job(job_id: UUID, _: str = Depends(require_admin)):
    return await mail_job_status(job_id)


@router.post('/mail-jobs/{job_id}/retry')
async def retry_mail_job(job_id: UUID, _: str = Depends(require_admin)):
    await mail_job_status(job_id)
    await db.execute("UPDATE mail_job_recipients SET status='pending',error=NULL WHERE job_id=$1 AND status='failed'", job_id)
    return await mail_job_status(job_id)
