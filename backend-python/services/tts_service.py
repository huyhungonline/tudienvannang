"""TTS Service - Generate audio MP3 base64 for words using gTTS."""
import asyncio
import base64
import io

from gtts import gTTS

GTTS_LANG_MAP = {
    "en": "en",
    "ja": "ja",
    "vi": "vi",
    "zh": "zh-CN",
}


def _generate_audio_sync(word: str, language: str) -> str | None:
    """Synchronous gTTS audio generation. Returns base64 MP3 or None."""
    lang_code = GTTS_LANG_MAP.get(language)
    if not lang_code:
        return None
    try:
        tts = gTTS(text=word, lang=lang_code)
        buf = io.BytesIO()
        tts.write_to_fp(buf)
        buf.seek(0)
        return base64.b64encode(buf.read()).decode("utf-8")
    except Exception as e:
        print(f"TTS error ({language}): {word} --> {e}")
        return None


async def generate_audio_base64(word: str, language: str) -> str | None:
    """Generate MP3 audio for a word, return base64 string or None on failure."""
    return await asyncio.to_thread(_generate_audio_sync, word, language)
