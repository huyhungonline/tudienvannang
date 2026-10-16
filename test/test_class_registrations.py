"""Registration API integration test with an isolated PostgreSQL schema.

Stage this file, class route as class_routes.py, migration 031 as migration.sql,
and migrations 032/030 as schedule_migration.sql/mail_migration.sql
in /tmp/class-test inside the local backend container; run with PYTHONPATH=/app.
"""
import asyncio
import importlib.util
from pathlib import Path
import sys
import uuid

import asyncpg
from fastapi import FastAPI
import httpx
import db
from config import DATABASE_URL


async def main():
    root = Path('/tmp/class-test')
    schema = 'class_test_' + uuid.uuid4().hex
    conn = await asyncpg.connect(DATABASE_URL)
    await conn.execute(f'CREATE SCHEMA {schema}')
    db._pool = await asyncpg.create_pool(DATABASE_URL, server_settings={'search_path': schema})
    try:
        await db.execute((root / 'migration.sql').read_text())
        await db.execute((root / 'schedule_migration.sql').read_text())
        await db.execute((root / 'mail_migration.sql').read_text())
        spec = importlib.util.spec_from_file_location('class_routes_test', root / 'class_routes.py')
        routes = importlib.util.module_from_spec(spec)
        sys.modules[spec.name] = routes
        spec.loader.exec_module(routes)
        app = FastAPI()
        app.include_router(routes.router)
        payload = dict(request_id=str(uuid.uuid4()), course='it-passport', full_name=' Test User ',
                       email='test@example.com', phone='+81 90 1234 5678', schedule='sat-tue-20-22')
        async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url='http://test') as client:
            for _ in range(2):
                assert (await client.post('/api/classes/registrations', json=payload)).status_code == 201
            queued = await db.query('SELECT j.subject,j.content,r.email FROM mail_jobs j JOIN mail_job_recipients r ON r.job_id=j.id')
            assert len(queued) == 1 and queued[0]['email'] == payload['email']
            assert 'Thứ 7 và thứ 3 từ 20h–22h' in queued[0]['content']
            assert 'Google Meet' in queued[0]['content']
            assert (await client.post('/api/classes/registrations', json={**payload, 'course': 'kikai-hozen', 'schedule': None})).status_code == 409
            assert (await client.post('/api/classes/registrations', json={**payload, 'schedule': 'sun-thu-20-22'})).status_code == 409
            for schedule in [None, '', 'unknown']:
                assert (await client.post('/api/classes/registrations', json={**payload, 'schedule': schedule})).status_code == 422
            for field, value in [('course', 'unknown'), ('full_name', ' '), ('email', 'bad'), ('phone', 'abc')]:
                assert (await client.post('/api/classes/registrations', json={**payload, field: value})).status_code == 422
            assert (await client.get('/api/classes/registrations')).status_code == 401
            async def admin_override():
                return 'admin'
            app.dependency_overrides[routes.require_admin] = admin_override
            response = (await client.get('/api/classes/registrations')).json()
            assert response['total'] == 1
            saved = response['registrations'][0]
            assert saved['full_name'] == 'Test User' and saved['book_address'] == ''
            assert saved['course'] == 'it-passport' and saved['phone'] == payload['phone']
            assert saved['schedule'] == payload['schedule']
            second = {**payload, 'request_id': str(uuid.uuid4()), 'course': 'kikai-hozen', 'schedule': None}
            assert (await client.post('/api/classes/registrations', json=second)).status_code == 201
            assert (await db.query_one('SELECT COUNT(*) AS total FROM mail_jobs'))['total'] == 1
            response = (await client.get('/api/classes/registrations?limit=1&offset=1')).json()
            assert response['total'] == 2 and len(response['registrations']) == 1
            alternate = {**payload, 'request_id': str(uuid.uuid4()), 'schedule': 'sun-thu-20-22'}
            assert (await client.post('/api/classes/registrations', json=alternate)).status_code == 201
            response = (await client.get('/api/classes/registrations')).json()
            assert response['total'] == 3
            assert any(row['schedule'] == 'sun-thu-20-22' for row in response['registrations'])
            assert any('Chủ nhật và thứ 5 từ 20h–22h' in job['content'] for job in await db.query('SELECT content FROM mail_jobs'))
            # Fill each slot to 109, then race five new registrations for its last seat.
            await db.execute('TRUNCATE class_registrations')
            for schedule in ('sat-tue-20-22', 'sun-thu-20-22'):
                for _ in range(109):
                    await db.execute('''INSERT INTO class_registrations
                        (id,course,full_name,email,phone,book_address,schedule)
                        VALUES ($1,'it-passport','Test','test@example.com','0901234567','',$2)''', uuid.uuid4(), schedule)
                requests = [{**payload, 'request_id': str(uuid.uuid4()), 'schedule': schedule} for _ in range(5)]
                jobs_before = (await db.query_one('SELECT COUNT(*) AS total FROM mail_jobs'))['total']
                results = await asyncio.gather(*(client.post('/api/classes/registrations', json=item) for item in requests))
                assert [r.status_code for r in results].count(201) == 1
                assert [r.status_code for r in results].count(409) == 4
                for response in results:
                    if response.status_code == 409:
                        assert response.json()['detail'] == 'Lớp đã đầy, vui lòng chọn khung giờ khác'
                winner = requests[next(i for i, response in enumerate(results) if response.status_code == 201)]
                assert (await client.post('/api/classes/registrations', json=winner)).status_code == 201
                count = await db.query_one('SELECT COUNT(*) AS total FROM class_registrations WHERE schedule=$1', schedule)
                assert count['total'] == 110
                assert (await db.query_one('SELECT COUNT(*) AS total FROM mail_jobs'))['total'] == jobs_before + 1
            assert (await client.post('/api/classes/registrations', json={**second, 'request_id': str(uuid.uuid4())})).status_code == 201
        print('PASS: both courses, validation, duplicate request, admin-only list, persisted fields and pagination')
    finally:
        await db.close_pool()
        await conn.execute(f'DROP SCHEMA {schema} CASCADE')
        await conn.close()


asyncio.run(main())
