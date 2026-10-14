CREATE TABLE IF NOT EXISTS class_registrations (
    id UUID PRIMARY KEY,
    course TEXT NOT NULL CHECK (course IN ('it-passport', 'kikai-hozen')),
    full_name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    book_address TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
