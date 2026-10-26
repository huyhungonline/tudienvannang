import { useState, useEffect, useRef, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, post, put, del, uploadBookImage } from '../api/client';
import { Spinner } from '../components/Spinner';
import { CLASS_SCHEDULES } from './ClassRegistrationPage';
import { WorkbookOrdersManagement } from './WorkbookOrdersManagement';
import { ClassSessionsManagement } from './ClassSessionsManagement';
import { EmailContactsManagement } from './EmailContactsManagement';

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

type AdminView = 'menu' | 'users' | 'mailer' | 'questions' | 'reading' | 'books' | 'class-registrations' | 'class-sessions' | 'workbook-orders' | 'email-contacts';

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
          <button className="admin-menu-item" onClick={() => setView('email-contacts')}>
            📧 Nhập mail user
          </button>
          <button className="admin-menu-item" onClick={() => setView('class-registrations')}>
            📋 Danh sách đăng kí lớp học
          </button>
          <button className="admin-menu-item" onClick={() => setView('class-sessions')}>
            🏫 Quản lý lớp học
          </button>
          <button className="admin-menu-item" onClick={() => setView('workbook-orders')}>
            📦 Danh sách đăng kí mua sách
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
      {view === 'email-contacts' && <EmailContactsManagement />}
      {view === 'class-registrations' && <ClassRegistrationsManagement />}
      {view === 'class-sessions' && <ClassSessionsManagement />}
      {view === 'workbook-orders' && <WorkbookOrdersManagement />}
      {view === 'questions' && <QuestionsManagement />}
      {view === 'reading' && <ReadingPostsManagement />}
      {view === 'books' && <BooksManagement />}
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
    } catch {
      // 401/403 is handled centrally in the API client (redirects to /login).
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

  if (loading) return <p className="loading-text"><Spinner /> Loading...</p>;

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
        <thead><tr><th>Email</th><th>Admin</th><th>Pro</th><th>Created</th><th>Actions</th></tr></thead>
        <tbody>
          {users.map((u) => (
            <tr key={u.id}>
              <td>{u.email}</td>
              <td>{u.isAdmin ? '✅' : '—'}</td>
              <td>{u.isVip ? '⭐ Pro' : '—'}</td>
              <td>{new Date(u.createdAt).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(u)}>Edit</button>
                <button
                  className={u.isVip ? 'btn-vip btn-vip-active' : 'btn-vip'}
                  onClick={() => handleToggleVip(u)}
                >
                  {u.isVip ? 'Hủy Pro' : 'Nâng cấp Pro'}
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

interface MailJob {
  jobId: string;
  subject: string;
  total: number;
  sent: number;
  failed: number;
  pending: number;
  failures: { email: string; error: string }[];
}

function MailerSection() {
  const [registeredUsers, setRegisteredUsers] = useState<AdminUser[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(true);
  const [userPage, setUserPage] = useState(0);
  const [jobs, setJobs] = useState<MailJob[]>([]);
  const requestAttempt = useRef<{ fingerprint: string; id: string } | null>(null);
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

  useEffect(() => {
    let disposed = false;
    get<AdminUser[]>('/admin/users')
      .then(data => {
        if (!disposed) setRegisteredUsers(data.map(user => ({ ...user, email: user.email.trim().toLowerCase() })));
      })
      .catch(() => { if (!disposed) setError('Không thể tải danh sách tài khoản đã đăng ký.'); })
      .finally(() => { if (!disposed) setLoadingUsers(false); });
    return () => { disposed = true; };
  }, []);

  const visibleUsers = registeredUsers.slice(userPage * SUB_PAGE_SIZE, (userPage + 1) * SUB_PAGE_SIZE);
  const totalUserPages = Math.ceil(registeredUsers.length / SUB_PAGE_SIZE);
  const allUsersSelected = registeredUsers.length > 0 && registeredUsers.every(user => selectedEmails.has(user.email));
  const toggleAllUsers = () => {
    setSelectedEmails(prev => {
      const next = new Set(prev);
      const allSelected = registeredUsers.every(user => prev.has(user.email));
      registeredUsers.forEach(user => allSelected ? next.delete(user.email) : next.add(user.email));
      return next;
    });
  };

  useEffect(() => {
    let disposed = false;
    let timer: ReturnType<typeof setTimeout>;
    const refresh = async () => {
      try {
        const data = await get<{ jobs: MailJob[] }>('/nhk/mail-jobs');
        if (!disposed) setJobs(data.jobs);
      } catch {
        if (!disposed) setError('Không thể tải tiến độ gửi mail. Đang thử lại...');
      } finally {
        if (!disposed) timer = setTimeout(refresh, 3000);
      }
    };
    refresh();
    return () => { disposed = true; clearTimeout(timer); };
  }, []);

  const retryJob = async (job: MailJob) => {
    if (!confirm('Gửi lại các email thất bại? Nếu báo gửi bị gián đoạn, hãy kiểm tra hộp thư trước để tránh gửi trùng.')) return;
    try {
      const updated = await post<MailJob>(`/nhk/mail-jobs/${job.jobId}/retry`, {});
      setJobs(prev => prev.map(item => item.jobId === updated.jobId ? updated : item));
    } catch { setError('Không thể gửi lại. Vui lòng thử lại.'); }
  };

  const fetchSubscribers = async (pageNum: number) => {
    setLoadingSubs(true);
    try {
      const offset = pageNum * SUB_PAGE_SIZE;
      const data = await get<{ subscribers: Subscriber[]; total: number }>(`/nhk/subscribers?limit=${SUB_PAGE_SIZE}&offset=${offset}`);
      setSubscribers(data.subscribers.map(subscriber => ({ ...subscriber, email: subscriber.email.trim().toLowerCase() })));
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
    setSelectedEmails(prev => {
      const next = new Set(prev);
      const allSelected = subscribers.every(s => prev.has(s.email));
      subscribers.forEach(s => allSelected ? next.delete(s.email) : next.add(s.email));
      return next;
    });
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
      const payload = {
        subject: subject.trim(),
        content: content.trim(),
        subscriber_emails: Array.from(selectedEmails).sort(),
      };
      const fingerprint = JSON.stringify(payload);
      if (requestAttempt.current?.fingerprint !== fingerprint) {
        requestAttempt.current = { fingerprint, id: crypto.randomUUID() };
      }
      const data = await post<{ jobId: string }>('/nhk/send-manual', {
        ...payload, request_id: requestAttempt.current!.id,
      });
      const job = await get<MailJob>(`/nhk/mail-jobs/${data.jobId}`);
      setJobs(prev => [job, ...prev.filter(item => item.jobId !== job.jobId)]);
      setResult('Đã đưa vào hàng đợi. Bạn có thể rời trang; mail vẫn tiếp tục được gửi.');
      requestAttempt.current = null;
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

        <p>Đã chọn {selectedEmails.size} email. Email trùng giữa hai danh sách chỉ được gửi một lần.</p>
        <div className="mailer-subscribers">
          <div className="mailer-subscribers-header">
            <h3>Tài khoản đã đăng ký ({registeredUsers.length})</h3>
            <button type="button" className="btn-back" onClick={toggleAllUsers} disabled={loadingUsers || registeredUsers.length === 0}>
              {allUsersSelected ? 'Bỏ chọn tất cả tài khoản' : 'Chọn tất cả tài khoản'}
            </button>
          </div>
          {loadingUsers ? <p className="loading-text"><Spinner /> Đang tải...</p> : registeredUsers.length === 0 ? (
            <p className="empty-state">Chưa có tài khoản nào.</p>
          ) : <>
            <div className="subscriber-list">
              {visibleUsers.map(user => (
                <label key={user.id} className="subscriber-item">
                  <input type="checkbox" checked={selectedEmails.has(user.email)} onChange={() => toggleEmail(user.email)} />
                  <span className="subscriber-email">{user.email}</span>
                  <span className="subscriber-lang">{user.isAdmin ? 'Admin' : user.isVip ? 'Pro' : 'User'}</span>
                </label>
              ))}
            </div>
            {totalUserPages > 1 && <div className="pagination">
              <button type="button" disabled={userPage === 0} onClick={() => setUserPage(page => page - 1)}>← Trước</button>
              <span>{userPage + 1} / {totalUserPages}</span>
              <button type="button" disabled={userPage >= totalUserPages - 1} onClick={() => setUserPage(page => page + 1)}>Sau →</button>
            </div>}
          </>}
        </div>

        <div className="mailer-subscribers">
          <div className="mailer-subscribers-header">
            <h3>Người đăng ký nhận tin ({totalSubs})</h3>
            <button type="button" className="btn-back" onClick={selectAll}>
              {subscribers.length > 0 && subscribers.every(s => selectedEmails.has(s.email)) ? 'Bỏ chọn trang này' : 'Chọn cả trang này'}
            </button>
          </div>

          {loadingSubs ? (
            <p className="loading-text"><Spinner /> Đang tải...</p>
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
                  <button type="button" disabled={subPage === 0} onClick={() => handleSubPage(subPage - 1)}>← Trước</button>
                  <span>{subPage + 1} / {totalSubPages}</span>
                  <button type="button" disabled={subPage >= totalSubPages - 1} onClick={() => handleSubPage(subPage + 1)}>Sau →</button>
                </div>
              )}
            </>
          )}
        </div>

        {error && <p className="form-error">{error}</p>}
        {result && <p className="subscribe-success">{result}</p>}

        <button type="submit" className="btn-submit" disabled={loading}>
          {loading ? 'Đang tạo đợt gửi...' : `Gửi mail (${selectedEmails.size})`}
        </button>
      </form>
      <h3>Tiến độ các đợt gửi gần đây</h3>
      <p>Mail được gửi lần lượt ở nền. “Đã gửi” nghĩa là máy chủ SMTP đã nhận email.</p>
      {jobs.map(job => (
        <div key={job.jobId} className="mailer-subscribers">
          <strong>{job.subject}</strong>
          <p>{job.pending > 0 ? 'Đang gửi' : 'Đã xử lý'} — Đã gửi: {job.sent}/{job.total} · Thất bại: {job.failed} · Đang chờ: {job.pending}</p>
          <progress value={job.sent + job.failed} max={job.total} aria-label="Tiến độ gửi email" />
          {job.failed > 0 && <>
            <button type="button" className="btn-back" onClick={() => retryJob(job)}>Gửi lại email thất bại</button>
            <details><summary>Xem email thất bại</summary>
              <ul>{job.failures.map(item => <li key={item.email}>{item.email}: {item.error}</li>)}</ul>
            </details>
          </>}
        </div>
      ))}
    </div>
  );
}

interface ClassRegistration {
  id: string;
  course: string;
  schedule: string | null;
  full_name: string;
  email: string;
  phone: string;
  book_address: string;
  created_at: string;
}

export function ClassRegistrationsManagement() {
  const [registrations, setRegistrations] = useState<ClassRegistration[]>([]);
  const [counts, setCounts] = useState<{ course: string; schedule: string | null; count: number }[]>([]);
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [reload, setReload] = useState(0);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [deleteError, setDeleteError] = useState('');

  async function deleteRegistration(item: ClassRegistration) {
    if (deletingId || loading) return;
    if (!window.confirm(`Xóa đăng kí lớp học của ${item.full_name} (${item.email})? Thao tác này không thể hoàn tác.`)) return;
    setDeletingId(item.id);
    setDeleteError('');
    try {
      await del(`/classes/registrations/${item.id}`);
      if (registrations.length === 1 && page > 0) setPage(value => value - 1);
      else setReload(value => value + 1);
    } catch {
      setDeleteError('Không thể xóa đăng kí lớp học. Vui lòng thử lại.');
    } finally {
      setDeletingId(null);
    }
  }
  useEffect(() => {
    let disposed = false;
    setLoading(true);
    setError('');
    get<{ registrations: ClassRegistration[]; total: number; counts: typeof counts }>(`/classes/registrations?limit=50&offset=${page * 50}`)
      .then(data => { if (!disposed) { setRegistrations(data.registrations); setTotal(data.total); setCounts(data.counts); } })
      .catch(() => { if (!disposed) setError('Không thể tải danh sách đăng kí.'); })
      .finally(() => { if (!disposed) setLoading(false); });
    return () => { disposed = true; };
  }, [page, reload]);
  return <div>
    <div className="admin-header">
      <h2>Đăng kí lớp học ({total})</h2>
      <button type="button" disabled={loading || deletingId !== null} onClick={() => { setPage(0); setReload(value => value + 1); }}>
        {loading ? 'Đang tải...' : 'Tải lại'}
      </button>
    </div>
    {deleteError && <p className="form-error" role="alert">{deleteError}</p>}
    {!loading && !error && <section aria-label="Số lượng đăng kí theo lớp">
      <h3>Số lượng đăng kí theo lớp</h3>
      <p><strong>IT Passport: {counts.filter(item => item.course === 'it-passport').reduce((sum, item) => sum + item.count, 0)} người</strong></p>
      <ul>
        {/* Driven by the API so newly added classes appear without a code change. */}
        {counts.filter(item => item.course === 'it-passport' && item.schedule).map(item => <li key={item.schedule}>
          {CLASS_SCHEDULES[item.schedule!] || item.schedule}: <strong>{item.count} người</strong>
        </li>)}
      </ul>
      <p><strong>機械保全技能検定: {counts.filter(item => item.course === 'kikai-hozen').reduce((sum, item) => sum + item.count, 0)} người</strong></p>
    </section>}
    {error && <p className="form-error">{error}</p>}
    {loading ? <p><Spinner /> Đang tải...</p> : registrations.length === 0 ? <p>Chưa có đăng kí nào.</p> : <>
      <div className="class-registrations-scroll"><table className="admin-table class-registrations-table">
        <thead><tr><th className="registration-actions">Thao tác</th><th>Lớp học</th><th>Lịch học</th><th>Họ tên</th><th>Email</th><th>Số điện thoại</th><th>Ngày đăng kí</th></tr></thead>
        <tbody>{registrations.map(item => <tr key={item.id}>
          <td className="registration-actions"><button className="btn-delete" type="button" disabled={deletingId !== null} onClick={() => deleteRegistration(item)}>
            {deletingId === item.id ? 'Đang xóa...' : 'Xóa'}
          </button></td>
          <td>{item.course === 'it-passport' ? 'IT Passport miễn phí' : '機械保全技能検定'}</td>
          <td>{item.schedule ? CLASS_SCHEDULES[item.schedule] || item.schedule : '—'}</td>
          <td>{item.full_name}</td><td>{item.email}</td><td>{item.phone}</td>
          <td>{new Date(item.created_at).toLocaleString()}</td>
        </tr>)}</tbody>
      </table></div>
      <div className="pagination">
        <button disabled={page === 0 || deletingId !== null} onClick={() => setPage(value => value - 1)}>← Trước</button>
        <span>{page + 1} / {Math.ceil(total / 50)}</span>
        <button disabled={(page + 1) * 50 >= total || deletingId !== null} onClick={() => setPage(value => value + 1)}>Sau →</button>
      </div>
    </>}
  </div>;
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
    } catch {
      // 401/403 is handled centrally in the API client (redirects to /login).
      setError('Failed to load questions.');
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

  if (loading) return <p className="loading-text"><Spinner /> Loading...</p>;

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

  if (loading && posts.length === 0) return <p className="loading-text"><Spinner /> Loading...</p>;

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

  if (loading && books.length === 0) return <p className="loading-text"><Spinner /> Loading...</p>;

  const imagePicker = (
    <div className="book-image-field">
      <input type="file" accept="image/*" onChange={handleImageChange} disabled={uploading} />
      {uploading && <span className="loading-text"><Spinner size={14} /> Đang tải ảnh lên...</span>}
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
            Link TikTok mua hàng
            <input type="text" placeholder="https://www.tiktok.com/@taikhoan" value={contact} onChange={e => setContact(e.target.value)} required />
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
            Link TikTok mua hàng
            <input type="text" placeholder="https://www.tiktok.com/@taikhoan" value={contact} onChange={e => setContact(e.target.value)} />
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
