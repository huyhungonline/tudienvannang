import logging
import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse
from config import AUDIO_FILES_PATH
from models import SpeakRequest, SpeakResponse
from services import tts_service

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/audio")


@router.get("/{filename}")
async def get_audio(filename: str):
    file_path = os.path.join(AUDIO_FILES_PATH, filename)
    file_path = os.path.abspath(file_path)

    if not os.path.isfile(file_path):
        raise HTTPException(status_code=404, detail="Audio file not found")

    return FileResponse(file_path, media_type="audio/mpeg")


@router.post("/speak", response_model=SpeakResponse)
async def speak(body: SpeakRequest):
    text = body.text.strip()
    if not text:
        raise HTTPException(status_code=400, detail="Text cannot be empty")

    try:
        audio_data = await tts_service.synthesize_speech(text, body.language)
    except Exception as e:
        logger.error(f"TTS synthesis failed: {e}")
        raise HTTPException(status_code=502, detail="Speech generation is temporarily unavailable")

    return SpeakResponse(audioData=audio_data)
