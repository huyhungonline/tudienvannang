from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from models import AuthRequest
from services import auth_service
from middleware.auth import get_current_user

router = APIRouter(prefix="/api/auth")


class ChangePasswordRequest(BaseModel):
    currentPassword: str
    newPassword: str


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
