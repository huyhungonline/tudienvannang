import asyncio
import base64
import io
from functools import lru_cache, partial

from gtts import gTTS

LANG_MAP = {
    "en": "en",
    "ja": "ja",
    "vi": "vi",
    "zh": "zh-CN",
}

MAX_TEXT_LENGTH = 1000


def _synthesize(text: str, lang: str) -> str:
    """Blocking gTTS call - runs in a worker thread. Result is cached since
    the free Google TTS endpoint is rate-limited and identical text/language
    pairs are common (repeated searches, translated sentences)."""
    buffer = io.BytesIO()
    gTTS(text=text, lang=lang).write_to_fp(buffer)
    return base64.b64encode(buffer.getvalue()).decode("utf-8")


@lru_cache(maxsize=200)
def _synthesize_cached(text: str, lang: str) -> str:
    return _synthesize(text, lang)


async def synthesize_speech(text: str, language: str) -> str:
    """Generate base64-encoded MP3 audio for text via gTTS (free, no API key)."""
    lang_code = LANG_MAP.get(language, "en")
    trimmed = text.strip()[:MAX_TEXT_LENGTH]
    loop = asyncio.get_running_loop()
    return await loop.run_in_executor(None, partial(_synthesize_cached, trimmed, lang_code))
