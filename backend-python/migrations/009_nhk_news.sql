-- Migration 009: NHK News Scraper tables
-- Creates nhk_articles and nhk_subscribers tables

-- Table: nhk_articles
CREATE TABLE IF NOT EXISTS nhk_articles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(100),
    source_url TEXT NOT NULL UNIQUE,
    published_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_nhk_articles_published_at ON nhk_articles(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_nhk_articles_created_at ON nhk_articles(created_at DESC);

-- Table: nhk_subscribers
CREATE TABLE IF NOT EXISTS nhk_subscribers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL UNIQUE,
    target_language VARCHAR(5) NOT NULL DEFAULT 'en',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_nhk_subscribers_active ON nhk_subscribers(is_active) WHERE is_active = TRUE;
