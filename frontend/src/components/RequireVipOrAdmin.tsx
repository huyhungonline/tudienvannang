import type { ReactNode } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export function RequireVipOrAdmin({ children }: { children: ReactNode }) {
  const { isAuthenticated, user } = useAuth();
  const hasAccess = isAuthenticated && (user?.isAdmin || user?.isVip);

  if (!hasAccess) {
    return (
      <div className="reading-posts-page certificate-page">
        <div className="upgrade-required">
          <h2>🔒 Tính năng dành cho tài khoản Pro</h2>
          <p>Bạn cần nâng cấp lên tài khoản Pro (hoặc Admin) để sử dụng tính năng luyện thi chứng chỉ chuyên ngành.</p>
          {!isAuthenticated ? (
            <p><Link to="/login">Đăng nhập</Link> hoặc <Link to="/register">Đăng ký</Link> để tiếp tục.</p>
          ) : (
            <p>Vui lòng liên hệ quản trị viên để nâng cấp tài khoản lên Pro.</p>
          )}
        </div>
      </div>
    );
  }

  return <>{children}</>;
}
