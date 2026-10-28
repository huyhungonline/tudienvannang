"""Book customer records captured from social media messages.

Kept separate from `workbook_orders` (the self-service web form) because these
are entered by staff from TikTok/Facebook conversations.
"""
import re

import db


def mask_email(email: str | None) -> str:
    """ng***@gmail.com — enough to recognise a record without exposing it."""
    if not email or "@" not in email:
        return email or ""
    local, _, domain = email.partition("@")
    head = local[:2] if len(local) > 2 else local[:1]
    return f"{head}***@{domain}"


def mask_phone(phone: str | None) -> str:
    """Show only the last three digits."""
    if not phone:
        return ""
    digits = re.sub(r"\D", "", phone)
    if len(digits) <= 3:
        return digits
    return f"***{digits[-3:]}"


def mask_address(address: str | None) -> str:
    """Keep only the final component (usually the province or city)."""
    if not address:
        return ""
    parts = [p.strip() for p in re.split(r"[,\n]", address) if p.strip()]
    return parts[-1] if parts else ""


async def create_customer(
    full_name: str,
    phone: str | None = None,
    email: str | None = None,
    address: str | None = None,
    book_type: str | None = None,
    note: str | None = None,
    source: str = "manual",
) -> dict:
    """Insert a customer and return the stored row."""
    if not full_name or not full_name.strip():
        raise ValueError("Họ tên không được để trống")

    return await db.query_one(
        """INSERT INTO book_customers
           (full_name, phone, email, address, book_type, note, source)
           VALUES ($1,$2,$3,$4,$5,$6,$7)
           RETURNING id, full_name, phone, email, address, book_type, note,
                     paid_at, shipped_at, source, created_at""",
        full_name.strip(),
        (phone or "").strip() or None,
        (email or "").strip() or None,
        (address or "").strip() or None,
        (book_type or "").strip() or None,
        (note or "").strip() or None,
        source,
    )


async def find_duplicates(phone: str | None, email: str | None) -> list[dict]:
    """Existing customers matching the same phone or email.

    Social media orders are entered by hand, so the same customer is easy to
    add twice. Surfacing matches lets the caller decide instead of silently
    creating a duplicate.
    """
    digits = re.sub(r"\D", "", phone or "")
    normalised_email = (email or "").strip().lower()
    if not digits and not normalised_email:
        return []

    return await db.query(
        """SELECT id, full_name, phone, email, created_at
           FROM book_customers
           WHERE ($1 <> '' AND regexp_replace(COALESCE(phone,''), '\\D', '', 'g') = $1)
              OR ($2 <> '' AND lower(COALESCE(email,'')) = $2)
           ORDER BY created_at DESC LIMIT 5""",
        digits, normalised_email,
    )


async def list_customers(limit: int = 50, offset: int = 0) -> tuple[list[dict], int]:
    rows = await db.query(
        """SELECT id, full_name, phone, email, address, book_type, note,
                  paid_at, shipped_at, source, created_at
           FROM book_customers ORDER BY created_at DESC, id DESC
           LIMIT $1 OFFSET $2""",
        limit, offset,
    )
    total = await db.query_one("SELECT COUNT(*) AS n FROM book_customers")
    return rows, (total["n"] if total else 0)


async def list_customers_masked(limit: int = 20, status: str | None = None) -> list[dict]:
    """Summary list for the MCP tool, with personal data reduced.

    Full contact details stay in the admin page; an internet-facing tool only
    needs enough to confirm a record exists and see its status.
    """
    where = ""
    if status == "unpaid":
        where = "WHERE paid_at IS NULL"
    elif status == "paid_unshipped":
        where = "WHERE paid_at IS NOT NULL AND shipped_at IS NULL"
    elif status == "shipped":
        where = "WHERE shipped_at IS NOT NULL"

    rows = await db.query(
        f"""SELECT id, full_name, phone, email, address, book_type,
                   paid_at, shipped_at, created_at
            FROM book_customers {where}
            ORDER BY created_at DESC, id DESC LIMIT $1""",
        limit,
    )
    return [{
        "id": r["id"],
        "fullName": r["full_name"],
        "phone": mask_phone(r["phone"]),
        "email": mask_email(r["email"]),
        "area": mask_address(r["address"]),
        "bookType": r["book_type"],
        "paid": r["paid_at"] is not None,
        "shipped": r["shipped_at"] is not None,
        "createdAt": r["created_at"].isoformat(),
    } for r in rows]


async def get_stats() -> dict:
    row = await db.query_one(
        """SELECT COUNT(*) AS total,
                  COUNT(*) FILTER (WHERE paid_at IS NULL) AS unpaid,
                  COUNT(*) FILTER (WHERE paid_at IS NOT NULL AND shipped_at IS NULL) AS paid_unshipped,
                  COUNT(*) FILTER (WHERE shipped_at IS NOT NULL) AS shipped
           FROM book_customers"""
    )
    return {
        "total": row["total"],
        "unpaid": row["unpaid"],
        "paidNotShipped": row["paid_unshipped"],
        "shipped": row["shipped"],
    }


async def set_paid(customer_id: int, paid: bool) -> dict | None:
    return await db.query_one(
        """UPDATE book_customers
           SET paid_at = CASE WHEN $2 THEN COALESCE(paid_at, NOW()) ELSE NULL END,
               updated_at = NOW()
           WHERE id = $1 RETURNING id, paid_at""",
        customer_id, paid,
    )


async def set_shipped(customer_id: int, shipped: bool) -> dict | None:
    return await db.query_one(
        """UPDATE book_customers
           SET shipped_at = CASE WHEN $2 THEN COALESCE(shipped_at, NOW()) ELSE NULL END,
               updated_at = NOW()
           WHERE id = $1 RETURNING id, shipped_at""",
        customer_id, shipped,
    )


async def update_customer(customer_id: int, fields: dict) -> dict | None:
    allowed = ("full_name", "phone", "email", "address", "book_type", "note")
    sets, params = [], []
    for key in allowed:
        if key in fields and fields[key] is not None:
            params.append(str(fields[key]).strip() or None)
            sets.append(f"{key} = ${len(params) + 1}")
    if not sets:
        return await db.query_one("SELECT * FROM book_customers WHERE id = $1", customer_id)

    return await db.query_one(
        f"""UPDATE book_customers SET {', '.join(sets)}, updated_at = NOW()
            WHERE id = $1
            RETURNING id, full_name, phone, email, address, book_type, note,
                      paid_at, shipped_at, created_at""",
        customer_id, *params,
    )


async def delete_customer(customer_id: int) -> bool:
    row = await db.query_one("DELETE FROM book_customers WHERE id = $1 RETURNING id", customer_id)
    return row is not None
