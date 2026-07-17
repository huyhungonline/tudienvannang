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
    """Tokenize Japanese text using fugashi (MeCab).
    Only keep meaningful words: nouns, verbs, adjectives, adverbs.
    Skip particles, auxiliary verbs, conjunctions, symbols.
    Use lemma (base form) for verbs/adjectives to avoid conjugated fragments.
    """
    import fugashi
    tagger = _get_japanese_tagger()

    # POS categories to SKIP (particles, auxiliaries, symbols, suffixes)
    SKIP_POS = {'助詞', '助動詞', '接続詞', '感動詞', '記号', '補助記号', '空白', '接尾辞'}
    # POS2 subcategories to SKIP (non-independent verbs used as auxiliaries)
    SKIP_POS2 = {'非自立可能'}

    # POS categories that should use lemma (base form) instead of surface
    LEMMA_POS = {'動詞', '形容詞', '形状詞'}

    tokens = []
    seen = set()
    for word in tagger(text):
        surface = word.surface
        # Skip punctuation and whitespace
        if not surface.strip() or re.match(r'^[\s\u3000-\u303F\uFF00-\uFFEF。、！？「」『』（）]+$', surface):
            continue

        # Skip single-character tokens
        if len(surface) == 1:
            continue

        # Extract POS
        pos = ""
        feature_str = ""
        if hasattr(word, 'feature') and word.feature:
            feature_str = str(word.feature)
            import re as _re
            pos_match = _re.search(r"pos='([^']*)'", feature_str)
            if pos_match:
                pos = pos_match.group(1)
            else:
                pos1_match = _re.search(r"pos1='([^']*)'", feature_str)
                if pos1_match:
                    pos = pos1_match.group(1)
                else:
                    parts = feature_str.split(",")
                    if parts:
                        pos = parts[0].strip()

        # Skip if POS is a particle/auxiliary/suffix
        if pos and pos in SKIP_POS:
            continue

        # Extract POS2 (subcategory) and skip non-independent verbs (auxiliaries like しまう, する)
        pos2 = ""
        if feature_str:
            import re as _re
            pos2_match = _re.search(r"pos2='([^']*)'", feature_str)
            if pos2_match:
                pos2 = pos2_match.group(1)
        if pos2 in SKIP_POS2:
            continue

        # For verbs/adjectives, use lemma (base form) instead of conjugated surface
        display_word = surface
        if pos in LEMMA_POS and feature_str:
            import re as _re
            lemma_match = _re.search(r"lemma='([^']*)'", feature_str)
            if lemma_match and lemma_match.group(1):
                display_word = lemma_match.group(1)

        # Skip short hiragana-only tokens (3 chars or less) - usually fragments
        if len(display_word) <= 3 and re.match(r'^[\u3040-\u309F]+$', display_word):
            continue

        if display_word in seen:
            continue
        seen.add(display_word)

        # Get reading (katakana → romaji)
        reading = ""
        if feature_str:
            import re as _re
            kana_value = ""
            pron_match = _re.search(r"pron='([^']*)'", feature_str)
            kana_match = _re.search(r"kana='([^']*)'", feature_str)
            lform_match = _re.search(r"lForm='([^']*)'", feature_str)

            if pron_match and pron_match.group(1):
                kana_value = pron_match.group(1)
            elif kana_match and kana_match.group(1):
                kana_value = kana_match.group(1)
            elif lform_match and lform_match.group(1):
                kana_value = lform_match.group(1)

            if kana_value:
                reading = _katakana_to_romaji(kana_value)

        tokens.append({"word": display_word, "reading": reading})

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
