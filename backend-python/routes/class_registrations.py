from datetime import date
from typing import Literal
from uuid import UUID, uuid4

from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, EmailStr, Field, StrictBool, field_validator, model_validator

import db
from routes.admin import require_admin

router = APIRouter(prefix='/api/classes', tags=['class-registrations'])

def registration_confirmation(full_name: str, class_name: str, first_lesson_date) -> tuple[str, str]:
    """Build the confirmation mail from the class session record."""
    if first_lesson_date:
        lesson_line = f'Buổi học đầu tiên: ngày {first_lesson_date.strftime("%d/%m/%Y")}.\n'
    else:
        lesson_line = 'Thời gian buổi học đầu tiên sẽ được thông báo qua email.\n'
    return ('Xác nhận đăng kí lớp IT Passport miễn phí – Táo Giáo Dục',
            f'Chào {full_name},\n\n'
            'Bạn đã đăng kí thành công lớp luyện thi IT Passport miễn phí.\n\n'
            f'Lớp đã chọn: {class_name}.\n'
            f'{lesson_line}'
            'Hình thức học: Online qua Google Meet. Link tham gia sẽ được gửi đến email bạn đã đăng ký trước khi lớp bắt đầu.\n\n'
            'Nếu muốn đăng kí in sách bài tập và luyện đề (bản dịch tiếng Việt), bạn truy cập:\n'
            'https://taogiaoduc.com/dang-ki-in-sach-bai-tap\n'
            'Đăng kí in tài liệu không bắt buộc. Thông tin thanh toán được hiển thị trên trang đăng kí.\n\n'
            'Hẹn gặp bạn trong lớp học!\nTáo Giáo Dục')


@router.get('/sessions')
async def list_public_class_sessions(course: str = Query(...)):
    """Active classes a visitor may register for, with remaining seats."""
    rows = await db.query('''SELECT s.code, s.name, s.first_lesson_date, s.capacity,
               (SELECT COUNT(*) FROM class_registrations r
                 WHERE r.course = s.course AND r.schedule = s.code) AS taken
        FROM class_sessions s
        WHERE s.course = $1 AND s.is_active = true
        ORDER BY s.sort_order, s.id''', course)
    return {'sessions': [{
        'code': r['code'],
        'name': r['name'],
        'firstLessonDate': r['first_lesson_date'].isoformat() if r['first_lesson_date'] else None,
        'capacity': r['capacity'],
        'taken': r['taken'],
        'isFull': r['taken'] >= r['capacity'],
    } for r in rows]}


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
    rows = await db.query('''SELECT id,full_name,email,book_address,created_at,paid_at,shipped_at
        FROM workbook_orders ORDER BY created_at DESC,id LIMIT $1 OFFSET $2''', limit, offset)
    total = await db.query_one('SELECT COUNT(*) AS total FROM workbook_orders')
    return {'orders': rows, 'total': total['total']}


class WorkbookPaymentRequest(BaseModel):
    paid: StrictBool


@router.delete('/workbook-orders/{order_id}')
async def delete_workbook_order(order_id: UUID, _: str = Depends(require_admin)):
    row = await db.query_one('DELETE FROM workbook_orders WHERE id = $1 RETURNING id', order_id)
    if not row:
        raise HTTPException(status_code=404, detail='Workbook order not found')
    return {'message': 'Workbook order deleted'}


@router.put('/workbook-orders/{order_id}/payment')
async def update_workbook_payment(order_id: UUID, body: WorkbookPaymentRequest, _: str = Depends(require_admin)):
    row = await db.query_one('''UPDATE workbook_orders
        SET paid_at = CASE WHEN $2 THEN COALESCE(paid_at, NOW()) ELSE NULL END
        WHERE id = $1 RETURNING id, paid_at''', order_id, body.paid)
    if not row:
        raise HTTPException(status_code=404, detail='Workbook order not found')
    return row


class WorkbookShippingRequest(BaseModel):
    shipped: StrictBool


@router.put('/workbook-orders/{order_id}/shipping')
async def update_workbook_shipping(order_id: UUID, body: WorkbookShippingRequest, _: str = Depends(require_admin)):
    row = await db.query_one('''UPDATE workbook_orders
        SET shipped_at = CASE WHEN $2 THEN COALESCE(shipped_at, NOW()) ELSE NULL END
        WHERE id = $1 RETURNING id, shipped_at''', order_id, body.shipped)
    if not row:
        raise HTTPException(status_code=404, detail='Workbook order not found')
    return row


