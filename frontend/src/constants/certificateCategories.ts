export interface CertificateCategory {
  code: string;
  labelVi: string;
  labelEn: string;
}

export const CERTIFICATE_CATEGORIES: CertificateCategory[] = [
  { code: 'cokhi', labelVi: 'Cơ khí, CNC, vận hành máy, đúc', labelEn: 'Mechanical, CNC, Machine Operation, Casting' },
  { code: 'dien', labelVi: 'Điện, cơ điện tử, PLC, vận hành điện', labelEn: 'Electrical, Mechatronics, PLC, Electrical Operation' },
  { code: 'xaydung', labelVi: 'Xây dựng, kiến trúc, giàn giáo', labelEn: 'Construction, Architecture, Scaffolding' },
  { code: 'thucpham', labelVi: 'Thực phẩm, quản lý sản xuất', labelEn: 'Food, Production Management' },
];
