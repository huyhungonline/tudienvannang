import uuid
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from typing import Optional

import db
from middleware.auth import get_current_user
from services.auth_service import validate_email, validate_password

router = APIRouter(prefix="/api/admin")


async def require_admin(user_id: str = Depends(get_current_user)) -> str:
    """Check that the current user is an admin."""
    uid = uuid.UUID(user_id)
    row = await db.query_one("SELECT is_admin FROM users WHERE id = $1", uid)
    if not row or not row.get("is_admin"):
        raise HTTPException(status_code=403, detail="Admin access required")
    return user_id


class CreateUserRequest(BaseModel):
    email: str
    password: str
    isAdmin: Optional[bool] = False


class UpdateUserRequest(BaseModel):
    email: Optional[str] = None
    password: Optional[str] = None
    isAdmin: Optional[bool] = None


@router.get("/users")
async def list_users(_: str = Depends(require_admin)):
    rows = await db.query(
        "SELECT id, email, is_admin, created_at FROM users ORDER BY created_at DESC"
    )
    return [
        {
            "id": str(r["id"]),
            "email": r["email"],
            "isAdmin": r["is_admin"],
            "createdAt": r["created_at"].isoformat(),
        }
        for r in rows
    ]


@router.post("/users", status_code=201)
async def create_user(body: CreateUserRequest, _: str = Depends(require_admin)):
    if not validate_email(body.email):
        raise HTTPException(status_code=400, detail="Invalid email format")
    if not validate_password(body.password):
        raise HTTPException(status_code=400, detail="Password must be at least 8 chars with 1 uppercase, 1 lowercase, 1 digit")

    existing = await db.query_one("SELECT id FROM users WHERE email = $1", body.email)
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")

    import bcrypt
    password_hash = bcrypt.hashpw(body.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    row = await db.query_one(
        "INSERT INTO users (email, password_hash, is_admin) VALUES ($1, $2, $3) RETURNING id, email, is_admin, created_at",
        body.email, password_hash, body.isAdmin or False,
    )
    return {
        "id": str(row["id"]),
        "email": row["email"],
        "isAdmin": row["is_admin"],
        "createdAt": row["created_at"].isoformat(),
    }


@router.put("/users/{user_id}")
async def update_user(user_id: str, body: UpdateUserRequest, _: str = Depends(require_admin)):
    uid = uuid.UUID(user_id)
    existing = await db.query_one("SELECT id FROM users WHERE id = $1", uid)
    if not existing:
        raise HTTPException(status_code=404, detail="User not found")

    if body.email is not None:
        if not validate_email(body.email):
            raise HTTPException(status_code=400, detail="Invalid email format")
        dup = await db.query_one("SELECT id FROM users WHERE email = $1 AND id != $2", body.email, uid)
        if dup:
            raise HTTPException(status_code=400, detail="Email already in use")
        await db.execute("UPDATE users SET email = $1 WHERE id = $2", body.email, uid)

    if body.password is not None:
        if not validate_password(body.password):
            raise HTTPException(status_code=400, detail="Password must be at least 8 chars with 1 uppercase, 1 lowercase, 1 digit")
        import bcrypt
        password_hash = bcrypt.hashpw(body.password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        await db.execute("UPDATE users SET password_hash = $1 WHERE id = $2", password_hash, uid)

    if body.isAdmin is not None:
        await db.execute("UPDATE users SET is_admin = $1 WHERE id = $2", body.isAdmin, uid)

    return {"message": "User updated"}


@router.delete("/users/{user_id}")
async def delete_user(user_id: str, admin_id: str = Depends(require_admin)):
    uid = uuid.UUID(user_id)
    if user_id == admin_id:
        raise HTTPException(status_code=400, detail="Cannot delete yourself")
    existing = await db.query_one("SELECT id FROM users WHERE id = $1", uid)
    if not existing:
        raise HTTPException(status_code=404, detail="User not found")
    await db.execute("DELETE FROM users WHERE id = $1", uid)
    return {"message": "User deleted"}
