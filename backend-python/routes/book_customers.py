"""Admin CRUD for book customers captured from social media."""
from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, Field, StrictBool

from routes.admin import require_admin
from services import book_customer_service

router = APIRouter(prefix="/api/book-customers", tags=["book-customers"])


class CustomerCreate(BaseModel):
    full_name: str = Field(min_length=1, max_length=200)
    phone: str | None = Field(default=None, max_length=50)
    email: str | None = Field(default=None, max_length=200)
    address: str | None = Field(default=None, max_length=1000)
    book_type: str | None = Field(default=None, max_length=200)
    note: str | None = Field(default=None, max_length=1000)


class CustomerUpdate(BaseModel):
    full_name: str | None = Field(default=None, min_length=1, max_length=200)
    phone: str | None = Field(default=None, max_length=50)
    email: str | None = Field(default=None, max_length=200)
    address: str | None = Field(default=None, max_length=1000)
    book_type: str | None = Field(default=None, max_length=200)
    note: str | None = Field(default=None, max_length=1000)


class StatusFlag(BaseModel):
    value: StrictBool


@router.get("")
async def list_customers(limit: int = Query(50, ge=1, le=200),
                         offset: int = Query(0, ge=0),
                         _: str = Depends(require_admin)):
    rows, total = await book_customer_service.list_customers(limit, offset)
    stats = await book_customer_service.get_stats()
    return {"customers": rows, "total": total, "stats": stats}


@router.post("", status_code=201)
async def create_customer(body: CustomerCreate, _: str = Depends(require_admin)):
    try:
        row = await book_customer_service.create_customer(
            full_name=body.full_name, phone=body.phone, email=body.email,
            address=body.address, book_type=body.book_type, note=body.note,
            source="admin",
        )
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    duplicates = await book_customer_service.find_duplicates(body.phone, body.email)
    # Exclude the row just created from its own duplicate list.
    return {"customer": row, "duplicates": [d for d in duplicates if d["id"] != row["id"]]}


@router.put("/{customer_id}")
async def update_customer(customer_id: int, body: CustomerUpdate,
                          _: str = Depends(require_admin)):
    row = await book_customer_service.update_customer(
        customer_id, body.model_dump(exclude_none=True))
    if not row:
        raise HTTPException(status_code=404, detail="Không tìm thấy khách hàng")
    return row


@router.put("/{customer_id}/payment")
async def set_payment(customer_id: int, body: StatusFlag, _: str = Depends(require_admin)):
    row = await book_customer_service.set_paid(customer_id, body.value)
    if not row:
        raise HTTPException(status_code=404, detail="Không tìm thấy khách hàng")
    return row


@router.put("/{customer_id}/shipping")
async def set_shipping(customer_id: int, body: StatusFlag, _: str = Depends(require_admin)):
    row = await book_customer_service.set_shipped(customer_id, body.value)
    if not row:
        raise HTTPException(status_code=404, detail="Không tìm thấy khách hàng")
    return row


@router.delete("/{customer_id}")
async def delete_customer(customer_id: int, _: str = Depends(require_admin)):
    if not await book_customer_service.delete_customer(customer_id):
        raise HTTPException(status_code=404, detail="Không tìm thấy khách hàng")
    return {"message": "Đã xoá khách hàng"}
