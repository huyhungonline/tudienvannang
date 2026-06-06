-- Users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Word dictionary table (stores all lookup data in one row per word)
CREATE TABLE IF NOT EXISTS word_dictionary (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  word VARCHAR(255) UNIQUE NOT NULL,
  ipa_pronunciation VARCHAR(500),
  audio_data TEXT,  -- base64-encoded mp3 binary data
  meaning_ja VARCHAR(1000),  -- Japanese translation
  meaning_vi VARCHAR(1000),  -- Vietnamese translation
  meaning_zh VARCHAR(1000),  -- Chinese translation
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Search history table
CREATE TABLE IF NOT EXISTS search_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  input_text TEXT NOT NULL,
  target_language VARCHAR(50) NOT NULL,
  sentence_translation TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Search history word entries (detail)
CREATE TABLE IF NOT EXISTS search_history_words (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  search_history_id UUID NOT NULL REFERENCES search_history(id) ON DELETE CASCADE,
  word VARCHAR(255) NOT NULL,
  ipa_pronunciation VARCHAR(500),
  audio_data TEXT,
  translation VARCHAR(1000),
  position INTEGER NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_word_dictionary_word ON word_dictionary(word);
CREATE INDEX IF NOT EXISTS idx_search_history_user ON search_history(user_id, created_at DESC);
