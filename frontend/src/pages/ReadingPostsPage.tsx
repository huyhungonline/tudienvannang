import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { get, post } from '../api/client';

interface ReadingPost {
  id: number;
  username: string;
  title: string;
  content: string;
  level: string;
  like_count: number;
  created_at: string;
}

const LEVELS = ['', 'N3', 'N2', 'N1', 'TOEIC'] as const;
const LEVEL_LABELS: Record<string, string> = { '': 'Tất cả', N3: 'N3', N2: 'N2', N1: 'N1', TOEIC: 'TOEIC' };

function formatRelativeTime(isoString: string): string {
  const now = Date.now();
  const then = new Date(isoString).getTime();
  const diff = Math.floor((now - then) / 1000);

  if (diff < 60) return 'vừa xong';
  if (diff < 3600) return `${Math.floor(diff / 60)} phút trước`;
  if (diff < 86400) return `${Math.floor(diff / 3600)} giờ trước`;
  if (diff < 2592000) return `${Math.floor(diff / 86400)} ngày trước`;
  return `${Math.floor(diff / 2592000)} tháng trước`;
}

export function ReadingPostsPage() {
  const navigate = useNavigate();
  const [posts, setPosts] = useState<ReadingPost[]>([]);
  const [total, setTotal] = useState(0);
  const [activeLevel, setActiveLevel] = useState('');
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [level, setLevel] = useState('N3');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    fetchPosts(0, activeLevel);
  }, [activeLevel]);

  async function fetchPosts(offset: number, filterLevel: string) {
    try {
      const params = new URLSearchParams({ limit: '10', offset: String(offset) });
      if (filterLevel) params.set('level', filterLevel);
      const data = await get<{ posts: ReadingPost[]; total: number }>(`/reading-posts?${params}`);
      if (offset === 0) {
        setPosts(data.posts);
      } else {
        setPosts(prev => [...prev, ...data.posts]);
      }
      setTotal(data.total);
    } catch {
      /* ignore */
    }
  }

  function handleLevelFilter(lv: string) {
    setActiveLevel(lv);
  }

  async function handleLoadMore() {
    setLoadingMore(true);
    await fetchPosts(posts.length, activeLevel);
    setLoadingMore(false);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError('');

    if (!title.trim()) { setError('Vui lòng nhập tiêu đề'); return; }
    if (!content.trim()) { setError('Vui lòng nhập nội dung'); return; }

    setLoading(true);
    try {
      const newPost = await post<ReadingPost>('/reading-posts', {
        username: 'Anonymous',
        title: title.trim(),
        content: content.trim(),
        level,
      });
      setPosts([newPost, ...posts]);
      setTotal(prev => prev + 1);
      setTitle('');
      setContent('');
    } catch {
      setError('Đăng bài thất bại. Vui lòng thử lại.');
    } finally {
      setLoading(false);
    }
  }

  async function handleLike(postId: number) {
    try {
      const data = await post<{ like_count: number }>(`/reading-posts/${postId}/like`, {});
      setPosts(posts.map(p => p.id === postId ? { ...p, like_count: data.like_count } : p));
    } catch {
      /* ignore */
    }
  }

  return (
    <div className="reading-posts-page">
      <h2>Reading</h2>

      {/* Level Filter Tabs */}
      <div className="level-filter-tabs">
        {LEVELS.map(lv => (
          <button
            key={lv}
            className={`level-tab ${activeLevel === lv ? 'active' : ''}`}
            onClick={() => handleLevelFilter(lv)}
          >
            {LEVEL_LABELS[lv]}
          </button>
        ))}
      </div>

      {/* Submit Form */}
      <form className="reading-post-form" onSubmit={handleSubmit}>
        <div className="form-row">
          <input
            type="text"
            placeholder="Tiêu đề bài viết"
            value={title}
            onChange={e => setTitle(e.target.value)}
            maxLength={200}
          />
          <select value={level} onChange={e => setLevel(e.target.value)}>
            <option value="N3">N3</option>
            <option value="N2">N2</option>
            <option value="N1">N1</option>
            <option value="TOEIC">TOEIC</option>
          </select>
        </div>
        <textarea
          placeholder="Nội dung bài đọc..."
          value={content}
          onChange={e => setContent(e.target.value)}
          maxLength={5000}
          rows={5}
        />
        {error && <p className="form-error">{error}</p>}
        <button type="submit" disabled={loading}>
          {loading ? 'Đang đăng...' : 'Đăng bài'}
        </button>
      </form>

      {/* Posts List */}
      <div className="reading-posts-list">
        {posts.length === 0 ? (
          <p className="empty-state">Không có bài viết nào.</p>
        ) : (
          posts.map(p => (
            <div key={p.id} className="reading-post-card">
              <div className="post-header">
                <span className="post-username">{p.username}</span>
                <span className={`level-badge level-${p.level.toLowerCase()}`}>{p.level}</span>
                <span className="post-time">{formatRelativeTime(p.created_at)}</span>
                <button className="translate-btn" onClick={() => navigate('/?text=' + encodeURIComponent(p.content))} title="Phân tích & Dịch">
                  🔤
                </button>
              </div>
              <h3 className="post-title">{p.title}</h3>
              <div className="post-content">{p.content}</div>
              <button className="like-btn" onClick={() => handleLike(p.id)}>
                ❤️ {p.like_count}
              </button>
            </div>
          ))
        )}
        {posts.length < total && (
          <button className="btn-load-more" onClick={handleLoadMore} disabled={loadingMore}>
            {loadingMore ? 'Đang tải...' : 'Xem thêm'}
          </button>
        )}
      </div>
    </div>
  );
}
