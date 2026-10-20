"""API/database integration check using a temporary PostgreSQL schema."""
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
from services.auth_service import _create_token


async def main():
    root = Path(__file__).resolve().parents[1]
    schema = 'email_contacts_test_' + uuid.uuid4().hex
    connection = await asyncpg.connect(DATABASE_URL)
    await connection.execute(f'CREATE SCHEMA {schema}')
    db._pool = await asyncpg.create_pool(DATABASE_URL, server_settings={'search_path': schema})
    try:
        migration = (root / 'backend-python/migrations/032_admin_email_contacts.sql').read_text()
        await db.execute(migration)
        await db.execute(migration)
        await db.execute('CREATE TABLE users (id UUID PRIMARY KEY, is_admin BOOLEAN NOT NULL)')
        admin_id, user_id = uuid.uuid4(), uuid.uuid4()
        await db.execute('INSERT INTO users VALUES ($1, TRUE), ($2, FALSE)', admin_id, user_id)
        spec = importlib.util.spec_from_file_location('email_contacts_under_test', root / 'backend-python/routes/email_contacts.py')
        routes = importlib.util.module_from_spec(spec)
        sys.modules[spec.name] = routes
        spec.loader.exec_module(routes)
        app = FastAPI()
        app.include_router(routes.router)
        endpoint = '/api/admin/email-contacts'
        headers = {'Authorization': 'Bearer ' + _create_token(str(admin_id))}
        user_headers = {'Authorization': 'Bearer ' + _create_token(str(user_id))}
        async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url='http://test') as client:
            for method in ('get', 'post'):
                kwargs = {'json': {'email': 'test@example.com'}} if method == 'post' else {}
                assert (await getattr(client, method)(endpoint, **kwargs)).status_code == 401
                assert (await getattr(client, method)(endpoint, headers=user_headers, **kwargs)).status_code == 403
            empty = await client.get(endpoint, headers=headers)
            assert empty.json() == {'contacts': [], 'total': 0}
            created = await client.post(endpoint, headers=headers, json={'email': '  Test@Example.COM  '})
            assert created.status_code == 201, created.text
            assert created.json()['email'] == 'test@example.com'
            duplicate = await client.post(endpoint, headers=headers, json={'email': 'TEST@example.com'})
            assert duplicate.status_code == 409
            for value in ('', 'bad-address', 'a@', 'one@example.com,two@example.com', 'x' * 255 + '@example.com'):
                assert (await client.post(endpoint, headers=headers, json={'email': value})).status_code == 422
            concurrent = await asyncio.gather(*[
                client.post(endpoint, headers=headers, json={'email': 'second@example.com'}) for _ in range(2)
            ])
            assert sorted(response.status_code for response in concurrent) == [201, 409]
            page = (await client.get(endpoint + '?limit=1&offset=1', headers=headers)).json()
            assert page['total'] == 2 and len(page['contacts']) == 1
            assert page['contacts'][0]['email'] == 'test@example.com'
            assert page['contacts'][0]['created_at']
            for query in ('?limit=0', '?limit=101', '?offset=-1'):
                assert (await client.get(endpoint + query, headers=headers)).status_code == 422
            assert await connection.fetchval(f'SELECT COUNT(*) FROM {schema}.admin_email_contacts') == 2
        print('PASS: admin-only access, persisted normalized emails, validation, concurrent duplicate protection, list pagination and idempotent migration.')
    finally:
        await db.close_pool()
        await connection.execute(f'DROP SCHEMA {schema} CASCADE')
        await connection.close()


if __name__ == '__main__':
    asyncio.run(main())
