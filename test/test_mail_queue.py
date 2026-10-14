"""Integration test in an isolated PostgreSQL schema; SMTP is always mocked.

Run inside the backend container with the repo mounted/copied at MAIL_TEST_ROOT.
"""
import asyncio
import importlib.util
import os
from pathlib import Path
import sys
import uuid

import asyncpg
from fastapi import HTTPException, FastAPI
import httpx
import db
from config import DATABASE_URL


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


async def main():
    root = Path(os.environ.get('MAIL_TEST_ROOT', '/tmp/mail-test'))
    schema = 'mail_test_' + uuid.uuid4().hex
    admin = await asyncpg.connect(DATABASE_URL)
    await admin.execute(f'CREATE SCHEMA {schema}')
    db._pool = await asyncpg.create_pool(DATABASE_URL, server_settings={'search_path': schema})
    stops, tasks = [], []
    try:
        await db.execute((root / 'migration.sql').read_text())
        routes = load('queue_test_routes', root / 'nhk_routes.py')
        worker = load('queue_test_worker', root / 'worker.py')
        app = FastAPI()
        app.include_router(routes.router)
        async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url='http://test') as client:
            assert (await client.get('/api/nhk/mail-jobs')).status_code == 401
            assert (await client.post('/api/nhk/send-manual', json={})).status_code == 401

        job_id = uuid.uuid4()
        request = routes.ManualMailRequest(request_id=job_id, subject='Test', content='Body',
            subscriber_emails=['a@example.com', 'b@example.com', 'a@example.com'])
        await asyncio.gather(routes.send_manual(request, 'admin'), routes.send_manual(request, 'admin'))
        assert (await routes.mail_job_status(job_id))['total'] == 2
        try:
            await routes.send_manual(request.model_copy(update={'subject': 'Changed'}), 'admin')
            raise AssertionError('Expected conflict')
        except HTTPException as error:
            assert error.status_code == 409

        deliveries = []
        def fake_send(email, subject, content):
            deliveries.append(email)
            return email != 'b@example.com' or deliveries.count(email) > 1
        worker.send_email = fake_send
        # Simulate a crash during delivery: it must be flagged, never automatically resent.
        await db.execute("UPDATE mail_job_recipients SET status='sending' WHERE email='b@example.com'")
        for _ in range(2):
            stop = asyncio.Event()
            stops.append(stop)
            tasks.append(asyncio.create_task(worker.run_mail_queue(stop)))
        for _ in range(100):
            status = await routes.mail_job_status(job_id)
            if status['pending'] == 0:
                break
            await asyncio.sleep(.1)
        assert status['sent'] == 1 and status['failed'] == 1
        assert deliveries == ['a@example.com']
        assert 'interrupted' in status['failures'][0]['error']
        await routes.retry_mail_job(job_id, 'admin')
        for _ in range(100):
            status = await routes.mail_job_status(job_id)
            if status['pending'] == 0:
                break
            await asyncio.sleep(.1)
        assert status['sent'] == 1 and status['failed'] == 1
        await routes.retry_mail_job(job_id, 'admin')
        for _ in range(100):
            status = await routes.mail_job_status(job_id)
            if status['pending'] == 0:
                break
            await asyncio.sleep(.1)
        assert status['sent'] == 2 and status['failed'] == 0
        assert deliveries.count('a@example.com') == 1
        assert deliveries.count('b@example.com') == 2
        print('PASS: admin auth, idempotent concurrent enqueue, crash recovery, exclusive workers, failed-only retry')
    finally:
        for stop in stops:
            stop.set()
        await asyncio.gather(*tasks)
        await db.close_pool()
        await admin.execute(f'DROP SCHEMA {schema} CASCADE')
        await admin.close()


asyncio.run(main())