class RegistrationRequest(BaseModel):
    request_id: UUID
    # 'kikai-hozen' is retained so historical records stay valid, but it is no
    # longer offered in the UI; 'qc-kentei-3' replaces it.
    course: Literal['it-passport', 'kikai-hozen', 'qc-kentei-3']
    full_name: str = Field(min_length=1, max_length=150)
    email: EmailStr
    phone: str = Field(min_length=6, max_length=30)
    book_address: str = Field(default='', max_length=1000)
    # Class codes are admin-managed, so this cannot be a fixed Literal.
    # Existence and availability are checked against class_sessions on insert.
    schedule: str | None = Field(default=None, max_length=100)

    @model_validator(mode='after')
    def validate_schedule(self):
        if self.course == 'it-passport' and not self.schedule:
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
    pool = await db.get_pool()
    async with pool.acquire() as conn:
        async with conn.transaction():
            # Serialize registration writes so concurrent requests cannot take the last seat twice.
            await conn.execute('LOCK TABLE class_registrations IN SHARE ROW EXCLUSIVE MODE')
            existing = await conn.fetchrow('SELECT course,full_name,email,phone,book_address,schedule FROM class_registrations WHERE id=$1', body.request_id)
            if existing:
                if tuple(existing[key] for key in ('course', 'full_name', 'email', 'phone', 'book_address', 'schedule')) != values[1:]:
                    raise HTTPException(status_code=409, detail='Request ID already used')
            else:
                session = None
                if body.course == 'it-passport':
                    session = await conn.fetchrow('''SELECT name, first_lesson_date, capacity, is_active
                        FROM class_sessions WHERE course=$1 AND code=$2''', body.course, body.schedule)
                    if not session:
                        raise HTTPException(status_code=400, detail='Lớp học không tồn tại')
                    # Guard against a class being closed while the form was open.
                    if not session['is_active']:
                        raise HTTPException(status_code=409, detail='Lớp này đã đóng đăng kí, vui lòng chọn lớp khác')
                    count = await conn.fetchval('SELECT COUNT(*) FROM class_registrations WHERE course=$1 AND schedule=$2', body.course, body.schedule)
                    if count >= session['capacity']:
                        raise HTTPException(status_code=409, detail='Lớp đã đầy, vui lòng chọn khung giờ khác')
                await conn.execute('''INSERT INTO class_registrations
                    (id,course,full_name,email,phone,book_address,schedule) VALUES ($1,$2,$3,$4,$5,$6,$7)''', *values)
                if body.course == 'it-passport' and session:
                    subject, content = registration_confirmation(
                        body.full_name, session['name'], session['first_lesson_date'])
                    job_id = uuid4()
                    await conn.execute('INSERT INTO mail_jobs (id,subject,content) VALUES ($1,$2,$3)', job_id, subject, content)
                    await conn.execute('INSERT INTO mail_job_recipients (job_id,email) VALUES ($1,$2)', job_id, str(body.email))
    return {'registrationId': str(body.request_id), 'message': 'Registration saved'}


@router.get('/registrations')
async def list_registrations(limit: int = Query(50, ge=1, le=100), offset: int = Query(0, ge=0), _: str = Depends(require_admin)):
    rows = await db.query('''SELECT id,course,full_name,email,phone,book_address,schedule,created_at
        FROM class_registrations ORDER BY created_at DESC,id LIMIT $1 OFFSET $2''', limit, offset)
    counts = await db.query('''SELECT course, schedule, COUNT(*) AS count
        FROM class_registrations GROUP BY course, schedule ORDER BY course, schedule''')
    return {'registrations': rows, 'total': sum(item['count'] for item in counts), 'counts': counts}


@router.delete('/registrations/{registration_id}')
async def delete_class_registration(registration_id: UUID, _: str = Depends(require_admin)):
    row = await db.query_one('DELETE FROM class_registrations WHERE id = $1 RETURNING id', registration_id)
    if not row:
        raise HTTPException(status_code=404, detail='Class registration not found')
    return {'message': 'Class registration deleted'}


# === Admin: class session management ===

class ClassSessionCreate(BaseModel):
    course: Literal['it-passport', 'kikai-hozen', 'qc-kentei-3'] = 'it-passport'
    code: str = Field(min_length=1, max_length=100)
    name: str = Field(min_length=1, max_length=200)
    # Typed as `date` so asyncpg receives a real date object; it will not
    # coerce a plain string even with an explicit ::date cast in the SQL.
    first_lesson_date: date | None = None
    capacity: int = Field(default=110, ge=1, le=10000)
    is_active: StrictBool = True
    sort_order: int = Field(default=0)

    @field_validator('first_lesson_date', mode='before')
    @classmethod
    def empty_date_to_none(cls, value):
        # The admin form submits '' when the field is left blank.
        return None if value in ('', None) else value

    @field_validator('code', 'name', mode='before')
    @classmethod
    def trim_text(cls, value):
        return value.strip() if isinstance(value, str) else value

    @field_validator('code')
    @classmethod
    def validate_code(cls, value):
        # Used in URLs and form values, so keep it to a safe character set.
        if not all(char.isalnum() or char in '-_' for char in value):
            raise ValueError('Code may only contain letters, numbers, - and _')
        return value


