import os
import base64
from config import AUDIO_FILES_PATH

try:
    from nltk.stem import WordNetLemmatizer
    import nltk
    # Download wordnet data silently if not present
    try:
        nltk.data.find('corpora/wordnet')
    except LookupError:
        nltk.download('wordnet', quiet=True)
    _lemmatizer = WordNetLemmatizer()
except ImportError:
    _lemmatizer = None


def _get_lemma(word: str) -> str | None:
    """Get the base/lemma form of a word (e.g., dogs→dog, played→play, running→run)."""
    if _lemmatizer is None:
        return None
    lemma = _lemmatizer.lemmatize(word, pos='v')  # try verb first (played→play)
    if lemma != word:
        return lemma
    lemma = _lemmatizer.lemmatize(word, pos='n')  # try noun (dogs→dog)
    if lemma != word:
        return lemma
    return None


def find_audio_file(word: str, audio_files: list[str]) -> str | None:
    """Match word against space-split filenames (case-insensitive).
    If no match found, try lemmatized (base) form of the word."""
    normalized_word = word.lower()

    # First try exact match
    for file in audio_files:
        name_without_ext = file.rsplit('.', 1)[0] if '.' in file else file
        file_words = name_without_ext.lower().split()
        if normalized_word in file_words:
            return file

    # If not found, try lemmatized form (dogs→dog, played→play, running→run)
    lemma = _get_lemma(normalized_word)
    if lemma and lemma != normalized_word:
        for file in audio_files:
            name_without_ext = file.rsplit('.', 1)[0] if '.' in file else file
            file_words = name_without_ext.lower().split()
            if lemma in file_words:
                return file

    return None


def get_audio_files_list() -> list[str]:
    """Read AUDIO_FILES_PATH directory and return list of mp3 files."""
    try:
        entries = os.listdir(AUDIO_FILES_PATH)
        return [f for f in entries if f.lower().endswith('.mp3')]
    except Exception:
        return []


def read_and_encode_audio(filepath: str) -> str:
    """Read mp3 file and return base64-encoded string."""
    full_path = os.path.join(AUDIO_FILES_PATH, filepath)
    with open(full_path, 'rb') as f:
        data = f.read()
    return base64.b64encode(data).decode('utf-8')
