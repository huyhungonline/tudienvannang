"""Payment marker integration check in an isolated PostgreSQL schema."""
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
    schema = 'workbook_payment_test_' + uuid.uuid4().hex
    conn = await asyncpg.connect(DATABASE_URL)
    await conn.execute(f'CREATE SCHEMA {schema}')
    db._pool = await asyncpg.create_pool(DATABASE_URL, server_settings={'search_path': schema})
    try:
        for migration in ('033_workbook_orders.sql', '034_workbook_order_payment.sql', '035_workbook_order_shipping.sql', '035_workbook_order_shipping.sql'):
            await db.execute((root / 'backend-python/migrations' / migration).read_text())
        await db.execute('CREATE TABLE users (id UUID PRIMARY KEY, is_admin BOOLEAN NOT NULL)')
        admin_id, user_id, order_id = uuid.uuid4(), uuid.uuid4(), uuid.uuid4()
        await db.execute('INSERT INTO users VALUES ($1, TRUE), ($2, FALSE)', admin_id, user_id)
        await db.execute("INSERT INTO workbook_orders (id,full_name,email,book_address) VALUES ($1,'Test','test@example.com','Tokyo')", order_id)
        spec = importlib.util.spec_from_file_location('payment_routes_test', root / 'backend-python/routes/class_registrations.py')
        routes = importlib.util.module_from_spec(spec)
        sys.modules[spec.name] = routes
        spec.loader.exec_module(routes)
        app = FastAPI()
        app.include_router(routes.router)
        headers = {'Authorization': 'Bearer ' + _create_token(str(admin_id))}
        user_headers = {'Authorization': 'Bearer ' + _create_token(str(user_id))}
        endpoint = f'/api/classes/workbook-orders/{order_id}/payment'
        async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url='http://test') as client:
            assert (await client.put(endpoint, json={'paid': True})).status_code == 401
            assert (await client.put(endpoint, headers=user_headers, json={'paid': True})).status_code == 403
            first = await client.put(endpoint, headers=headers, json={'paid': True})
            assert first.status_code == 200 and first.json()['paid_at'], first.text
            repeated = await client.put(endpoint, headers=headers, json={'paid': True})
            assert repeated.json()['paid_at'] == first.json()['paid_at']
            listed = await client.get('/api/classes/workbook-orders', headers=headers)
            assert listed.json()['orders'][0]['paid_at'] == first.json()['paid_at']
            for value in ('true', 1, None):
                assert (await client.put(endpoint, headers=headers, json={'paid': value})).status_code == 422
            assert (await client.put(f'/api/classes/workbook-orders/{uuid.uuid4()}/payment', headers=headers, json={'paid': True})).status_code == 404
            undone = await client.put(endpoint, headers=headers, json={'paid': False})
            assert undone.status_code == 200 and undone.json()['paid_at'] is None
            assert await conn.fetchval(f'SELECT paid_at FROM {schema}.workbook_orders WHERE id=$1', order_id) is None
            shipping = f'/api/classes/workbook-orders/{order_id}/shipping'
            assert (await client.put(shipping, json={'shipped': True})).status_code == 401
            assert (await client.put(shipping, headers=user_headers, json={'shipped': True})).status_code == 403
            shipped = await client.put(shipping, headers=headers, json={'shipped': True})
            assert shipped.status_code == 200 and shipped.json()['shipped_at'], shipped.text
            repeated = await client.put(shipping, headers=headers, json={'shipped': True})
            assert repeated.json()['shipped_at'] == shipped.json()['shipped_at']
            listed = await client.get('/api/classes/workbook-orders', headers=headers)
            assert listed.json()['orders'][0]['shipped_at'] == shipped.json()['shipped_at']
            assert listed.json()['orders'][0]['paid_at'] is None
            for value in ('true', 1, None):
                assert (await client.put(shipping, headers=headers, json={'shipped': value})).status_code == 422
            assert (await client.put(f'/api/classes/workbook-orders/{uuid.uuid4()}/shipping', headers=headers, json={'shipped': True})).status_code == 404
            undone = await client.put(shipping, headers=headers, json={'shipped': False})
            assert undone.status_code == 200 and undone.json()['shipped_at'] is None
            assert await conn.fetchval(f'SELECT shipped_at FROM {schema}.workbook_orders WHERE id=$1', order_id) is None
            delete_endpoint = f'/api/classes/workbook-orders/{order_id}'
            assert (await client.delete(delete_endpoint)).status_code == 401
            assert (await client.delete(delete_endpoint, headers=user_headers)).status_code == 403
            assert await conn.fetchval(f'SELECT COUNT(*) FROM {schema}.workbook_orders') == 1
            assert (await client.delete(delete_endpoint, headers=headers)).status_code == 200
            assert await conn.fetchval(f'SELECT COUNT(*) FROM {schema}.workbook_orders') == 0
            assert (await client.delete(delete_endpoint, headers=headers)).status_code == 404
            assert (await client.delete('/api/classes/workbook-orders/invalid', headers=headers)).status_code == 422
        print('PASS: payment, shipment persistence/undo/idempotency, admin-only access and deletion, missing order and invalid input handling.')
    finally:
        await db.close_pool()
        await conn.execute(f'DROP SCHEMA {schema} CASCADE')
        await conn.close()


if __name__ == '__main__':
    asyncio.run(main())
