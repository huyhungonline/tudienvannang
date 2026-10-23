import { useState, useEffect, useCallback, type FormEvent } from 'react';
import { get, post, put, del } from '../api/client';
import { Spinner } from '../components/Spinner';

interface ClassSessionRow {
  id: number;
  course: string;
  code: string;
  name: string;
  first_lesson_date: string | null;
  capacity: number;
  is_active: boolean;
  sort_order: number;
  registrations: number;
}

const COURSE_LABELS: Record<string, string> = {
  'it-passport': 'IT Passport miễn phí',
  'kikai-hozen': '機械保全技能検定',
};

export function ClassSessionsManagement() {
  const [sessions, setSessions] = useState<ClassSessionRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busyId, setBusyId] = useState<number | null>(null);
  const [showForm, setShowForm] = useState(false);

  const [course, setCourse] = useState('it-passport');
  const [code, setCode] = useState('');
  const [name, setName] = useState('');
  const [firstLesson, setFirstLesson] = useState('');
  const [capacity, setCapacity] = useState(110);
  const [sortOrder, setSortOrder] = useState(0);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const data = await get<{ sessions: ClassSessionRow[] }>('/classes/admin/sessions');
      setSessions(data.sessions);
    } catch {
      setError('Không tải được danh sách lớp học.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { load(); }, [load]);

  const resetForm = () => {
    setCode(''); setName(''); setFirstLesson(''); setCapacity(110); setSortOrder(0);
  };

  const create = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      await post('/classes/admin/sessions', {
        course,
        code: code.trim(),
        name: name.trim(),
        first_lesson_date: firstLesson || null,
        capacity,
        is_active: true,
        sort_order: sortOrder,
      });
      resetForm();
      setShowForm(false);
      load();
    } catch (err: any) {
      setError(err?.message || 'Không tạo được lớp học.');
    }
  };

  const toggleActive = async (row: ClassSessionRow) => {
    setBusyId(row.id);
    setError(null);
    try {
      await put(`/classes/admin/sessions/${row.id}`, { is_active: !row.is_active });
      load();
    } catch (err: any) {
      setError(err?.message || 'Không cập nhật được trạng thái.');
    } finally {
      setBusyId(null);
    }
  };

  const remove = async (row: ClassSessionRow) => {
    if (!confirm(`Xoá lớp "${row.name}"?`)) return;
    setBusyId(row.id);
    setError(null);
    try {
      await del(`/classes/admin/sessions/${row.id}`);
      load();
    } catch (err: any) {
      setError(err?.message || 'Không xoá được lớp học.');
    } finally {
      setBusyId(null);
    }
  };

  if (loading && sessions.length === 0) return <p><Spinner /> Đang tải...</p>;

  return (
    <div>
      <div className="admin-header">
        <h2>Quản lý lớp học ({sessions.length})</h2>
        <button type="button" className="btn-submit" onClick={() => { setShowForm(!showForm); resetForm(); }}>
          {showForm ? 'Huỷ' : '+ Thêm lớp học'}
        </button>
      </div>

      {error && <p className="form-error" role="alert">{error}</p>}

      <p className="certificate-usage-note">
        Lớp ở trạng thái không hoạt động sẽ không hiện trong trang đăng kí của học viên.
      </p>

      {showForm && (
        <form className="admin-form book-form" onSubmit={create}>
          <label className="book-form-field">
            Khoá học
            <select value={course} onChange={e => setCourse(e.target.value)}>
              {Object.entries(COURSE_LABELS).map(([value, label]) => (
                <option key={value} value={value}>{label}</option>
              ))}
            </select>
          </label>
          <label className="book-form-field">
            Mã lớp (chỉ chữ, số, - và _)
            <input value={code} onChange={e => setCode(e.target.value)}
                   placeholder="vd: thang-12-sat-tue" required maxLength={100} />
          </label>
          <label className="book-form-field">
            Tên lớp hiển thị
            <input value={name} onChange={e => setName(e.target.value)}
                   placeholder="vd: Lớp tháng 12 — Thứ 7 và thứ 3 từ 20h–22h" required maxLength={200} />
          </label>
          <label className="book-form-field">
            Ngày học đầu tiên
            <input type="date" value={firstLesson} onChange={e => setFirstLesson(e.target.value)} />
          </label>
          <label className="book-form-field">
            Số lượng tối đa
            <input type="number" min={1} max={10000} value={capacity}
                   onChange={e => setCapacity(Number(e.target.value))} required />
          </label>
          <label className="book-form-field">
            Thứ tự hiển thị
            <input type="number" value={sortOrder} onChange={e => setSortOrder(Number(e.target.value))} />
          </label>
          <button type="submit" className="btn-submit">Tạo lớp học</button>
        </form>
      )}

      {sessions.length === 0 ? (
        <p className="empty-state">Chưa có lớp học nào.</p>
      ) : (
        <div className="class-registrations-scroll">
          <table className="admin-table">
            <thead>
              <tr>
                <th>Trạng thái</th><th>Khoá</th><th>Tên lớp</th><th>Mã</th>
                <th>Buổi đầu</th><th>Đã đăng kí</th><th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {sessions.map(row => (
                <tr key={row.id} style={{ opacity: row.is_active ? 1 : 0.55 }}>
                  <td>
                    <button type="button" disabled={busyId === row.id}
                            onClick={() => toggleActive(row)}
                            style={{ cursor: 'pointer', border: 'none', background: 'none', fontSize: 15 }}
                            title={row.is_active ? 'Đang mở đăng kí — bấm để đóng' : 'Đang đóng — bấm để mở'}>
                      {busyId === row.id ? '…' : row.is_active ? '✅ Mở' : '❌ Đóng'}
                    </button>
                  </td>
                  <td>{COURSE_LABELS[row.course] || row.course}</td>
                  <td>{row.name}</td>
                  <td><code>{row.code}</code></td>
                  <td>{row.first_lesson_date ? new Date(row.first_lesson_date).toLocaleDateString('vi-VN') : '—'}</td>
                  <td>{row.registrations}/{row.capacity}</td>
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
    </div>
  );
}
