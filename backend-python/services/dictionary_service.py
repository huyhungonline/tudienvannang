import asyncio
import db
from services import translation_service, audio_service


async def get_or_create(word: str) -> dict:
    """Check DB for word, if miss fetch IPA + translations + audio and save."""
    row = await db.query_one(
        "SELECT word, ipa_pronunciation, audio_data, meaning_ja, meaning_vi, meaning_zh "
        "FROM word_dictionary WHERE word = $1",
        word,
    )
    if row:
        return {
            "word": row["word"],
            "ipaPronunciation": row["ipa_pronunciation"] or "",
            "audioData": row["audio_data"],
            "meaningJa": row["meaning_ja"] or "",
            "meaningVi": row["meaning_vi"] or "",
            "meaningZh": row["meaning_zh"] or "",
        }

    # Dictionary miss — fetch all data concurrently
    ipa_result, meaning_ja, meaning_vi, meaning_zh = await asyncio.gather(
        translation_service.get_ipa_async(word),
        translation_service.translate_word(word, "ja"),
        translation_service.translate_word(word, "vi"),
        translation_service.translate_word(word, "zh"),
    )

    # Find and encode audio
    audio_data = None
    audio_file_name = None
    audio_files = audio_service.get_audio_files_list()
    matched_file = audio_service.find_audio_file(word, audio_files)
    if matched_file:
        audio_file_name = matched_file.rsplit('.', 1)[0] if '.' in matched_file else matched_file
        try:
            audio_data = audio_service.read_and_encode_audio(matched_file)
        except Exception:
            audio_data = None

    # Save to dictionary
    await db.execute(
        "INSERT INTO word_dictionary (word, ipa_pronunciation, audio_data, meaning_ja, meaning_vi, meaning_zh) "
        "VALUES ($1, $2, $3, $4, $5, $6) ON CONFLICT (word) DO NOTHING",
        word, ipa_result, audio_data, meaning_ja, meaning_vi, meaning_zh,
    )

    return {
        "word": word,
        "ipaPronunciation": ipa_result,
        "audioData": audio_data,
        "audioFileName": audio_file_name,
        "meaningJa": meaning_ja,
        "meaningVi": meaning_vi,
        "meaningZh": meaning_zh,
    }
