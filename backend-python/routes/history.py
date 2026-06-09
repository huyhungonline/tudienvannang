from fastapi import APIRouter, Depends, HTTPException
from models import HistorySaveRequest
from services import history_service
from middleware.auth import get_current_user

router = APIRouter(prefix="/api/history")


@router.get("")
async def list_history(user_id: str = Depends(get_current_user)):
    try:
        records = await history_service.get_all(user_id)
        return {"records": records}
    except Exception as e:
        print(f"History list error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")


@router.get("/recent-public")
async def list_recent_public():
    """Get recent search texts from all users (public, no auth required)."""
    try:
        records = await history_service.get_recent_public()
        return {"records": records}
    except Exception as e:
        print(f"Recent public history error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")


@router.get("/{record_id}")
async def get_history(record_id: str, user_id: str = Depends(get_current_user)):
    try:
        record = await history_service.get_by_id(user_id, record_id)
        if not record:
            raise HTTPException(status_code=404, detail="Record not found")
        return {"record": record}
    except HTTPException:
        raise
    except Exception as e:
        print(f"History get error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("", status_code=201)
async def save_history(body: HistorySaveRequest, user_id: str = Depends(get_current_user)):
    try:
        words_dicts = [w.model_dump() for w in body.words]
        record = await history_service.save(
            user_id,
            body.inputText,
            body.targetLanguage,
            body.sentenceTranslation,
            words_dicts,
        )
        return {"record": record}
    except Exception as e:
        print(f"History save error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")


@router.delete("/{record_id}")
async def delete_history(record_id: str, user_id: str = Depends(get_current_user)):
    try:
        deleted = await history_service.delete_record(user_id, record_id)
        if not deleted:
            raise HTTPException(status_code=404, detail="Record not found")
        return {"success": True}
    except HTTPException:
        raise
    except Exception as e:
        print(f"History delete error: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")
