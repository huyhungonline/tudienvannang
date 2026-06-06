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
    "gold": {
        "title": "Gold",
        "prompt": (
            "Provide a brief macro-economic analysis of gold prices. Include: "
            "1) Current price trend summary, "
            "2) Technical and fundamental trend analysis, "
            "3) Cross-market impact (how gold movements affect stocks, bonds, currencies, and other commodities). "
            "Write in English, keep it concise (200-300 words)."
        ),
    },
    "silver": {
        "title": "Silver",
        "prompt": (
            "Provide a brief macro-economic analysis of silver prices. Include: "
            "1) Current price trend summary, "
            "2) Technical and fundamental trend analysis, "
            "3) Cross-market impact (how silver movements affect stocks, bonds, currencies, and other commodities). "
            "Write in English, keep it concise (200-300 words)."
        ),
    },
    "oil": {
        "title": "Oil (Crude)",
        "prompt": (
            "Provide a brief macro-economic analysis of crude oil prices. Include: "
            "1) Current price trend summary, "
            "2) Technical and fundamental trend analysis, "
            "3) Cross-market impact (how oil price movements affect stocks, bonds, currencies, and other commodities). "
            "Write in English, keep it concise (200-300 words)."
        ),
    },
    "us_treasury": {
        "title": "US Treasury",
        "prompt": (
            "Provide a brief macro-economic analysis of US Treasury yields. Include: "
            "1) Current yield trend summary (2Y, 10Y, 30Y), "
            "2) Technical and fundamental trend analysis, "
            "3) Cross-market impact (how Treasury yield movements affect stocks, currencies, gold, and credit markets). "
            "Write in English, keep it concise (200-300 words)."
        ),
    },
    "central_banks": {
        "title": "Central Banks",
        "prompt": (
            "Provide a brief macro-economic analysis of major central bank policies (Fed, ECB, BOJ, BOE). Include: "
            "1) Current policy stance summary, "
            "2) Recent decisions and forward guidance analysis, "
            "3) Cross-market impact (how central bank policies affect stocks, bonds, currencies, and commodities). "
            "Write in English, keep it concise (200-300 words)."
        ),
    },
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

        # Azure OpenAI responses API format
        if "output" in data:
            for item in data["output"]:
                if item.get("type") == "message":
                    for content in item.get("content", []):
                        if content.get("type") == "output_text":
                            return content.get("text", "")
        # Fallback: try chat completions format
        if "choices" in data:
            return data["choices"][0]["message"]["content"]

        logger.error(f"Unexpected API response format: {json.dumps(data)[:500]}")
        return "Unable to generate content at this time."


async def get_all_news() -> list[dict]:
    """Retrieve latest content for all 5 categories from DB."""
    rows = await db.query(
        """
        SELECT DISTINCT ON (category) id, category, title, content, updated_at
        FROM macro_news
        ORDER BY category, updated_at DESC
        """
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


async def get_history(days: int = 20) -> list[dict]:
    """Get list of all news snapshots grouped by date (last N days)."""
    rows = await db.query(
        """
        SELECT id, category, title, content, updated_at
        FROM macro_news
        WHERE updated_at >= NOW() - INTERVAL '%s days'
        ORDER BY updated_at DESC
        """ % days
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


async def get_news_by_date(date_str: str) -> list[dict]:
    """Get the latest news entry per category for a specific date."""
    rows = await db.query(
        """
        SELECT DISTINCT ON (category) id, category, title, content, updated_at
        FROM macro_news
        WHERE DATE(updated_at) = $1
        ORDER BY category, updated_at DESC
        """,
        date_str,
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


async def refresh_news() -> list[dict]:
    """Call OpenAI for each category, INSERT new records (keep history)."""
    results = []

    for category, info in CATEGORIES.items():
        try:
            logger.info(f"Refreshing macro news for category: {category}")
            content = await _call_openai(info["prompt"])

            # INSERT new record (don't delete old ones - keep history)
            await db.execute(
                """
                INSERT INTO macro_news (category, title, content, updated_at)
                VALUES ($1, $2, $3, NOW())
                """,
                category,
                info["title"],
                content,
            )

            results.append({
                "category": category,
                "title": info["title"],
                "content": content,
                "updated_at": datetime.now(timezone.utc).isoformat(),
            })
        except Exception as e:
            logger.error(f"Failed to refresh news for {category}: {e}")
            results.append({
                "category": category,
                "title": info["title"],
                "content": f"Error refreshing content: {str(e)}",
                "updated_at": datetime.now(timezone.utc).isoformat(),
            })

    return results


async def is_db_empty() -> bool:
    """Check if macro_news table has any data."""
    row = await db.query_one("SELECT COUNT(*) as count FROM macro_news")
    return row is None or row.get("count", 0) == 0
