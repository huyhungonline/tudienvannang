"""Dictionary service for non-English source languages."""
import asyncio
from functools import partial
from deep_translator import GoogleTranslator

import db

# Map language codes to Google Translate codes
LANG_MAP = {
    "ja": "ja",
    "zh": "zh-CN",
    "vi": "vi",
    "en": "en",
}


def _translate_word(word: str, source_lang: str, target_lang: str) -> str:
    """Synchronous translation between any two languages."""
    try:
        src = LANG_MAP.get(source_lang, source_lang)
        tgt = LANG_MAP.get(target_lang, target_lang)
        # Add context to help Google Translate handle single words better
        result = GoogleTranslator(source=src, target=tgt).translate(word)
        if not result:
            # Retry with context sentence for short words
            padded = f"{word}の意味"  if source_lang == "ja" else f"{word} meaning"
            result = GoogleTranslator(source=src, target=tgt).translate(padded)
            # Strip the padding from result if possible
            if result:
                result = result.replace("의미", "").replace("meaning", "").replace("nghĩa của", "").replace("ý nghĩa", "").strip()
        return result if result else ""
    except Exception as e:
        print(f"Translation error ({source_lang} → {target_lang}): {word} --> {e}")
        return ""


async def get_or_create(word: str, source_language: str, reading: str = "", target_language: str = "en") -> dict:
    """Check DB cache, if miss → translate and save."""
    # Check cache for this specific source→target pair
    row = await db.query_one(
        "SELECT word, source_language, reading, meaning_en "
        "FROM word_dictionary_multilang WHERE word = $1 AND source_language = $2",
        word, source_language,
    )

    if row and target_language == "en":
        return {
            "word": row["word"],
            "reading": row["reading"] or "",
            "translation": row["meaning_en"] or "",
        }

    # For non-English target, always translate (don't cache non-English targets for now)
    loop = asyncio.get_running_loop()
    translation = await loop.run_in_executor(
        None, partial(_translate_word, word, source_language, target_language)
    )

    # Cache English translation if not cached yet
    if target_language == "en" and not row:
        await db.execute(
            "INSERT INTO word_dictionary_multilang (word, source_language, reading, meaning_en) "
            "VALUES ($1, $2, $3, $4) ON CONFLICT (word, source_language) DO NOTHING",
            word, source_language, reading, translation,
        )

    return {
        "word": word,
        "reading": reading,
        "translation": translation,
    }
