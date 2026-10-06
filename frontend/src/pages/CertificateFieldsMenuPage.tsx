import { Link } from 'react-router-dom';
import { CERTIFICATE_CATEGORIES } from '../constants/certificateCategories';

export function CertificateFieldsMenuPage() {
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
          <li>Chọn <strong>"Từ vựng chuyên ngành"</strong> để học từ theo chủ đề, hoặc <strong>"Bài tập / Giải đề"</strong> để luyện đề thi</li>
          <li>Ở phần đề thi, đọc câu hỏi tiếng Nhật rồi bấm <strong>"Show answer"</strong> để xem đáp án, bản dịch và giải thích</li>
        </ol>
        <p className="certificate-usage-note">Lưu ý: tính năng này dành riêng cho tài khoản Pro hoặc Admin.</p>
      </div>
      <div className="certificate-list">
        {CERTIFICATE_CATEGORIES.map((cat) => (
          <Link key={cat.code} to={`/certificates/${cat.code}`} className="certificate-card">
            <h3>{cat.labelJa}</h3>
            <p>{cat.labelVi}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}
