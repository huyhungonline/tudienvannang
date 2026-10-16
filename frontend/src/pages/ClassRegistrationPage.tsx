import { useRef, useState, type FormEvent } from 'react';
import { Link, useParams } from 'react-router-dom';
import { post } from '../api/client';

export const CLASS_NAMES: Record<string, string> = {
  'it-passport': 'Đăng kí luyện thi IT Passport miễn phí',
  'kikai-hozen': 'Đăng kí luyện thi 機械保全技能検定',
};

export const CLASS_SCHEDULES: Record<string, string> = {
  'sat-tue-20-22': 'Thứ 7 và thứ 3 từ 20h–22h',
  'sun-thu-20-22': 'Chủ nhật và thứ 5 từ 20h–22h',
};

export function ClassRegistrationPage() {
  return (
    <div className="class-registration-page">
      <h2>Đăng kí lớp học</h2>
      <ol className="class-registration-menu">
        {Object.entries(CLASS_NAMES).map(([code, title]) => (
          <li key={code}><Link to={`/dang-ki-lop-hoc/${code}`}>{title}</Link></li>
        ))}
      </ol>
    </div>
  );
}

export function ClassRegistrationFormPage() {
  const { course = '' } = useParams<{ course: string }>();
  return <ClassRegistrationForm key={course} course={course} />;
}

function ClassRegistrationForm({ course }: { course: string }) {
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [schedule, setSchedule] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [saved, setSaved] = useState(false);
  const attempt = useRef<{ fingerprint: string; id: string } | null>(null);
  const title = CLASS_NAMES[course];

  const submit = async (event: FormEvent) => {
    event.preventDefault();
    if (loading) return;
    setError('');
    const payload = { course, full_name: fullName.trim(), email: email.trim(), phone: phone.trim(), schedule: course === 'it-passport' ? schedule : null };
    if (course === 'it-passport' && !CLASS_SCHEDULES[schedule]) { setError('Vui lòng chọn lớp học.'); return; }
    if (!payload.full_name) { setError('Vui lòng nhập đầy đủ thông tin.'); return; }
    const digits = payload.phone.replace(/\D/g, '').length;
    if (digits < 6 || digits > 15 || !/^[\d+().\s-]+$/.test(payload.phone)) {
      setError('Vui lòng nhập số điện thoại hợp lệ (6–15 chữ số).'); return;
    }
    const fingerprint = JSON.stringify(payload);
    if (attempt.current?.fingerprint !== fingerprint) attempt.current = { fingerprint, id: crypto.randomUUID() };
    setLoading(true);
    try {
      await post('/classes/registrations', { ...payload, request_id: attempt.current!.id });
      setSaved(true);
    } catch { setError('Chưa thể xác nhận đăng kí. Vui lòng thử lại; hệ thống sẽ tránh lưu trùng yêu cầu.'); }
    finally { setLoading(false); }
  };

  return (
    <div className="class-registration-page">
      <Link to="/dang-ki-lop-hoc" className="btn-back">← Danh sách lớp học</Link>
      <h2>{title || 'Không tìm thấy lớp học'}</h2>
      {title && (saved ? <p className="subscribe-success" role="status">Đã nhận đăng kí của bạn. Thông tin đã được lưu để liên hệ.</p> : (
        <form className="class-registration-form" onSubmit={submit}>
          {course === 'it-passport' && <>
            <label htmlFor="class-schedule">Chọn lớp</label>
            <select id="class-schedule" name="schedule" required value={schedule} onChange={e => setSchedule(e.target.value)}>
              <option value="">-- Chọn lớp --</option>
              {Object.entries(CLASS_SCHEDULES).map(([code, label]) => <option key={code} value={code}>{label}</option>)}
            </select>
          </>}
          <label htmlFor="class-full-name">Họ tên</label>
          <input id="class-full-name" name="name" autoComplete="name" required maxLength={150} value={fullName} onChange={e => setFullName(e.target.value)} />
          <label htmlFor="class-email">Email</label>
          <input id="class-email" name="email" type="email" autoComplete="email" required value={email} onChange={e => setEmail(e.target.value)} />
          <label htmlFor="class-phone">Số điện thoại</label>
          <input id="class-phone" name="phone" type="tel" autoComplete="tel" required maxLength={30} value={phone} onChange={e => setPhone(e.target.value)} />
          {error && <p className="form-error" role="alert">{error}</p>}
          {course === 'it-passport' && <div className="workbook-option">
            <Link className="btn-submit" to="/dang-ki-in-sach-bai-tap">Đăng kí in sách bài tập</Link>
            <p>Không bắt buộc.</p>
          </div>}
          <button type="submit" className="btn-submit" disabled={loading}>{loading ? 'Đang đăng kí...' : 'Đăng kí lớp học'}</button>
        </form>
      ))}
      {course === 'it-passport' && saved && <div className="workbook-option">
        <Link className="btn-submit" to="/dang-ki-in-sach-bai-tap">Đăng kí in sách bài tập</Link>
        <p>Không bắt buộc.</p>
      </div>}
    </div>
  );
}
