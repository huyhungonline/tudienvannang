"""MCP (Model Context Protocol) endpoint so ChatGPT can record book customers.

Exposes a small, deliberately narrow tool set over JSON-RPC 2.0:

  add_book_customer   - write a new customer record
  list_book_customers - read back a masked summary
  book_customer_stats - counts by status

Design decisions worth knowing:

* Authentication uses a dedicated MCP_TOKEN rather than an admin JWT, so this
  access path can be revoked on its own without disturbing admin logins.
* Read tools return masked contact details. The endpoint is reachable from the
  internet, so full addresses and emails stay in the admin UI only.
* No delete or update tool is exposed. Destructive changes require the admin UI.
* Every write is logged with a truncated token fingerprint for traceability.
"""
import hashlib
import logging
import secrets
from typing import Any

from fastapi import APIRouter, Header, HTTPException
from pydantic import BaseModel

from config import MCP_TOKEN
from services import book_customer_service

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/mcp", tags=["mcp"])

PROTOCOL_VERSION = "2024-11-05"
SERVER_INFO = {"name": "taogiaoduc-book-customers", "version": "1.0.0"}

TOOLS = [
    {
        "name": "add_book_customer",
        "description": (
            "Thêm một khách hàng mua sách vào danh sách. Dùng khi người dùng dán "
            "thông tin khách hàng (từ tin nhắn TikTok, Facebook...). Trích xuất họ tên, "
            "số điện thoại, email, địa chỉ và loại sách từ đoạn văn bản rồi gọi tool này. "
            "Chỉ họ tên là bắt buộc."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "full_name": {"type": "string", "description": "Họ và tên khách hàng"},
                "phone": {"type": "string", "description": "Số điện thoại"},
                "email": {"type": "string", "description": "Địa chỉ email"},
                "address": {"type": "string", "description": "Địa chỉ nhận sách"},
                "book_type": {"type": "string", "description": "Loại sách khách đặt"},
                "note": {"type": "string", "description": "Ghi chú thêm"},
            },
            "required": ["full_name"],
        },
    },
    {
        "name": "list_book_customers",
        "description": (
            "Xem danh sách khách hàng mua sách gần đây. Thông tin liên hệ được "
            "che một phần để bảo mật; xem đầy đủ trong trang quản trị."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "limit": {"type": "integer", "description": "Số bản ghi (tối đa 50)", "default": 20},
                "status": {
                    "type": "string",
                    "enum": ["all", "unpaid", "paid_unshipped", "shipped"],
                    "description": "Lọc theo trạng thái",
                    "default": "all",
                },
            },
        },
    },
    {
        "name": "book_customer_stats",
        "description": "Thống kê số khách hàng theo trạng thái thanh toán và gửi sách.",
        "inputSchema": {"type": "object", "properties": {}},
    },
]


class JsonRpcRequest(BaseModel):
    jsonrpc: str = "2.0"
    id: Any = None
    method: str
    params: dict | None = None


def _token_fingerprint(token: str) -> str:
    """Short hash for logs; never log the token itself."""
    return hashlib.sha256(token.encode()).hexdigest()[:8]


def _require_token(authorization: str | None) -> str:
    if not MCP_TOKEN:
        # Fail closed: without a configured token the endpoint stays shut.
        raise HTTPException(status_code=503, detail="MCP endpoint is not configured")
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    token = authorization[7:].strip()
    if token != MCP_TOKEN:
        raise HTTPException(status_code=401, detail="Invalid token")
    return token


def _text_result(text: str) -> dict:
    return {"content": [{"type": "text", "text": text}]}


