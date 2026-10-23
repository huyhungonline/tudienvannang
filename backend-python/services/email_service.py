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
    subject = f"【{FROM_NAME}】ご登録ありがとうございます"

    body = "\n".join([
        "この度はご登録いただき、ありがとうございます。",
        "",
        f"{FROM_NAME} のアカウント登録が完了しました。",
        "",
        "■ アカウント情報",
        f"　メールアドレス：{to}",
        "",
        f"ログイン：{APP_URL}/login",
        f"サイトトップ：{APP_URL}",
        "",
        "日本の技能資格の学習（専門用語・過去問・模擬試験）にご活用ください。",
        "",
        FROM_NAME,
    ])

    content = f"""
        <p style="margin:0 0 18px;font-size:14px;color:#555;line-height:1.8;">
          この度はご登録いただき、ありがとうございます。<br>
          アカウントの登録が完了しました。
        </p>

        <table role="presentation" style="width:100%;background:#f8fafc;
               border:1px solid #e5e7eb;border-radius:8px;">
          <tr>
            <td style="padding:16px 20px;font-size:14px;">
              <span style="color:#666;">メールアドレス</span><br>
              <strong style="color:#111;font-size:15px;">{_escape_html(to)}</strong>
            </td>
          </tr>
        </table>

        <p style="margin:20px 0 0;font-size:14px;color:#555;line-height:1.8;">
          日本の技能資格の学習にご活用ください。専門用語、過去問の解説、
          本番と同じ形式の模擬試験をご利用いただけます。
        </p>
        {_html_button(f"{APP_URL}/login", "ログインして学習を始める")}"""

    return send_email(to, subject, body, html=_html_shell("ご登録完了", content))


def send_pro_upgrade_email(to: str) -> bool:
    """Notify a user after their Pro upgrade has been saved."""
    subject = f"【{FROM_NAME}】Proアカウントへのアップグレードが完了しました"

    body = "\n".join([
        "お待たせいたしました。",
        "",
        f"アカウント {to} の Pro へのアップグレードが完了しました。",
        "",
        "専門用語・過去問の解説・模擬試験のすべての機能をご利用いただけます。",
        "権限が反映されていない場合は、一度ログアウトして再度ログインしてください。",
        "",
        f"サイトトップ：{APP_URL}",
        "",
        f"今後ともよろしくお願いいたします。",
        FROM_NAME,
    ])

    content = f"""
        <p style="margin:0 0 18px;font-size:14px;color:#555;line-height:1.8;">
          お待たせいたしました。<br>
          アカウントの <strong style="color:#15803d;">Pro</strong> へのアップグレードが完了しました。
        </p>

        <table role="presentation" style="width:100%;background:#f0fdf4;
               border-left:3px solid #16a34a;border-radius:6px;">
          <tr>
            <td style="padding:14px 18px;font-size:14px;color:#15803d;line-height:1.8;">
              専門用語・過去問の解説・模擬試験のすべての機能が
              ご利用いただけるようになりました。
            </td>
          </tr>
        </table>

        <p style="margin:18px 0 0;font-size:13px;color:#666;line-height:1.8;">
          権限が反映されていない場合は、一度ログアウトして再度ログインしてください。
        </p>
        {_html_button(f"{APP_URL}/certificates", "資格学習を始める")}"""

    return send_email(to, subject, body, html=_html_shell("Proアカウント有効化", content))


def send_password_reset_email(to: str, new_password: str) -> bool:
    """Send a newly generated password to the user."""
    subject = f"【{FROM_NAME}】パスワード再設定のお知らせ"

    body = "\n".join([
        "パスワード再設定のご依頼を承りました。",
        "",
        "■ 新しいパスワード",
        f"　{new_password}",
        "",
        f"ログイン：{APP_URL}/login",
        "",
        "セキュリティのため、ログイン後にパスワードの変更をお願いいたします。",
        "このご依頼に心当たりがない場合は、お手数ですがご連絡ください。",
        "",
        FROM_NAME,
    ])

    content = f"""
        <p style="margin:0 0 18px;font-size:14px;color:#555;line-height:1.8;">
          パスワード再設定のご依頼を承りました。<br>
          新しいパスワードは以下のとおりです。
        </p>

        <table role="presentation" style="width:100%;background:#f8fafc;
               border:1px solid #e5e7eb;border-radius:8px;">
          <tr>
            <td style="padding:20px;text-align:center;">
              <div style="font-size:12px;color:#666;margin-bottom:8px;">新しいパスワード</div>
              <div style="font-family:'Courier New',monospace;font-size:20px;
                          font-weight:700;color:#111;letter-spacing:1px;
                          word-break:break-all;">{_escape_html(new_password)}</div>
            </td>
          </tr>
        </table>

        <table role="presentation" style="width:100%;margin-top:18px;background:#fffbeb;
               border-left:3px solid #f59e0b;border-radius:6px;">
          <tr>
            <td style="padding:14px 18px;font-size:13px;color:#b45309;line-height:1.8;">
              セキュリティのため、ログイン後にパスワードの変更をお願いいたします。<br>
              このご依頼に心当たりがない場合は、お手数ですがご連絡ください。
            </td>
          </tr>
        </table>
        {_html_button(f"{APP_URL}/login", "ログインする")}"""

    return send_email(to, subject, body, html=_html_shell("パスワード再設定", content))


def _escape_html(value: str) -> str:
    """Minimal escaping so dynamic text cannot break the mail layout."""
    return (
        str(value)
        .replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
    )


def _html_shell(header_title: str, content_html: str) -> str:
    """Wrap content in the shared branded email layout.

    Inline styles only and a table-based frame, because many mail clients
    strip <style> blocks and have patchy flexbox support.
    """
    return f"""<!DOCTYPE html>
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
          {header_title}
        </div>
        <div style="color:#cfe3ff;font-size:13px;margin-top:4px;">{_escape_html(FROM_NAME)}</div>
      </td>
    </tr>
    <tr><td style="padding:28px;">{content_html}</td></tr>
    <tr>
      <td style="padding:16px 28px;background:#fafafa;border-top:1px solid #eee;
                 font-size:12px;color:#888;line-height:1.7;">
        {_escape_html(FROM_NAME)} — <a href="{APP_URL}" style="color:#1976d2;text-decoration:none;">{APP_URL}</a>
      </td>
    </tr>
  </table>
</body>
</html>"""


def _html_button(href: str, label: str) -> str:
    """A centred call-to-action button."""
    return f"""
        <div style="margin-top:26px;text-align:center;">
          <a href="{href}" style="display:inline-block;padding:12px 32px;
             background:#1976d2;color:#fff;text-decoration:none;border-radius:6px;
             font-size:15px;font-weight:700;">{label}</a>
        </div>"""


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

    content = f"""
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
        {_html_button(f"{APP_URL}/certificates", "結果の詳細を見る")}"""

    return send_email(to, subject, text_body, html=_html_shell("模擬試験 結果通知", content))
