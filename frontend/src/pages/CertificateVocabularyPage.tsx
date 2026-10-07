import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get } from '../api/client';
import { Spinner } from '../components/Spinner';

interface VocabEntry {
  term: string;
  reading: string;
  meaningVi: string;
  exampleJa: string;
  exampleReading: string;
  exampleVi: string;
}

interface VocabCategory {
  categoryNo: number;
  categoryName: string;
  entries: VocabEntry[];
}

export function CertificateVocabularyPage() {
  const { category, code } = useParams<{ category: string; code: string }>();
  const [categories, setCategories] = useState<VocabCategory[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeCategory, setActiveCategory] = useState<number | null>(null);

  useEffect(() => {
    if (!code) return;
    setLoading(true);
    setError(null);
    get<{ categories: VocabCategory[] }>(`/certificates/${code}/vocabulary`)
      .then((data) => {
        setCategories(data.categories);
        setActiveCategory(data.categories[0]?.categoryNo ?? null);
      })
      .catch(() => setError('Failed to load vocabulary.'))
      .finally(() => setLoading(false));
  }, [code]);

  if (loading) {
    return (
      <div className="reading-posts-page certificate-page">
        <p className="loading-text"><Spinner /> Loading...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="reading-posts-page certificate-page">
        <div className="form-error">{error}</div>
      </div>
    );
  }

  const current = categories.find((c) => c.categoryNo === activeCategory);

  return (
    <div className="reading-posts-page certificate-page certificate-vocab-page">
      <Link to={`/certificates/${category}/${code}`} className="btn-back">← Quay lại</Link>
      <h2>Từ vựng chuyên ngành</h2>

      <div className="vocab-category-tabs">
        {categories.map((c) => (
          <button
            key={c.categoryNo}
            className={`vocab-category-tab ${activeCategory === c.categoryNo ? 'active' : ''}`}
            onClick={() => setActiveCategory(c.categoryNo)}
          >
            {c.categoryNo}. {c.categoryName}
          </button>
        ))}
      </div>

      {current && (
        <table className="result-table vocab-table">
          <thead>
            <tr>
              <th>Từ/cụm từ</th>
              <th>Cách đọc</th>
              <th>Nghĩa tiếng Việt</th>
              <th>Câu ví dụ</th>
            </tr>
          </thead>
          <tbody>
            {current.entries.map((e, idx) => (
              <tr key={idx}>
                <td className="word-cell">{e.term}</td>
                <td>{e.reading}</td>
                <td>{e.meaningVi}</td>
                <td className="vocab-example-cell">
                  {e.exampleJa && <div>{e.exampleJa}</div>}
                  {e.exampleReading && <div className="vocab-example-reading">{e.exampleReading}</div>}
                  {e.exampleVi && <div className="vocab-example-vi">Dịch: {e.exampleVi}</div>}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}
