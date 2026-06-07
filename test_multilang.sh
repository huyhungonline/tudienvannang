#!/bin/bash
# Test multilang: Japanese → Vietnamese
echo '{"text":"経済は回復している","sourceLanguage":"ja","targetLanguage":"vi"}' | \
  curl -s -X POST http://localhost:4000/api/words/split \
  -H "Content-Type: application/json" \
  -d @- | python3 -m json.tool
