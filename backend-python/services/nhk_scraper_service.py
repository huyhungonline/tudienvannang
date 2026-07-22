import asyncio
import logging
import re
from datetime import datetime

import httpx
from bs4 import BeautifulSoup

import db

logger = logging.getLogger(__name__)

NHK_BASE_URL = "https://www3.nhk.or.jp"
NHK_NEWS_URL = f"{NHK_BASE_URL}/news/"
ARTICLE_URL_PATTERN = re.compile(r"/news/html/\d+/\w+\.html")
MAX_ARTICLES_PER_SCRAPE = 5
FETCH_DELAY_SECONDS = 1


async def _fetch_nhk_page() -> str:
    """Fetch HTML from NHK News Web main page using httpx."""
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(
                NHK_NEWS_URL,
                headers={
                    "User-Agent": "Mozilla/5.0 (compatible; NHKNewsBot/1.0)"
                },
            )
            response.raise_for_status()
            return response.text
    except httpx.TimeoutException:
        logger.error("[NHK] Timeout while fetching NHK news page")
        raise
    except httpx.ConnectError:
        logger.error("[NHK] Connection error while fetching NHK news page")
        raise
    except httpx.HTTPStatusError as e:
        logger.error(f"[NHK] HTTP error {e.response.status_code} while fetching NHK news page")
        raise
    except httpx.HTTPError as e:
        logger.error(f"[NHK] HTTP error while fetching NHK news page: {e}")
        raise


async def _fetch_article_page(url: str) -> str | None:
    """Fetch HTML content of a single article page."""
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(
                url,
                headers={
                    "User-Agent": "Mozilla/5.0 (compatible; NHKNewsBot/1.0)"
                },
            )
            response.raise_for_status()
            return response.text
    except httpx.HTTPError as e:
        logger.warning(f"[NHK] Failed to fetch article page {url}: {e}")
        return None


def _parse_article_detail(html: str, source_url: str) -> dict | None:
    """Parse a single article page to extract title, content, category."""
    soup = BeautifulSoup(html, "html.parser")

    # Extract title
    title_el = soup.select_one("h1.content--title") or soup.select_one("h1")
    title = title_el.get_text(strip=True) if title_el else ""

    if not title:
        return None

    # Extract body content
    body_el = (
        soup.select_one("div.content--detail-body")
        or soup.select_one("section.content--detail-main")
        or soup.select_one("div.content--body")
    )
    content = body_el.get_text(strip=True) if body_el else ""

    if not content:
        # Try to get any main text area
        body_el = soup.select_one("div#news_textbody") or soup.select_one("p.content--summary")
        content = body_el.get_text(strip=True) if body_el else ""

    # Extract category
    category_el = soup.select_one("span.content--category") or soup.select_one("a.content--header-category")
    category = category_el.get_text(strip=True) if category_el else "general"

    # Extract published date
    time_el = soup.select_one("time")
    published_at = None
    if time_el:
        datetime_attr = time_el.get("datetime")
        if datetime_attr:
            try:
                published_at = datetime.fromisoformat(datetime_attr.replace("Z", "+00:00"))
            except (ValueError, TypeError):
                pass
        if not published_at:
            # Try parsing text content
            time_text = time_el.get_text(strip=True)
            try:
                # NHK format: "2024年1月15日 18時30分"
                published_at = datetime.strptime(
                    re.sub(r"[年月日時分秒]", " ", time_text).strip(),
                    "%Y %m %d %H %M"
                )
            except (ValueError, TypeError):
                pass

    if not published_at:
        published_at = datetime.utcnow()

    return {
        "title": title,
        "content": content,
        "category": category,
        "source_url": source_url,
        "published_at": published_at,
    }


def _parse_articles(html: str) -> list[str]:
    """Parse the NHK main page HTML and extract article URLs.

    Returns a list of absolute article URLs (max MAX_ARTICLES_PER_SCRAPE).
    """
    soup = BeautifulSoup(html, "html.parser")
    article_urls = []
    seen_urls = set()

    # Find all links matching the NHK article URL pattern
    for link in soup.find_all("a", href=True):
        href = link["href"]
        if ARTICLE_URL_PATTERN.search(href):
            # Build absolute URL
            if href.startswith("/"):
                full_url = NHK_BASE_URL + href
            elif href.startswith("http"):
                full_url = href
            else:
                full_url = NHK_BASE_URL + "/" + href

            if full_url not in seen_urls:
                seen_urls.add(full_url)
                article_urls.append(full_url)

            if len(article_urls) >= MAX_ARTICLES_PER_SCRAPE:
                break

    return article_urls