async def _call_tool(name: str, args: dict, fingerprint: str) -> dict:
    if name == "add_book_customer":
        full_name = (args.get("full_name") or "").strip()
        if not full_name:
            return _text_result("Lỗi: thiếu họ tên khách hàng.")

        phone = args.get("phone")
        email = args.get("email")

        # Hand-entered social media orders duplicate easily; warn instead of
        # silently creating a second record for the same person.
        duplicates = await book_customer_service.find_duplicates(phone, email)

        row = await book_customer_service.create_customer(
            full_name=full_name,
            phone=phone,
            email=email,
            address=args.get("address"),
            book_type=args.get("book_type"),
            note=args.get("note"),
            source="chatgpt",
        )
        logger.info("MCP add_book_customer id=%s by token=%s", row["id"], fingerprint)

        lines = [
            f"Đã thêm khách hàng #{row['id']}: {row['full_name']}",
            f"  Điện thoại: {row['phone'] or '(chưa có)'}",
            f"  Email: {row['email'] or '(chưa có)'}",
            f"  Địa chỉ: {row['address'] or '(chưa có)'}",
            f"  Loại sách: {row['book_type'] or '(chưa ghi)'}",
            "  Trạng thái: chưa thanh toán, chưa gửi sách",
        ]
        if duplicates:
            lines.append("")
            lines.append(f"Lưu ý: có {len(duplicates)} khách hàng trùng số điện thoại hoặc email:")
            for d in duplicates:
                lines.append(f"  - #{d['id']} {d['full_name']} ({d['created_at'].strftime('%d/%m/%Y')})")
            lines.append("Hãy kiểm tra trong trang quản trị nếu đây là bản ghi trùng.")
        return _text_result("\n".join(lines))

    if name == "list_book_customers":
        limit = min(int(args.get("limit") or 20), 50)
        status = args.get("status") or "all"
        rows = await book_customer_service.list_customers_masked(
            limit=limit, status=None if status == "all" else status
        )
        if not rows:
            return _text_result("Chưa có khách hàng nào.")
        lines = [f"{len(rows)} khách hàng gần nhất:"]
        for r in rows:
            state = "đã gửi" if r["shipped"] else ("đã thanh toán" if r["paid"] else "chưa thanh toán")
            lines.append(
                f"  #{r['id']} {r['fullName']} | {r['phone']} | {r['email']} "
                f"| {r['area'] or '—'} | {r['bookType'] or '—'} | {state}"
            )
        lines.append("")
        lines.append("Thông tin liên hệ được che một phần. Xem đầy đủ trong trang quản trị.")
        return _text_result("\n".join(lines))

    if name == "book_customer_stats":
        s = await book_customer_service.get_stats()
        return _text_result(
            f"Tổng khách hàng: {s['total']}\n"
            f"  Chưa thanh toán: {s['unpaid']}\n"
            f"  Đã thanh toán, chưa gửi sách: {s['paidNotShipped']}\n"
            f"  Đã gửi sách: {s['shipped']}"
        )

    raise ValueError(f"Unknown tool: {name}")


async def _dispatch(body: JsonRpcRequest, fingerprint: str) -> dict:
    """Route one JSON-RPC call. Shared by both authentication styles."""
    params = body.params or {}

    try:
        if body.method == "initialize":
            result = {
                "protocolVersion": PROTOCOL_VERSION,
                "capabilities": {"tools": {}},
                "serverInfo": SERVER_INFO,
            }
        elif body.method in ("notifications/initialized", "ping"):
            result = {}
        elif body.method == "tools/list":
            result = {"tools": TOOLS}
        elif body.method == "tools/call":
            name = params.get("name")
            args = params.get("arguments") or {}
            result = await _call_tool(name, args, fingerprint)
        else:
            return {
                "jsonrpc": "2.0", "id": body.id,
                "error": {"code": -32601, "message": f"Method not found: {body.method}"},
            }
    except ValueError as e:
        return {"jsonrpc": "2.0", "id": body.id,
                "error": {"code": -32602, "message": str(e)}}
    except Exception as e:
        logger.error("MCP error on %s: %s", body.method, e)
        return {"jsonrpc": "2.0", "id": body.id,
                "error": {"code": -32603, "message": "Internal error"}}

    return {"jsonrpc": "2.0", "id": body.id, "result": result}


@router.post("")
async def handle_mcp(body: JsonRpcRequest,
                     authorization: str | None = Header(default=None)):
    """Entry point for clients that can send an Authorization header
    (Claude Desktop, Kiro, Codex)."""
    token = _require_token(authorization)
    return await _dispatch(body, _token_fingerprint(token))


@router.post("/t/{url_token}")
async def handle_mcp_url_token(url_token: str, body: JsonRpcRequest):
    """Entry point for ChatGPT web, which cannot send a static bearer token.

    The secret lives in the URL path instead of a header, so the connector can
    be configured as "No authentication" while the endpoint stays protected:
    without the exact token in the path there is no route to the tools.

    The trade-off versus a header is that the secret may appear in proxy or
    browser history, so treat the whole URL as the credential and rotate it
    (MCP_TOKEN in .env) if it is ever shared by accident.
    """
    if not MCP_TOKEN:
        raise HTTPException(status_code=503, detail="MCP endpoint is not configured")
    # Constant-time comparison to avoid leaking the token through timing.
    if not secrets.compare_digest(url_token, MCP_TOKEN):
        raise HTTPException(status_code=404, detail="Not found")
    return await _dispatch(body, _token_fingerprint(url_token))


@router.get("/health")
async def mcp_health():
    """Unauthenticated liveness probe; reveals nothing but configuration state."""
    return {"status": "ok", "configured": bool(MCP_TOKEN), "tools": len(TOOLS)}
