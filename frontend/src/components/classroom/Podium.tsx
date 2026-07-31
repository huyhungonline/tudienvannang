import Avatar from './Avatar';
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
        padding: '16px 0',
        gap: 8,
      }}
    >
      <div
        style={{
          backgroundColor: '#deb887',
          border: '3px solid #8B4513',
          borderRadius: 6,
          padding: '12px 32px',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          gap: 6,
          minWidth: 120,
        }}
      >
        {teacher ? (
          <>
            <Avatar
              email={teacher.email}
              userId={teacher.id}
              searchCount={teacher.search_count}
              size={48}
              isTeacher
            />
            <span style={{ fontSize: 12, fontWeight: 'bold', color: '#333' }}>
              {teacher.email.split('@')[0]}
            </span>
            <span style={{ fontSize: 10, color: '#666' }}>Giáo viên</span>
          </>
        ) : (
          <span style={{ fontSize: 13, color: '#999', fontStyle: 'italic' }}>
            Chưa có giáo viên
          </span>
        )}
      </div>
    </div>
  );
}