class ClassSessionUpdate(BaseModel):
    name: str | None = Field(default=None, min_length=1, max_length=200)
    first_lesson_date: date | None = None
    capacity: int | None = Field(default=None, ge=1, le=10000)
    is_active: StrictBool | None = None
    sort_order: int | None = None

    @field_validator('first_lesson_date', mode='before')
    @classmethod
    def empty_date_to_none(cls, value):
        return None if value in ('', None) else value


@router.get('/admin/sessions')
async def list_class_sessions(_: str = Depends(require_admin)):
    """All classes including inactive ones, with current registration counts."""
    rows = await db.query('''SELECT s.id, s.course, s.code, s.name, s.first_lesson_date,
               s.capacity, s.is_active, s.sort_order, s.created_at,
               (SELECT COUNT(*) FROM class_registrations r
                 WHERE r.course = s.course AND r.schedule = s.code) AS registrations
        FROM class_sessions s ORDER BY s.course, s.sort_order, s.id''')
    return {'sessions': rows}


@router.post('/admin/sessions', status_code=201)
async def create_class_session(body: ClassSessionCreate, _: str = Depends(require_admin)):
    existing = await db.query_one('SELECT id FROM class_sessions WHERE code = $1', body.code)
    if existing:
        raise HTTPException(status_code=409, detail='Mã lớp đã tồn tại')
    row = await db.query_one('''INSERT INTO class_sessions
        (course, code, name, first_lesson_date, capacity, is_active, sort_order)
        VALUES ($1,$2,$3,$4,$5,$6,$7)
        RETURNING id, course, code, name, first_lesson_date, capacity, is_active, sort_order''',
        body.course, body.code, body.name, body.first_lesson_date,
        body.capacity, body.is_active, body.sort_order)
    return row


@router.put('/admin/sessions/{session_id}')
async def update_class_session(session_id: int, body: ClassSessionUpdate, _: str = Depends(require_admin)):
    existing = await db.query_one('SELECT id FROM class_sessions WHERE id = $1', session_id)
    if not existing:
        raise HTTPException(status_code=404, detail='Không tìm thấy lớp học')

    if body.name is not None:
        await db.execute('UPDATE class_sessions SET name = $1 WHERE id = $2', body.name, session_id)
    if body.first_lesson_date is not None:
        await db.execute('UPDATE class_sessions SET first_lesson_date = $1 WHERE id = $2',
                         body.first_lesson_date, session_id)
    if body.capacity is not None:
        await db.execute('UPDATE class_sessions SET capacity = $1 WHERE id = $2', body.capacity, session_id)
    if body.is_active is not None:
        await db.execute('UPDATE class_sessions SET is_active = $1 WHERE id = $2', body.is_active, session_id)
    if body.sort_order is not None:
        await db.execute('UPDATE class_sessions SET sort_order = $1 WHERE id = $2', body.sort_order, session_id)

    return await db.query_one('''SELECT id, course, code, name, first_lesson_date,
        capacity, is_active, sort_order FROM class_sessions WHERE id = $1''', session_id)


@router.delete('/admin/sessions/{session_id}')
async def delete_class_session(session_id: int, _: str = Depends(require_admin)):
    """Delete a class. Refused when registrations already reference it, so
    existing sign-ups never lose the class they belong to."""
    row = await db.query_one('SELECT course, code FROM class_sessions WHERE id = $1', session_id)
    if not row:
        raise HTTPException(status_code=404, detail='Không tìm thấy lớp học')

    count = await db.query_one('''SELECT COUNT(*) AS n FROM class_registrations
        WHERE course = $1 AND schedule = $2''', row['course'], row['code'])
    if count and count['n'] > 0:
        raise HTTPException(status_code=409,
            detail=f'Lớp đã có {count["n"]} người đăng kí. Hãy chuyển sang trạng thái không hoạt động thay vì xoá.')

    await db.execute('DELETE FROM class_sessions WHERE id = $1', session_id)
    return {'message': 'Đã xoá lớp học'}
