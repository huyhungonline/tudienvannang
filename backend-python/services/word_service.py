import re
import asyncio
from functools import partial
from deep_translator import GoogleTranslator
from services import dictionary_service, translation_service, tokenizer_service, multilang_dictionary_service


# Source language map for sentence translation
SOURCE_LANG_MAP = {
    "ja": "ja",
    "zh": "zh-CN",
    "vi": "vi",
}


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


def _translate_sentence_to_english(text: str, source_lang: str) -> str:
    """Translate sentence from source language to English."""
    try:
        lang_code = SOURCE_LANG_MAP.get(source_lang, source_lang)
        result = GoogleTranslator(source=lang_code, target="en").translate(text)
        return result if result else ""
    except Exception as e:
        print(f"Sentence translation error ({source_lang} → en): {e}")
        return ""


def _translate_sentence_to_target(text: str, source_lang: str, target_lang: str) -> str:
    """Translate sentence from source language to target language."""
    try:
        src_code = SOURCE_LANG_MAP.get(source_lang, source_lang)
        tgt_code = SOURCE_LANG_MAP.get(target_lang, target_lang)
        result = GoogleTranslator(source=src_code, target=tgt_code).translate(text)
        return result if result else ""
    except Exception as e:
        print(f"Sentence translation error ({source_lang} → {target_lang}): {e}")
        return ""


async def split_and_process(text: str, target_language: str, source_language: str = "en") -> dict:
    """Orchestrate dictionary lookup + translation for all words."""

    # Non-English source: use tokenizer + multilang dictionary
    if source_language != "en":
        return await _process_multilang(text, source_language, target_language)

    # English source: existing logic
    unique_words = split_words(text)

    # Process all words concurrently
    tasks = [dictionary_service.get_or_create(word) for word in unique_words]
    entries = await asyncio.gather(*tasks)

    words = []
    for entry in entries:
        display_word = entry["word"]
        audio_file_name = entry.get("audioFileName")
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


async def _process_multilang(text: str, source_language: str, target_language: str = "en") -> dict:
    """Process non-English text: tokenize → translate each token."""
    tokens = tokenizer_service.tokenize(text, source_language)

    # Filter out tokens that are purely numbers/digits
    tokens = [t for t in tokens if not re.match(r'^[\d０-９]+$', t["word"])]

    # Limit tokens
    if len(tokens) > 50:
        tokens = tokens[:50]

    # Determine actual target for word translation
    # If target == source, default to English
    actual_target = target_language if target_language != source_language else "en"

    # Translate each token concurrently
    tasks = [
        multilang_dictionary_service.get_or_create(
            token["word"], source_language, token.get("reading", ""), actual_target
        )
        for token in tokens
    ]
    entries = await asyncio.gather(*tasks)

    words = []
    for entry in entries:
        words.append({
            "word": entry["word"],
            "ipa": entry["reading"],
            "audioData": None,
            "translation": entry["translation"],
        })

    # Translate full sentence
    loop = asyncio.get_running_loop()
    sentence_translation = await loop.run_in_executor(
        None, partial(_translate_sentence_to_target, text, source_language, actual_target)
    )

    return {
        "words": words,
        "sentenceTranslation": sentence_translation,
    }
