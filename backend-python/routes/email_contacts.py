from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, EmailStr, field_validator

import db
from routes.admin import require_admin

router = APIRouter(prefix="/api/admin/email-contacts", tags=["admin-email-contacts"])


class EmailContactRequest(BaseModel):
    email: EmailStr

    @field_validator("email", mode="before")
    @classmethod
    def normalize_email(cls, value):
        return value.strip().lower() if isinstance(value, str) else value


@router.post("", status_code=201)
async def create_contact(body: EmailContactRequest, _: str = Depends(require_admin)):
    email = str(body.email).lower()
    if len(email) > 254:
        raise HTTPException(status_code=422, detail="Email must be at most 254 characters")
    row = await db.query_one(
        """INSERT INTO admin_email_contacts (email) VALUES ($1)
        ON CONFLICT (email) DO NOTHING RETURNING id, email, created_at""",
        email,
    )
    if not row:
        raise HTTPException(status_code=409, detail="Email already saved")
    return row


@router.get("")
async def list_contacts(
    limit: int = Query(50, ge=1, le=100),
    offset: int = Query(0, ge=0),
    _: str = Depends(require_admin),
):
    rows = await db.query(
        """SELECT id, email, created_at FROM admin_email_contacts
        ORDER BY created_at DESC, id DESC LIMIT $1 OFFSET $2""",
        limit, offset,
    )
    total = await db.query_one("SELECT COUNT(*) AS total FROM admin_email_contacts")
    return {"contacts": rows, "total": total["total"]}
