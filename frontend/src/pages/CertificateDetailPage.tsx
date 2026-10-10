import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get } from '../api/client';
import { Spinner } from '../components/Spinner';

interface Certificate {
  id: number;
  code: string;
  category: string;
  name_ja: string;
  name_vi: string | null;
  related_occupations: string | null;
}

export function CertificateDetailPage() {
  const { category, code } = useParams<{ category: string; code: string }>();
  const [certificate, setCertificate] = useState<Certificate | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!code) return;
    setLoading(true);
    setError(null);
    get<Certificate>(`/certificates/${code}`)
      .then(setCertificate)
      .catch(() => setError('Failed to load certificate.'))
      .finally(() => setLoading(false));
  }, [code]);

  if (loading) {
    return (
      <div className="reading-posts-page certificate-page">
        <p className="loading-text"><Spinner /> Loading...</p>
      </div>
    );
  }

  if (error || !certificate) {
    return (
      <div className="reading-posts-page certificate-page">
        <div className="form-error">{error || 'Certificate not found.'}</div>
      </div>
    );
  }

  return (
    <div className="reading-posts-page certificate-page">
      <h2>{certificate.name_ja}</h2>
      {certificate.name_vi && <p className="certificate-subtitle">{certificate.name_vi}</p>}
      {certificate.related_occupations && (
        <p className="certificate-occupations">
          <strong>Ngành nghề liên quan:</strong> {certificate.related_occupations}
        </p>
      )}

      <div className="certificate-choice">
        <Link to={`/certificates/${category}/${code}/vocabulary`} className="certificate-choice-card">
          <h3>📚 Từ vựng chuyên ngành</h3>
          <p>Specialized vocabulary</p>
        </Link>
        <Link to={`/certificates/${category}/${code}/exam`} className="certificate-choice-card">
          <h3>📝 Giải đề các năm</h3>
          <p>Practice exams</p>
        </Link>
      </div>
    </div>
  );
}
