"""Email service for sending transactional emails."""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os

SMTP_HOST = os.getenv("SMTP_HOST", "pro205.emailserver.vn")
SMTP_PORT = int(os.getenv("SMTP_PORT", "465"))
SMTP_USER = os.getenv("SMTP_USER", "admin@jaenglish.com")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "Kmno4kclo3!123")
FROM_EMAIL = os.getenv("FROM_EMAIL", "admin@jaenglish.com")
APP_URL = os.getenv("APP_URL", "https://jaenglish.com")


def send_email(to: str, subject: str, body: str) -> bool:
    """Send an email - exact same logic as test/test_email.py."""
    msg = MIMEMultipart()
    msg["From"] = FROM_EMAIL
    msg["To"] = to
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=10)
        server.ehlo()
        server.login(SMTP_USER, SMTP_PASSWORD)
        server.sendmail(FROM_EMAIL, to, msg.as_string())
        server.quit()
        return True
    except Exception as e:
        print(f"[EMAIL-ERROR] Failed to send to {to}: {e}")
        return False


def send_password_reset_email(to: str, new_password: str) -> bool:
    """Send new password to user."""
    subject = "New password - jaenglish.com"
    body = f"Your new password is: {new_password}\n\nPlease login and change your password after."
    return send_email(to, subject, body)
