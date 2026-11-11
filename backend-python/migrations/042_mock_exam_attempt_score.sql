-- Keep the scoring summary (e.g. IT Passport 1000-point result per field) with
-- each attempt so the exam history can show pass/fail without re-grading.
-- Idempotent: the backend applies this at startup.

ALTER TABLE mock_exam_attempts
  ADD COLUMN IF NOT EXISTS score_json JSONB;
