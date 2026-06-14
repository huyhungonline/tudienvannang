import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { get, post } from '../api/client';

interface ReadingPost {
  id: number;
  username: string;
  content: string;
  like_count: number;
  created_at: string;
}

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

export function ReadingPostsPage() {
  const navigate = useNavigate();
  const [posts, setPosts] = useState<ReadingPost[]>([]);
  const [total, setTotal] = useState(0);
  const [username, setUsername] = useState('');
  const [content, setContent] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [loadingMore, setLoadingMore] = useState(false);

  useEffect(() => {
    fetchPosts(0);
  }, []);

  async function fetchPosts(offset: number) {
    try {
      const data = await get<{ posts: ReadingPost[]; total: number }>(`/reading-posts?limit=10&offset=${offset}`);
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

  async function handleLoadMore() {
    setLoadingMore(true);
    await fetchPosts(posts.length);
    setLoadingMore(false);
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError('');

    if (!username.trim()) { setError('Please enter your name'); return; }
    if (!content.trim()) { setError('Please enter the reading content'); return; }

    setLoading(true);
    try {
      const newPost = await post<ReadingPost>('/reading-posts', {
        username: username.trim(),
        content: content.trim(),
      });
      setPosts([newPost, ...posts]);
      setTotal(prev => prev + 1);
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

      <form className="reading-post-form" onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Your name"
          value={username}
          onChange={e => setUsername(e.target.value)}
          maxLength={50}
        />
        <textarea
          placeholder="Share an interesting reading..."
          value={content}
          onChange={e => setContent(e.target.value)}
          maxLength={5000}
          rows={4}
        />
        {error && <p className="form-error">{error}</p>}
        <button type="submit" disabled={loading}>
          {loading ? 'Posting...' : 'Post'}
        </button>
      </form>

      <div className="reading-posts-list">
        {posts.length === 0 ? (
          <p className="empty-state">No posts yet. Be the first to share!</p>
        ) : (
          posts.map(p => (
            <div key={p.id} className="reading-post-card">
              <div className="post-header">
                <span className="post-username">{p.username}</span>
                <span className="post-time">{formatRelativeTime(p.created_at)}</span>
                <button className="translate-btn" onClick={() => navigate('/?text=' + encodeURIComponent(p.content))} title="Analyze & Translate">
                  🔤
                </button>
              </div>
              <div className="post-content">{p.content}</div>
              <button className="like-btn" onClick={() => handleLike(p.id)}>
                ❤️ {p.like_count}
              </button>
            </div>
          ))
        )}
        {posts.length < total && (
          <button className="btn-load-more" onClick={handleLoadMore} disabled={loadingMore}>
            {loadingMore ? 'Loading...' : 'Read more'}
          </button>
        )}
      </div>
    </div>
  );
}
