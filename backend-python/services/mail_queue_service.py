"""Persistent manual mail queue. One global worker, paced SMTP calls off the event loop."""
import asyncio
import logging
import os

import db
from services.email_service import send_email

logger = logging.getLogger(__name__)


async def run_mail_queue(stop: asyncio.Event):
    async def pause(seconds):
        try:
            await asyncio.wait_for(stop.wait(), timeout=seconds)
        except asyncio.TimeoutError:
            pass

    interval = max(1.0, float(os.getenv('MAIL_SEND_INTERVAL_SECONDS', '2')))
    while not stop.is_set():
        try:
            pool = await db.get_pool()
            async with pool.acquire() as conn:
                # Session lock prevents multiple processes sending the same queue concurrently.
                if not await conn.fetchval('SELECT pg_try_advisory_lock(730030)'):
                    await pause(2)
                    continue
                try:
                    # A previous process may have stopped after SMTP accepted a message.
                    # Never silently resend these ambiguous deliveries.
                    await conn.execute("UPDATE mail_job_recipients SET status='failed', error='Delivery interrupted; check mailbox before retrying' WHERE status='sending'")
                    while not stop.is_set():
                        row = await conn.fetchrow("""
                            UPDATE mail_job_recipients SET status='sending', attempts=attempts+1, error=NULL
                            WHERE (job_id,email) = (
                                SELECT r.job_id,r.email FROM mail_job_recipients r
                                JOIN mail_jobs j ON j.id=r.job_id
                                WHERE r.status='pending' ORDER BY j.created_at,r.email LIMIT 1
                            ) RETURNING job_id,email
                        """)
                        if not row:
                            await pause(2)
                            continue
                        job = await conn.fetchrow('SELECT subject,content FROM mail_jobs WHERE id=$1', row['job_id'])
                        try:
                            success = await asyncio.to_thread(send_email, row['email'], job['subject'], job['content'])
                            error = None if success else 'SMTP rejected delivery or connection failed; see server logs'
                        except Exception:
                            logger.exception('Mail delivery failed')
                            success, error = False, 'Mail delivery failed; see server logs'
                        await conn.execute(
                            'UPDATE mail_job_recipients SET status=$3,error=$4 WHERE job_id=$1 AND email=$2',
                            row['job_id'], row['email'], 'sent' if success else 'failed', error,
                        )
                        await pause(interval)
                finally:
                    await conn.execute('SELECT pg_advisory_unlock(730030)')
        except asyncio.CancelledError:
            raise
        except Exception:
            logger.exception('Mail queue worker unavailable; retrying in 5 seconds')
            await pause(5)
