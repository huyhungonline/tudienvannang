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
          ) : null}
          <div className="upgrade-payment-instructions">
            <p>Để nâng cấp tài khoản Pro, quý khách vui lòng thực hiện theo các bước sau:</p>
            <ol>
              <li>
                Thanh toán chuyển khoản vào tài khoản sau:
                <br />Ngân hàng: BIDV
                <br />Số TK: 8865150623
                <br />Chủ TK: NGUYEN HUY HUNG
                <br />Nội dung chuyển khoản: nhập email bạn đã đăng ký tài khoản
              </li>
            </ol>
            <p>Nếu sau hai tiếng tài khoản chưa được nâng cấp Pro, vui lòng liên hệ <strong>Táo giáo dục</strong>.</p>
          </div>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}
