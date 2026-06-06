from fastapi import APIRouter, HTTPException
from models import SplitRequest
from services import word_service
import db

router = APIRouter(prefix="/api/words")


@router.post("/split")
async def split_words(body: SplitRequest):
    if not body.text or not body.text.strip():
        raise HTTPException(status_code=400, detail="Input text is required")

    # Check word count limit (50 words max)
    words_check = word_service.split_words(body.text)
    if len(words_check) > 50:
        raise HTTPException(
            status_code=400,
            detail="Đoạn văn quá dài. Vui lòng nhập tối đa 50 từ."
        )

    valid_languages = ["ja", "vi", "zh"]
    target_language = body.targetLanguage if body.targetLanguage in valid_languages else "ja"

    try:
        result = await word_service.split_and_process(body.text, target_language)

        if len(result["words"]) == 0:
            return {
                "words": [],
                "sentenceTranslation": "",
                "message": "No English words found in the input text.",
            }

        # Auto-save to public_searches
        try:
            await db.execute(
                "INSERT INTO public_searches (input_text, target_language) VALUES ($1, $2)",
                body.text.strip(), target_language,
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
