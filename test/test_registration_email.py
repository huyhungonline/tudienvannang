"""Offline checks: python3 -m unittest discover -s test -p test_registration_email.py"""
import ast
import asyncio
import importlib.util
from pathlib import Path
import sys
import types
import unittest
from email import message_from_string
from email.header import decode_header, make_header
from unittest.mock import AsyncMock, Mock, patch

ROOT = Path(__file__).resolve().parents[1]
config = types.ModuleType("config")
config.SMTP_HOST = "smtp.example.com"
config.SMTP_PORT = 465
config.SMTP_USER = "admin@example.com"
config.SMTP_PASSWORD = "test-only-password"
config.FROM_EMAIL = "admin@example.com"
config.FROM_NAME = "Táo Giáo Dục"
config.APP_URL = "https://example.com"
spec = importlib.util.spec_from_file_location(
    "registration_email_service", ROOT / "backend-python/services/email_service.py"
)
email_service = importlib.util.module_from_spec(spec)
with patch.dict(sys.modules, {"config": config}):
    spec.loader.exec_module(email_service)


class HTTPException(Exception):
    def __init__(self, status_code, detail):
        self.status_code = status_code
        self.detail = detail


class RegistrationEmailTests(unittest.TestCase):
    def setUp(self):
        # Compile the actual route body without importing unrelated DB/framework
        # dependencies. Replace only its external collaborators.
        tree = ast.parse((ROOT / "backend-python/routes/auth.py").read_text(encoding="utf-8"))
        route = next(node for node in tree.body if isinstance(node, ast.AsyncFunctionDef) and node.name == "register")
        route.decorator_list = []
        self.auth = Mock(register=AsyncMock())
        self.send_welcome = Mock()
        namespace = {
            "AuthRequest": object,
            "BackgroundTasks": object,
            "HTTPException": HTTPException,
            "auth_service": self.auth,
            "send_welcome_email": self.send_welcome,
        }
        exec(compile(ast.Module(body=[route], type_ignores=[]), "routes/auth.py", "exec"), namespace)
        self.register = namespace["register"]
        self.body = types.SimpleNamespace(email="user@example.com", password="Example123", captchaToken="captcha")
        self.tasks = Mock()

    def test_success_queues_welcome_for_saved_user_and_preserves_response(self):
        response = {"user": {"email": "saved@example.com"}, "token": "token"}
        self.auth.register.return_value = response
        result = asyncio.run(self.register(self.body, self.tasks))
        self.assertIs(result, response)
        self.auth.register.assert_awaited_once_with("user@example.com", "Example123", "captcha")
        self.tasks.add_task.assert_called_once_with(self.send_welcome, "saved@example.com")
        self.send_welcome.assert_not_called()

    def test_failed_registration_never_queues_email(self):
        for error, expected_status in [(ValueError("Email already registered"), 400), (PermissionError("CAPTCHA verification failed"), 403), (RuntimeError("database unavailable"), 500)]:
            with self.subTest(error=error):
                self.auth.register.side_effect = error
                with self.assertRaises(HTTPException) as caught:
                    asyncio.run(self.register(self.body, self.tasks))
                self.assertEqual(caught.exception.status_code, expected_status)
                self.tasks.add_task.assert_not_called()

    def test_welcome_smtp_headers_body_and_envelope(self):
        with patch.object(email_service.smtplib, "SMTP_SSL") as smtp:
            self.assertTrue(email_service.send_welcome_email("user@example.com"))
            smtp.assert_called_once_with("smtp.example.com", 465, timeout=30)
            server = smtp.return_value.__enter__.return_value
            server.login.assert_called_once_with("admin@example.com", "test-only-password")
            sender, recipient, raw = server.sendmail.call_args.args
            self.assertEqual((sender, recipient), ("admin@example.com", "user@example.com"))
            message = message_from_string(raw)
            self.assertEqual(str(make_header(decode_header(message["From"]))), "Táo Giáo Dục <admin@example.com>")
            self.assertIn("Chào mừng", str(make_header(decode_header(message["Subject"]))))
            body = message.get_payload(0).get_payload(decode=True).decode("utf-8")
            self.assertIn("user@example.com", body)
            self.assertIn("https://example.com/login", body)
            self.assertNotIn("test-only-password", raw)

    def test_smtp_failure_is_logged_and_does_not_raise(self):
        with patch.object(email_service.smtplib, "SMTP_SSL", side_effect=OSError("SMTP unavailable")):
            with self.assertLogs(email_service.logger, level="ERROR"):
                self.assertFalse(email_service.send_welcome_email("user@example.com"))


if __name__ == "__main__":
    unittest.main()
