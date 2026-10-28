import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/english_word_splitter")
JWT_SECRET = os.getenv("JWT_SECRET", "dev-secret-change-me")
JWT_EXPIRY_DAYS = 7
RECAPTCHA_SECRET_KEY = os.getenv("RECAPTCHA_SECRET_KEY", "")
AUDIO_FILES_PATH = os.getenv("AUDIO_FILES_PATH", "./audio")
BOOK_IMAGES_PATH = os.getenv("BOOK_IMAGES_PATH", "./book_images")

# Shared mail settings, loaded after .env for local and Docker runs.
SMTP_HOST = os.getenv("SMTP_HOST", "pro203.emailserver.vn")
SMTP_PORT = int(os.getenv("SMTP_PORT", "465"))
SMTP_USER = os.getenv("SMTP_USER", "admin@jaenglish.com")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "")
FROM_EMAIL = os.getenv("FROM_EMAIL", "admin@jaenglish.com")
FROM_NAME = os.getenv("FROM_NAME", "Táo Giáo Dục")
APP_URL = os.getenv("APP_URL", "https://jaenglish.com").rstrip("/")

# Token for the MCP endpoint used by ChatGPT. Deliberately separate from
# JWT_SECRET so it can be rotated or revoked without affecting user logins.
# Empty means the MCP endpoint refuses every request.
MCP_TOKEN = os.getenv("MCP_TOKEN", "")
