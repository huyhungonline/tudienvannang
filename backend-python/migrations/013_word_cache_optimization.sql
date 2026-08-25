-- Extend word_dictionary_multilang to support all translation directions + audio caching

-- Add new columns
ALTER TABLE word_dictionary_multilang
    ADD COLUMN IF NOT EXISTS target_language VARCHAR(10) NOT NULL DEFAULT 'en',
    ADD COLUMN IF NOT EXISTS translation VARCHAR(1000),
    ADD COLUMN IF NOT EXISTS audio_data TEXT,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- Migrate existing data: copy meaning_en → translation for existing rows
UPDATE word_dictionary_multilang
SET translation = meaning_en, target_language = 'en'
WHERE translation IS NULL AND meaning_en IS NOT NULL;

-- Drop old unique constraint (may have different auto-generated names)
ALTER TABLE word_dictionary_multilang DROP CONSTRAINT IF EXISTS word_dictionary_multilang_word_source_language_key;

-- Add new unique constraint on (word, source_language, target_language)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'word_dictionary_multilang_unique'
    ) THEN
        ALTER TABLE word_dictionary_multilang
            ADD CONSTRAINT word_dictionary_multilang_unique UNIQUE (word, source_language, target_language);
    END IF;
END $$;

-- Drop old index and create new ones
DROP INDEX IF EXISTS idx_multilang_word;
CREATE INDEX IF NOT EXISTS idx_multilang_word_lookup ON word_dictionary_multilang(word, source_language, target_language);
CREATE INDEX IF NOT EXISTS idx_multilang_batch ON word_dictionary_multilang(source_language, target_language, word);
