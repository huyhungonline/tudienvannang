import type { ClassroomUser } from '../../types/classroom';

interface PodiumProps {
  teacher: ClassroomUser | null;
}

export default function Podium({ teacher }: PodiumProps) {
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        padding: '12px 0',
        gap: 6,
      }}
    >
      {/* Teacher figure */}
      <div style={{ fontSize: 40 }}>🧑‍🏫</div>
      <span style={{ fontSize: 11, fontWeight: 'bold', color: '#333' }}>
        {teacher ? teacher.email.split('@')[0] : 'Teacher'}
      </span>
      {/* Podium desk */}
      <div
        style={{
          backgroundColor: '#deb887',
          border: '3px solid #8B4513',
          borderRadius: 4,
          padding: '6px 24px',
          minWidth: 80,
          textAlign: 'center',
          fontSize: 10,
          color: '#666',
        }}
      >
        Podium
      </div>
    </div>
  );
}
