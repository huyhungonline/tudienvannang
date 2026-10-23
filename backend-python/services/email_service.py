"""Email service for sending transactional emails."""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.utils import formataddr
import logging

from config import SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, FROM_EMAIL, FROM_NAME, APP_URL

logger = logging.getLogger(__name__)


def send_email(to: str, subject: str, body: str, html: str | None = None) -> bool:
    """Send a UTF-8 email using the shared SMTP configuration.

    When `html` is supplied the message is sent as multipart/alternative so
    clients that cannot render HTML still show the plain-text `body`.
    """
    msg = MIMEMultipart("alternative" if html else "mixed")
    msg["From"] = formataddr((FROM_NAME, FROM_EMAIL))
    msg["To"] = to
    msg["Subject"] = subject
    # Plain part first: mail clients display the last part they can render.
    msg.attach(MIMEText(body, "plain", "utf-8"))
    if html:
        msg.attach(MIMEText(html, "html", "utf-8"))

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


def _escape_html(value: str) -> str:
    """Minimal escaping so exam text cannot break the mail layout."""
    return (
        str(value)
        .replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
    )


def send_mock_exam_result_email(
    to: str,
    certificate_name: str,
    total_questions: int,
    correct_count: int,
    score_percent: float,
    duration_seconds: int | None,
    wrong_questions: list[dict] | None = None,
) -> bool:
    """Send a Japanese-language mock exam report to the learner.

    `wrong_questions` is a list of {questionNo, correctLabel, selectedLabel}
    so the learner can see which questions they missed without logging in.
    Sent as HTML with a plain-text fallback.
    """
    if duration_seconds is None:
        duration_text = "—"
    else:
        minutes, seconds = divmod(max(0, duration_seconds), 60)
        duration_text = f"{minutes}分{seconds:02d}秒"

    wrong_questions = wrong_questions or []
    # Pass mark follows the common 60% threshold used by Japanese skill exams.
    passed = score_percent >= 60
    verdict_ja = "合格ライン到達" if passed else "合格ラインまであと一歩"
    accent = "#15803d" if passed else "#b45309"

    subject = (
        f"【{FROM_NAME}】模擬試験の結果 — {certificate_name}"
        f"（{score_percent}% / {correct_count}問正解）"
    )

    # ---------- Plain-text fallback ----------
    lines = [
        "お疲れさまでした。",
        "",
        f"模擬試験「{certificate_name}」の結果をお知らせします。",
        "",
        "■ 試験結果",
        f"　得点率　　：{score_percent}%",
        f"　正解数　　：{correct_count} / {total_questions} 問",
        f"　所要時間　：{duration_text}",
        f"　判定　　　：{verdict_ja}",
    ]

    if wrong_questions:
        lines += ["", f"■ 誤答一覧（{len(wrong_questions)}問）"]
        for w in wrong_questions:
            chosen = w.get("selectedLabel") or "未解答"
            lines.append(
                f"　問{w.get('questionNo')}：あなたの解答 {chosen} ／ 正解 {w.get('correctLabel')}"
            )
        lines += ["", "解説と和訳・ベトナム語訳はサイトにログインしてご確認ください。"]

    lines += [
        "",
        f"結果の詳細：{APP_URL}/certificates",
        "",
        "引き続き学習を頑張ってください。",
        FROM_NAME,
    ]
    text_body = "\n".join(lines)

    # ---------- HTML version ----------
    if wrong_questions:
        rows = "".join(
            f"""
            <tr>
              <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#333;">問{_escape_html(w.get('questionNo'))}</td>
              <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#dc2626;font-weight:600;">{_escape_html(w.get('selectedLabel') or '未解答')}</td>
              <td style="padding:8px 12px;border-bottom:1px solid #eee;color:#15803d;font-weight:600;">{_escape_html(w.get('correctLabel'))}</td>
            </tr>"""
            for w in wrong_questions
        )
        wrong_section = f"""
        <h3 style="margin:28px 0 10px;font-size:15px;color:#333;font-weight:600;">
          誤答一覧（{len(wrong_questions)}問）
        </h3>
        <table style="width:100%;border-collapse:collapse;font-size:14px;">
          <thead>
            <tr style="background:#f3f4f6;">
              <th style="padding:8px 12px;text-align:left;color:#555;font-weight:600;">問題</th>
              <th style="padding:8px 12px;text-align:left;color:#555;font-weight:600;">あなたの解答</th>
              <th style="padding:8px 12px;text-align:left;color:#555;font-weight:600;">正解</th>
            </tr>
          </thead>
          <tbody>{rows}</tbody>
        </table>
        <p style="margin:14px 0 0;font-size:13px;color:#666;line-height:1.7;">
          解説・和訳・ベトナム語訳は、サイトにログインしてご確認いただけます。
        </p>"""
    else:
        wrong_section = """
        <p style="margin:24px 0 0;padding:14px 16px;background:#f0fdf4;
                  border-left:3px solid #16a34a;font-size:14px;color:#15803d;">
          全問正解です。素晴らしい成績です。
        </p>"""

    html_body = f"""<!DOCTYPE html>
<html lang="ja">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:24px 12px;background:#f5f6f8;
             font-family:'Hiragino Kaku Gothic ProN','Yu Gothic','Meiryo',sans-serif;">
  <table role="presentation" style="max-width:600px;margin:0 auto;width:100%;
         background:#fff;border-radius:10px;overflow:hidden;
         box-shadow:0 1px 4px rgba(0,0,0,0.08);">
    <tr>
      <td style="background:#1976d2;padding:20px 28px;">
        <div style="color:#fff;font-size:18px;font-weight:700;letter-spacing:.5px;">
          模擬試験 結果通知
        </div>
        <div style="color:#cfe3ff;font-size:13px;margin-top:4px;">{_escape_html(FROM_NAME)}</div>
      </td>
    </tr>
    <tr>
      <td style="padding:28px;">
        <p style="margin:0 0 6px;font-size:14px;color:#555;">お疲れさまでした。</p>
        <p style="margin:0 0 22px;font-size:15px;color:#111;font-weight:600;">
          {_escape_html(certificate_name)}
        </p>

        <table role="presentation" style="width:100%;background:#f8fafc;
               border:1px solid #e5e7eb;border-radius:8px;">
          <tr>
            <td style="padding:20px 24px;text-align:center;">
              <div style="font-size:40px;font-weight:800;color:#1976d2;line-height:1;">
                {score_percent}%
              </div>
              <div style="margin-top:6px;font-size:14px;color:#444;">
                {correct_count} / {total_questions} 問 正解
              </div>
              <div style="margin-top:10px;display:inline-block;padding:4px 14px;
                          border-radius:999px;background:#fff;border:1px solid {accent};
                          color:{accent};font-size:13px;font-weight:600;">
                {verdict_ja}
              </div>
            </td>
          </tr>
        </table>

        <table role="presentation" style="width:100%;margin-top:18px;font-size:14px;">
          <tr>
            <td style="padding:7px 0;color:#666;width:120px;">所要時間</td>
            <td style="padding:7px 0;color:#111;font-weight:600;">{duration_text}</td>
          </tr>
          <tr>
            <td style="padding:7px 0;color:#666;">出題数</td>
            <td style="padding:7px 0;color:#111;font-weight:600;">{total_questions} 問</td>
          </tr>
        </table>

        {wrong_section}

        <div style="margin-top:28px;text-align:center;">
          <a href="{APP_URL}/certificates"
             style="display:inline-block;padding:12px 32px;background:#1976d2;
                    color:#fff;text-decoration:none;border-radius:6px;
                    font-size:15px;font-weight:700;">
            結果の詳細を見る
          </a>
        </div>
      </td>
    </tr>
    <tr>
      <td style="padding:16px 28px;background:#fafafa;border-top:1px solid #eee;
                 font-size:12px;color:#888;line-height:1.7;">
        引き続き学習を頑張ってください。<br>
        {_escape_html(FROM_NAME)} — <a href="{APP_URL}" style="color:#1976d2;text-decoration:none;">{APP_URL}</a>
      </td>
    </tr>
  </table>
</body>
</html>"""

    return send_email(to, subject, text_body, html=html_body)
