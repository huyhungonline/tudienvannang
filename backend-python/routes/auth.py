from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from models import AuthRequest
from services import auth_service
from services.email_service import send_password_reset_email, send_email
from middleware.auth import get_current_user
import db
import secrets
import uuid
from datetime import datetime, timedelta, timezone

router = APIRouter(prefix="/api/auth")


class ChangePasswordRequest(BaseModel):
    currentPassword: str
    newPassword: str


class ForgotPasswordRequest(BaseModel):
    email: str


class ResetPasswordWithTokenRequest(BaseModel):
    token: str
    newPassword: str


@router.get("/test-email")
async def test_email_endpoint():
    """Temporary test endpoint to debug email sending from API context."""
    result = send_email("huyhungonline@gmail.com", "API email test", "This email was sent from an API endpoint.")
    return {"sent": result}


@router.post("/register", status_code=201)
async def register(body: AuthRequest):
    try:
        result = await auth_service.register(body.email, body.password, body.captchaToken)
        return result
    except PermissionError as e:
        raise HTTPException(status_code=403, detail=str(e))
    except ValueError as e:
        message = str(e)
        if message == "Email already registered":
            raise HTTPException(status_code=400, detail=message)
        raise HTTPException(status_code=400, detail=message)
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/login")
async def login(body: AuthRequest):
    try:
        result = await auth_service.login(body.email, body.password, body.captchaToken)
        return result
    except PermissionError as e:
        raise HTTPException(status_code=403, detail=str(e))
    except LookupError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/logout")
async def logout():
    return {"success": True}


@router.post("/change-password")
async def change_password(body: ChangePasswordRequest, user_id: str = Depends(get_current_user)):
    try:
        await auth_service.change_password(user_id, body.currentPassword, body.newPassword)
        return {"message": "Password changed successfully"}
    except LookupError as e:
        raise HTTPException(status_code=401, detail=str(e))
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/forgot-password")
async def forgot_password(body: ForgotPasswordRequest):
    """Generate new password and send to user email."""
    user = await db.query_one("SELECT id, email FROM users WHERE email = $1", body.email)
    if user:
        # Generate random password
        import string
        import random
        chars = string.ascii_letters + string.digits
        new_password = ''.join(random.choices(chars, k=10)) + 'A1!'  # ensure uppercase, digit, special

        # Update password in DB
        import bcrypt
        password_hash = bcrypt.hashpw(new_password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        await db.execute("UPDATE users SET password_hash = $1 WHERE id = $2", password_hash, user["id"])

        # Send email in separate thread (smtplib is blocking, avoid async conflict)
        import concurrent.futures
        with concurrent.futures.ThreadPoolExecutor() as executor:
            future = executor.submit(send_password_reset_email, body.email, new_password)
            result = future.result(timeout=15)
        print(f"[FORGOT-PASSWORD] Email to {body.email}: {'SENT' if result else 'FAILED'}")

    return {"message": "If the email exists, a new password has been sent."}


@router.post("/reset-password-with-token")
async def reset_password_with_token(body: ResetPasswordWithTokenRequest):
    """Reset password using token from email."""
    row = await db.query_one(
        "SELECT id, user_id, expires_at, used FROM password_reset_tokens WHERE token = $1",
        body.token,
    )
    if not row:
        raise HTTPException(status_code=400, detail="Invalid or expired reset link.")

    if row["used"]:
        raise HTTPException(status_code=400, detail="This reset link has already been used.")

    if row["expires_at"] < datetime.now(timezone.utc):
        raise HTTPException(status_code=400, detail="This reset link has expired.")

    if not auth_service.validate_password(body.newPassword):
        raise HTTPException(
            status_code=400,
            detail="Password must be at least 8 characters with 1 uppercase, 1 lowercase, and 1 digit",
        )

    # Update password
    import bcrypt
    password_hash = bcrypt.hashpw(body.newPassword.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
    user_id = row["user_id"]
    await db.execute("UPDATE users SET password_hash = $1 WHERE id = $2", password_hash, user_id)

    # Mark token as used
    await db.execute("UPDATE password_reset_tokens SET used = TRUE WHERE id = $1", row["id"])

    return {"message": "Password has been reset successfully."}
