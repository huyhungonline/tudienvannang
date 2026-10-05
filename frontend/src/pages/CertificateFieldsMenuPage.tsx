import { Link } from 'react-router-dom';
import { CERTIFICATE_CATEGORIES } from '../constants/certificateCategories';

export function CertificateFieldsMenuPage() {
  return (
    <div className="reading-posts-page certificate-page">
      <h2>Luyện thi chứng chỉ chuyên ngành</h2>
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
