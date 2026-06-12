from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field

import db

router = APIRouter(prefix="/api/reading-posts", tags=["reading-posts"])


class CreatePostRequest(BaseModel):
    username: str = Field(..., min_length=1, max_length=50)
    content: str = Field(..., min_length=1, max_length=5000)


@router.get("")
async def get_reading_posts():
    """Return all reading posts ordered by newest first."""
    posts = await db.query(
        "SELECT id, username, content, like_count, created_at FROM reading_posts ORDER BY created_at DESC"
    )
    for post in posts:
        post["created_at"] = post["created_at"].isoformat()
    return {"posts": posts}


@router.post("", status_code=201)
async def create_reading_post(req: CreatePostRequest):
    """Create a new reading post."""
    post = await db.query_one(
        "INSERT INTO reading_posts (username, content) VALUES ($1, $2) RETURNING id, username, content, like_count, created_at",
        req.username.strip(),
        req.content.strip(),
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
