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


def send_email(to: str, subject: str, html_body: str) -> bool:
    """Send an email using SMTP SSL."""
    msg = MIMEMultipart("alternative")
    msg["From"] = FROM_EMAIL
    msg["To"] = to
    msg["Subject"] = subject
    msg.attach(MIMEText(html_body, "html"))

    try:
        server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=10)
        server.login(SMTP_USER, SMTP_PASSWORD)
        server.sendmail(FROM_EMAIL, to, msg.as_string())
        server.quit()
        return True
    except Exception as e:
        import logging
        logging.getLogger(__name__).error(f"Email send error to {to}: {e}")
        return False


def send_password_reset_email(to: str, reset_token: str) -> bool:
    """Send password reset email with link."""
    reset_url = f"{APP_URL}/reset-password?token={reset_token}"
    subject = "Password Reset - jaenglish.com"
    html = f"""
    <div style="font-family: sans-serif; max-width: 500px; margin: 0 auto;">
        <h2 style="color: #2563eb;">Password Reset</h2>
        <p>You requested a password reset for your jaenglish.com account.</p>
        <p>Click the link below to set a new password:</p>
        <p><a href="{reset_url}" style="display: inline-block; padding: 10px 20px; background: #2563eb; color: #fff; text-decoration: none; border-radius: 6px;">Reset Password</a></p>
        <p style="color: #888; font-size: 0.85rem;">This link expires in 1 hour. If you didn't request this, please ignore this email.</p>
    </div>
    """
    return send_email(to, subject, html)
