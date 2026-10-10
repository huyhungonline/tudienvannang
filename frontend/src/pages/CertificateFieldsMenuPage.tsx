import { useState } from 'react';
import { Link } from 'react-router-dom';
import { CERTIFICATE_CATEGORIES } from '../constants/certificateCategories';
import { CERTIFICATE_LIST } from '../constants/certificateList';

export function CertificateFieldsMenuPage() {
  const [showList, setShowList] = useState(false);

  return (
    <div className="reading-posts-page certificate-page">
      <h2>Thi chứng chỉ tại Nhật</h2>
      <p className="certificate-page-desc">
        Luyện thi các chứng chỉ nghề của Nhật Bản bằng tiếng Nhật: học từ vựng chuyên ngành theo chủ đề
        và làm đề thi thử có đáp án, bản dịch, giải thích chi tiết.
      </p>
      <div className="certificate-usage-guide">
        <strong>Cách sử dụng:</strong>
        <ol>
          <li>Chọn lĩnh vực bạn quan tâm bên dưới</li>
          <li>Chọn chứng chỉ muốn luyện trong danh sách</li>
          <li>Chọn <strong>"Từ vựng chuyên ngành"</strong> để học từ theo chủ đề, hoặc <strong>"Giải đề các năm"</strong> để luyện đề thi</li>
          <li>Ở phần đề thi, đọc câu hỏi tiếng Nhật rồi bấm <strong>"Show answer"</strong> để xem đáp án, bản dịch và giải thích</li>
        </ol>
        <p className="certificate-usage-note">Lưu ý: tính năng này dành riêng cho tài khoản Pro hoặc Admin.</p>
      </div>
      <p className="certificate-recommend-line">
        Xem danh sách các chứng chỉ nên luyện thi{' '}
        <button type="button" className="certificate-recommend-btn" onClick={() => setShowList(true)}>
          Tại đây
        </button>
      </p>
      <div className="certificate-list">
        {CERTIFICATE_CATEGORIES.map((cat) => (
          <Link key={cat.code} to={`/certificates/${cat.code}`} className="certificate-card">
            <h3>{cat.labelJa}</h3>
            <p>{cat.labelVi}</p>
          </Link>
        ))}
      </div>
      {showList && (
        <div className="cert-modal-overlay" onClick={() => setShowList(false)}>
          <div className="cert-modal" role="dialog" aria-modal="true" onClick={(e) => e.stopPropagation()}>
            <div className="cert-modal-header">
              <h3>Danh sách chứng chỉ nên luyện thi (điểm HSP)</h3>
              <button type="button" className="cert-modal-close" onClick={() => setShowList(false)} aria-label="Đóng">×</button>
            </div>
            <div className="cert-modal-body">
              <table className="cert-list-table">
                <thead>
                  <tr>
                    <th>STT</th><th>Tên chứng chỉ</th><th>Dịch tên</th><th>Hình thức thi</th>
                    <th>Thực hành / tự luận</th><th>HSP +5?</th><th>Ghi chú</th>
                  </tr>
                </thead>
                <tbody>
                  {CERTIFICATE_LIST.map((c) => (
                    <tr key={c.no}>
                      <td>{c.no}</td><td>{c.ja}</td><td>{c.vi}</td><td>{c.format}</td>
                      <td>{c.practical}</td><td>{c.hsp}</td><td>{c.note}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
              <p className="certificate-usage-note">
                ◎ cơ sở mạnh; ○ thuộc 技能士; △ cần xác nhận; × không mặc định tính +5; ※ phân biệt 技士補. Cần liên quan công việc thực tế.
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
