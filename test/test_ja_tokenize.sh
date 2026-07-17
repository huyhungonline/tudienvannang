#!/bin/bash
curl -s -X POST http://localhost:4000/api/words/split \
  -H "Content-Type: application/json" \
  -d '{"text":"経済が回復してしまった","targetLanguage":"en","sourceLanguage":"ja"}' \
  | python3 -m json.tool
