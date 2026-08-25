"""Multilang dictionary cache service with batch operations."""
import db


async def batch_lookup(
    words: list[str], source_language: str, target_language: str
) -> dict[str, dict]:
    """
    Query cache for multiple words at once.
    Returns dict mapping word → {translation, reading, audio_data} for cache hits.
    """
    if not words:
        return {}
    try:
        rows = await db.query(
            "SELECT word, translation, reading, audio_data, meaning_en "
            "FROM word_dictionary_multilang "
            "WHERE word = ANY($1) AND source_language = $2 AND target_language = $3",
            words, source_language, target_language,
        )
        result = {}
        for row in rows:
            translation = row["translation"]
            # Legacy fallback: if translation is NULL but meaning_en exists and target is 'en'
            if not translation and target_language == "en" and row.get("meaning_en"):
                translation = row["meaning_en"]
            if translation:  # Only return cache hits with actual translations
                result[row["word"]] = {
                    "translation": translation,
                    "reading": row["reading"] or "",
                    "audio_data": row["audio_data"],
                }
        return result
    except Exception as e:
        print(f"Cache lookup error: {e}")
        return {}


async def batch_save(entries: list[dict]) -> None:
    """
    Insert multiple new translation entries into cache.
    Uses ON CONFLICT DO NOTHING to handle race conditions.
    Non-blocking: logs errors but doesn't raise.
    """
    if not entries:
        return
    try:
        for entry in entries:
            if not entry.get("translation"):
                continue  # Don't cache empty translations
            await db.execute(
                "INSERT INTO word_dictionary_multilang "
                "(word, source_language, target_language, translation, reading, audio_data, updated_at) "
                "VALUES ($1, $2, $3, $4, $5, $6, NOW()) "
                "ON CONFLICT (word, source_language, target_language) DO UPDATE SET "
                "translation = EXCLUDED.translation, audio_data = EXCLUDED.audio_data, updated_at = NOW()",
                entry["word"],
                entry["source_language"],
                entry["target_language"],
                entry["translation"],
                entry.get("reading", ""),
                entry.get("audio_data"),
            )
    except Exception as e:
        print(f"Cache save error: {e}")


async def get_or_create(
    word: str, source_language: str, reading: str = "", target_language: str = "en"
) -> dict:
    """Single-word cache lookup + translate. For backward compatibility."""
    cached = await batch_lookup([word], source_language, target_language)
    if word in cached:
        return {
            "word": word,
            "reading": cached[word]["reading"] or reading,
            "translation": cached[word]["translation"],
            "audio_data": cached[word]["audio_data"],
        }
    return {
        "word": word,
        "reading": reading,
        "translation": "",
        "audio_data": None,
    }
