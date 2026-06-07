#!/bin/bash
# Unit test API dịch: EN→VI, EN→ZH, EN→JA
# Usage: wsl -e bash -c "cd /mnt/c/source/dic && bash test-api.sh"

BASE="http://localhost:4000/api/words/split"
PASS=0
FAIL=0

test_api() {
    local name="$1"
    local data="$2"
    local expect_field="$3"

    echo -n "  $name: "
    RESPONSE=$(curl -s -X POST "$BASE" -H "Content-Type: application/json" -d "$data" 2>/dev/null)
    STATUS=$?

    if [ $STATUS -ne 0 ] || [ -z "$RESPONSE" ]; then
        echo "❌ FAIL (no response)"
        FAIL=$((FAIL+1))
        return
    fi

    # Check if response has words array
    WORD_COUNT=$(echo "$RESPONSE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(len(d.get('words',[])))" 2>/dev/null)
    SENTENCE=$(echo "$RESPONSE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('sentenceTranslation',''))" 2>/dev/null)

    if [ -z "$WORD_COUNT" ] || [ "$WORD_COUNT" = "0" ]; then
        echo "❌ FAIL (no words returned)"
        echo "    Response: ${RESPONSE:0:200}"
        FAIL=$((FAIL+1))
        return
    fi

    if [ -z "$SENTENCE" ]; then
        echo "❌ FAIL (no sentence translation)"
        FAIL=$((FAIL+1))
        return
    fi

    echo "✅ OK (words: $WORD_COUNT, sentence: ${SENTENCE:0:50})"
    PASS=$((PASS+1))
}

echo "========== API Translation Tests =========="
echo ""

echo "[1] English → Japanese"
test_api "hello world" \
    '{"text":"hello world","sourceLanguage":"en","targetLanguage":"ja"}' \
    "translation"

test_api "long sentence" \
    '{"text":"The economy is recovering from the pandemic","sourceLanguage":"en","targetLanguage":"ja"}' \
    "translation"

echo ""
echo "[2] English → Vietnamese"
test_api "hello world" \
    '{"text":"hello world","sourceLanguage":"en","targetLanguage":"vi"}' \
    "translation"

test_api "long sentence" \
    '{"text":"Gold prices surged to a new all-time high","sourceLanguage":"en","targetLanguage":"vi"}' \
    "translation"

echo ""
echo "[3] English → Chinese"
test_api "hello world" \
    '{"text":"hello world","sourceLanguage":"en","targetLanguage":"zh"}' \
    "translation"

test_api "long sentence" \
    '{"text":"The Federal Reserve held interest rates steady","sourceLanguage":"en","targetLanguage":"zh"}' \
    "translation"

echo ""
echo "[4] Japanese → English"
test_api "keizai" \
    '{"text":"経済は回復している","sourceLanguage":"ja","targetLanguage":"en"}' \
    "translation"

echo ""
echo "[5] Japanese → Vietnamese"
test_api "keizai to vi" \
    '{"text":"経済は回復している","sourceLanguage":"ja","targetLanguage":"vi"}' \
    "translation"

echo ""
echo "[6] Chinese → English"
test_api "jingji" \
    '{"text":"经济正在复苏","sourceLanguage":"zh","targetLanguage":"en"}' \
    "translation"

echo ""
echo "[7] Vietnamese → English"
test_api "kinh te" \
    '{"text":"nền kinh tế đang phục hồi","sourceLanguage":"vi","targetLanguage":"en"}' \
    "translation"

echo ""
echo "=========================================="
echo "Results: ✅ $PASS passed, ❌ $FAIL failed"
echo "=========================================="
