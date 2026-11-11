import { useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const MENU = [
  { to: '/my-page/searches', title: 'Lịch sử tra cứu', desc: 'Các đoạn văn bạn đã lưu để dịch lại' },
  { to: '/my-page/exams', title: 'Lịch sử thi', desc: 'Kết quả các lần thi thử chứng chỉ' },
];

export function MyPage() {
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();

  useEffect(() => {
    if (!isAuthenticated) navigate('/login');
  }, [isAuthenticated, navigate]);

  if (!isAuthenticated) return null;

  return (
    <div className="history-page">
      <h2>My Page</h2>
      <div className="certificate-list">
        {MENU.map((item) => (
          <Link key={item.to} to={item.to} className="certificate-card">
            <h3>{item.title}</h3>
            <p>{item.desc}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}
