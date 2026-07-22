-- Add title and level columns to existing reading_posts table
ALTER TABLE reading_posts ADD COLUMN IF NOT EXISTS title VARCHAR(200) NOT NULL DEFAULT '';
ALTER TABLE reading_posts ADD COLUMN IF NOT EXISTS level VARCHAR(10) NOT NULL DEFAULT 'N3';

-- Index for efficient level filtering
CREATE INDEX IF NOT EXISTS idx_reading_posts_level ON reading_posts(level);