async def _save_articles(articles: list[dict]) -> int:
    """Save articles to database. Uses ON CONFLICT to skip duplicates.

    Returns the count of newly inserted articles.
    """
    if not articles:
        return 0

    new_count = 0
    pool = await db.get_pool()

    async with pool.acquire() as conn:
        for article in articles:
            result = await conn.execute(
                """
                INSERT INTO nhk_articles (title, content, category, source_url, published_at)
                VALUES ($1, $2, $3, $4, $5)
                ON CONFLICT (source_url) DO NOTHING
                """,
                article["title"],
                article["content"],
                article["category"],
                article["source_url"],
                article["published_at"],
            )
            # asyncpg returns "INSERT 0 1" for inserted, "INSERT 0 0" for conflict
            if result and result.endswith("1"):
                new_count += 1

    return new_count


async def _cleanup_old_articles() -> int:
    """Delete articles older than 30 days.

    Returns the count of deleted articles.
    """
    pool = await db.get_pool()

    async with pool.acquire() as conn:
        result = await conn.execute(
            "DELETE FROM nhk_articles WHERE created_at < NOW() - INTERVAL '30 days'"
        )
        # asyncpg returns "DELETE N" where N is the count
        try:
            deleted_count = int(result.split()[-1])
        except (ValueError, IndexError):
            deleted_count = 0

    return deleted_count


async def scrape_nhk_news() -> dict:
    """Orchestrate the full NHK news scraping process.

    Flow: fetch main page → extract article URLs → fetch each article →
          parse details → save to DB → cleanup old articles.

    Returns a dict with scrape results.
    """
    try:
        # Step 1: Fetch main page
        logger.info("[NHK] Starting scrape of NHK News Web")
        main_html = await _fetch_nhk_page()

        # Step 2: Parse article URLs from main page
        article_urls = _parse_articles(main_html)
        logger.info(f"[NHK] Found {len(article_urls)} article URLs")

        if not article_urls:
            logger.warning("[NHK] No article URLs found on main page")
            return {
                "success": True,
                "message": "No articles found on NHK main page",
                "new_articles": 0,
                "deleted_old": 0,
            }

        # Step 3: Fetch and parse each article page
        articles = []
        for url in article_urls:
            article_html = await _fetch_article_page(url)
            if article_html:
                article = _parse_article_detail(article_html, url)
                if article:
                    articles.append(article)

            # Delay between requests to be polite
            await asyncio.sleep(FETCH_DELAY_SECONDS)

        logger.info(f"[NHK] Parsed {len(articles)} articles successfully")

        # Step 4: Save to database
        new_count = await _save_articles(articles)
        logger.info(f"[NHK] Saved {new_count} new articles")

        # Step 5: Cleanup old articles
        deleted_count = await _cleanup_old_articles()
        if deleted_count > 0:
            logger.info(f"[NHK] Cleaned up {deleted_count} old articles")

        return {
            "success": True,
            "message": f"Scrape complete: {new_count} new, {deleted_count} old deleted",
            "new_articles": new_count,
            "deleted_old": deleted_count,
        }

    except (httpx.HTTPError, httpx.TimeoutException, httpx.ConnectError) as e:
        error_msg = f"NHK website unreachable: {type(e).__name__}: {str(e)}"
        logger.error(f"[NHK] {error_msg}")
        return {
            "success": False,
            "message": error_msg,
            "new_articles": 0,
            "deleted_old": 0,
        }
    except Exception as e:
        error_msg = f"Unexpected error during scrape: {type(e).__name__}: {str(e)}"
        logger.error(f"[NHK] {error_msg}")
        return {
            "success": False,
            "message": error_msg,
            "new_articles": 0,
            "deleted_old": 0,
        }
