#!/bin/bash
curl -s -X POST http://localhost:5000/translate \
  -H "Content-Type: application/json" \
  -d '{"q": "dog", "source": "en", "target": "ja"}'
echo ""
