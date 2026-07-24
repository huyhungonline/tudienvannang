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
const LEVEL_LABELS: Record<string, string> = { '': 'All', N3: 'N3', N2: 'N2', N1: 'N1', TOEIC: 'TOEIC' };

function formatRelativeTime(isoString: string): string {
  const now = Date.now();
  const then = new Date(isoString).getTime();
  const diff = Math.floor((now - then) / 1000);

  if (diff < 60) return 'just now';
  if (diff < 3600) return `${Math.floor(diff / 60)} min ago`;
  if (diff < 86400) return `${Math.floor(diff / 3600)} hours ago`;
  if (diff < 2592000) return `${Math.floor(diff / 86400)} days ago`;
  return `${Math.floor(diff / 2592000)} months ago`;
}

const CONTENT_PREVIEW_LENGTH = 300;

function PostContent({ content }: { content: string }) {
  const [expanded, setExpanded] = useState(false);
  const isLong = content.length > CONTENT_PREVIEW_LENGTH;

  if (!isLong) {
    return <div className="post-content">{content}</div>;
  }

  return (
    <div className="post-content">
      {expanded ? content : content.slice(0, CONTENT_PREVIEW_LENGTH) + '...'}
      <button className="btn-read-more" onClick={() => setExpanded(!expanded)}>
        {expanded ? 'Show less' : 'Read more'}
      </button>
    </div>
  );
}

export function ReadingPostsPage() {
  const navigate = useNavigate();
  const [posts, setPosts] = useState<ReadingPost[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [activeLevel, setActiveLevel] = useState('');
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [level, setLevel] = useState('N3');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const PAGE_SIZE = 5;

  useEffect(() => {
    fetchPosts(page, activeLevel);
  }, [activeLevel, page]);

  async function fetchPosts(pageNum: number, filterLevel: string) {
    try {
      const offset = pageNum * PAGE_SIZE;
      const params = new URLSearchParams({ limit: String(PAGE_SIZE), offset: String(offset) });
      if (filterLevel) params.set('level', filterLevel);
      const data = await get<{ posts: ReadingPost[]; total: number }>(`/reading-posts?${params}`);
      setPosts(data.posts);
      setTotal(data.total);
    } catch {
      /* ignore */
    }
  }

  function handleLevelFilter(lv: string) {
    setActiveLevel(lv);
    setPage(0);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError('');

    if (!title.trim()) { setError('Please enter a title'); return; }
    if (!content.trim()) { setError('Please enter content'); return; }

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
      setPage(0);
      setTitle('');
      setContent('');
    } catch {
      setError('Failed to post. Please try again.');
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
            placeholder="Post title"
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
          placeholder="Reading content..."
          value={content}
          onChange={e => setContent(e.target.value)}
          maxLength={5000}
          rows={5}
        />
        {error && <p className="form-error">{error}</p>}
        <button type="submit" disabled={loading}>
          {loading ? 'Posting...' : 'Post'}
        </button>
      </form>

      {/* Posts List */}
      <div className="reading-posts-list">
        {posts.length === 0 ? (
          <p className="empty-state">No posts yet.</p>
        ) : (
          posts.map(p => (
            <div key={p.id} className="reading-post-card">
              <div className="post-header">
                <span className="post-username">{p.username}</span>
                <span className={`level-badge level-${p.level.toLowerCase()}`}>{p.level}</span>
                <span className="post-time">{formatRelativeTime(p.created_at)}</span>
                <button className="translate-btn" onClick={() => navigate('/?text=' + encodeURIComponent(p.content))} title="Analyze & Translate">
                  🔤
                </button>
              </div>
              <h3 className="post-title">{p.title}</h3>
              <PostContent content={p.content} />
              <button className="like-btn" onClick={() => handleLike(p.id)}>
                ❤️ {p.like_count}
              </button>
            </div>
          ))
        )}
        {posts.length < total && (
          <div className="pagination">
            <button disabled={page === 0} onClick={() => setPage(p => p - 1)}>← Prev</button>
            <span>{page + 1} / {Math.ceil(total / PAGE_SIZE)}</span>
            <button disabled={(page + 1) * PAGE_SIZE >= total} onClick={() => setPage(p => p + 1)}>Next →</button>
          </div>
        )}
      </div>
    </div>
  );
}
