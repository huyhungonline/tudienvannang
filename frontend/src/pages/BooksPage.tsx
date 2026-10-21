import { useState, useEffect, useCallback } from 'react';
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

function ContactModal({ book, onClose }: { book: Book; onClose: () => void }) {
  // Close on Escape for keyboard accessibility
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [onClose]);

  return (
    <div className="book-modal-overlay" onClick={onClose}>
      <div
        className="book-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="book-modal-title"
        onClick={(e) => e.stopPropagation()}
      >
        <button className="book-modal-close" onClick={onClose} aria-label="Đóng">
          ×
        </button>

        <h3 id="book-modal-title" className="book-modal-title">
          Hãy liên hệ ngay với Táo Giáo Dục để mua sách
        </h3>

        <p className="book-modal-book">{book.title}</p>

        <div className="book-modal-info">
          <div className="book-modal-row">
            <span className="book-modal-label">Liên hệ</span>
            <span className="book-modal-value">{book.contact}</span>
          </div>
          {book.price && (
            <div className="book-modal-row">
              <span className="book-modal-label">Giá</span>
              <span className="book-modal-value book-modal-price">{book.price}</span>
            </div>
          )}
        </div>

        <button className="btn-submit book-modal-ok" onClick={onClose}>
          Đã hiểu
        </button>
      </div>
    </div>
  );
}

export function BooksPage() {
  const [books, setBooks] = useState<Book[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedBook, setSelectedBook] = useState<Book | null>(null);

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

                <button
                  className="btn-buy-book"
                  onClick={() => setSelectedBook(b)}
                >
                  Liên hệ mua sách
                </button>
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

      {selectedBook && (
        <ContactModal book={selectedBook} onClose={() => setSelectedBook(null)} />
      )}
    </div>
  );
}
