import { useState, useEffect, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, post, put, del } from '../api/client';

interface AdminUser {
  id: string;
  email: string;
  isAdmin: boolean;
  createdAt: string;
}

interface Subscriber {
  id: string;
  email: string;
  target_language: string;
  created_at: string | null;
}

type AdminView = 'menu' | 'users' | 'mailer';

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
        </div>
      </div>
    );
  }

  return (
    <div className="admin-page">
      <button className="btn-back" onClick={() => setView('menu')}>← Quay lại</button>
      {view === 'users' && <UserManagement />}
      {view === 'mailer' && <MailerSection />}
    </div>
  );
}

function UserManagement() {
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
      setError(err?.status === 403 ? 'Admin access required.' : 'Failed to load users.');
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
        <thead><tr><th>Email</th><th>Admin</th><th>Created</th><th>Actions</th></tr></thead>
        <tbody>
          {users.map((u) => (
            <tr key={u.id}>
              <td>{u.email}</td>
              <td>{u.isAdmin ? '✅' : '—'}</td>
              <td>{new Date(u.createdAt).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(u)}>Edit</button>
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
