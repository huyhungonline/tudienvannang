-- Books for sale: title, short description, detailed content, price, purchase contact

CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    content TEXT NOT NULL,
    price NUMERIC(12, 0) NOT NULL DEFAULT 0,
    contact VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_books_created_at ON books(created_at DESC);
