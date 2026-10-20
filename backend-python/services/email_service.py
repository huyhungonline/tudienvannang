"""Email service for sending transactional emails."""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.utils import formataddr
import logging

from config import SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, FROM_EMAIL, FROM_NAME, APP_URL

logger = logging.getLogger(__name__)


def send_email(to: str, subject: str, body: str) -> bool:
    """Send a UTF-8 email using the shared SMTP configuration."""
    msg = MIMEMultipart()
    msg["From"] = formataddr((FROM_NAME, FROM_EMAIL))
    msg["To"] = to
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain", "utf-8"))

    try:
        with smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=30) as server:
            server.ehlo()
            server.login(SMTP_USER, SMTP_PASSWORD)
            server.sendmail(FROM_EMAIL, to, msg.as_string())
        return True
    except Exception as e:
        logger.error("Failed to send email to %s: %s", to, e)
        return False


def send_welcome_email(to: str) -> bool:
    """Notify a newly registered user without including their password."""
    subject = f"Chào mừng bạn đến với {FROM_NAME}"
    body = (
        "Xin chào,\n\n"
        f"Bạn đã đăng ký tài khoản thành công tại {FROM_NAME}.\n"
        f"Email tài khoản: {to}\n\n"
        f"Bắt đầu học tại: {APP_URL}\n"
        f"Đăng nhập tại: {APP_URL}/login\n\n"
        f"Chúc bạn học tập hiệu quả!\n{FROM_NAME}"
    )
    return send_email(to, subject, body)


def send_pro_upgrade_email(to: str) -> bool:
    """Notify a user after their Pro upgrade has been saved."""
    subject = f"Tài khoản của bạn đã được nâng cấp Pro - {FROM_NAME}"
    body = (
        "Xin chào,\n\n"
        f"Tài khoản {to} của bạn tại {FROM_NAME} đã được nâng cấp lên Pro thành công.\n\n"
        f"Bạn có thể truy cập {APP_URL} để sử dụng các tính năng dành cho tài khoản Pro.\n"
        "Nếu quyền Pro chưa hiển thị, hãy đăng xuất rồi đăng nhập lại.\n\n"
        f"Cảm ơn bạn đã đồng hành cùng {FROM_NAME}!\n{FROM_NAME}"
    )
    return send_email(to, subject, body)


def send_password_reset_email(to: str, new_password: str) -> bool:
    """Send new password to user."""
    subject = f"Your new password - {FROM_NAME}"
    body = f"Hi,\n\nWe received a request to reset your password.\n\nYour new password is: {new_password}\n\nPlease login at {APP_URL}/login and change your password after.\n\nBest regards,\n{FROM_NAME}"
    return send_email(to, subject, body)
