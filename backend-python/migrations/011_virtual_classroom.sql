-- Virtual Classroom tables

-- Classrooms table
CREATE TABLE IF NOT EXISTS classrooms (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL DEFAULT 'Main Classroom',
  teacher_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Classroom seats table (10 rows x 10 seats per row)
CREATE TABLE IF NOT EXISTS classroom_seats (
  id SERIAL PRIMARY KEY,
  classroom_id INTEGER NOT NULL REFERENCES classrooms(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  row_number INTEGER NOT NULL CHECK (row_number >= 1 AND row_number <= 10),
  seat_number INTEGER NOT NULL CHECK (seat_number >= 1 AND seat_number <= 10),
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE (classroom_id, row_number, seat_number),
  UNIQUE (classroom_id, user_id)
);

-- User search counts table (tracks "Tách từ & Dịch nghĩa" usage)
CREATE TABLE IF NOT EXISTS user_search_counts (
  id SERIAL PRIMARY KEY,
  user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  search_count INTEGER NOT NULL DEFAULT 0,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_classroom_seats_classroom ON classroom_seats(classroom_id);
CREATE INDEX IF NOT EXISTS idx_classroom_seats_user ON classroom_seats(user_id);
CREATE INDEX IF NOT EXISTS idx_user_search_counts_user ON user_search_counts(user_id);

-- Seed default classroom
INSERT INTO classrooms (name) VALUES ('Main Classroom');
