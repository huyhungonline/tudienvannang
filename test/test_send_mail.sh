#!/bin/bash
curl -s -X POST http://localhost:4000/api/nhk/send-manual \
  -H "Content-Type: application/json" \
  -d '{"subject":"Test mail","content":"Hello from admin","subscriber_emails":["huyhungonline@gmail.com"]}' | python3 -m json.tool
