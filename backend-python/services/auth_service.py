import re
from datetime import datetime, timedelta, timezone

import bcrypt
import jwt
import httpx

import db
from config import JWT_SECRET, JWT_EXPIRY_DAYS, RECAPTCHA_SECRET_KEY


def validate_email(email: str) -> bool:
    if not email or not isinstance(email, str):
        return False
    at_index = email.find("@")
    if at_index < 1:
        return False
    domain = email[at_index + 1:]
    if not domain or "." not in domain[1:]:
        return False
    if domain.endswith("."):
        return False
    return True


def validate_password(password: str) -> bool:
    if not password or not isinstance(password, str):
        return False
    if len(password) < 8:
        return False
    if not re.search(r'[A-Z]', password):
        return False
    if not re.search(r'[a-z]', password):
        return False
    if not re.search(r'[0-9]', password):
        return False
    return True


async def verify_captcha(token: str) -> bool:
    """Verify reCAPTCHA token. Skip if no secret key configured."""
    if not RECAPTCHA_SECRET_KEY:
        return True
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            response = await client.post(
                "https://www.google.com/recaptcha/api/siteverify",
                data={
                    "secret": RECAPTCHA_SECRET_KEY,
                    "response": token,
                },
            )
            data = response.json()
            return data.get("success") is True
    except Exception:
        return False


def _hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')


def _verify_password(password: str, password_hash: str) -> bool:
    return bcrypt.checkpw(password.encode('utf-8'), password_hash.encode('utf-8'))


def _create_token(user_id: str) -> str:
    expire = datetime.now(timezone.utc) + timedelta(days=JWT_EXPIRY_DAYS)
    payload = {"userId": user_id, "exp": expire}
    return jwt.encode(payload, JWT_SECRET, algorithm="HS256")


async def register(email: str, password: str, captcha_token: str) -> dict:
    if not validate_email(email):
        raise ValueError("Invalid email format")

    if not validate_password(password):
        raise ValueError(
            "Password must be at least 8 characters with 1 uppercase, 1 lowercase, and 1 digit"
        )

    captcha_valid = await verify_captcha(captcha_token)
    if not captcha_valid:
        raise PermissionError("CAPTCHA verification failed")

    existing = await db.query_one("SELECT id FROM users WHERE email = $1", email)
    if existing:
        raise ValueError("Email already registered")

    password_hash = _hash_password(password)
    row = await db.query_one(
        "INSERT INTO users (email, password_hash) VALUES ($1, $2) RETURNING id, email, created_at",
        email, password_hash,
    )

    token = _create_token(str(row["id"]))
    return {
        "user": {
            "id": str(row["id"]),
            "email": row["email"],
            "createdAt": row["created_at"].isoformat(),
        },
        "token": token,
    }


async def login(email: str, password: str, captcha_token: str) -> dict:
    captcha_valid = await verify_captcha(captcha_token)
    if not captcha_valid:
        raise PermissionError("CAPTCHA verification failed")

    row = await db.query_one(
        "SELECT id, email, password_hash, created_at FROM users WHERE email = $1",
        email,
    )
    if not row:
        raise LookupError("Invalid credentials")

    if not _verify_password(password, row["password_hash"]):
        raise LookupError("Invalid credentials")

    token = _create_token(str(row["id"]))
    return {
        "user": {
            "id": str(row["id"]),
            "email": row["email"],
            "createdAt": row["created_at"].isoformat(),
        },
        "token": token,
    }


def verify_token(token: str) -> dict | None:
    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        return {"userId": payload["userId"]}
    except jwt.PyJWTError:
        return None
