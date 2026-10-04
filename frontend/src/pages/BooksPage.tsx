import { useState, useEffect } from 'react';
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

const CONTENT_PREVIEW_LENGTH = 300;

function BookContent({ content }: { content: string }) {
  const [expanded, setExpanded] = useState(false);
  const isLong = content.length > CONTENT_PREVIEW_LENGTH;

  if (!isLong) {
    return <div className="post-content">{content}</div>;
  }

  return (
    <div className="post-content">
      {expanded ? content : content.slice(0, CONTENT_PREVIEW_LENGTH) + '...'}
      <button className="btn-read-more" onClick={() => setExpanded(!expanded)}>
        {expanded ? 'Thu gọn' : 'Xem thêm'}
      </button>
    </div>
  );
}

export function BooksPage() {
  const [books, setBooks] = useState<Book[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const PAGE_SIZE = 10;

  useEffect(() => {
    fetchBooks(page);
  }, [page]);

  async function fetchBooks(pageNum: number) {
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
  }

  const totalPages = Math.ceil(total / PAGE_SIZE);

  return (
    <div className="reading-posts-page books-page">
      <h2>Professional Books</h2>

      {error && <div className="form-error">{error}</div>}

      {loading ? (
        <p className="loading-text"><Spinner /> Đang tải...</p>
      ) : books.length === 0 ? (
        <p className="empty-state">Chưa có sách nào.</p>
      ) : (
        <>
          <div className="reading-posts-list">
            {books.map((b) => (
              <div key={b.id} className="reading-post-card book-card">
                <div className="book-card-body">
                  {b.image_url && (
                    <img src={b.image_url} alt={b.title} className="book-cover" />
                  )}
                  <div className="book-card-info">
                    <div className="post-header">
                      <h3 className="post-title book-title">{b.title}</h3>
                      <span className="book-price">{b.price}</span>
                    </div>
                    <p className="book-description">{b.description}</p>
                    <BookContent content={b.content} />
                    <div className="book-contact">
                      Liên hệ mua hàng: <strong>{b.contact}</strong>
                    </div>
                  </div>
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
