from pydantic import BaseModel, EmailStr, validator
from typing import Optional


class SubscribeRequest(BaseModel):
    email: EmailStr
    target_language: str

    @validator("target_language")
    def validate_target_language(cls, v):
        if v not in ("en", "vi"):
            raise ValueError("target_language must be 'en' or 'vi'")
        return v


class UnsubscribeRequest(BaseModel):
    email: EmailStr


class ScrapeResponse(BaseModel):
    success: bool
    new_articles: int
    deleted_old: int
    message: str


class DailyJobResponse(BaseModel):
    success: bool
    sent: int
    failed: int
    article_title: Optional[str] = None
