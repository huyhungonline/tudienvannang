import { Link } from 'react-router-dom';
import { CERTIFICATE_CATEGORIES } from '../constants/certificateCategories';

export function CertificateFieldsMenuPage() {
  return (
    <div className="reading-posts-page certificate-page">
      <h2>Chuyên ngành</h2>
      <div className="certificate-list">
        {CERTIFICATE_CATEGORIES.map((cat) => (
          <Link key={cat.code} to={`/certificates/${cat.code}`} className="certificate-card">
            <h3>{cat.labelVi}</h3>
          </Link>
        ))}
      </div>
    </div>
  );
}
