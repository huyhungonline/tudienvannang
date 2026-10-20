import { useEffect, useState, type FormEvent } from 'react';
import { ApiError, get, post } from '../api/client';

interface EmailContact {
  id: number;
  email: string;
  created_at: string;
}

interface ContactList {
  contacts: EmailContact[];
  total: number;
}

const PAGE_SIZE = 50;

export function EmailContactsManagement() {
  const [email, setEmail] = useState('');
  const [contacts, setContacts] = useState<EmailContact[]>([]);
  const [total, setTotal] = useState(0);
  const [offset, setOffset] = useState(0);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [loadError, setLoadError] = useState('');
  const [saveError, setSaveError] = useState('');
  const [success, setSuccess] = useState('');
  const [refresh, setRefresh] = useState(0);

  useEffect(() => {
    let active = true;
    setLoading(true);
    setLoadError('');
    get<ContactList>(`/admin/email-contacts?limit=${PAGE_SIZE}&offset=${offset}`)
      .then(data => {
        if (!active) return;
        setContacts(data.contacts);
        setTotal(data.total);
      })
      .catch(err => {
        if (active) setLoadError(err instanceof ApiError && [401, 403].includes(err.status)
          ? 'Bạn cần quyền admin để xem danh sách email.'
          : 'Không tải được danh sách email. Vui lòng thử lại.');
      })
      .finally(() => { if (active) setLoading(false); });
    return () => { active = false; };
  }, [offset, refresh]);

  async function handleSubmit(event: FormEvent) {
    event.preventDefault();
    if (saving) return;
    setSaveError('');
    setSuccess('');
    setSaving(true);
    try {
      const saved = await post<EmailContact>('/admin/email-contacts', { email: email.trim() });
      setEmail('');
      setSuccess(`Đã lưu email ${saved.email}.`);
      setOffset(0);
      setRefresh(value => value + 1);
    } catch (err) {
      setSaveError(err instanceof ApiError && err.status === 409
        ? 'Email này đã có trong danh sách.'
        : err instanceof ApiError && err.status === 422
          ? 'Địa chỉ email không hợp lệ.'
          : err instanceof ApiError && [401, 403].includes(err.status)
            ? 'Bạn cần quyền admin để lưu email.'
            : 'Không lưu được email. Vui lòng thử lại.');
    } finally {
      setSaving(false);
    }
  }

  return (
    <section>
      <h2>Nhập mail user</h2>
      <form className="auth-form" onSubmit={handleSubmit}>
        <div className="form-field">
          <label htmlFor="contact-email">Email</label>
          <input id="contact-email" type="email" required maxLength={254}
            value={email} onChange={event => setEmail(event.target.value)}
            placeholder="Nhập địa chỉ email" autoComplete="off" disabled={saving} />
        </div>
        <button className="btn-submit" type="submit" disabled={saving || !email.trim()}>
          {saving ? 'Đang lưu...' : 'Lưu email'}
        </button>
        {saveError && <p className="form-error" role="alert">{saveError}</p>}
        {success && <p role="status">{success}</p>}
      </form>

      <h3>Danh sách email đã nhập{!loading && !loadError ? ` (${total})` : ''}</h3>
      {loading ? <p role="status">Đang tải...</p> : loadError ? (
        <div role="alert">
          <p>{loadError}</p>
          <button onClick={() => setRefresh(value => value + 1)}>Thử lại</button>
        </div>
      ) : contacts.length === 0 ? <p>Chưa có email nào.</p> : (
        <>
          <ul>
            {contacts.map(contact => <li key={contact.id} style={{ overflowWrap: 'anywhere' }}>{contact.email}</li>)}
          </ul>
          <div className="admin-header">
            <button disabled={offset === 0} onClick={() => setOffset(value => Math.max(0, value - PAGE_SIZE))}>Trang trước</button>
            <span>Trang {Math.floor(offset / PAGE_SIZE) + 1} / {Math.max(1, Math.ceil(total / PAGE_SIZE))}</span>
            <button disabled={offset + PAGE_SIZE >= total} onClick={() => setOffset(value => value + PAGE_SIZE)}>Trang sau</button>
          </div>
        </>
      )}
    </section>
  );
}
