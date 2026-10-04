import os
import uuid
from typing import Optional

from fastapi import APIRouter, Depends, File, HTTPException, Query, UploadFile
from fastapi.responses import FileResponse
from pydantic import BaseModel, Field

import db
from config import BOOK_IMAGES_PATH
from routes.admin import require_admin

router = APIRouter(prefix="/api/books", tags=["books"])

ALLOWED_IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".webp", ".gif"}
MAX_IMAGE_SIZE = 5 * 1024 * 1024  # 5MB


class CreateBookRequest(BaseModel):
    title: str = Field(..., min_length=1, max_length=200)
    description: str = Field(..., min_length=1, max_length=1000)
    content: str = Field(..., min_length=1, max_length=5000)
    price: str = Field(..., min_length=1, max_length=100)
    contact: str = Field(..., min_length=1, max_length=255)
    image_url: Optional[str] = Field(default=None, max_length=500)


class UpdateBookRequest(BaseModel):
    title: Optional[str] = Field(default=None, min_length=1, max_length=200)
    description: Optional[str] = Field(default=None, min_length=1, max_length=1000)
    content: Optional[str] = Field(default=None, min_length=1, max_length=5000)
    price: Optional[str] = Field(default=None, min_length=1, max_length=100)
    contact: Optional[str] = Field(default=None, min_length=1, max_length=255)
    image_url: Optional[str] = Field(default=None, max_length=500)


def _serialize(row: dict) -> dict:
    row["created_at"] = row["created_at"].isoformat()
    return row


@router.post("/upload-image")
async def upload_book_image(file: UploadFile = File(...), _: str = Depends(require_admin)):
    """Upload a cover image for a book. Returns the URL to use as image_url."""
    ext = os.path.splitext(file.filename or "")[1].lower()
    if ext not in ALLOWED_IMAGE_EXTENSIONS:
        raise HTTPException(status_code=400, detail="Unsupported image type")

    contents = await file.read()
    if len(contents) > MAX_IMAGE_SIZE:
        raise HTTPException(status_code=400, detail="Image too large (max 5MB)")

    os.makedirs(BOOK_IMAGES_PATH, exist_ok=True)
    filename = f"{uuid.uuid4().hex}{ext}"
    filepath = os.path.join(BOOK_IMAGES_PATH, filename)
    with open(filepath, "wb") as f:
        f.write(contents)

    return {"image_url": f"/api/books/images/{filename}"}


@router.get("/images/{filename}")
async def get_book_image(filename: str):
    file_path = os.path.abspath(os.path.join(BOOK_IMAGES_PATH, filename))
    if not os.path.isfile(file_path):
        raise HTTPException(status_code=404, detail="Image not found")
    return FileResponse(file_path)


@router.get("")
async def get_books(limit: int = Query(default=20, le=100), offset: int = Query(default=0, ge=0)):
    """Return books with pagination, ordered newest first."""
    books = await db.query(
        "SELECT id, title, description, content, price, contact, image_url, created_at "
        "FROM books ORDER BY created_at DESC LIMIT $1 OFFSET $2",
        limit,
        offset,
    )
    total = await db.query_one("SELECT COUNT(*) as count FROM books")
    return {"books": [_serialize(b) for b in books], "total": total["count"] if total else 0}


@router.get("/{book_id}")
async def get_book(book_id: int):
    book = await db.query_one(
        "SELECT id, title, description, content, price, contact, image_url, created_at FROM books WHERE id = $1",
        book_id,
    )
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    return _serialize(book)


@router.post("", status_code=201)
async def create_book(req: CreateBookRequest, _: str = Depends(require_admin)):
    book = await db.query_one(
        "INSERT INTO books (title, description, content, price, contact, image_url) "
        "VALUES ($1, $2, $3, $4, $5, $6) "
        "RETURNING id, title, description, content, price, contact, image_url, created_at",
        req.title.strip(),
        req.description.strip(),
        req.content.strip(),
        req.price.strip(),
        req.contact.strip(),
        req.image_url,
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
        await db.execute("UPDATE books SET price = $1 WHERE id = $2", req.price.strip(), book_id)
    if req.contact is not None:
        await db.execute("UPDATE books SET contact = $1 WHERE id = $2", req.contact.strip(), book_id)
    if req.image_url is not None:
        await db.execute("UPDATE books SET image_url = $1 WHERE id = $2", req.image_url, book_id)

    updated = await db.query_one(
        "SELECT id, title, description, content, price, contact, image_url, created_at FROM books WHERE id = $1",
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
