-- Multi-language dictionary cache for reverse translation
CREATE TABLE IF NOT EXISTS word_dictionary_multilang (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    word VARCHAR(500) NOT NULL,
    source_language VARCHAR(10) NOT NULL,
    reading VARCHAR(500),
    meaning_en VARCHAR(1000),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(word, source_language)
);

CREATE INDEX IF NOT EXISTS idx_multilang_word ON word_dictionary_multilang(word, source_language);

-- Add source_language to public_searches
ALTER TABLE public_searches ADD COLUMN IF NOT EXISTS source_language VARCHAR(10) DEFAULT 'en';
