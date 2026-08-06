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
