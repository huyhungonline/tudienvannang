"""Test sending email from jaenglish.com mail server.
Usage: python3 test/test_email.py
"""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Mail server config
SMTP_HOST = "pro205.emailserver.vn"
SMTP_PORT = 465
SMTP_USER = "admin@jaenglish.com"
SMTP_PASSWORD = "Kmno4kclo3!123"

# Test email
FROM_EMAIL = SMTP_USER
TO_EMAIL = "huyhungonline@gmail.com"  # Recipient
SUBJECT = "Test email from jaenglish.com"
BODY = "This is a test email sent from the jaenglish.com mail server using Python."


def send_test_email():
    msg = MIMEMultipart()
    msg["From"] = FROM_EMAIL
    msg["To"] = TO_EMAIL
    msg["Subject"] = SUBJECT
    msg.attach(MIMEText(BODY, "plain"))

    try:
        print(f"Connecting to {SMTP_HOST}:{SMTP_PORT} (SSL)...")
        server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=10)
        server.ehlo()
        print(f"Logging in as {SMTP_USER}...")
        server.login(SMTP_USER, SMTP_PASSWORD)
        print(f"Sending email to {TO_EMAIL}...")
        server.sendmail(FROM_EMAIL, TO_EMAIL, msg.as_string())
        server.quit()
        print("✅ Email sent successfully!")
    except smtplib.SMTPAuthenticationError as e:
        print(f"❌ Authentication failed: {e}")
    except smtplib.SMTPException as e:
        print(f"❌ SMTP error: {e}")
    except Exception as e:
        print(f"❌ Error: {e}")


if __name__ == "__main__":
    send_test_email()
