from fastapi import HTTPException, Request

from services.auth_service import verify_token


def get_current_user(request: Request) -> str:
    """FastAPI dependency that extracts and verifies Bearer token from Authorization header."""
    auth_header = request.headers.get("authorization", "")

    if not auth_header or not auth_header.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Authentication required")

    token = auth_header[7:]
    payload = verify_token(token)

    if not payload:
        raise HTTPException(status_code=401, detail="Invalid or expired token")

    return payload["userId"]
