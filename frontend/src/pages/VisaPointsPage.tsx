import { useState } from 'react';

interface PointItem {
  id: string;
  label: string;
  points: number;
}

interface PointCategory {
  category: string;
  exclusive?: boolean; // only one can be selected in this category
  items: PointItem[];
}

const CATEGORIES: PointCategory[] = [
  {
    category: '学歴（※1）',
    exclusive: true,
    items: [
      { id: 'edu1', label: '博士学位（専門職学位を除く）', points: 30 },
      { id: 'edu2', label: '経営管理に関する専門職学位（MBA, MOT）を保有', points: 25 },
      { id: 'edu3', label: '修士又は専門職学位', points: 20 },
      { id: 'edu4', label: '大卒又はこれと同等以上の教育（博士，修士を除く）', points: 10 },
      { id: 'edu5', label: '複数分野の2以上の博士/修士/専門職学位（※2）', points: 5 },
    ],
  },
  {
    category: '職歴（従事しようとする業務に係る実務経験）',
    exclusive: true,
    items: [
      { id: 'exp1', label: '10年以上', points: 20 },
      { id: 'exp2', label: '7年以上10年未満', points: 15 },
      { id: 'exp3', label: '5年以上7年未満', points: 10 },
      { id: 'exp4', label: '3年以上5年未満', points: 5 },
    ],
  },
  {
    category: '年収（※3）',
    exclusive: true,
    items: [
      { id: 'sal1', label: '1000万円以上', points: 40 },
      { id: 'sal2', label: '900万〜1000万円', points: 35 },
      { id: 'sal3', label: '800万〜900万円', points: 30 },
      { id: 'sal4', label: '700万〜800万円', points: 25 },
      { id: 'sal5', label: '600万〜700万円', points: 20 },
      { id: 'sal6', label: '500万〜600万円', points: 15 },
      { id: 'sal7', label: '400万〜500万円', points: 10 },
    ],
  },
  {
    category: '年齢（申請時点）',
    exclusive: true,
    items: [
      { id: 'age1', label: '30歳未満', points: 15 },
      { id: 'age2', label: '30〜34歳', points: 10 },
      { id: 'age3', label: '35〜39歳', points: 5 },
    ],
  },
  {
    category: '研究実績',
    exclusive: false,
    items: [
      { id: 'res1', label: '発明者として特許を受けた発明が１件以上', points: 15 },
      { id: 'res2', label: '外国政府の補助金・競争的資金等の研究に3回以上従事', points: 15 },
      { id: 'res3', label: '学術論文DB掲載雑誌の論文が3本以上', points: 15 },
      { id: 'res4', label: 'その他法務大臣が認める研究実績', points: 15 },
    ],
  },
  {
    category: '資格',
    exclusive: false,
    items: [
      { id: 'cert1', label: '関連する日本の国家資格（業務独占/名称独占）またはIT告示の試験・資格を1つ保有', points: 5 },
      { id: 'cert2', label: '上記の資格を複数保有', points: 10 },
    ],
  },
  {
    category: '特別加算 契約機関',
    exclusive: false,
    items: [
      { id: 'org1', label: 'Ⅰ イノベーション促進支援措置を受けている', points: 10 },
      { id: 'org2', label: 'Ⅱ Ⅰに該当し、中小企業基本法に規定する中小企業者', points: 10 },
      { id: 'org3', label: 'Ⅲ 地方公共団体の支援（法務大臣認定）を受けている', points: 10 },
      { id: 'org4', label: '契約機関が中小企業で、試験研究費＋開発費が売上高の3%超', points: 5 },
    ],
  },
  {
    category: '特別加算 資格・表彰',
    exclusive: false,
    items: [
      { id: 'award1', label: '関連する外国の資格・表彰（法務大臣が認める）を保有', points: 5 },
    ],
  },
  {
    category: '特別加算 日本の大学',
    exclusive: false,
    items: [
      { id: 'jpuni1', label: '日本の大学を卒業又は大学院修了', points: 10 },
    ],
  },
  {
    category: '特別加算 日本語能力',
    exclusive: true,
    items: [
      { id: 'jpn1', label: 'Ⅰ 日本語専攻の外国大卒またはJLPT N1相当', points: 15 },
      { id: 'jpn2', label: 'Ⅱ JLPT N2相当（※日本の大学卒/大学院修了およびⅠを除く）', points: 10 },
    ],
  },
  {
    category: '特別加算 プロジェクト',
    exclusive: false,
    items: [
      { id: 'proj1', label: '各省が関与する成長分野の先端プロジェクトに従事', points: 10 },
    ],
  },
  {
    category: '特別加算 卒業大学',
    exclusive: false,
    items: [
      { id: 'uni1', label: 'Ⅰ QS/THE/ARWUのうち2つ以上で300位以内の大学を卒業（※4）', points: 10 },
      { id: 'uni2', label: 'Ⅱ スーパーグローバル大学（トップ型）の補助金交付大学', points: 10 },
      { id: 'uni3', label: 'Ⅲ 外務省「イノベーティブ・アジア」パートナー校', points: 10 },
    ],
  },
  {
    category: '特別加算 研修修了',
    exclusive: false,
    items: [
      { id: 'jica1', label: 'JICA研修（イノベーティブ・アジアの一環、1年以上）を修了（※5）', points: 5 },
    ],
  },
  {
    category: '特別加算',
    exclusive: false,
    items: [
      { id: 'inv1', label: '投資運用業等に係る業務に従事', points: 10 },
    ],
  },
];

