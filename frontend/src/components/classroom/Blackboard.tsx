import type { TopStudent } from '../../types/classroom';

interface BlackboardProps {
  topStudents: TopStudent[];
}

export default function Blackboard({ topStudents }: BlackboardProps) {
  return (
    <div
      style={{
        backgroundColor: '#2d5016',
        border: '8px solid #8B4513',
        borderRadius: 4,
        padding: '24px 40px',
        color: '#e8e8e8',
        fontFamily: 'serif',
        letterSpacing: 1,
        minHeight: 160,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        boxShadow: 'inset 0 0 30px rgba(0,0,0,0.3)',
      }}
    >
      <div style={{ fontSize: 22, marginBottom: 12 }}>Virtual Classroom</div>
      {topStudents.length > 0 && (
        <div style={{ width: '100%', maxWidth: 320 }}>
          <div style={{ fontSize: 13, textAlign: 'center', marginBottom: 8, color: '#ffd700' }}>
            ⭐ Top 5 Today ⭐
          </div>
          {topStudents.map((s, i) => (
            <div
              key={s.email}
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                fontSize: 13,
                padding: '2px 0',
                color: i === 0 ? '#ffd700' : '#e8e8e8',
              }}
            >
              <span>{i + 1}. {s.email.split('@')[0]}</span>
              <span>{s.search_count} pts</span>
            </div>
          ))}
        </div>
      )}
      {topStudents.length === 0 && (
        <div style={{ fontSize: 13, color: '#aaa', fontStyle: 'italic' }}>
          No searches today yet
        </div>
      )}
    </div>
  );
}
