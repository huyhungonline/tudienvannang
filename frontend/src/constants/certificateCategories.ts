export interface CertificateCategory {
  code: string;
  labelJa: string;
  labelVi: string;
  labelEn: string;
}

export const CERTIFICATE_CATEGORIES: CertificateCategory[] = [
  { code: 'cokhi', labelJa: '機械系', labelVi: 'Cơ khí, CNC, vận hành máy, đúc', labelEn: 'Mechanical, CNC, Machine Operation, Casting' },
  { code: 'dien', labelJa: '電気系', labelVi: 'Điện, cơ điện tử, PLC, vận hành điện', labelEn: 'Electrical, Mechatronics, PLC, Electrical Operation' },
  { code: 'xaydung', labelJa: '建築系', labelVi: 'Xây dựng, kiến trúc, giàn giáo', labelEn: 'Construction, Architecture, Scaffolding' },
  { code: 'thucpham', labelJa: '食品系', labelVi: 'Thực phẩm, quản lý sản xuất', labelEn: 'Food, Production Management' },
  { code: 'itpp', labelJa: 'ITパスポート', labelVi: 'IT Passport', labelEn: 'IT Passport' },
];
