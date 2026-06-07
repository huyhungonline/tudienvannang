"""Tokenizer service for splitting text in different languages."""
import re
from functools import lru_cache


def tokenize(text: str, source_language: str) -> list[dict]:
    """Dispatch tokenization based on source language.
    Returns list of {word, reading} dicts.
    """
    if source_language == "ja":
        return _tokenize_japanese(text)
    elif source_language == "zh":
        return _tokenize_chinese(text)
    elif source_language == "vi":
        return _tokenize_vietnamese(text)
    else:
        return _tokenize_english(text)


def _tokenize_english(text: str) -> list[dict]:
    """Split English text by non-alpha characters."""
    words = re.split(r'[^a-zA-Z]+', text)
    words = [w.lower() for w in words if w]
    seen = set()
    unique = []
    for w in words:
        if w not in seen:
            seen.add(w)
            unique.append({"word": w, "reading": ""})
    return unique


def _tokenize_japanese(text: str) -> list[dict]:
    """Tokenize Japanese text using fugashi (MeCab)."""
    import fugashi
    tagger = _get_japanese_tagger()

    tokens = []
    seen = set()
    for word in tagger(text):
        surface = word.surface
        # Skip punctuation and whitespace
        if not surface.strip() or re.match(r'^[\s\u3000-\u303F\uFF00-\uFFEF。、！？「」『』（）]+$', surface):
            continue
        if surface in seen:
            continue
        seen.add(surface)

        # Get reading (katakana → romaji)
        reading = ""
        if hasattr(word, 'feature') and word.feature:
            parts = str(word.feature).split(",")
            # Try to get reading from feature
            if len(parts) >= 7 and parts[6] != '*':
                reading = _katakana_to_romaji(parts[6])
            elif len(parts) >= 8 and parts[7] != '*':
                reading = _katakana_to_romaji(parts[7])

        tokens.append({"word": surface, "reading": reading})

    return tokens


def _tokenize_chinese(text: str) -> list[dict]:
    """Tokenize Chinese text using jieba + pypinyin."""
    import jieba
    from pypinyin import pinyin, Style

    words = jieba.cut(text)
    tokens = []
    seen = set()

    for word in words:
        word = word.strip()
        # Skip punctuation and whitespace
        if not word or re.match(r'^[\s\u3000-\u303F\uFF00-\uFFEF。，！？、；：""''（）【】]+$', word):
            continue
        if word in seen:
            continue
        seen.add(word)

        # Get pinyin
        py = pinyin(word, style=Style.TONE)
        reading = " ".join([p[0] for p in py])

        tokens.append({"word": word, "reading": reading})

    return tokens


def _tokenize_vietnamese(text: str) -> list[dict]:
    """Tokenize Vietnamese text by whitespace (syllable-level)."""
    words = text.split()
    tokens = []
    seen = set()

    for word in words:
        word = word.strip()
        # Remove surrounding punctuation
        word = re.sub(r'^[^\w]+|[^\w]+$', '', word)
        if not word:
            continue
        lower = word.lower()
        if lower in seen:
            continue
        seen.add(lower)
        tokens.append({"word": word, "reading": ""})

    return tokens


@lru_cache(maxsize=1)
def _get_japanese_tagger():
    """Cached MeCab tagger instance."""
    import fugashi
    return fugashi.Tagger()


def _katakana_to_romaji(katakana: str) -> str:
    """Simple katakana to romaji conversion."""
    mapping = {
        'ア': 'a', 'イ': 'i', 'ウ': 'u', 'エ': 'e', 'オ': 'o',
        'カ': 'ka', 'キ': 'ki', 'ク': 'ku', 'ケ': 'ke', 'コ': 'ko',
        'サ': 'sa', 'シ': 'shi', 'ス': 'su', 'セ': 'se', 'ソ': 'so',
        'タ': 'ta', 'チ': 'chi', 'ツ': 'tsu', 'テ': 'te', 'ト': 'to',
        'ナ': 'na', 'ニ': 'ni', 'ヌ': 'nu', 'ネ': 'ne', 'ノ': 'no',
        'ハ': 'ha', 'ヒ': 'hi', 'フ': 'fu', 'ヘ': 'he', 'ホ': 'ho',
        'マ': 'ma', 'ミ': 'mi', 'ム': 'mu', 'メ': 'me', 'モ': 'mo',
        'ヤ': 'ya', 'ユ': 'yu', 'ヨ': 'yo',
        'ラ': 'ra', 'リ': 'ri', 'ル': 'ru', 'レ': 're', 'ロ': 'ro',
        'ワ': 'wa', 'ヲ': 'wo', 'ン': 'n',
        'ガ': 'ga', 'ギ': 'gi', 'グ': 'gu', 'ゲ': 'ge', 'ゴ': 'go',
        'ザ': 'za', 'ジ': 'ji', 'ズ': 'zu', 'ゼ': 'ze', 'ゾ': 'zo',
        'ダ': 'da', 'ヂ': 'di', 'ヅ': 'du', 'デ': 'de', 'ド': 'do',
        'バ': 'ba', 'ビ': 'bi', 'ブ': 'bu', 'ベ': 'be', 'ボ': 'bo',
        'パ': 'pa', 'ピ': 'pi', 'プ': 'pu', 'ペ': 'pe', 'ポ': 'po',
        'キャ': 'kya', 'キュ': 'kyu', 'キョ': 'kyo',
        'シャ': 'sha', 'シュ': 'shu', 'ショ': 'sho',
        'チャ': 'cha', 'チュ': 'chu', 'チョ': 'cho',
        'ニャ': 'nya', 'ニュ': 'nyu', 'ニョ': 'nyo',
        'ヒャ': 'hya', 'ヒュ': 'hyu', 'ヒョ': 'hyo',
        'ミャ': 'mya', 'ミュ': 'myu', 'ミョ': 'myo',
        'リャ': 'rya', 'リュ': 'ryu', 'リョ': 'ryo',
        'ギャ': 'gya', 'ギュ': 'gyu', 'ギョ': 'gyo',
        'ジャ': 'ja', 'ジュ': 'ju', 'ジョ': 'jo',
        'ビャ': 'bya', 'ビュ': 'byu', 'ビョ': 'byo',
        'ピャ': 'pya', 'ピュ': 'pyu', 'ピョ': 'pyo',
        'ッ': '', 'ー': '',
    }
    result = ""
    i = 0
    while i < len(katakana):
        # Try 2-char match first (for combo chars like キャ)
        if i + 1 < len(katakana) and katakana[i:i+2] in mapping:
            result += mapping[katakana[i:i+2]]
            i += 2
        elif katakana[i] in mapping:
            if katakana[i] == 'ッ' and i + 1 < len(katakana) and katakana[i+1] in mapping:
                # Double consonant
                next_romaji = mapping.get(katakana[i+1], '')
                if next_romaji:
                    result += next_romaji[0]
            else:
                result += mapping[katakana[i]]
            i += 1
        else:
            result += katakana[i]
            i += 1
    return result
