"""Dictionary service for non-English source languages."""
import asyncio
from functools import partial
from deep_translator import GoogleTranslator

import db

# Map source language to Google Translate language code
SOURCE_LANG_MAP = {
    "ja": "ja",
    "zh": "zh-CN",
    "vi": "vi",
}


def _translate_to_english(word: str, source_lang: str) -> str:
    """Synchronous translation to English."""
    try:
        lang_code = SOURCE_LANG_MAP.get(source_lang, source_lang)
        result = GoogleTranslator(source=lang_code, target="en").translate(word)
        return result if result else ""
    except Exception as e:
        print(f"Translation error ({source_lang} → en): {e}")
        return ""


async def get_or_create(word: str, source_language: str, reading: str = "") -> dict:
    """Check DB cache, if miss → translate to English and save."""
    row = await db.query_one(
        "SELECT word, source_language, reading, meaning_en "
        "FROM word_dictionary_multilang WHERE word = $1 AND source_language = $2",
        word, source_language,
    )
    if row:
        return {
            "word": row["word"],
            "reading": row["reading"] or "",
            "meaningEn": row["meaning_en"] or "",
        }

    # Cache miss — translate
    loop = asyncio.get_running_loop()
    meaning_en = await loop.run_in_executor(
        None, partial(_translate_to_english, word, source_language)
    )

    # Save to cache
    await db.execute(
        "INSERT INTO word_dictionary_multilang (word, source_language, reading, meaning_en) "
        "VALUES ($1, $2, $3, $4) ON CONFLICT (word, source_language) DO NOTHING",
        word, source_language, reading, meaning_en,
    )

    return {
        "word": word,
        "reading": reading,
        "meaningEn": meaning_en,
    }
