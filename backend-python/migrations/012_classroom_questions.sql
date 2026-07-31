-- Classroom questions (displayed on the blackboard)
CREATE TABLE IF NOT EXISTS classroom_questions (
  id SERIAL PRIMARY KEY,
  question TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_active BOOLEAN NOT NULL DEFAULT true
);

CREATE INDEX IF NOT EXISTS idx_classroom_questions_active ON classroom_questions(is_active, created_at DESC);
