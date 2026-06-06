#!/bin/bash
docker exec postgres-dic psql -U postgres -d english_word_splitter -c "DELETE FROM word_dictionary;"
echo "Cache cleared."
