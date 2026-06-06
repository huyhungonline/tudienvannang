from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class SplitRequest(BaseModel):
    text: str
    targetLanguage: Optional[str] = "ja"


class WordEntry(BaseModel):
    word: str
    ipa: str
    audioData: Optional[str] = None
    translation: str


class ProcessedResult(BaseModel):
    words: list[WordEntry]
    sentenceTranslation: str
    message: Optional[str] = None


class AuthRequest(BaseModel):
    email: str
    password: str
    captchaToken: str


class UserResponse(BaseModel):
    id: str
    email: str
    createdAt: datetime


class AuthResponse(BaseModel):
    user: UserResponse
    token: str


class HistorySaveRequest(BaseModel):
    inputText: str
    words: list[WordEntry]
    targetLanguage: str
    sentenceTranslation: str


class SearchHistoryRecord(BaseModel):
    id: str
    userId: str
    inputText: str
    targetLanguage: str
    sentenceTranslation: str
    words: list[WordEntry]
    createdAt: datetime
