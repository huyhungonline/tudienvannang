export interface CertificateCategory {
  code: string;
  labelEn: string;
}

export const CERTIFICATE_CATEGORIES: CertificateCategory[] = [
  { code: 'cokhi', labelEn: 'Mechanical, CNC, Machine Operation, Casting' },
  { code: 'dien', labelEn: 'Electrical, Mechatronics, PLC, Electrical Operation' },
  { code: 'xaydung', labelEn: 'Construction, Architecture, Scaffolding' },
  { code: 'thucpham', labelEn: 'Food, Production Management' },
];
