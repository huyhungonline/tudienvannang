"""Registration API integration test with an isolated PostgreSQL schema.

Stage this file, class route as class_routes.py, migration 031 as migration.sql,
and migration 032 as schedule_migration.sql
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
            response = (await client.get('/api/classes/registrations?limit=1&offset=1')).json()
            assert response['total'] == 2 and len(response['registrations']) == 1
            alternate = {**payload, 'request_id': str(uuid.uuid4()), 'schedule': 'sun-thu-20-22'}
            assert (await client.post('/api/classes/registrations', json=alternate)).status_code == 201
            response = (await client.get('/api/classes/registrations')).json()
            assert response['total'] == 3
            assert any(row['schedule'] == 'sun-thu-20-22' for row in response['registrations'])
        print('PASS: both courses, validation, duplicate request, admin-only list, persisted fields and pagination')
    finally:
        await db.close_pool()
        await conn.execute(f'DROP SCHEMA {schema} CASCADE')
        await conn.close()


asyncio.run(main())
