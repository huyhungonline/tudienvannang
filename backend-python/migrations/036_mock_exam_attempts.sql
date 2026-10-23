-- Mock exam (thi thử) attempt tracking.
-- Stores one row per completed attempt plus the per-question answers so a
-- learner can review which questions they got wrong.

CREATE TABLE IF NOT EXISTS mock_exam_attempts (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  certificate_id INTEGER NOT NULL REFERENCES certificates(id) ON DELETE CASCADE,
  total_questions INTEGER NOT NULL,
  correct_count INTEGER NOT NULL,
  duration_seconds INTEGER,
  started_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  finished_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS mock_exam_attempt_answers (
  id SERIAL PRIMARY KEY,
  attempt_id INTEGER NOT NULL REFERENCES mock_exam_attempts(id) ON DELETE CASCADE,
  question_id INTEGER NOT NULL REFERENCES certificate_exam_questions(id) ON DELETE CASCADE,
  selected_label VARCHAR(100),
  is_correct BOOLEAN NOT NULL,
  UNIQUE (attempt_id, question_id)
);

CREATE INDEX IF NOT EXISTS idx_mock_attempts_user
  ON mock_exam_attempts(user_id, finished_at DESC);
CREATE INDEX IF NOT EXISTS idx_mock_attempts_cert
  ON mock_exam_attempts(certificate_id);
CREATE INDEX IF NOT EXISTS idx_mock_attempt_answers_attempt
  ON mock_exam_attempt_answers(attempt_id);
