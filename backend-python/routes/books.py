from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel, Field

import db
from routes.admin import require_admin

router = APIRouter(prefix="/api/books", tags=["books"])


class CreateBookRequest(BaseModel):
    title: str = Field(..., min_length=1, max_length=200)
    description: str = Field(..., min_length=1, max_length=1000)
    content: str = Field(..., min_length=1, max_length=5000)
    price: float = Field(..., ge=0)
    contact: str = Field(..., min_length=1, max_length=255)


class UpdateBookRequest(BaseModel):
    title: Optional[str] = Field(default=None, min_length=1, max_length=200)
    description: Optional[str] = Field(default=None, min_length=1, max_length=1000)
    content: Optional[str] = Field(default=None, min_length=1, max_length=5000)
    price: Optional[float] = Field(default=None, ge=0)
    contact: Optional[str] = Field(default=None, min_length=1, max_length=255)


def _serialize(row: dict) -> dict:
    row["created_at"] = row["created_at"].isoformat()
    row["price"] = float(row["price"])
    return row


@router.get("")
async def get_books(limit: int = Query(default=20, le=100), offset: int = Query(default=0, ge=0)):
    """Return books with pagination, ordered newest first."""
    books = await db.query(
        "SELECT id, title, description, content, price, contact, created_at "
        "FROM books ORDER BY created_at DESC LIMIT $1 OFFSET $2",
        limit,
        offset,
    )
    total = await db.query_one("SELECT COUNT(*) as count FROM books")
    return {"books": [_serialize(b) for b in books], "total": total["count"] if total else 0}


@router.get("/{book_id}")
async def get_book(book_id: int):
    book = await db.query_one(
        "SELECT id, title, description, content, price, contact, created_at FROM books WHERE id = $1",
        book_id,
    )
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    return _serialize(book)


@router.post("", status_code=201)
async def create_book(req: CreateBookRequest, _: str = Depends(require_admin)):
    book = await db.query_one(
        "INSERT INTO books (title, description, content, price, contact) "
        "VALUES ($1, $2, $3, $4, $5) RETURNING id, title, description, content, price, contact, created_at",
        req.title.strip(),
        req.description.strip(),
        req.content.strip(),
        req.price,
        req.contact.strip(),
    )
    return _serialize(book)


@router.put("/{book_id}")
async def update_book(book_id: int, req: UpdateBookRequest, _: str = Depends(require_admin)):
    existing = await db.query_one("SELECT id FROM books WHERE id = $1", book_id)
    if not existing:
        raise HTTPException(status_code=404, detail="Book not found")

    if req.title is not None:
        await db.execute("UPDATE books SET title = $1 WHERE id = $2", req.title.strip(), book_id)
    if req.description is not None:
        await db.execute("UPDATE books SET description = $1 WHERE id = $2", req.description.strip(), book_id)
    if req.content is not None:
        await db.execute("UPDATE books SET content = $1 WHERE id = $2", req.content.strip(), book_id)
    if req.price is not None:
        await db.execute("UPDATE books SET price = $1 WHERE id = $2", req.price, book_id)
    if req.contact is not None:
        await db.execute("UPDATE books SET contact = $1 WHERE id = $2", req.contact.strip(), book_id)

    updated = await db.query_one(
        "SELECT id, title, description, content, price, contact, created_at FROM books WHERE id = $1",
        book_id,
    )
    return _serialize(updated)


@router.delete("/{book_id}")
async def delete_book(book_id: int, _: str = Depends(require_admin)):
    existing = await db.query_one("SELECT id FROM books WHERE id = $1", book_id)
    if not existing:
        raise HTTPException(status_code=404, detail="Book not found")
    await db.execute("DELETE FROM books WHERE id = $1", book_id)
    return {"message": "Book deleted"}
