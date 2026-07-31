import { useState, useEffect } from 'react';
import type { TopStudent } from '../../types/classroom';

interface BlackboardProps {
  topStudents: TopStudent[];
  questions: string[];
}

export default function Blackboard({ topStudents, questions }: BlackboardProps) {
  const [currentQ, setCurrentQ] = useState(0);

  useEffect(() => {
    if (questions.length <= 1) return;
    const timer = setInterval(() => {
      setCurrentQ((prev) => (prev + 1) % questions.length);
    }, 8000);
    return () => clearInterval(timer);
  }, [questions.length]);

  return (
    <div
      style={{
        backgroundColor: '#2d5016',
        border: '10px solid #8B4513',
        borderRadius: 4,
        padding: '28px 48px',
        color: '#e8e8e8',
        fontFamily: 'serif',
        letterSpacing: 1,
        minHeight: 200,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        boxShadow: 'inset 0 0 30px rgba(0,0,0,0.3)',
      }}
    >
      <div style={{ fontSize: 24, marginBottom: 16 }}>Virtual Classroom</div>

      {/* Question display */}
      {questions.length > 0 && (
        <div style={{
          backgroundColor: 'rgba(0,0,0,0.2)',
          borderRadius: 6,
          padding: '12px 20px',
          marginBottom: 16,
          width: '100%',
          maxWidth: 500,
          textAlign: 'center',
        }}>
          <div style={{ fontSize: 11, color: '#ffd700', marginBottom: 4 }}>📝 Question</div>
          <div style={{ fontSize: 16, lineHeight: 1.4 }}>{questions[currentQ]}</div>
          {questions.length > 1 && (
            <div style={{ fontSize: 10, color: '#aaa', marginTop: 6 }}>
              {currentQ + 1} / {questions.length}
            </div>
          )}
        </div>
      )}

      {/* Top 5 */}
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
      {topStudents.length === 0 && questions.length === 0 && (
        <div style={{ fontSize: 13, color: '#aaa', fontStyle: 'italic' }}>
          No searches today yet
        </div>
      )}
    </div>
  );
}
