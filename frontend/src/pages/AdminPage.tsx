import { useState, useEffect, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, post, put, del, uploadBookImage } from '../api/client';

interface AdminUser {
  id: string;
  email: string;
  isAdmin: boolean;
  isVip: boolean;
  createdAt: string;
}

interface Subscriber {
  id: string;
  email: string;
  target_language: string;
  created_at: string | null;
}

type AdminView = 'menu' | 'users' | 'mailer' | 'questions' | 'reading' | 'books';

export function AdminPage() {
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const [view, setView] = useState<AdminView>('menu');

  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login');
    }
  }, [isAuthenticated]);

  if (view === 'menu') {
    return (
      <div className="admin-page">
        <h2>Admin</h2>
        <div className="admin-menu">
          <button className="admin-menu-item" onClick={() => setView('users')}>
            👥 Quản lý User
          </button>
          <button className="admin-menu-item" onClick={() => setView('mailer')}>
            ✉️ Gửi mail cho User
          </button>
          <button className="admin-menu-item" onClick={() => setView('questions')}>
            📝 Classroom Questions
          </button>
          <button className="admin-menu-item" onClick={() => setView('reading')}>
            📖 Reading Posts
          </button>
          <button className="admin-menu-item" onClick={() => setView('books')}>
            📚 Quản lý Sách
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="admin-page">
      <button className="btn-back" onClick={() => setView('menu')}>← Quay lại</button>
      {view === 'users' && <UserManagement />}
      {view === 'mailer' && <MailerSection />}
      {view === 'questions' && <QuestionsManagement />}
      {view === 'reading' && <ReadingPostsManagement />}
      {view === 'books' && <BooksManagement />}
    </div>
  );
}