export function VisaPointsPage() {
  const [selected, setSelected] = useState<Set<string>>(new Set());

  const handleToggle = (category: PointCategory, itemId: string) => {
    setSelected((prev) => {
      const next = new Set(prev);
      if (category.exclusive) {
        // Uncheck all others in this category
        category.items.forEach((item) => {
          if (item.id !== itemId) next.delete(item.id);
        });
      }
      if (next.has(itemId)) {
        next.delete(itemId);
      } else {
        next.add(itemId);
      }
      return next;
    });
  };

  const totalPoints = CATEGORIES.reduce((sum, cat) => {
    return sum + cat.items.reduce((catSum, item) => {
      return catSum + (selected.has(item.id) ? item.points : 0);
    }, 0);
  }, 0);

  const remaining = Math.max(0, 70 - totalPoints);

  return (
    <div className="visa-points-page">
      <h2>高度専門職ポイント計算</h2>
      <p className="visa-points-desc">
        該当項目にチェックを入れると自動でポイント合計が計算されます（※学歴・年収・年齢は相互排他）。
      </p>

      <div className="visa-points-total">
        <span>あなたの高度専門職ポイントは</span>
        <strong className={totalPoints >= 70 ? 'points-pass' : 'points-fail'}>{totalPoints}</strong>
        <span>ポイントです</span>
      </div>
      <p className="visa-points-hint">
        {totalPoints >= 70
          ? '✅ 70点以上です。高度専門職ビザの要件を満たしています。'
          : `70点まで、あと ${remaining} 点。学歴/資格/日本語/JLPT等の加点を検討。`}
      </p>

      <table className="visa-points-table">
        <thead>
          <tr>
            <th className="col-category">カテゴリ</th>
            <th className="col-item">項目</th>
            <th className="col-check">✓</th>
            <th className="col-points">点数</th>
          </tr>
        </thead>
        <tbody>
          {CATEGORIES.map((cat) =>
            cat.items.map((item, idx) => (
              <tr key={item.id} className={selected.has(item.id) ? 'row-selected' : ''}>
                {idx === 0 && (
                  <td className="cell-category" rowSpan={cat.items.length}>
                    {cat.category}
                    {cat.exclusive && <span className="exclusive-badge">択一</span>}
                  </td>
                )}
                <td className="cell-item">{item.label}</td>
                <td className="cell-check">
                  <input
                    type="checkbox"
                    checked={selected.has(item.id)}
                    onChange={() => handleToggle(cat, item.id)}
                  />
                </td>
                <td className="cell-points">{item.points}点</td>
              </tr>
            ))
          )}
        </tbody>
      </table>

      <div className="visa-points-notes">
        <p>（※1）最終学歴が対象となります（博士と修士の両方を有する場合は30点）。</p>
        <p>（※2）専攻が異なることが分かる資料（学位記/学位証明書、必要に応じて成績証明書）を提出。</p>
        <p>（※3）年収が300万円に満たないときは、他項目の合計が70点以上でも高度専門職外国人としては認められません。</p>
        <p>（※4）日本の大学は卒業修了と重複加算が認定。</p>
        <p>（※5）JICA研修はイノベーティブ・アジアの一環として行われるもの。</p>
      </div>
    </div>
  );
}
