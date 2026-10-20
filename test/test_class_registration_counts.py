"""Verify class totals across pages using an isolated PostgreSQL schema."""
import asyncio
import importlib.util
from pathlib import Path
import sys
import uuid
import asyncpg
from fastapi import FastAPI, HTTPException
import httpx
import db
from config import DATABASE_URL


async def main():
    root = Path(__file__).resolve().parents[1]
    schema = 'class_counts_test_' + uuid.uuid4().hex
    conn = await asyncpg.connect(DATABASE_URL)
    await conn.execute(f'CREATE SCHEMA {schema}')
    db._pool = await asyncpg.create_pool(DATABASE_URL, server_settings={'search_path': schema})
    try:
        for filename in ('031_class_registrations.sql', '032_class_registration_schedule.sql'):
            await db.execute((root / 'backend-python/migrations' / filename).read_text())
        spec = importlib.util.spec_from_file_location('counts_routes_test', root / 'backend-python/routes/class_registrations.py')
        routes = importlib.util.module_from_spec(spec)
        sys.modules[spec.name] = routes
        spec.loader.exec_module(routes)
        app = FastAPI()
        app.include_router(routes.router)
        async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url='http://test') as client:
            endpoint = '/api/classes/registrations'
            assert (await client.get(endpoint)).status_code == 401
            app.dependency_overrides[routes.require_admin] = lambda: 'test-admin'
            empty = (await client.get(endpoint)).json()
            assert empty['total'] == 0 and empty['counts'] == []
            pool = await db.get_pool()
            expected = {('it-passport', 'sat-tue-20-22'): 55, ('it-passport', 'sun-thu-20-22'): 2, ('kikai-hozen', None): 3}
            rows = [(uuid.uuid4(), course, schedule) for (course, schedule), count in expected.items() for _ in range(count)]
            async with pool.acquire() as test_conn:
                await test_conn.executemany("""INSERT INTO class_registrations
                    (id, course, schedule, full_name, email, phone, book_address)
                    VALUES ($1,$2,$3,'Test','test@example.com','09012345678','Tokyo')""", rows)
            for offset in (0, 50, 100):
                response = (await client.get(endpoint + f'?limit=1&offset={offset}')).json()
                assert response['total'] == 60
                assert {(item['course'], item['schedule']): item['count'] for item in response['counts']} == expected
                assert len(response['registrations']) == (1 if offset < 60 else 0)
            delete_endpoint = endpoint + '/' + str(rows[0][0])
            app.dependency_overrides.clear()
            assert (await client.delete(delete_endpoint)).status_code == 401
            async def not_admin():
                raise HTTPException(status_code=403, detail='Admin access required')
            app.dependency_overrides[routes.require_admin] = not_admin
            assert (await client.delete(delete_endpoint)).status_code == 403
            assert await conn.fetchval(f'SELECT COUNT(*) FROM {schema}.class_registrations') == 60
            app.dependency_overrides[routes.require_admin] = lambda: 'test-admin'
            assert (await client.delete(delete_endpoint)).status_code == 200
            assert (await client.delete(delete_endpoint)).status_code == 404
            assert (await client.delete(endpoint + '/invalid')).status_code == 422
            after = (await client.get(endpoint)).json()
            assert after['total'] == 59
            after_counts = {(x['course'], x['schedule']): x['count'] for x in after['counts']}
            assert after_counts[('it-passport', 'sat-tue-20-22')] == 54
            assert after_counts[('it-passport', 'sun-thu-20-22')] == 2
            assert after_counts[('kikai-hozen', None)] == 3
        print('PASS: class counts, admin-only persisted deletion, denied requests preserve data, invalid/missing IDs and refreshed counts after deletion.')
    finally:
        await db.close_pool()
        await conn.execute(f'DROP SCHEMA {schema} CASCADE')
        await conn.close()


if __name__ == '__main__':
    asyncio.run(main())
