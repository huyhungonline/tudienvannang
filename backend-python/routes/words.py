from fastapi import APIRouter, HTTPException, Request
from models import SplitRequest
from services import word_service
from services import classroom_service
from services.auth_service import verify_token
import db

router = APIRouter(prefix="/api/words")


def get_optional_user_id(request: Request) -> str | None:
    """Extract user_id from token if present, return None otherwise."""
    auth_header = request.headers.get("authorization", "")
    if not auth_header or not auth_header.startswith("Bearer "):
        return None
    token = auth_header[7:]
    payload = verify_token(token)
    return payload["userId"] if payload else None


@router.post("/split")
async def split_words(body: SplitRequest, request: Request):
    if not body.text or not body.text.strip():
        raise HTTPException(status_code=400, detail="Input text is required")

    valid_languages = ["ja", "vi", "zh"]
    valid_sources = ["en", "ja", "vi", "zh"]
    target_language = body.targetLanguage if body.targetLanguage in valid_languages else "ja"
    source_language = body.sourceLanguage if body.sourceLanguage in valid_sources else "en"

    # Word count limit only for English source
    if source_language == "en":
        words_check = word_service.split_words(body.text)
        if len(words_check) > 100:
            raise HTTPException(
                status_code=400,
                detail="Đoạn văn quá dài. Vui lòng nhập tối đa 100 từ."
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

        # Increment search count for authenticated users
        user_id = get_optional_user_id(request)
        if user_id:
            try:
                await classroom_service.increment_search_count(user_id)
            except Exception:
                pass  # Don't fail the request if count increment fails

        return result
    except Exception as e:
        print(f"Word split error: {e}")
        raise HTTPException(
            status_code=502,
            detail={"error": "Translation service unavailable", "retryable": True},
        )