function UserManagement() {
  const navigate = useNavigate();
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showCreate, setShowCreate] = useState(false);
  const [newEmail, setNewEmail] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [newIsAdmin, setNewIsAdmin] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editEmail, setEditEmail] = useState('');
  const [editPassword, setEditPassword] = useState('');
  const [editIsAdmin, setEditIsAdmin] = useState(false);

  useEffect(() => { fetchUsers(); }, []);

  const fetchUsers = async () => {
    setLoading(true);
    setError(null);
    try {
      const data = await get<AdminUser[]>('/admin/users');
      setUsers(data);
    } catch (err: any) {
      if (err?.status === 401 || err?.status === 403) {
        navigate('/login');
        return;
      }
      setError('Failed to load users.');
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      await post('/admin/users', { email: newEmail, password: newPassword, isAdmin: newIsAdmin });
      setNewEmail(''); setNewPassword(''); setNewIsAdmin(false); setShowCreate(false);
      fetchUsers();
    } catch (err: any) { setError(err?.message || 'Failed to create user.'); }
  };

  const handleUpdate = async (e: FormEvent) => {
    e.preventDefault();
    if (!editingId) return;
    setError(null);
    const body: any = { isAdmin: editIsAdmin };
    if (editEmail) body.email = editEmail;
    if (editPassword) body.password = editPassword;
    try {
      await put(`/admin/users/${editingId}`, body);
      setEditingId(null);
      fetchUsers();
    } catch (err: any) { setError(err?.message || 'Failed to update user.'); }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Delete this user?')) return;
    try { await del(`/admin/users/${id}`); fetchUsers(); }
    catch (err: any) { setError(err?.message || 'Failed to delete user.'); }
  };

  const handleToggleVip = async (u: AdminUser) => {
    try {
      await put(`/admin/users/${u.id}`, { isVip: !u.isVip });
      fetchUsers();
    } catch (err: any) { setError(err?.message || 'Failed to update VIP status.'); }
  };

  const startEdit = (u: AdminUser) => {
    setEditingId(u.id); setEditEmail(u.email); setEditPassword(''); setEditIsAdmin(u.isAdmin);
  };

  if (loading) return <p className="loading-text">Loading...</p>;

  return (
    <div>
      <div className="admin-header">
        <h2>Quản lý User</h2>
        <button className="btn-submit" onClick={() => setShowCreate(!showCreate)}>
          {showCreate ? 'Cancel' : '+ Add User'}
        </button>
      </div>

      {error && <p className="form-error">{error}</p>}

      {showCreate && (
        <form className="admin-form" onSubmit={handleCreate}>
          <input type="email" placeholder="Email" value={newEmail} onChange={(e) => setNewEmail(e.target.value)} required />
          <input type="password" placeholder="Password" value={newPassword} onChange={(e) => setNewPassword(e.target.value)} required />
          <label className="admin-checkbox"><input type="checkbox" checked={newIsAdmin} onChange={(e) => setNewIsAdmin(e.target.checked)} /> Admin</label>
          <button type="submit" className="btn-submit">Create</button>
        </form>
      )}

      {editingId && (
        <form className="admin-form" onSubmit={handleUpdate}>
          <h3>Edit User</h3>
          <input type="email" placeholder="Email" value={editEmail} onChange={(e) => setEditEmail(e.target.value)} />
          <input type="password" placeholder="New password (leave empty to keep)" value={editPassword} onChange={(e) => setEditPassword(e.target.value)} />
          <label className="admin-checkbox"><input type="checkbox" checked={editIsAdmin} onChange={(e) => setEditIsAdmin(e.target.checked)} /> Admin</label>
          <div className="admin-form-actions">
            <button type="submit" className="btn-submit">Save</button>
            <button type="button" className="btn-back" onClick={() => setEditingId(null)}>Cancel</button>
          </div>
        </form>
      )}

      <table className="admin-table">
        <thead><tr><th>Email</th><th>Admin</th><th>VIP</th><th>Created</th><th>Actions</th></tr></thead>
        <tbody>
          {users.map((u) => (
            <tr key={u.id}>
              <td>{u.email}</td>
              <td>{u.isAdmin ? '✅' : '—'}</td>
              <td>{u.isVip ? '⭐ VIP' : '—'}</td>
              <td>{new Date(u.createdAt).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(u)}>Edit</button>
                <button
                  className={u.isVip ? 'btn-vip btn-vip-active' : 'btn-vip'}
                  onClick={() => handleToggleVip(u)}
                >
                  {u.isVip ? 'Hủy VIP' : 'Nâng cấp VIP'}
                </button>
                <button className="btn-delete" onClick={() => handleDelete(u.id)}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function MailerSection() {
  const [subscribers, setSubscribers] = useState<Subscriber[]>([]);
  const [selectedEmails, setSelectedEmails] = useState<Set<string>>(new Set());
  const [subject, setSubject] = useState('');
  const [content, setContent] = useState('');
  const [loading, setLoading] = useState(false);
  const [loadingSubs, setLoadingSubs] = useState(true);
  const [totalSubs, setTotalSubs] = useState(0);
  const [subPage, setSubPage] = useState(0);
  const [result, setResult] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const SUB_PAGE_SIZE = 20;

  useEffect(() => { fetchSubscribers(0); }, []);

  const fetchSubscribers = async (pageNum: number) => {
    setLoadingSubs(true);
    try {
      const offset = pageNum * SUB_PAGE_SIZE;
      const data = await get<{ subscribers: Subscriber[]; total: number }>(`/nhk/subscribers?limit=${SUB_PAGE_SIZE}&offset=${offset}`);
      setSubscribers(data.subscribers);
      setTotalSubs(data.total);
    } catch {
      setError('Không thể tải danh sách subscribers.');
    } finally {
      setLoadingSubs(false);
    }
  };

  const handleSubPage = (newPage: number) => {
    setSubPage(newPage);
    fetchSubscribers(newPage);
  };

  const totalSubPages = Math.ceil(totalSubs / SUB_PAGE_SIZE);

  const toggleEmail = (email: string) => {
    setSelectedEmails(prev => {
      const next = new Set(prev);
      if (next.has(email)) next.delete(email);
      else next.add(email);
      return next;
    });
  };

  const selectAll = () => {
    if (selectedEmails.size === subscribers.length) {
      setSelectedEmails(new Set());
    } else {
      setSelectedEmails(new Set(subscribers.map(s => s.email)));
    }
  };

  const handleSend = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);
    setResult(null);

    if (!subject.trim()) { setError('Vui lòng nhập tiêu đề'); return; }
    if (!content.trim()) { setError('Vui lòng nhập nội dung'); return; }
    if (selectedEmails.size === 0) { setError('Vui lòng chọn ít nhất 1 email'); return; }

    setLoading(true);
    try {
      const data = await post<{ sent: number; failed: number }>('/nhk/send-manual', {
        subject: subject.trim(),
        content: content.trim(),
        subscriber_emails: Array.from(selectedEmails),
      });
      setResult(`Đã gửi thành công ${data.sent} email${data.failed > 0 ? `, thất bại ${data.failed}` : ''}`);
      setSubject('');
      setContent('');
      setSelectedEmails(new Set());
    } catch (err: any) {
      setError(err?.message || 'Gửi mail thất bại.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>Gửi mail cho User</h2>

      <form className="mailer-form" onSubmit={handleSend}>
        <input
          type="text"
          placeholder="Tiêu đề email"
          value={subject}
          onChange={e => setSubject(e.target.value)}
        />
        <textarea
          placeholder="Nội dung email..."
          value={content}
          onChange={e => setContent(e.target.value)}
          rows={8}
        />

        <div className="mailer-subscribers">
          <div className="mailer-subscribers-header">
            <h3>Chọn người nhận ({selectedEmails.size}/{subscribers.length})</h3>
            <button type="button" className="btn-back" onClick={selectAll}>
              {selectedEmails.size === subscribers.length ? 'Bỏ chọn tất cả' : 'Chọn tất cả'}
            </button>
          </div>

          {loadingSubs ? (
            <p className="loading-text">Đang tải...</p>
          ) : subscribers.length === 0 ? (
            <p className="empty-state">Chưa có subscriber nào.</p>
          ) : (
            <>
              <div className="subscriber-list">
                {subscribers.map(s => (
                  <label key={s.id} className="subscriber-item">
                    <input
                      type="checkbox"
                      checked={selectedEmails.has(s.email)}
                      onChange={() => toggleEmail(s.email)}
                    />
                    <span className="subscriber-email">{s.email}</span>
                    <span className="subscriber-lang">{s.target_language.toUpperCase()}</span>
                  </label>
                ))}
              </div>
              {totalSubPages > 1 && (
                <div className="pagination">
                  <button disabled={subPage === 0} onClick={() => handleSubPage(subPage - 1)}>← Trước</button>
                  <span>{subPage + 1} / {totalSubPages}</span>
                  <button disabled={subPage >= totalSubPages - 1} onClick={() => handleSubPage(subPage + 1)}>Sau →</button>
                </div>
              )}
            </>
          )}
        </div>

        {error && <p className="form-error">{error}</p>}
        {result && <p className="subscribe-success">{result}</p>}

        <button type="submit" className="btn-submit" disabled={loading}>
          {loading ? 'Đang gửi...' : `Gửi mail (${selectedEmails.size})`}
        </button>
      </form>
    </div>
  );
}

interface Question {
  id: number;
  question: string;
  is_active: boolean;
  createdAt: string;
}

function QuestionsManagement() {
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [newQuestion, setNewQuestion] = useState('');

  useEffect(() => { fetchQuestions(); }, []);

  const fetchQuestions = async () => {
    setLoading(true);
    try {
      const data = await get<Question[]>('/admin/questions');
      setQuestions(data);
    } catch (err: any) {
      setError(err?.status === 403 ? 'Admin access required.' : 'Failed to load questions.');
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    if (!newQuestion.trim()) return;
    setError(null);
    try {
      await post('/admin/questions', { question: newQuestion.trim() });
      setNewQuestion('');
      fetchQuestions();
    } catch (err: any) { setError(err?.message || 'Failed to create question.'); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('Delete this question?')) return;
    try { await del(`/admin/questions/${id}`); fetchQuestions(); }
    catch (err: any) { setError(err?.message || 'Failed to delete.'); }
  };

  const toggleActive = async (q: Question) => {
    try {
      await put(`/admin/questions/${q.id}`, { is_active: !q.is_active });
      fetchQuestions();
    } catch (err: any) { setError(err?.message || 'Failed to update.'); }
  };

  if (loading) return <p className="loading-text">Loading...</p>;

  return (
    <div>
      <h2>Classroom Questions</h2>
      <p style={{ fontSize: 13, color: '#666', marginBottom: 12 }}>
        Active questions are displayed on the classroom blackboard.
      </p>

      {error && <p className="form-error">{error}</p>}

      <form className="admin-form" onSubmit={handleCreate} style={{ marginBottom: 16 }}>
        <input
          type="text"
          placeholder="Enter a new question..."
          value={newQuestion}
          onChange={(e) => setNewQuestion(e.target.value)}
          style={{ flex: 1 }}
        />
        <button type="submit" className="btn-submit">Add</button>
      </form>

      {questions.length === 0 ? (
        <p className="empty-state">No questions yet.</p>
      ) : (
        <table className="admin-table">
          <thead><tr><th>Question</th><th>Active</th><th>Created</th><th>Actions</th></tr></thead>
          <tbody>
            {questions.map((q) => (
              <tr key={q.id} style={{ opacity: q.is_active ? 1 : 0.5 }}>
                <td>{q.question}</td>
                <td>
                  <button onClick={() => toggleActive(q)} style={{ cursor: 'pointer', border: 'none', background: 'none', fontSize: 16 }}>
                    {q.is_active ? '✅' : '❌'}
                  </button>
                </td>
                <td>{new Date(q.createdAt).toLocaleDateString()}</td>
                <td>
                  <button className="btn-delete" onClick={() => handleDelete(q.id)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}


interface ReadingPost {
  id: number;
  username: string;
  title: string;
  content: string;
  level: string;
  like_count: number;
  created_at: string;
}

function ReadingPostsManagement() {
  const [posts, setPosts] = useState<ReadingPost[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [level, setLevel] = useState('N3');

  const PAGE_SIZE = 10;

  useEffect(() => { fetchPosts(page); }, [page]);

  const fetchPosts = async (pageNum: number) => {
    setLoading(true);
    try {
      const offset = pageNum * PAGE_SIZE;
      const data = await get<{ posts: ReadingPost[]; total: number }>(`/reading-posts?limit=${PAGE_SIZE}&offset=${offset}`);
      setPosts(data.posts);
      setTotal(data.total);
    } catch (err: any) {
      setError('Failed to load posts.');
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !content.trim()) { setError('Title and content required'); return; }
    setError(null);
    try {
      await post('/reading-posts', { username: 'Admin', title: title.trim(), content: content.trim(), level });
      setTitle(''); setContent(''); setShowForm(false);
      fetchPosts(page);
    } catch (err: any) { setError(err?.message || 'Failed to create.'); }
  };

  const handleUpdate = async (e: FormEvent) => {
    e.preventDefault();
    if (!editingId) return;
    setError(null);
    const body: any = {};
    if (title.trim()) body.title = title.trim();
    if (content.trim()) body.content = content.trim();
    body.level = level;
    try {
      await put(`/reading-posts/${editingId}`, body);
      setEditingId(null); setTitle(''); setContent('');
      fetchPosts(page);
    } catch (err: any) { setError(err?.message || 'Failed to update.'); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('Delete this post?')) return;
    try { await del(`/reading-posts/${id}`); fetchPosts(page); }
    catch (err: any) { setError(err?.message || 'Failed to delete.'); }
  };

  const startEdit = (p: ReadingPost) => {
    setEditingId(p.id); setTitle(p.title); setContent(p.content); setLevel(p.level); setShowForm(false);
  };

  const totalPages = Math.ceil(total / PAGE_SIZE);

  if (loading && posts.length === 0) return <p className="loading-text">Loading...</p>;

  return (
    <div>
      <div className="admin-header">
        <h2>Reading Posts ({total})</h2>
        <button className="btn-submit" onClick={() => { setShowForm(!showForm); setEditingId(null); setTitle(''); setContent(''); }}>
          {showForm ? 'Cancel' : '+ New Post'}
        </button>
      </div>

      {error && <p className="form-error">{error}</p>}

      {showForm && (
        <form className="admin-form" onSubmit={handleCreate}>
          <input type="text" placeholder="Title" value={title} onChange={e => setTitle(e.target.value)} required />
          <select value={level} onChange={e => setLevel(e.target.value)}>
            <option value="N3">N3</option>
            <option value="N2">N2</option>
            <option value="N1">N1</option>
            <option value="TOEIC">TOEIC</option>
          </select>
          <textarea placeholder="Content..." value={content} onChange={e => setContent(e.target.value)} rows={6} required />
          <button type="submit" className="btn-submit">Create Post</button>
        </form>
      )}

      {editingId && (
        <form className="admin-form" onSubmit={handleUpdate}>
          <h3>Edit Post #{editingId}</h3>
          <input type="text" placeholder="Title" value={title} onChange={e => setTitle(e.target.value)} />
          <select value={level} onChange={e => setLevel(e.target.value)}>
            <option value="N3">N3</option>
            <option value="N2">N2</option>
            <option value="N1">N1</option>
            <option value="TOEIC">TOEIC</option>
          </select>
          <textarea placeholder="Content..." value={content} onChange={e => setContent(e.target.value)} rows={6} />
          <div className="admin-form-actions">
            <button type="submit" className="btn-submit">Save</button>
            <button type="button" className="btn-back" onClick={() => setEditingId(null)}>Cancel</button>
          </div>
        </form>
      )}

      <table className="admin-table">
        <thead><tr><th>Title</th><th>Level</th><th>Likes</th><th>Created</th><th>Actions</th></tr></thead>
        <tbody>
          {posts.map(p => (
            <tr key={p.id}>
              <td style={{ maxWidth: 200, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{p.title}</td>
              <td>{p.level}</td>
              <td>{p.like_count}</td>
              <td>{new Date(p.created_at).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(p)}>Edit</button>
                <button className="btn-delete" onClick={() => handleDelete(p.id)}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {totalPages > 1 && (
        <div className="pagination">
          <button disabled={page === 0} onClick={() => setPage(p => p - 1)}>← Prev</button>
          <span>{page + 1} / {totalPages}</span>
          <button disabled={page >= totalPages - 1} onClick={() => setPage(p => p + 1)}>Next →</button>
        </div>
      )}
    </div>
  );
}

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

function BooksManagement() {
  const [books, setBooks] = useState<Book[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [content, setContent] = useState('');
  const [price, setPrice] = useState('');
  const [contact, setContact] = useState('');
  const [imageUrl, setImageUrl] = useState<string | null>(null);
  const [uploading, setUploading] = useState(false);

  const PAGE_SIZE = 10;

  useEffect(() => { fetchBooks(page); }, [page]);

  const resetForm = () => {
    setTitle(''); setDescription(''); setContent(''); setPrice(''); setContact(''); setImageUrl(null);
  };

  const fetchBooks = async (pageNum: number) => {
    setLoading(true);
    try {
      const offset = pageNum * PAGE_SIZE;
      const data = await get<{ books: Book[]; total: number }>(`/books?limit=${PAGE_SIZE}&offset=${offset}`);
      setBooks(data.books);
      setTotal(data.total);
    } catch {
      setError('Failed to load books.');
    } finally {
      setLoading(false);
    }
  };

  const handleImageChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setUploading(true);
    setError(null);
    try {
      const { image_url } = await uploadBookImage(file);
      setImageUrl(image_url);
    } catch (err: any) {
      setError(err?.message || 'Upload ảnh thất bại.');
    } finally {
      setUploading(false);
      e.target.value = '';
    }
  };

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !description.trim() || !content.trim() || !contact.trim()) {
      setError('Vui lòng điền đầy đủ thông tin.');
      return;
    }
    setError(null);
    try {
      await post('/books', {
        title: title.trim(),
        description: description.trim(),
        content: content.trim(),
        price: price.trim(),
        contact: contact.trim(),
        image_url: imageUrl,
      });
      resetForm();
      setShowForm(false);
      fetchBooks(page);
    } catch (err: any) { setError(err?.message || 'Failed to create book.'); }
  };

  const handleUpdate = async (e: FormEvent) => {
    e.preventDefault();
    if (!editingId) return;
    setError(null);
    try {
      await put(`/books/${editingId}`, {
        title: title.trim(),
        description: description.trim(),
        content: content.trim(),
        price: price.trim(),
        contact: contact.trim(),
        image_url: imageUrl,
      });
      setEditingId(null);
      resetForm();
      fetchBooks(page);
    } catch (err: any) { setError(err?.message || 'Failed to update book.'); }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('Delete this book?')) return;
    try { await del(`/books/${id}`); fetchBooks(page); }
    catch (err: any) { setError(err?.message || 'Failed to delete.'); }
  };

  const startEdit = (b: Book) => {
    setEditingId(b.id);
    setTitle(b.title); setDescription(b.description); setContent(b.content);
    setPrice(String(b.price ?? '')); setContact(b.contact); setImageUrl(b.image_url);
    setShowForm(false);
  };

  const totalPages = Math.ceil(total / PAGE_SIZE);

  if (loading && books.length === 0) return <p className="loading-text">Loading...</p>;

  const imagePicker = (
    <div className="book-image-field">
      <input type="file" accept="image/*" onChange={handleImageChange} disabled={uploading} />
      {uploading && <span className="loading-text">Đang tải ảnh lên...</span>}
      {imageUrl && !uploading && (
        <div className="book-image-preview">
          <img src={imageUrl} alt="Preview" />
          <button type="button" className="btn-back" onClick={() => setImageUrl(null)}>Xoá ảnh</button>
        </div>
      )}
    </div>
  );

  return (
    <div>
      <div className="admin-header">
        <h2>Quản lý Sách ({total})</h2>
        <button className="btn-submit" onClick={() => { setShowForm(!showForm); setEditingId(null); resetForm(); }}>
          {showForm ? 'Cancel' : '+ Thêm sách'}
        </button>
      </div>

      {error && <p className="form-error">{error}</p>}

      {showForm && (
        <form className="admin-form book-form" onSubmit={handleCreate}>
          <label className="book-form-field">
            Tên sách
            <input type="text" value={title} onChange={e => setTitle(e.target.value)} required />
          </label>
          <label className="book-form-field">
            Ảnh bìa
            {imagePicker}
          </label>
          <label className="book-form-field">
            Mô tả
            <input type="text" value={description} onChange={e => setDescription(e.target.value)} required />
          </label>
          <label className="book-form-field">
            Giá bán
            <input type="text" placeholder="VD: 150,000 VNĐ" value={price} onChange={e => setPrice(e.target.value)} required />
          </label>
          <label className="book-form-field">
            Liên hệ mua hàng
            <input type="text" placeholder="SĐT/email/zalo..." value={contact} onChange={e => setContact(e.target.value)} required />
          </label>
          <label className="book-form-field">
            Nội dung / mô tả chi tiết
            <textarea value={content} onChange={e => setContent(e.target.value)} rows={6} required />
          </label>
          <button type="submit" className="btn-submit" disabled={uploading}>Tạo sách</button>
        </form>
      )}

      {editingId && (
        <form className="admin-form book-form" onSubmit={handleUpdate}>
          <h3>Sửa sách #{editingId}</h3>
          <label className="book-form-field">
            Tên sách
            <input type="text" value={title} onChange={e => setTitle(e.target.value)} />
          </label>
          <label className="book-form-field">
            Ảnh bìa
            {imagePicker}
          </label>
          <label className="book-form-field">
            Mô tả
            <input type="text" value={description} onChange={e => setDescription(e.target.value)} />
          </label>
          <label className="book-form-field">
            Giá bán
            <input type="text" placeholder="VD: 150,000 VNĐ" value={price} onChange={e => setPrice(e.target.value)} />
          </label>
          <label className="book-form-field">
            Liên hệ mua hàng
            <input type="text" value={contact} onChange={e => setContact(e.target.value)} />
          </label>
          <label className="book-form-field">
            Nội dung / mô tả chi tiết
            <textarea value={content} onChange={e => setContent(e.target.value)} rows={6} />
          </label>
          <div className="admin-form-actions">
            <button type="submit" className="btn-submit" disabled={uploading}>Save</button>
            <button type="button" className="btn-back" onClick={() => setEditingId(null)}>Cancel</button>
          </div>
        </form>
      )}

      <table className="admin-table">
        <thead><tr><th>Ảnh</th><th>Tên sách</th><th>Giá</th><th>Liên hệ</th><th>Created</th><th>Actions</th></tr></thead>
        <tbody>
          {books.map(b => (
            <tr key={b.id}>
              <td>{b.image_url ? <img src={b.image_url} alt={b.title} className="book-thumb" /> : '—'}</td>
              <td style={{ maxWidth: 200, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{b.title}</td>
              <td>{b.price}</td>
              <td>{b.contact}</td>
              <td>{new Date(b.created_at).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(b)}>Edit</button>
                <button className="btn-delete" onClick={() => handleDelete(b.id)}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {totalPages > 1 && (
        <div className="pagination">
          <button disabled={page === 0} onClick={() => setPage(p => p - 1)}>← Prev</button>
          <span>{page + 1} / {totalPages}</span>
          <button disabled={page >= totalPages - 1} onClick={() => setPage(p => p + 1)}>Next →</button>
        </div>
      )}
    </div>
  );
}
