from typing import Literal
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, EmailStr, Field, field_validator, model_validator

import db
from routes.admin import require_admin

router = APIRouter(prefix='/api/classes', tags=['class-registrations'])


class WorkbookOrderRequest(BaseModel):
    request_id: UUID
    full_name: str = Field(min_length=1, max_length=150)
    email: EmailStr
    book_address: str = Field(min_length=1, max_length=1000)

    @field_validator('full_name', 'book_address', mode='before')
    @classmethod
    def trim_text(cls, value):
        return value.strip() if isinstance(value, str) else value


@router.post('/workbook-orders', status_code=201)
async def register_workbook(body: WorkbookOrderRequest):
    values = (body.request_id, body.full_name, str(body.email), body.book_address)
    row = await db.query_one('''INSERT INTO workbook_orders (id,full_name,email,book_address)
        VALUES ($1,$2,$3,$4) ON CONFLICT (id) DO NOTHING RETURNING id''', *values)
    if not row:
        existing = await db.query_one('SELECT full_name,email,book_address FROM workbook_orders WHERE id=$1', body.request_id)
        if tuple(existing[key] for key in ('full_name', 'email', 'book_address')) != values[1:]:
            raise HTTPException(status_code=409, detail='Request ID already used')
    return {'orderId': str(body.request_id), 'message': 'Workbook registration saved'}


@router.get('/workbook-orders')
async def list_workbook_orders(limit: int = Query(50, ge=1, le=100), offset: int = Query(0, ge=0), _: str = Depends(require_admin)):
    rows = await db.query('''SELECT id,full_name,email,book_address,created_at
        FROM workbook_orders ORDER BY created_at DESC,id LIMIT $1 OFFSET $2''', limit, offset)
    total = await db.query_one('SELECT COUNT(*) AS total FROM workbook_orders')
    return {'orders': rows, 'total': total['total']}


class RegistrationRequest(BaseModel):
    request_id: UUID
    course: Literal['it-passport', 'kikai-hozen']
    full_name: str = Field(min_length=1, max_length=150)
    email: EmailStr
    phone: str = Field(min_length=6, max_length=30)
    book_address: str = Field(default='', max_length=1000)
    schedule: Literal['sat-tue-20-22', 'sun-thu-20-22'] | None = None

    @model_validator(mode='after')
    def validate_schedule(self):
        if self.course == 'it-passport' and self.schedule is None:
            raise ValueError('Please select a class schedule')
        if self.course != 'it-passport' and self.schedule is not None:
            raise ValueError('Schedule is only available for IT Passport')
        return self

    @field_validator('full_name', 'phone', 'book_address', mode='before')
    @classmethod
    def trim_text(cls, value):
        return value.strip() if isinstance(value, str) else value

    @field_validator('phone')
    @classmethod
    def validate_phone(cls, value):
        if not 6 <= sum(char.isdigit() for char in value) <= 15:
            raise ValueError('Phone must contain between 6 and 15 digits')
        if any(not (char.isdigit() or char in '+-(). ') for char in value):
            raise ValueError('Invalid phone number')
        return value


@router.post('/registrations', status_code=201)
async def register_class(body: RegistrationRequest):
    values = (body.request_id, body.course, body.full_name, str(body.email), body.phone, body.book_address, body.schedule)
    row = await db.query_one('''INSERT INTO class_registrations
        (id,course,full_name,email,phone,book_address,schedule) VALUES ($1,$2,$3,$4,$5,$6,$7)
        ON CONFLICT (id) DO NOTHING RETURNING id''', *values)
    if not row:
        existing = await db.query_one('SELECT course,full_name,email,phone,book_address,schedule FROM class_registrations WHERE id=$1', body.request_id)
        if tuple(existing[key] for key in ('course', 'full_name', 'email', 'phone', 'book_address', 'schedule')) != values[1:]:
            raise HTTPException(status_code=409, detail='Request ID already used')
    return {'registrationId': str(body.request_id), 'message': 'Registration saved'}


@router.get('/registrations')
async def list_registrations(limit: int = Query(50, ge=1, le=100), offset: int = Query(0, ge=0), _: str = Depends(require_admin)):
    rows = await db.query('''SELECT id,course,full_name,email,phone,book_address,schedule,created_at
        FROM class_registrations ORDER BY created_at DESC,id LIMIT $1 OFFSET $2''', limit, offset)
    total = await db.query_one('SELECT COUNT(*) AS total FROM class_registrations')
    return {'registrations': rows, 'total': total['total']}
