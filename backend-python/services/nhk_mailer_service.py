"""NHK News Mailer Service.

Prepares and sends daily NHK news emails to subscribers.
Tokenizes Japanese content, translates words to target language,
and sends HTML emails with word breakdown tables.
"""
import asyncio
import logging
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from functools import partial

from deep_translator import GoogleTranslator

import db
from services.nhk_scraper_service import scrape_nhk_news
from services.tokenizer_service import tokenize

logger = logging.getLogger(__name__)

# SMTP configuration
SMTP_HOST = os.getenv("SMTP_HOST", "pro205.emailserver.vn")
SMTP_PORT = int(os.getenv("SMTP_PORT", "465"))
SMTP_USER = os.getenv("SMTP_USER", "admin@jaenglish.com")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "")
FROM_EMAIL = os.getenv("FROM_EMAIL", "admin@jaenglish.com")

# Limit tokens per article to avoid rate limiting
MAX_TOKENS_PER_ARTICLE = 30


async def _translate_from_ja(word: str, target_lang: str) -> str:
    """Translate Japanese word to target language using deep-translator."""
    try:
        loop = asyncio.get_running_loop()
        result = await loop.run_in_executor(
            None,
            partial(GoogleTranslator(source="ja", target=target_lang).translate, word),
        )
        return result if result else "N/A"
    except Exception:
        return "N/A"


def _send_html_email(to: str, subject: str, html_body: str) -> bool:
    """Send an HTML email via SMTP SSL."""
    msg = MIMEMultipart("alternative")
    msg["From"] = FROM_EMAIL
    msg["To"] = to
    msg["Subject"] = subject
    # Add plain text fallback
    from html import unescape
    import re
    plain_text = re.sub(r'<[^>]+>', '', html_body)
    plain_text = unescape(plain_text).strip()
    msg.attach(MIMEText(plain_text, "plain"))
    msg.attach(MIMEText(html_body, "html"))

    try:
        server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=10)
        server.ehlo()
        server.login(SMTP_USER, SMTP_PASSWORD)
        server.sendmail(FROM_EMAIL, to, msg.as_string())
        server.quit()
        logger.info(f"[NHK] Email sent successfully to {to}")
        return True
    except Exception as e:
        logger.error(f"[NHK] Failed to send HTML email to {to}: {e}")
        return False


async def _prepare_email_content(article: dict, target_language: str) -> list[dict]:
    """Tokenize article content and translate each word to target language.

    Args:
        article: Dict with 'content' (Japanese text) and other fields.
        target_language: Target language code ('en' or 'vi').

    Returns:
        List of dicts: [{"word": str, "reading": str, "translation": str}, ...]
    """
    # Tokenize the Japanese article content
    tokens = tokenize(article["content"], "ja")

    # Limit to MAX_TOKENS_PER_ARTICLE to avoid rate limiting
    tokens = tokens[:MAX_TOKENS_PER_ARTICLE]

    # Translate each token
    tokens_with_translations = []
    for token in tokens:
        translation = await _translate_from_ja(token["word"], target_language)
        tokens_with_translations.append({
            "word": token["word"],
            "reading": token.get("reading", ""),
            "translation": translation,
        })

    return tokens_with_translations


