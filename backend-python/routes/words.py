from fastapi import APIRouter, HTTPException
from models import SplitRequest
from services import word_service
import db

router = APIRouter(prefix="/api/words")


@router.post("/split")
async def split_words(body: SplitRequest):
    if not body.text or not body.text.strip():
        raise HTTPException(status_code=400, detail="Input text is required")

    valid_languages = ["ja", "vi", "zh"]
    valid_sources = ["en", "ja", "vi", "zh"]
    target_language = body.targetLanguage if body.targetLanguage in valid_languages else "ja"
    source_language = body.sourceLanguage if body.sourceLanguage in valid_sources else "en"

    # Word count limit only for English source
    if source_language == "en":
        words_check = word_service.split_words(body.text)
        if len(words_check) > 50:
            raise HTTPException(
                status_code=400,
                detail="Đoạn văn quá dài. Vui lòng nhập tối đa 50 từ."
            )

    try:
        result = await word_service.split_and_process(body.text, target_language, source_language)

        if len(result["words"]) == 0:
            return {
                "words": [],
                "sentenceTranslation": "",
                "message": "No words found in the input text.",
            }

        # Auto-save to public_searches
        try:
            await db.execute(
                "INSERT INTO public_searches (input_text, target_language, source_language) VALUES ($1, $2, $3)",
                body.text.strip(), target_language, source_language,
            )
        except Exception:
            pass  # Don't fail the request if logging fails

        return result
    except Exception as e:
        print(f"Word split error: {e}")
        raise HTTPException(
            status_code=502,
            detail={"error": "Translation service unavailable", "retryable": True},
        )
