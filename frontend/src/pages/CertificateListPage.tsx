import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get } from '../api/client';
import { CERTIFICATE_CATEGORIES } from '../constants/certificateCategories';
import { Spinner } from '../components/Spinner';

interface Certificate {
  id: number;
  code: string;
  category: string;
  name_ja: string;
  name_vi: string | null;
}

export function CertificateListPage() {
  const { category } = useParams<{ category: string }>();
  const [certificates, setCertificates] = useState<Certificate[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const categoryInfo = CERTIFICATE_CATEGORIES.find((c) => c.code === category);

  useEffect(() => {
    if (!category) return;
    setLoading(true);
    setError(null);
    get<{ certificates: Certificate[] }>(`/certificates?category=${category}`)
      .then((data) => setCertificates(data.certificates))
      .catch(() => setError('Failed to load certificates.'))
      .finally(() => setLoading(false));
  }, [category]);

  return (
    <div className="reading-posts-page certificate-page">
      <h2>{categoryInfo?.labelEn || 'Professional Field'}</h2>

      {error && <div className="form-error">{error}</div>}

      {loading ? (
        <p className="loading-text"><Spinner /> Loading...</p>
      ) : certificates.length === 0 ? (
        <p className="empty-state">No certificates available in this field yet.</p>
      ) : (
        <div className="certificate-list">
          {certificates.map((c) => (
            <Link key={c.id} to={`/certificates/${category}/${c.code}`} className="certificate-card">
              <h3>{c.name_ja}</h3>
              {c.name_vi && <p>{c.name_vi}</p>}
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
