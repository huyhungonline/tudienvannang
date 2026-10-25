import { useEffect, useRef, useState, type FormEvent } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ApiError, get, post } from '../api/client';

export const CLASS_NAMES: Record<string, string> = {
  'it-passport': 'Đăng kí luyện thi IT Passport miễn phí',
  'kikai-hozen': 'Đăng kí luyện thi 機械保全技能検定',
};

/**
 * Labels for the two original November classes. Classes are now managed in the
 * database, so this only serves as a fallback when displaying historical
 * registrations whose class row has since been renamed or removed.
 */
export const CLASS_SCHEDULES: Record<string, string> = {
  'sat-tue-20-22': 'Thứ 7 và thứ 3 từ 20h–22h',
  'sun-thu-20-22': 'Chủ nhật và thứ 5 từ 20h–22h',
};

export interface ClassSession {
  code: string;
  name: string;
  firstLessonDate: string | null;
  capacity: number;
  taken: number;
  isFull: boolean;
}

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
  const navigate = useNavigate();
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [schedule, setSchedule] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [saved, setSaved] = useState(false);
  const [sessions, setSessions] = useState<ClassSession[]>([]);
  const [sessionsLoading, setSessionsLoading] = useState(course === 'it-passport');
  const attempt = useRef<{ fingerprint: string; id: string } | null>(null);
  const title = CLASS_NAMES[course];

  // Only IT Passport offers selectable classes.
  useEffect(() => {
    if (course !== 'it-passport') return;
    setSessionsLoading(true);
    get<{ sessions: ClassSession[] }>(`/classes/sessions?course=${course}`)
      .then((data) => setSessions(data.sessions))
      .catch(() => setError('Không tải được danh sách lớp học.'))
      .finally(() => setSessionsLoading(false));
  }, [course]);

  const submit = async (event: FormEvent) => {
    event.preventDefault();
    if (loading) return;
    const goToWorkbook = (event.nativeEvent as SubmitEvent).submitter?.getAttribute('value') === 'workbook';
    setError('');
    const payload = { course, full_name: fullName.trim(), email: email.trim(), phone: phone.trim(), schedule: course === 'it-passport' ? schedule : null };
    if (course === 'it-passport' && !sessions.some((s) => s.code === schedule)) { setError('Vui lòng chọn lớp học.'); return; }
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
      if (goToWorkbook) navigate('/dang-ki-in-sach-bai-tap', { state: { fullName: payload.full_name, email: payload.email } });
    } catch (error) {
      setError(error instanceof ApiError && error.status === 409 && error.message === 'Lớp đã đầy, vui lòng chọn khung giờ khác'
        ? error.message
        : 'Chưa thể xác nhận đăng kí. Vui lòng thử lại; hệ thống sẽ tránh lưu trùng yêu cầu.');
    }
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
            <select id="class-schedule" name="schedule" required value={schedule}
                    disabled={sessionsLoading || sessions.length === 0}
                    onChange={e => setSchedule(e.target.value)}>
              <option value="">
                {sessionsLoading ? 'Đang tải danh sách lớp...'
                  : sessions.length === 0 ? '-- Hiện chưa có lớp nào mở đăng kí --'
                  : '-- Chọn lớp --'}
              </option>
              {sessions.map((s) => (
                <option key={s.code} value={s.code} disabled={s.isFull}>
                  {s.name}{s.isFull ? ' (đã đầy)' : ''}
                </option>
              ))}
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
            <button type="submit" name="action" value="workbook" className="btn-submit" disabled={loading}>Đăng kí in sách bài tập</button>
            <p>Không bắt buộc.</p>
          </div>}
          <div className="class-registration-actions">
            <button type="submit" className="btn-submit" disabled={loading}>{loading ? 'Đang đăng kí...' : 'Đăng kí lớp học'}</button>
            {course === 'it-passport' && <a className="btn-submit" href="/downloads/IT_Passport_Khoa_Hoc_Mien_Phi_46_Slide.pdf" download="IT_Passport_Khoa_Hoc_Mien_Phi_46_Slide.pdf">📥 Download bài giảng</a>}
          </div>
        </form>
      ))}
      {course === 'it-passport' && saved && <div className="workbook-option">
        <Link className="btn-submit" to="/dang-ki-in-sach-bai-tap">Đăng kí in sách bài tập</Link>
        <p>Không bắt buộc.</p>
      </div>}
    </div>
  );
}
