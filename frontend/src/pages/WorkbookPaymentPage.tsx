import { useRef, useState, type FormEvent } from 'react';
import { Link } from 'react-router-dom';
import { post } from '../api/client';

export function WorkbookPaymentPage() {
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [address, setAddress] = useState('');
  const [loading, setLoading] = useState(false);
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState('');
  const attempt = useRef<{ fingerprint: string; id: string } | null>(null);

  async function submit(event: FormEvent) {
    event.preventDefault();
    if (loading) return;
    const payload = { full_name: fullName.trim(), email: email.trim(), book_address: address.trim() };
    if (!payload.full_name || !payload.book_address) { setError('Vui lòng nhập đầy đủ thông tin.'); return; }
    const fingerprint = JSON.stringify(payload);
    if (attempt.current?.fingerprint !== fingerprint) attempt.current = { fingerprint, id: crypto.randomUUID() };
    setLoading(true);
    setError('');
    try {
      await post('/classes/workbook-orders', { ...payload, request_id: attempt.current!.id });
      setSaved(true);
    } catch { setError('Chưa thể lưu đăng kí in sách. Vui lòng thử lại.'); }
    finally { setLoading(false); }
  }

  return <div className="class-registration-page">
    <Link className="btn-back" to="/dang-ki-lop-hoc/it-passport">← Đăng kí lớp IT Passport</Link>
    <h2>Đăng kí in sách bài tập — Thanh toán</h2>
    {!saved && <p>Không bắt buộc.</p>}
    {saved ? <p role="status">Đã lưu đăng kí in sách của bạn. Vui lòng chuyển khoản theo thông tin bên dưới.</p> :
      <form className="class-registration-form" onSubmit={submit}>
        <label htmlFor="workbook-name">Họ tên</label>
        <input id="workbook-name" autoComplete="name" required maxLength={150} value={fullName} onChange={e => setFullName(e.target.value)} />
        <label htmlFor="workbook-email">Email bạn đã đăng ký</label>
        <input id="workbook-email" type="email" autoComplete="email" required maxLength={254} value={email} onChange={e => setEmail(e.target.value)} />
        <label htmlFor="workbook-address">Nhập địa chỉ nhận sách bài tập &amp; luyện đề (bản dịch tiếng Việt)</label>
        <textarea id="workbook-address" aria-describedby="workbook-address-hint" autoComplete="street-address" required maxLength={1000} rows={4} value={address} onChange={e => setAddress(e.target.value)} />
        <small id="workbook-address-hint">Địa chỉ ở Nhật.</small>
        {error && <p className="form-error" role="alert">{error}</p>}
        <button className="btn-submit" type="submit" disabled={loading}>{loading ? 'Đang lưu...' : 'Lưu đăng kí in sách'}</button>
      </form>}
    <section className="workbook-payment">
      <h3>Thông tin thanh toán</h3>
      <p>Thanh toán chuyển khoản vào tài khoản sau:</p>
      <p>Phí photo tài liệu: <strong>350.000 đồng</strong></p>
      <p>Ngân hàng: <strong>BIDV</strong></p>
      <p>Số TK: <strong>8865150623</strong></p>
      <p>Chủ TK: <strong>NGUYEN HUY HUNG</strong></p>
      <p>Nội dung chuyển khoản: nhập email bạn đã đăng ký</p>
    </section>
  </div>;
}
