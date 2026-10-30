export interface ExamPdfAsset {
  type: string;
  url: string;
  pages: number[];
}

export interface ExamPdfReferences {
  assets?: ExamPdfAsset[];
  passage?: { assets?: ExamPdfAsset[]; text?: { ja: string; vi?: string } } | null;
}

export function ExamPdfLinks({ assets, passage }: ExamPdfReferences) {
  const links = [...(assets ?? []), ...(passage?.assets ?? [])];
  const pages = new Map<string, { url: string; page: number }>();
  for (const asset of links) {
    for (const page of asset.pages) {
      pages.set(`${asset.url}#page=${page}`, { url: asset.url, page });
    }
  }
  if (!pages.size) return null;
  return (
    <p className="exam-pdf-links">
      Xem hình/bảng trong đề gốc:{' '}
      {[...pages].map(([href, item]) => (
        <a key={href} href={href} target="_blank" rel="noreferrer" style={{ marginRight: 12 }}>
          Trang {item.page}
        </a>
      ))}
    </p>
  );
}
