from fastapi import APIRouter, HTTPException
from models import AuthRequest
from services import auth_service

router = APIRouter(prefix="/api/auth")


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
