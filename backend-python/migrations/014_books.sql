-- Books for sale: title, short description, detailed content, price, purchase contact

CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    content TEXT NOT NULL,
    price VARCHAR(100) NOT NULL DEFAULT '',
    contact VARCHAR(255) NOT NULL,
    image_url VARCHAR(500),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

ALTER TABLE books ADD COLUMN IF NOT EXISTS image_url VARCHAR(500);

CREATE INDEX IF NOT EXISTS idx_books_created_at ON books(created_at DESC);
