-- Macro News table for storing AI-generated macro-economic analysis
CREATE TABLE IF NOT EXISTS macro_news (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category VARCHAR(50) NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_macro_news_category ON macro_news(category);
