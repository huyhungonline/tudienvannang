"""Run with backend dependencies: python -m unittest discover -s test -p test_pro_upgrade_email.py."""
from pathlib import Path
import sys
import unittest
from unittest.mock import AsyncMock, patch
from email import message_from_string
from email.header import decode_header, make_header

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "backend-python"))
from fastapi import FastAPI
from fastapi.testclient import TestClient
from routes import admin
from services import email_service

USER_ID = "11111111-1111-4111-8111-111111111111"


class ProUpgradeEmailTests(unittest.TestCase):
    def setUp(self):
        app = FastAPI()
        app.include_router(admin.router)
        app.dependency_overrides[admin.require_admin] = lambda: USER_ID
        self.client = TestClient(app, raise_server_exceptions=False)
        self.query = self.enterContext(patch.object(admin.db, "query_one", new_callable=AsyncMock))
        self.execute = self.enterContext(patch.object(admin.db, "execute", new_callable=AsyncMock))
        self.smtp = self.enterContext(patch.object(email_service.smtplib, "SMTP_SSL"))
        self.server = self.smtp.return_value.__enter__.return_value

    def update(self, body):
        return self.client.put(f"/api/admin/users/{USER_ID}", json=body)

    def test_upgrade_sends_pro_email_after_conditional_update(self):
        self.query.side_effect = [{"id": USER_ID}, {"email": "user@example.com"}]
        response = self.update({"isVip": True})
        self.assertEqual(response.status_code, 200)
        self.assertIn("is_vip IS DISTINCT FROM TRUE", self.query.call_args.args[0])
        self.server.sendmail.assert_called_once()
        sender, recipient, raw = self.server.sendmail.call_args.args
        self.assertEqual(sender, email_service.FROM_EMAIL)
        self.assertEqual(recipient, "user@example.com")
        message = message_from_string(raw)
        self.assertIn("nâng cấp Pro", str(make_header(decode_header(message["Subject"]))))
        self.assertIn(email_service.FROM_NAME, str(make_header(decode_header(message["From"]))))
        body = message.get_payload(0).get_payload(decode=True).decode("utf-8")
        self.assertIn(email_service.APP_URL, body)

    def test_already_pro_does_not_send_duplicate_email(self):
        self.query.side_effect = [{"id": USER_ID}, None]
        self.assertEqual(self.update({"isVip": True}).status_code, 200)
        self.smtp.assert_not_called()

    def test_downgrade_does_not_send_upgrade_email(self):
        self.query.return_value = {"id": USER_ID}
        self.assertEqual(self.update({"isVip": False}).status_code, 200)
        self.execute.assert_awaited_once()
        self.smtp.assert_not_called()

    def test_unrelated_edit_does_not_send_upgrade_email(self):
        self.query.return_value = {"id": USER_ID}
        self.assertEqual(self.update({"isAdmin": True}).status_code, 200)
        self.smtp.assert_not_called()

    def test_email_change_and_upgrade_uses_updated_email(self):
        self.query.side_effect = [{"id": USER_ID}, None, {"email": "new@example.com"}]
        self.assertEqual(self.update({"email": "new@example.com", "isVip": True}).status_code, 200)
        self.assertEqual(self.server.sendmail.call_args.args[1], "new@example.com")

    def test_database_failure_sends_no_email(self):
        self.query.side_effect = [{"id": USER_ID}, RuntimeError("DB unavailable")]
        self.assertEqual(self.update({"isVip": True}).status_code, 500)
        self.smtp.assert_not_called()

    def test_smtp_failure_preserves_successful_upgrade_response(self):
        self.query.side_effect = [{"id": USER_ID}, {"email": "user@example.com"}]
        self.smtp.side_effect = OSError("SMTP unavailable")
        with self.assertLogs(email_service.logger, level="ERROR"):
            self.assertEqual(self.update({"isVip": True}).status_code, 200)

    def test_missing_user_sends_no_email(self):
        self.query.return_value = None
        self.assertEqual(self.update({"isVip": True}).status_code, 404)
        self.smtp.assert_not_called()


if __name__ == "__main__":
    unittest.main()
