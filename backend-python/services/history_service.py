import uuid

import db


async def save(user_id: str, input_text: str, target_language: str, sentence_translation: str, words: list[dict]) -> dict:
    """Save a search history record with word entries."""
    pool = await db.get_pool()
    user_uuid = uuid.UUID(user_id)
    async with pool.acquire() as conn:
        async with conn.transaction():
            history_row = await conn.fetchrow(
                "INSERT INTO search_history (user_id, input_text, target_language, sentence_translation) "
                "VALUES ($1, $2, $3, $4) RETURNING id, created_at",
                user_uuid, input_text, target_language, sentence_translation,
            )
            history_id = history_row["id"]

            for i, w in enumerate(words):
                await conn.execute(
                    "INSERT INTO search_history_words "
                    "(search_history_id, word, ipa_pronunciation, audio_data, translation, position) "
                    "VALUES ($1, $2, $3, $4, $5, $6)",
                    history_id, w["word"], w.get("ipa", ""), w.get("audioData"), w.get("translation", ""), i,
                )

    return {
        "id": str(history_id),
        "userId": user_id,
        "inputText": input_text,
        "targetLanguage": target_language,
        "sentenceTranslation": sentence_translation,
        "words": words,
        "createdAt": history_row["created_at"].isoformat(),
    }


async def get_recent_public(limit: int = 20) -> list[dict]:
    """Get recent search texts from public_searches (auto-saved on every split)."""
    rows = await db.query(
        "SELECT DISTINCT ON (input_text) id, input_text, target_language, created_at "
        "FROM public_searches ORDER BY input_text, created_at DESC",
    )
    rows.sort(key=lambda r: r["created_at"], reverse=True)
    rows = rows[:limit]

    return [
        {
            "id": str(row["id"]),
            "inputText": row["input_text"],
            "targetLanguage": row["target_language"],
            "createdAt": row["created_at"].isoformat(),
        }
        for row in rows
    ]


async def get_all(user_id: str, limit: int = 10, offset: int = 0) -> dict:
    """Get paginated search history records for a user."""
    user_uuid = uuid.UUID(user_id)

    total_row = await db.query_one(
        "SELECT COUNT(*) as count FROM search_history WHERE user_id = $1",
        user_uuid,
    )
    total = total_row["count"] if total_row else 0

    rows = await db.query(
        "SELECT id, user_id, input_text, target_language, sentence_translation, created_at "
        "FROM search_history WHERE user_id = $1 ORDER BY created_at DESC LIMIT $2 OFFSET $3",
        user_uuid, limit, offset,
    )

    histories = []
    for row in rows:
        histories.append({
            "id": str(row["id"]),
            "userId": str(row["user_id"]),
            "inputText": row["input_text"],
            "targetLanguage": row["target_language"],
            "sentenceTranslation": row["sentence_translation"] or "",
            "createdAt": row["created_at"].isoformat(),
        })

    return {"records": histories, "total": total}


async def get_by_id(user_id: str, record_id: str) -> dict | None:
    """Get a single search history record."""
    user_uuid = uuid.UUID(user_id)
    record_uuid = uuid.UUID(record_id)
    row = await db.query_one(
        "SELECT id, user_id, input_text, target_language, sentence_translation, created_at "
        "FROM search_history WHERE id = $1 AND user_id = $2",
        record_uuid, user_uuid,
    )
    if not row:
        return None

    word_rows = await db.query(
        "SELECT word, ipa_pronunciation, audio_data, translation "
        "FROM search_history_words WHERE search_history_id = $1 ORDER BY position ASC",
        row["id"],
    )
    words = [
        {
            "word": w["word"],
            "ipa": w["ipa_pronunciation"] or "",
            "audioData": w["audio_data"],
            "translation": w["translation"] or "",
        }
        for w in word_rows
    ]

    return {
        "id": str(row["id"]),
        "userId": str(row["user_id"]),
        "inputText": row["input_text"],
        "targetLanguage": row["target_language"],
        "sentenceTranslation": row["sentence_translation"] or "",
        "words": words,
        "createdAt": row["created_at"].isoformat(),
    }


async def delete_record(user_id: str, record_id: str) -> bool:
    """Delete a search history record."""
    user_uuid = uuid.UUID(user_id)
    record_uuid = uuid.UUID(record_id)
    result = await db.execute(
        "DELETE FROM search_history WHERE id = $1 AND user_id = $2",
        record_uuid, user_uuid,
    )
    return result.endswith("1")
