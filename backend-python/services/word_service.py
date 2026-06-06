import re
import asyncio
from services import dictionary_service, translation_service


def split_words(text: str) -> list[str]:
    """Split text by non-alpha characters, lowercase, deduplicate while preserving order."""
    words = re.split(r'[^a-zA-Z]+', text)
    words = [w.lower() for w in words if w]
    seen = set()
    unique = []
    for w in words:
        if w not in seen:
            seen.add(w)
            unique.append(w)
    return unique


def _get_translation(entry: dict, target_language: str) -> str:
    mapping = {
        "ja": "meaningJa",
        "vi": "meaningVi",
        "zh": "meaningZh",
    }
    key = mapping.get(target_language, "meaningJa")
    return entry.get(key, "")


async def split_and_process(text: str, target_language: str) -> dict:
    """Orchestrate dictionary lookup + translation for all words."""
    unique_words = split_words(text)

    # Process all words concurrently
    tasks = [dictionary_service.get_or_create(word) for word in unique_words]
    entries = await asyncio.gather(*tasks)

    words = []
    for entry in entries:
        display_word = entry["word"]
        audio_file_name = entry.get("audioFileName")
        # Nếu file mp3 có 2 từ trở lên, chú thích tên file
        if audio_file_name and " " in audio_file_name:
            display_word = f"{entry['word']} ({audio_file_name})"

        words.append({
            "word": display_word,
            "ipa": entry["ipaPronunciation"],
            "audioData": entry["audioData"],
            "translation": _get_translation(entry, target_language),
        })

    sentence_translation = await translation_service.translate_sentence(text, target_language)

    return {
        "words": words,
        "sentenceTranslation": sentence_translation,
    }
