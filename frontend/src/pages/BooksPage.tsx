import { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { get } from '../api/client';
import { Spinner } from '../components/Spinner';

interface Book {
  id: number;
  title: string;
  description: string;
  content: string;
  price: string;
  contact: string;
  image_url: string | null;
  created_at: string;
}

const CONTENT_PREVIEW_LENGTH = 180;

function BookContent({ content }: { content: string }) {
  const [expanded, setExpanded] = useState(false);
  const isLong = content.length > CONTENT_PREVIEW_LENGTH;

  if (!isLong) {
    return <div className="book-content">{content}</div>;
  }

  return (
    <div className="book-content">
      {expanded ? content : content.slice(0, CONTENT_PREVIEW_LENGTH) + '...'}
      <button className="btn-read-more" onClick={() => setExpanded(!expanded)}>
        {expanded ? 'Thu gọn' : 'Xem thêm'}
      </button>
    </div>
  );
}

function getTikTokUrl(contact: string): string | undefined {
  const match = contact.trim().match(/(?:https?:\/\/)?(?:[a-z0-9-]+\.)*tiktok\.com\/[^\s<>"']*/i);
  if (!match) return undefined;
  try {
    const url = new URL(/^https?:\/\//i.test(match[0]) ? match[0] : `https://${match[0]}`);
    if (url.hostname === 'tiktok.com' || url.hostname.endsWith('.tiktok.com')) {
      return url.href;
    }
  } catch {
    return undefined;
  }
  return undefined;
}
export function BooksPage() {
  const [books, setBooks] = useState<Book[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);


  const PAGE_SIZE = 10;

  const fetchBooks = useCallback(async (pageNum: number) => {
    setLoading(true);
    setError(null);
    try {
      const offset = pageNum * PAGE_SIZE;
      const data = await get<{ books: Book[]; total: number }>(`/books?limit=${PAGE_SIZE}&offset=${offset}`);
      setBooks(data.books);
      setTotal(data.total);
    } catch {
      setError('Không thể tải danh sách sách.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchBooks(page);
  }, [page, fetchBooks]);

  const totalPages = Math.ceil(total / PAGE_SIZE);

  return (
    <div className="books-page">
      <h2>Professional Books</h2>

      <div className="mock-exam-cta">
        <span className="mock-exam-cta-badge">Thi thử miễn phí</span>
        <h3 className="mock-exam-cta-title">Luyện thi chứng chỉ Nhật — giống đề thi thật</h3>

        <ul className="mock-exam-cta-points">
          <li>
            <span className="mock-exam-cta-icon" aria-hidden="true">📝</span>
            <span>Nội dung và phương thức thi giống đề thi thật</span>
          </li>
          <li>
            <span className="mock-exam-cta-icon" aria-hidden="true">🎯</span>
            <span>Tự đánh giá năng lực, chuẩn bị tốt tâm lý khi đi thi</span>
          </li>
          <li>
            <span className="mock-exam-cta-icon" aria-hidden="true">💰</span>
            <span>Giảm chi phí thi lại nhiều lần</span>
          </li>
          <li>
            <span className="mock-exam-cta-icon" aria-hidden="true">📧</span>
            <span>Điểm và kết quả chi tiết gửi qua email</span>
          </li>
        </ul>

        <Link to="/certificates" className="btn-mock-exam-cta">
          Thi thử ngay
          <span className="btn-mock-exam-arrow" aria-hidden="true">→</span>
        </Link>
      </div>

      {error && <div className="form-error">{error}</div>}

      {loading ? (
        <p className="loading-text"><Spinner /> Đang tải...</p>
      ) : books.length === 0 ? (
        <p className="empty-state">Chưa có sách nào.</p>
      ) : (
        <>
          <div className="book-grid">
            {books.map((b) => (
              <div key={b.id} className="book-item">
                {b.image_url ? (
                  <img src={b.image_url} alt={b.title} className="book-item-cover" />
                ) : (
                  <div className="book-item-cover book-item-cover-empty">📘</div>
                )}

                <div className="book-item-body">
                  <h3 className="book-item-title">{b.title}</h3>
                  {b.price && <span className="book-item-price">{b.price}</span>}
                  {b.description && <p className="book-item-desc">{b.description}</p>}
                  {b.content && <BookContent content={b.content} />}
                </div>

                <div className="book-purchase-contact">
                  Liên hệ mua hàng:{' '}
                  {getTikTokUrl(b.contact) ? (
                    <a href={getTikTokUrl(b.contact)} target="_blank" rel="noopener noreferrer">
                      {getTikTokUrl(b.contact)}
                    </a>
                  ) : (
                    <strong>TikTok (chưa có link)</strong>
                  )}
                </div>
              </div>
            ))}
          </div>

          {totalPages > 1 && (
            <div className="pagination">
              <button disabled={page === 0} onClick={() => setPage((p) => p - 1)}>← Trước</button>
              <span>{page + 1} / {totalPages}</span>
              <button disabled={page >= totalPages - 1} onClick={() => setPage((p) => p + 1)}>Sau →</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
