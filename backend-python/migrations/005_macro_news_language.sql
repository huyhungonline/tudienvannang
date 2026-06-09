-- Add language column to macro_news table
ALTER TABLE macro_news ADD COLUMN IF NOT EXISTS language VARCHAR(10) DEFAULT 'en';

-- Create index for faster language-based queries
CREATE INDEX IF NOT EXISTS idx_macro_news_language ON macro_news(category, language);
