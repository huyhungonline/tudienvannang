from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from middleware.auth import get_current_user
from services import classroom_service

router = APIRouter(prefix="/api")


class JoinSeatRequest(BaseModel):
    row_number: int
    seat_number: int


@router.get("/classroom")
async def get_classroom_state():
    """Returns the current classroom state (teacher + seats + total_students)."""
    try:
        state = await classroom_service.get_classroom_state()
        return {"classroom": state}
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/classroom/join")
async def join_seat(body: JoinSeatRequest, user_id: str = Depends(get_current_user)):
    """Assigns authenticated user to the specified seat."""
    try:
        result = await classroom_service.join_seat(user_id, body.row_number, body.seat_number)
        return result
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/classroom/leave")
async def leave_classroom(user_id: str = Depends(get_current_user)):
    """Removes authenticated user from their seat or teacher position."""
    try:
        result = await classroom_service.leave_classroom(user_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.post("/classroom/teacher")
async def become_teacher(user_id: str = Depends(get_current_user)):
    """Assigns authenticated user as the classroom teacher."""
    try:
        result = await classroom_service.become_teacher(user_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")


@router.get("/user/search-count")
async def get_search_count(user_id: str = Depends(get_current_user)):
    """Returns the authenticated user's search count."""
    try:
        count = await classroom_service.get_user_search_count(user_id)
        return {"search_count": count}
    except Exception:
        raise HTTPException(status_code=500, detail="Internal server error")
