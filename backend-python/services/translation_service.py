import asyncio
from functools import partial
from deep_translator import GoogleTranslator
import eng_to_ipa
import httpx

LANG_MAP = {
    "ja": "ja",
    "vi": "vi",
    "zh": "zh-CN",
}

DICTIONARY_API_URL = "https://api.dictionaryapi.dev/api/v2/entries/en"


async def get_ipa_from_api(word: str) -> str:
    """Get IPA from Free Dictionary API (more accurate)."""
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            resp = await client.get(f"{DICTIONARY_API_URL}/{word}")
            if resp.status_code == 200:
                data = resp.json()
                if data and isinstance(data, list):
                    for entry in data:
                        phonetics = entry.get("phonetics", [])
                        for p in phonetics:
                            text = p.get("text", "")
                            if text:
                                return text
    except Exception:
        pass
    return ""


def get_ipa_offline(word: str) -> str:
    """Get IPA pronunciation using eng_to_ipa library (fallback)."""
    try:
        result = eng_to_ipa.convert(word)
        if not result or result == word or "*" in result:
            return "N/A"
        return result
    except Exception:
        return "N/A"


async def get_ipa_async(word: str) -> str:
    """Get IPA: try API first, fallback to offline."""
    api_result = await get_ipa_from_api(word)
    if api_result:
        return api_result
    loop = asyncio.get_running_loop()
    return await loop.run_in_executor(None, partial(get_ipa_offline, word))


def get_ipa(word: str) -> str:
    """Synchronous wrapper - used by dictionary_service via asyncio.to_thread."""
    try:
        result = eng_to_ipa.convert(word)
        if not result or result == word or "*" in result:
            return "N/A"
        return result
    except Exception:
        return "N/A"


def _do_translate(text: str, dest: str) -> str:
    """Synchronous translation using deep-translator."""
    try:
        result = GoogleTranslator(source="en", target=dest).translate(text)
        return result if result else "N/A"
    except Exception as e:
        print(f"Translation error: {e}")
        return "N/A"


async def translate_word(word: str, target_language: str) -> str:
    """Translate a single word using deep-translator."""
    lang_code = LANG_MAP.get(target_language, "ja")
    loop = asyncio.get_running_loop()
    return await loop.run_in_executor(None, partial(_do_translate, word, lang_code))


async def translate_sentence(text: str, target_language: str) -> str:
    """Translate a full sentence using deep-translator."""
    lang_code = LANG_MAP.get(target_language, "ja")
    loop = asyncio.get_running_loop()
    return await loop.run_in_executor(None, partial(_do_translate, text, lang_code))
