import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse
from config import AUDIO_FILES_PATH

router = APIRouter(prefix="/api/audio")


@router.get("/{filename}")
async def get_audio(filename: str):
    file_path = os.path.join(AUDIO_FILES_PATH, filename)
    file_path = os.path.abspath(file_path)

    if not os.path.isfile(file_path):
        raise HTTPException(status_code=404, detail="Audio file not found")

    return FileResponse(file_path, media_type="audio/mpeg")