def _build_html_email(article: dict, tokens_with_translations: list[dict]) -> str:
    """Build HTML email content with article title and word breakdown table.

    Args:
        article: Dict with 'title', 'source_url', 'published_at'.
        tokens_with_translations: List of dicts with 'word', 'reading', 'translation'.

    Returns:
        HTML string for the email body.
    """
    published_at = article.get("published_at", "")
    if hasattr(published_at, "strftime"):
        published_at = published_at.strftime("%Y-%m-%d %H:%M")

    # Build table rows
    rows_html = ""
    for token in tokens_with_translations:
        rows_html += (
            f"<tr>"
            f"<td style=\"padding:8px;border:1px solid #ddd;\">{token['word']}</td>"
            f"<td style=\"padding:8px;border:1px solid #ddd;\">{token['reading']}</td>"
            f"<td style=\"padding:8px;border:1px solid #ddd;\">{token['translation']}</td>"
            f"</tr>"
        )

    html = f"""<!DOCTYPE html>
<html>
<head><meta charset="utf-8"></head>
<body style="font-family:Arial,sans-serif;max-width:600px;margin:0 auto;padding:20px;">
    <h2 style="color:#333;">{article.get('title', '')}</h2>
    <p style="color:#666;font-size:14px;">
        Source: <a href="{article.get('source_url', '#')}">NHK News</a> | {published_at}
    </p>
    <hr style="border:1px solid #eee;">
    <h3 style="color:#444;">Word Breakdown</h3>
    <table style="border-collapse:collapse;width:100%;margin:10px 0;">
        <tr style="background:#f5f5f5;">
            <th style="padding:8px;border:1px solid #ddd;text-align:left;">Japanese</th>
            <th style="padding:8px;border:1px solid #ddd;text-align:left;">Reading</th>
            <th style="padding:8px;border:1px solid #ddd;text-align:left;">Translation</th>
        </tr>
        {rows_html}
    </table>
    <hr style="border:1px solid #eee;">
    <p style="color:#999;font-size:12px;">
        You are receiving this because you subscribed to NHK Daily News.<br>
        To unsubscribe, reply "unsubscribe" to this email.
    </p>
</body>
</html>"""

    return html


async def send_daily_news() -> dict:
    """Orchestrate the daily news email sending process.

    Flow:
    1. Scrape NHK news (get latest articles)
    2. Get newest article from DB
    3. Get all active subscribers
    4. For each subscriber: prepare content (tokenize + translate) and send email

    Returns:
        Dict with summary: {"success": bool, "sent": int, "failed": int, "article_title": str}
    """
    try:
        # Step 1: Scrape latest news
        logger.info("[NHK] Starting daily news job")
        scrape_result = await scrape_nhk_news()

        if not scrape_result.get("success"):
            logger.error(f"[NHK] Scrape failed: {scrape_result.get('message')}")
            return {
                "success": False,
                "sent": 0,
                "failed": 0,
                "article_title": "",
            }

        # Step 2: Get newest article from DB
        article = await db.query_one(
            "SELECT * FROM nhk_articles ORDER BY created_at DESC LIMIT 1"
        )

        if not article:
            logger.warning("[NHK] No articles found in database after scrape")
            return {
                "success": False,
                "sent": 0,
                "failed": 0,
                "article_title": "",
            }

        article_title = article.get("title", "")
        logger.info(f"[NHK] Sending article: {article_title}")

        # Step 3: Get all active subscribers
        subscribers = await db.query(
            "SELECT * FROM nhk_subscribers WHERE is_active = TRUE"
        )

        if not subscribers:
            logger.info("[NHK] No active subscribers found")
            return {
                "success": True,
                "sent": 0,
                "failed": 0,
                "article_title": article_title,
            }

        logger.info(f"[NHK] Sending to {len(subscribers)} active subscribers")

        # Step 4: Prepare and send email to each subscriber
        sent_count = 0
        failed_count = 0

        for subscriber in subscribers:
            try:
                target_lang = subscriber.get("target_language", "en")
                email_addr = subscriber.get("email", "")

                # Prepare email content (tokenize + translate)
                tokens_with_translations = await _prepare_email_content(
                    article, target_lang
                )

                # Build HTML email
                html_body = _build_html_email(article, tokens_with_translations)

                # Send email
                subject = f"[NHK Daily] {article_title}"
                success = _send_html_email(email_addr, subject, html_body)

                if success:
                    sent_count += 1
                    logger.info(f"[NHK] Sent to {email_addr}")
                else:
                    failed_count += 1
                    logger.error(f"[NHK] Failed to send to {email_addr}")

            except Exception as e:
                failed_count += 1
                logger.error(
                    f"[NHK] Error processing subscriber {subscriber.get('email', 'unknown')}: {e}"
                )
                continue

        logger.info(
            f"[NHK] Daily job complete: sent={sent_count}, failed={failed_count}"
        )

        return {
            "success": True,
            "sent": sent_count,
            "failed": failed_count,
            "article_title": article_title,
        }

    except Exception as e:
        logger.error(f"[NHK] Unexpected error in send_daily_news: {e}")
        return {
            "success": False,
            "sent": 0,
            "failed": 0,
            "article_title": "",
        }
