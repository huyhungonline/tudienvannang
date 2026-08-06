from enum import Enum
from typing import Optional

from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel, Field

import db

router = APIRouter(prefix="/api/reading-posts", tags=["reading-posts"])


class PostLevel(str, Enum):
    N1 = "N1"
    N2 = "N2"
    N3 = "N3"
    TOEIC = "TOEIC"


class CreatePostRequest(BaseModel):
    username: str = Field(..., min_length=1, max_length=50)
    title: str = Field(..., min_length=1, max_length=200)
    content: str = Field(..., min_length=1, max_length=5000)
    level: PostLevel


@router.get("")
async def get_reading_posts(
    level: Optional[str] = Query(default=None),
    limit: int = Query(default=10, le=100),
    offset: int = Query(default=0, ge=0),
):
    """Return reading posts with optional level filter and pagination, ordered by newest first."""
    if level:
        # Validate level value
        valid_levels = [e.value for e in PostLevel]
        if level not in valid_levels:
            raise HTTPException(status_code=400, detail=f"Invalid level. Must be one of: {', '.join(valid_levels)}")
        posts = await db.query(
            "SELECT id, username, title, content, level, like_count, created_at FROM reading_posts WHERE level = $1 ORDER BY created_at DESC LIMIT $2 OFFSET $3",
            level,
            limit,
            offset,
        )
        total = await db.query_one("SELECT COUNT(*) as count FROM reading_posts WHERE level = $1", level)
    else:
        posts = await db.query(
            "SELECT id, username, title, content, level, like_count, created_at FROM reading_posts ORDER BY created_at DESC LIMIT $1 OFFSET $2",
            limit,
            offset,
        )
        total = await db.query_one("SELECT COUNT(*) as count FROM reading_posts")

    for post in posts:
        post["created_at"] = post["created_at"].isoformat()
    return {"posts": posts, "total": total["count"] if total else 0}


@router.post("", status_code=201)
async def create_reading_post(req: CreatePostRequest):
    """Create a new reading post with title and level."""
    post = await db.query_one(
        "INSERT INTO reading_posts (username, title, content, level) VALUES ($1, $2, $3, $4) RETURNING id, username, title, content, level, like_count, created_at",
        req.username.strip(),
        req.title.strip(),
        req.content.strip(),
        req.level.value,
    )
    post["created_at"] = post["created_at"].isoformat()
    return post


@router.post("/{post_id}/like")
async def like_reading_post(post_id: int):
    """Increment like count for a post. No auth required."""
    result = await db.query_one(
        "UPDATE reading_posts SET like_count = like_count + 1 WHERE id = $1 RETURNING like_count",
        post_id,
    )
    if not result:
        raise HTTPException(status_code=404, detail="Post not found")
    return {"like_count": result["like_count"]}


class UpdatePostRequest(BaseModel):
    title: Optional[str] = Field(default=None, min_length=1, max_length=200)
    content: Optional[str] = Field(default=None, min_length=1, max_length=5000)
    level: Optional[PostLevel] = None


@router.put("/{post_id}")
async def update_reading_post(post_id: int, req: UpdatePostRequest):
    """Update a reading post (admin use)."""
    existing = await db.query_one("SELECT id FROM reading_posts WHERE id = $1", post_id)
    if not existing:
        raise HTTPException(status_code=404, detail="Post not found")

    if req.title is not None:
        await db.execute("UPDATE reading_posts SET title = $1 WHERE id = $2", req.title.strip(), post_id)
    if req.content is not None:
        await db.execute("UPDATE reading_posts SET content = $1 WHERE id = $2", req.content.strip(), post_id)
    if req.level is not None:
        await db.execute("UPDATE reading_posts SET level = $1 WHERE id = $2", req.level.value, post_id)

    updated = await db.query_one(
        "SELECT id, username, title, content, level, like_count, created_at FROM reading_posts WHERE id = $1", post_id
    )
    updated["created_at"] = updated["created_at"].isoformat()
    return updated


@router.delete("/{post_id}")
async def delete_reading_post(post_id: int):
    """Delete a reading post (admin use)."""
    existing = await db.query_one("SELECT id FROM reading_posts WHERE id = $1", post_id)
    if not existing:
        raise HTTPException(status_code=404, detail="Post not found")
    await db.execute("DELETE FROM reading_posts WHERE id = $1", post_id)
    return {"message": "Post deleted"}
