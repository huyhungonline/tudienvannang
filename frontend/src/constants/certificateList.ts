export interface CertificateListItem {
  no: number;
  ja: string;
  vi: string;
  format: string;
  practical: string;
  hsp: string;
  note: string;
}

// Nguồn: doccument/danh_sach_chung_chi_Nhat_HSP_day_du (1).md
export const CERTIFICATE_LIST: CertificateListItem[] = [
  {
    "no": 1,
    "ja": "機械保全技能士（機械系保全作業）",
    "vi": "Chứng chỉ kỹ năng bảo trì máy móc -- hệ cơ khí",
    "format": "○× / 択一 + 実技",
    "practical": "判断等試験",
    "hsp": "○",
    "note": "技能士; cần liên quan công việc"
  },
  {
    "no": 2,
    "ja": "機械保全技能士（電気系保全作業）",
    "vi": "Chứng chỉ kỹ năng bảo trì máy móc -- hệ điện",
    "format": "○× / 択一 + 実技",
    "practical": "Có thực hành điện",
    "hsp": "○",
    "note": "技能士; cần liên quan công việc"
  },
  {
    "no": 3,
    "ja": "機械検査技能士",
    "vi": "Chứng chỉ kỹ năng kiểm tra cơ khí",
    "format": "○× / 択一 + 実技",
    "practical": "Đo kiểm",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 4,
    "ja": "機械加工技能士（普通旋盤作業）",
    "vi": "Chứng chỉ kỹ năng gia công cơ khí -- tiện thường",
    "format": "○× / 択一 + 実技",
    "practical": "Tiện thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 5,
    "ja": "機械加工技能士（数値制御旋盤作業）",
    "vi": "Chứng chỉ kỹ năng gia công cơ khí -- tiện CNC",
    "format": "○× / 択一 + 実技",
    "practical": "CNC",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 6,
    "ja": "機械加工技能士（フライス盤作業）",
    "vi": "Chứng chỉ kỹ năng gia công cơ khí -- máy phay",
    "format": "○× / 択一 + 実技",
    "practical": "Phay thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 7,
    "ja": "機械加工技能士（マシニングセンタ作業）",
    "vi": "Chứng chỉ kỹ năng gia công cơ khí -- machining center",
    "format": "○× / 択一 + 実技",
    "practical": "CNC",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 8,
    "ja": "仕上げ技能士",
    "vi": "Chứng chỉ kỹ năng hoàn thiện và lắp ráp cơ khí",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 9,
    "ja": "金型製作技能士",
    "vi": "Chứng chỉ kỹ năng chế tạo khuôn",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 10,
    "ja": "金属プレス加工技能士",
    "vi": "Chứng chỉ kỹ năng gia công dập kim loại",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 11,
    "ja": "金属熱処理技能士",
    "vi": "Chứng chỉ kỹ năng nhiệt luyện kim loại",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 12,
    "ja": "めっき技能士",
    "vi": "Chứng chỉ kỹ năng mạ",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 13,
    "ja": "鋳造技能士",
    "vi": "Chứng chỉ kỹ năng đúc kim loại",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 14,
    "ja": "鍛造技能士",
    "vi": "Chứng chỉ kỹ năng rèn kim loại",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 15,
    "ja": "鉄工技能士",
    "vi": "Chứng chỉ kỹ năng gia công kết cấu thép",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 16,
    "ja": "シーケンス制御技能士",
    "vi": "Chứng chỉ kỹ năng điều khiển trình tự/PLC",
    "format": "○× / 択一 + 実技",
    "practical": "PLC",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 17,
    "ja": "電気機器組立て技能士",
    "vi": "Chứng chỉ kỹ năng lắp ráp thiết bị điện",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 18,
    "ja": "電子機器組立て技能士",
    "vi": "Chứng chỉ kỹ năng lắp ráp thiết bị điện tử",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 19,
    "ja": "プリント配線板製造技能士",
    "vi": "Chứng chỉ kỹ năng sản xuất bảng mạch in",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 20,
    "ja": "半導体製品製造技能士",
    "vi": "Chứng chỉ kỹ năng sản xuất sản phẩm bán dẫn",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士; cần kiểm tra職種/cấp thi hiện hành"
  },
  {
    "no": 21,
    "ja": "光学機器製造技能士",
    "vi": "Chứng chỉ kỹ năng sản xuất thiết bị quang học",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 22,
    "ja": "プラスチック成形技能士",
    "vi": "Chứng chỉ kỹ năng tạo hình/ép nhựa",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 23,
    "ja": "化学分析技能士",
    "vi": "Chứng chỉ kỹ năng phân tích hóa học",
    "format": "○× / 択一 + 実技",
    "practical": "Phân tích thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 24,
    "ja": "計量士",
    "vi": "Chứng chỉ chuyên môn đo lường",
    "format": "選択式",
    "practical": "Không thực hành nghề",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 25,
    "ja": "環境計量士",
    "vi": "Chứng chỉ chuyên môn đo lường môi trường",
    "format": "選択式",
    "practical": "Không",
    "hsp": "◎",
    "note": "Thuộc hệ 計量士"
  },
  {
    "no": 26,
    "ja": "測量士補",
    "vi": "Chứng chỉ trợ lý trắc địa/đo đạc",
    "format": "択一式",
    "practical": "Không",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 27,
    "ja": "測量士",
    "vi": "Chứng chỉ trắc địa/đo đạc",
    "format": "筆記",
    "practical": "Không thực hành",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 28,
    "ja": "とび技能士",
    "vi": "Chứng chỉ kỹ năng giàn giáo và công việc trên cao",
    "format": "○× / 択一 + 実技",
    "practical": "Lắp dựng",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 29,
    "ja": "建築大工技能士",
    "vi": "Chứng chỉ kỹ năng mộc xây dựng",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 30,
    "ja": "鉄筋施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công cốt thép",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 31,
    "ja": "型枠施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công cốp pha",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 32,
    "ja": "配管技能士",
    "vi": "Chứng chỉ kỹ năng thi công đường ống",
    "format": "○× / 択一 + 実技",
    "practical": "Lắp/gia công ống",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 33,
    "ja": "冷凍空気調和機器施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công thiết bị lạnh và điều hòa không khí",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 34,
    "ja": "塗装技能士",
    "vi": "Chứng chỉ kỹ năng sơn",
    "format": "○× / 択一 + 実技",
    "practical": "Sơn thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 35,
    "ja": "防水施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công chống thấm",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 36,
    "ja": "内装仕上げ施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công hoàn thiện nội thất",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 37,
    "ja": "左官技能士",
    "vi": "Chứng chỉ kỹ năng trát/tô tường",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 38,
    "ja": "かわらぶき技能士",
    "vi": "Chứng chỉ kỹ năng lợp ngói",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 39,
    "ja": "ガラス施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công kính",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 40,
    "ja": "コンクリート圧送施工技能士",
    "vi": "Chứng chỉ kỹ năng thi công bơm bê tông",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 41,
    "ja": "造園技能士",
    "vi": "Chứng chỉ kỹ năng thi công cảnh quan",
    "format": "○× / 択一 + 実技",
    "practical": "Có",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 42,
    "ja": "第二種電気工事士",
    "vi": "Chứng chỉ thợ điện loại 2",
    "format": "CBT/筆記 + 技能",
    "practical": "Đấu dây thực tế",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 43,
    "ja": "第一種電気工事士",
    "vi": "Chứng chỉ thợ điện loại 1",
    "format": "CBT/筆記 + 技能",
    "practical": "Đấu dây thực tế",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 44,
    "ja": "第三種電気主任技術者（電験三種）",
    "vi": "Chứng chỉ kỹ sư phụ trách kỹ thuật điện loại 3",
    "format": "択一式",
    "practical": "Không",
    "hsp": "◎",
    "note": "Độ khó tương đối cao"
  },
  {
    "no": 45,
    "ja": "2級建築施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công xây dựng cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Đỗ 第一次 chỉ là 2級建築施工管理技士補"
  },
  {
    "no": 46,
    "ja": "1級建築施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công xây dựng cấp 1",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần phân biệt 技士補 và 施工管理技士"
  },
  {
    "no": 47,
    "ja": "2級土木施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công công trình dân dụng cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 48,
    "ja": "2級管工事施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công đường ống/HVAC cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 49,
    "ja": "2級電気工事施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công điện cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Đỗ 第一次 chỉ là 技士補"
  },
  {
    "no": 50,
    "ja": "1級電気工事施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công điện cấp 1",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 51,
    "ja": "2級電気通信工事施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công viễn thông cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 52,
    "ja": "2級造園施工管理技術検定",
    "vi": "Kỳ thi/chứng chỉ quản lý thi công cảnh quan cấp 2",
    "format": "第一次: 選択中心",
    "practical": "第二次 có 記述",
    "hsp": "△※",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 53,
    "ja": "宅地建物取引士",
    "vi": "Chứng chỉ chuyên viên giao dịch bất động sản",
    "format": "4択",
    "practical": "Không",
    "hsp": "◎",
    "note": "Cần liên quan công việc"
  },
  {
    "no": 54,
    "ja": "マンション管理士",
    "vi": "Chứng chỉ chuyên môn quản lý chung cư",
    "format": "4択",
    "practical": "Không",
    "hsp": "◎",
    "note": "名称独占資格; cần liên quan công việc"
  },
  {
    "no": 55,
    "ja": "FP技能士",
    "vi": "Chứng chỉ kỹ năng hoạch định tài chính",
    "format": "CBT/選択",
    "practical": "実技 dạng bài thi",
    "hsp": "○",
    "note": "技能士; cần liên quan công việc"
  },
  {
    "no": 56,
    "ja": "情報セキュリティマネジメント（SG）",
    "vi": "Kỳ thi quản lý an toàn thông tin",
    "format": "CBT",
    "practical": "Không",
    "hsp": "◎",
    "note": "Xem theo cơ chế IT告示"
  },
  {
    "no": 57,
    "ja": "基本情報技術者（FE）",
    "vi": "Kỳ thi kỹ sư công nghệ thông tin cơ bản",
    "format": "CBT",
    "practical": "Không",
    "hsp": "◎",
    "note": "Xem theo IT告示"
  },
  {
    "no": 58,
    "ja": "応用情報技術者（AP）",
    "vi": "Kỳ thi kỹ sư công nghệ thông tin ứng dụng",
    "format": "CBT/方式 hiện hành",
    "practical": "Không thực hành tay nghề",
    "hsp": "◎",
    "note": "Xem theo IT告示"
  },
  {
    "no": 59,
    "ja": "パン製造技能士",
    "vi": "Chứng chỉ kỹ năng sản xuất bánh mì",
    "format": "○× / 択一 + 実技",
    "practical": "Làm bánh thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 60,
    "ja": "菓子製造技能士",
    "vi": "Chứng chỉ kỹ năng sản xuất bánh và bánh kẹo",
    "format": "○× / 択一 + 実技",
    "practical": "Làm thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 61,
    "ja": "ハム・ソーセージ・ベーコン製造技能士",
    "vi": "Chứng chỉ kỹ năng chế biến ham, xúc xích và bacon",
    "format": "○× / 択一 + 実技",
    "practical": "Chế biến thực tế",
    "hsp": "○",
    "note": "技能士"
  },
  {
    "no": 62,
    "ja": "衛生管理者",
    "vi": "Chứng chỉ quản lý vệ sinh và an toàn lao động",
    "format": "選択式",
    "practical": "Không",
    "hsp": "△/×",
    "note": "Không nên mặc định +5 HSP"
  },
  {
    "no": 63,
    "ja": "危険物取扱者",
    "vi": "Chứng chỉ xử lý vật liệu nguy hiểm",
    "format": "選択式",
    "practical": "Không",
    "hsp": "△",
    "note": "Cần xác nhận HSP"
  },
  {
    "no": 64,
    "ja": "公害防止管理者",
    "vi": "Chứng chỉ quản lý phòng chống ô nhiễm",
    "format": "選択式",
    "practical": "Không",
    "hsp": "△",
    "note": "Không nên mặc định +5"
  },
  {
    "no": 65,
    "ja": "運行管理者",
    "vi": "Chứng chỉ quản lý vận hành vận tải",
    "format": "CBT/選択",
    "practical": "Không",
    "hsp": "△",
    "note": "Cần xác nhận HSP"
  }
];
