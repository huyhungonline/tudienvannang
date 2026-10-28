import { useState, useEffect, useCallback, type FormEvent } from 'react';
import { get, post, put, del } from '../api/client';
import { Spinner } from '../components/Spinner';

interface BookCustomer {
  id: number;
  full_name: string;
  phone: string | null;
  email: string | null;
  address: string | null;
  book_type: string | null;
  note: string | null;
  paid_at: string | null;
  shipped_at: string | null;
  source: string;
  created_at: string;
}

interface Stats {
  total: number;
  unpaid: number;
  paidNotShipped: number;
  shipped: number;
}

const SOURCE_LABELS: Record<string, string> = {
  manual: 'Nhập tay',
  admin: 'Trang quản trị',
  chatgpt: 'ChatGPT',
};

export function BookCustomersManagement() {
  const [customers, setCustomers] = useState<BookCustomer[]>([]);
  const [stats, setStats] = useState<Stats | null>(null);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busyId, setBusyId] = useState<number | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [filter, setFilter] = useState<'all' | 'unpaid' | 'paid_unshipped' | 'shipped'>('all');

  const [fullName, setFullName] = useState('');
  const [phone, setPhone] = useState('');
  const [email, setEmail] = useState('');
  const [address, setAddress] = useState('');
  const [bookType, setBookType] = useState('');
  const [note, setNote] = useState('');

  const PAGE_SIZE = 50;

  const load = useCallback(async (pageNum: number) => {
    setLoading(true);
    setError(null);
    try {
      const data = await get<{ customers: BookCustomer[]; total: number; stats: Stats }>(
        `/book-customers?limit=${PAGE_SIZE}&offset=${pageNum * PAGE_SIZE}`
      );
      setCustomers(data.customers);
      setTotal(data.total);
      setStats(data.stats);
    } catch {
      setError('Không tải được danh sách khách hàng.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { load(page); }, [page, load]);

  const resetForm = () => {
    setFullName(''); setPhone(''); setEmail(''); setAddress(''); setBookType(''); setNote('');
  };

  const create = async (e: FormEvent) => {
    e.preventDefault();
    if (!fullName.trim()) { setError('Vui lòng nhập họ tên.'); return; }
    setError(null);
    try {
      const res = await post<{ duplicates: { id: number; full_name: string }[] }>(
        '/book-customers',
        {
          full_name: fullName.trim(),
          phone: phone.trim() || null,
          email: email.trim() || null,
          address: address.trim() || null,
          book_type: bookType.trim() || null,
          note: note.trim() || null,
        }
      );
      if (res.duplicates?.length) {
        setError(`Đã thêm, nhưng có ${res.duplicates.length} khách hàng trùng số điện thoại/email: `
          + res.duplicates.map(d => `#${d.id} ${d.full_name}`).join(', '));
      }
      resetForm();
      setShowForm(false);
      setPage(0);
      load(0);
    } catch (err: any) {
      setError(err?.message || 'Không thêm được khách hàng.');
    }
  };

  const toggle = async (row: BookCustomer, field: 'payment' | 'shipping') => {
    setBusyId(row.id);
    setError(null);
    const current = field === 'payment' ? row.paid_at : row.shipped_at;
    try {
      await put(`/book-customers/${row.id}/${field}`, { value: !current });
      load(page);
    } catch (err: any) {
      setError(err?.message || 'Không cập nhật được trạng thái.');
    } finally {
      setBusyId(null);
    }
  };

  const remove = async (row: BookCustomer) => {
    if (!confirm(`Xoá khách hàng "${row.full_name}"?`)) return;
    setBusyId(row.id);
    try {
      await del(`/book-customers/${row.id}`);
      load(page);
    } catch (err: any) {
      setError(err?.message || 'Không xoá được khách hàng.');
    } finally {
      setBusyId(null);
    }
  };

  const shown = customers.filter(c => {
    if (filter === 'unpaid') return !c.paid_at;
    if (filter === 'paid_unshipped') return c.paid_at && !c.shipped_at;
    if (filter === 'shipped') return !!c.shipped_at;
    return true;
  });

  const totalPages = Math.ceil(total / PAGE_SIZE);

  if (loading && customers.length === 0) return <p><Spinner /> Đang tải...</p>;

  return (
    <div>
      <div className="admin-header">
        <h2>Khách hàng mua sách ({total})</h2>
        <button type="button" className="btn-submit"
                onClick={() => { setShowForm(!showForm); resetForm(); setError(null); }}>
          {showForm ? 'Huỷ' : '+ Thêm khách hàng'}
        </button>
      </div>

      {error && <p className="form-error" role="alert">{error}</p>}

      {stats && (
        <div className="customer-stats">
          <button type="button" className={`customer-stat ${filter === 'all' ? 'active' : ''}`}
                  onClick={() => setFilter('all')}>
            <span className="customer-stat-value">{stats.total}</span>
            <span className="customer-stat-label">Tổng</span>
          </button>
          <button type="button" className={`customer-stat ${filter === 'unpaid' ? 'active' : ''}`}
                  onClick={() => setFilter('unpaid')}>
            <span className="customer-stat-value">{stats.unpaid}</span>
            <span className="customer-stat-label">Chưa thanh toán</span>
          </button>
          <button type="button" className={`customer-stat ${filter === 'paid_unshipped' ? 'active' : ''}`}
                  onClick={() => setFilter('paid_unshipped')}>
            <span className="customer-stat-value">{stats.paidNotShipped}</span>
            <span className="customer-stat-label">Cần gửi sách</span>
          </button>
          <button type="button" className={`customer-stat ${filter === 'shipped' ? 'active' : ''}`}
                  onClick={() => setFilter('shipped')}>
            <span className="customer-stat-value">{stats.shipped}</span>
            <span className="customer-stat-label">Đã gửi</span>
          </button>
        </div>
      )}

      {showForm && (
        <form className="admin-form book-form" onSubmit={create}>
          <label className="book-form-field">
            Họ tên *
            <input value={fullName} onChange={e => setFullName(e.target.value)} required maxLength={200} />
          </label>
          <label className="book-form-field">
            Số điện thoại
            <input value={phone} onChange={e => setPhone(e.target.value)} maxLength={50} />
          </label>
          <label className="book-form-field">
            Email
            <input type="email" value={email} onChange={e => setEmail(e.target.value)} maxLength={200} />
          </label>
          <label className="book-form-field">
            Địa chỉ
            <textarea value={address} onChange={e => setAddress(e.target.value)} rows={2} maxLength={1000} />
          </label>
          <label className="book-form-field">
            Loại sách
            <input value={bookType} onChange={e => setBookType(e.target.value)} maxLength={200} />
          </label>
          <label className="book-form-field">
            Ghi chú
            <input value={note} onChange={e => setNote(e.target.value)} maxLength={1000} />
          </label>
          <button type="submit" className="btn-submit">Lưu khách hàng</button>
        </form>
      )}

      {shown.length === 0 ? (
        <p className="empty-state">
          {customers.length === 0 ? 'Chưa có khách hàng nào.' : 'Không có khách hàng nào trong mục này.'}
        </p>
      ) : (
        <div className="class-registrations-scroll">
          <table className="admin-table">
            <thead>
              <tr>
                <th>Thanh toán</th><th>Gửi sách</th><th>Họ tên</th><th>Điện thoại</th>
                <th>Email</th><th>Địa chỉ</th><th>Loại sách</th><th>Nguồn</th>
                <th>Ngày tạo</th><th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {shown.map(row => (
                <tr key={row.id}>
                  <td>
                    <button type="button" disabled={busyId === row.id}
                            onClick={() => toggle(row, 'payment')}
                            style={{ cursor: 'pointer', border: 'none', background: 'none', fontSize: 15 }}
                            title={row.paid_at ? 'Đã thanh toán' : 'Chưa thanh toán'}>
                      {busyId === row.id ? '…' : row.paid_at ? '✅' : '⬜'}
                    </button>
                  </td>
                  <td>
                    <button type="button" disabled={busyId === row.id}
                            onClick={() => toggle(row, 'shipping')}
                            style={{ cursor: 'pointer', border: 'none', background: 'none', fontSize: 15 }}
                            title={row.shipped_at ? 'Đã gửi sách' : 'Chưa gửi'}>
                      {busyId === row.id ? '…' : row.shipped_at ? '📦' : '⬜'}
                    </button>
                  </td>
                  <td>{row.full_name}</td>
                  <td>{row.phone || '—'}</td>
                  <td>{row.email || '—'}</td>
                  <td style={{ maxWidth: 220, whiteSpace: 'normal' }}>{row.address || '—'}</td>
                  <td>{row.book_type || '—'}</td>
                  <td><span className="customer-source">{SOURCE_LABELS[row.source] || row.source}</span></td>
                  <td>{new Date(row.created_at).toLocaleDateString('vi-VN')}</td>
                  <td>
                    <button className="btn-delete" type="button" disabled={busyId === row.id}
                            onClick={() => remove(row)}>Xoá</button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {totalPages > 1 && (
        <div className="pagination">
          <button disabled={page === 0} onClick={() => setPage(p => p - 1)}>← Trước</button>
          <span>{page + 1} / {totalPages}</span>
          <button disabled={page >= totalPages - 1} onClick={() => setPage(p => p + 1)}>Sau →</button>
        </div>
      )}
    </div>
  );
}
