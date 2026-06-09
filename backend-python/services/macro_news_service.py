import json
import logging
from datetime import datetime, timezone

import httpx

import db
from config import (
    AZURE_OPENAI_ENDPOINT,
    AZURE_OPENAI_API_KEY,
    AZURE_OPENAI_API_VERSION,
    AZURE_OPENAI_MODEL,
)

logger = logging.getLogger(__name__)

CATEGORIES = {
    "gold": {"title": "Gold", "title_ja": "金（ゴールド）"},
    "silver": {"title": "Silver", "title_ja": "銀（シルバー）"},
    "oil": {"title": "Oil (Crude)", "title_ja": "原油"},
    "us_treasury": {"title": "US Treasury", "title_ja": "米国債"},
    "central_banks": {"title": "Central Banks", "title_ja": "中央銀行"},
}

PROMPTS_EN = {
    "gold": (
        "Provide a brief macro-economic analysis of gold prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how gold movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "silver": (
        "Provide a brief macro-economic analysis of silver prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how silver movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "oil": (
        "Provide a brief macro-economic analysis of crude oil prices. Include: "
        "1) Current price trend summary, "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how oil price movements affect stocks, bonds, currencies, and other commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "us_treasury": (
        "Provide a brief macro-economic analysis of US Treasury yields. Include: "
        "1) Current yield trend summary (2Y, 10Y, 30Y), "
        "2) Technical and fundamental trend analysis, "
        "3) Cross-market impact (how Treasury yield movements affect stocks, currencies, gold, and credit markets). "
        "Write in English, keep it concise (200-300 words)."
    ),
    "central_banks": (
        "Provide a brief macro-economic analysis of major central bank policies (Fed, ECB, BOJ, BOE). Include: "
        "1) Current policy stance summary, "
        "2) Recent decisions and forward guidance analysis, "
        "3) Cross-market impact (how central bank policies affect stocks, bonds, currencies, and commodities). "
        "Write in English, keep it concise (200-300 words)."
    ),
}

PROMPTS_JA = {
    "gold": (
        "金価格のマクロ経済分析を簡潔に提供してください。以下を含めてください："
        "1) 現在の価格トレンドの概要、"
        "2) テクニカルおよびファンダメンタル分析、"
        "3) クロスマーケットへの影響（金の動きが株式、債券、通貨、その他のコモディティにどう影響するか）。"
        "日本語で書いてください。200〜300語程度で簡潔にまとめてください。"
    ),
    "silver": (
        "銀価格のマクロ経済分析を簡潔に提供してください。以下を含めてください："
        "1) 現在の価格トレンドの概要、"
        "2) テクニカルおよびファンダメンタル分析、"
        "3) クロスマーケットへの影響（銀の動きが株式、債券、通貨、その他のコモディティにどう影響するか）。"
        "日本語で書いてください。200〜300語程度で簡潔にまとめてください。"
    ),
    "oil": (
        "原油価格のマクロ経済分析を簡潔に提供してください。以下を含めてください："
        "1) 現在の価格トレンドの概要、"
        "2) テクニカルおよびファンダメンタル分析、"
        "3) クロスマーケットへの影響（原油価格の動きが株式、債券、通貨、その他のコモディティにどう影響するか）。"
        "日本語で書いてください。200〜300語程度で簡潔にまとめてください。"
    ),
    "us_treasury": (
        "米国債利回りのマクロ経済分析を簡潔に提供してください。以下を含めてください："
        "1) 現在の利回りトレンドの概要（2年、10年、30年）、"
        "2) テクニカルおよびファンダメンタル分析、"
        "3) クロスマーケットへの影響（米国債利回りの動きが株式、通貨、金、クレジット市場にどう影響するか）。"
        "日本語で書いてください。200〜300語程度で簡潔にまとめてください。"
    ),
    "central_banks": (
        "主要中央銀行（FRB、ECB、日銀、BOE）の政策に関するマクロ経済分析を簡潔に提供してください。以下を含めてください："
        "1) 現在の政策スタンスの概要、"
        "2) 最近の決定とフォワードガイダンスの分析、"
        "3) クロスマーケットへの影響（中央銀行の政策が株式、債券、通貨、コモディティにどう影響するか）。"
        "日本語で書いてください。200〜300語程度で簡潔にまとめてください。"
    ),
}


async def _call_openai(prompt: str) -> str:
    """Call Azure OpenAI API to generate macro news content."""
    url = f"{AZURE_OPENAI_ENDPOINT}?api-version={AZURE_OPENAI_API_VERSION}"

    headers = {
        "Content-Type": "application/json",
        "api-key": AZURE_OPENAI_API_KEY,
    }

    payload = {
        "model": AZURE_OPENAI_MODEL,
        "input": prompt,
    }

    async with httpx.AsyncClient(timeout=60.0) as client:
        response = await client.post(url, headers=headers, json=payload)
        response.raise_for_status()
        data = response.json()

        if "output" in data:
            for item in data["output"]:
                if item.get("type") == "message":
                    for content in item.get("content", []):
                        if content.get("type") == "output_text":
                            return content.get("text", "")
        if "choices" in data:
            return data["choices"][0]["message"]["content"]

        logger.error(f"Unexpected API response format: {json.dumps(data)[:500]}")
        return "Unable to generate content at this time."


async def get_all_news(language: str = "en") -> list[dict]:
    """Retrieve latest content for all 5 categories from DB filtered by language."""
    rows = await db.query(
        """
        SELECT DISTINCT ON (category) id, category, title, content, language, updated_at
        FROM macro_news
        WHERE language = $1
        ORDER BY category, updated_at DESC
        """,
        language,
    )

    results = []
    for row in rows:
        item = dict(row)
        if isinstance(item.get("updated_at"), datetime):
            item["updated_at"] = item["updated_at"].isoformat()
        if item.get("id"):
            item["id"] = str(item["id"])
        results.append(item)

    return results


async def get_history(days: int = 20, language: str = "en") -> list[dict]:
    """Get list of all news snapshots grouped by date (last N days)."""
    rows = await db.query(
        """
        SELECT id, category, title, content, language, updated_at
        FROM macro_news
        WHERE updated_at >= NOW() - INTERVAL '%s days' AND language = $1
        ORDER BY updated_at DESC
        """ % days,
        language,
    )

    results = []
    for row in rows:
        item = dict(row)
        if isinstance(item.get("updated_at"), datetime):
            item["updated_at"] = item["updated_at"].isoformat()
        if item.get("id"):
            item["id"] = str(item["id"])
        results.append(item)

    return results


async def get_news_by_date(date_str: str, language: str = "en") -> list[dict]:
    """Get the latest news entry per category for a specific date."""
    rows = await db.query(
        """
        SELECT DISTINCT ON (category) id, category, title, content, language, updated_at
        FROM macro_news
        WHERE DATE(updated_at) = $1 AND language = $2
        ORDER BY category, updated_at DESC
        """,
        date_str,
        language,
    )

    results = []
    for row in rows:
        item = dict(row)
        if isinstance(item.get("updated_at"), datetime):
            item["updated_at"] = item["updated_at"].isoformat()
        if item.get("id"):
            item["id"] = str(item["id"])
        results.append(item)

    return results


async def refresh_news(language: str = "en") -> list[dict]:
    """Call OpenAI for each category in specified language, INSERT new records."""
    prompts = PROMPTS_JA if language == "ja" else PROMPTS_EN
    results = []

    for category, info in CATEGORIES.items():
        try:
            logger.info(f"Refreshing macro news for {category} ({language})")
            prompt = prompts[category]
            content = await _call_openai(prompt)

            title = info["title_ja"] if language == "ja" else info["title"]

            await db.execute(
                """
                INSERT INTO macro_news (category, title, content, language, updated_at)
                VALUES ($1, $2, $3, $4, NOW())
                """,
                category,
                title,
                content,
                language,
            )

            results.append({
                "category": category,
                "title": title,
                "content": content,
                "language": language,
                "updated_at": datetime.now(timezone.utc).isoformat(),
            })
        except Exception as e:
            logger.error(f"Failed to refresh news for {category} ({language}): {e}")
            results.append({
                "category": category,
                "title": info["title"],
                "content": f"Error refreshing content: {str(e)}",
                "language": language,
                "updated_at": datetime.now(timezone.utc).isoformat(),
            })

    return results
