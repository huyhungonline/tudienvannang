import { useState, useEffect } from 'react';
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

  if (diff < 60) return 'vừa xong';
  if (diff < 3600) return `${Math.floor(diff / 60)} phút trước`;
  if (diff < 86400) return `${Math.floor(diff / 3600)} giờ trước`;
  if (diff < 2592000) return `${Math.floor(diff / 86400)} ngày trước`;
  return `${Math.floor(diff / 2592000)} tháng trước`;
}

export function ReadingPostsPage() {
  const [posts, setPosts] = useState<ReadingPost[]>([]);
  const [username, setUsername] = useState('');
  const [content, setContent] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchPosts();
  }, []);

  async function fetchPosts() {
    try {
      const data = await get<{ posts: ReadingPost[] }>('/reading-posts');
      setPosts(data.posts);
    } catch {
      /* ignore */
    }
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError('');

    if (!username.trim()) { setError('Vui lòng nhập tên'); return; }
    if (!content.trim()) { setError('Vui lòng nhập nội dung bài đọc'); return; }

    setLoading(true);
    try {
      const newPost = await post<ReadingPost>('/reading-posts', {
        username: username.trim(),
        content: content.trim(),
      });
      setPosts([newPost, ...posts]);
      setContent('');
    } catch {
      setError('Không thể đăng bài. Vui lòng thử lại.');
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
          placeholder="Tên của bạn"
          value={username}
          onChange={e => setUsername(e.target.value)}
          maxLength={50}
        />
        <textarea
          placeholder="Chia sẻ bài đọc hay..."
          value={content}
          onChange={e => setContent(e.target.value)}
          maxLength={5000}
          rows={4}
        />
        {error && <p className="form-error">{error}</p>}
        <button type="submit" disabled={loading}>
          {loading ? 'Đang đăng...' : 'Đăng bài'}
        </button>
      </form>

      <div className="reading-posts-list">
        {posts.length === 0 ? (
          <p className="empty-state">Chưa có bài đọc nào. Hãy là người đầu tiên chia sẻ!</p>
        ) : (
          posts.map(p => (
            <div key={p.id} className="reading-post-card">
              <div className="post-header">
                <span className="post-username">{p.username}</span>
                <span className="post-time">{formatRelativeTime(p.created_at)}</span>
              </div>
              <div className="post-content">{p.content}</div>
              <button className="like-btn" onClick={() => handleLike(p.id)}>
                ❤️ {p.like_count}
              </button>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
