-- Admin-managed class sessions, so new monthly classes can be opened without
-- a code change. Replaces the hardcoded schedule values.
--
-- `capacity` and `first_lesson_date` move here too: both were hardcoded in
-- routes/class_registrations.py and had to be edited for every new class.

CREATE TABLE IF NOT EXISTS class_sessions (
  id SERIAL PRIMARY KEY,
  course TEXT NOT NULL,
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  first_lesson_date DATE,
  capacity INTEGER NOT NULL DEFAULT 110 CHECK (capacity > 0),
  is_active BOOLEAN NOT NULL DEFAULT true,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_class_sessions_lookup
  ON class_sessions(course, is_active, sort_order);

-- Carry over the two existing November classes so current registrations stay valid.
INSERT INTO class_sessions (course, code, name, first_lesson_date, capacity, is_active, sort_order)
VALUES
  ('it-passport', 'sat-tue-20-22', 'Lớp tháng 11 — Thứ 7 và thứ 3 từ 20h–22h', '2026-11-03', 110, true, 1),
  ('it-passport', 'sun-thu-20-22', 'Lớp tháng 11 — Chủ nhật và thứ 5 từ 20h–22h', '2026-11-01', 110, true, 2)
ON CONFLICT (code) DO NOTHING;

-- The schedule column was restricted to those two codes; new classes need
-- arbitrary codes, so the check has to go. Referential sanity is enforced in
-- the API instead (a registration must name an active class).
ALTER TABLE class_registrations
  DROP CONSTRAINT IF EXISTS class_registrations_schedule_check;
