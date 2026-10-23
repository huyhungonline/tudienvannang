import type { ReactNode } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

interface RequireVipOrAdminProps {
  children: ReactNode;
  /** Membership fee shown in the upgrade notice. Varies per feature. */
  feeLabel?: string;
  /** Name of the feature being gated, used in the explanatory sentence. */
  featureName?: string;
}

export function RequireVipOrAdmin({
  children,
  feeLabel = '200.000 đồng',
  featureName = 'luyện thi chứng chỉ chuyên ngành',
}: RequireVipOrAdminProps) {
  const { isAuthenticated, user } = useAuth();
  const hasAccess = isAuthenticated && (user?.isAdmin || user?.isVip);

  if (!hasAccess) {
    return (
      <div className="reading-posts-page certificate-page">
        <div className="upgrade-required">
          <h2>🔒 Tính năng dành cho tài khoản Pro</h2>
          <p>Bạn cần nâng cấp lên tài khoản Pro (hoặc Admin) để sử dụng tính năng {featureName}.</p>
          {!isAuthenticated ? (
            <p><Link to="/login">Đăng nhập</Link> hoặc <Link to="/register">Đăng ký</Link> để tiếp tục.</p>
          ) : null}
          <div className="upgrade-payment-instructions">
            <p>Để nâng cấp tài khoản Pro, quý khách vui lòng thực hiện theo các bước sau:</p>
            <ol>
              <li>
                Thanh toán chuyển khoản vào tài khoản sau:
                <br />Phí hội viên: <strong>{feeLabel}</strong>
                <br />Ngân hàng: BIDV
                <br />Số TK: 8865150623
                <br />Chủ TK: NGUYEN HUY HUNG
                <br />Nội dung chuyển khoản: <strong>nhập email bạn đã đăng ký tài khoản</strong>
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
