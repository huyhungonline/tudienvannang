import { useState } from 'react';

interface AvatarProps {
  email: string;
  userId: string;
  searchCount: number;
  size?: number;
  isTeacher?: boolean;
}

function getColorFromId(userId: string): string {
  let hash = 0;
  for (let i = 0; i < userId.length; i++) {
    hash = userId.charCodeAt(i) + ((hash << 5) - hash);
  }
  const hue = Math.abs(hash) % 360;
  return `hsl(${hue}, 60%, 45%)`;
}

export default function Avatar({ email, userId, searchCount, size = 36, isTeacher }: AvatarProps) {
  const [showTooltip, setShowTooltip] = useState(false);
  const letter = email.charAt(0).toUpperCase();
  const bgColor = getColorFromId(userId);

  return (
    <div
      style={{ position: 'relative', display: 'inline-block' }}
      onMouseEnter={() => setShowTooltip(true)}
      onMouseLeave={() => setShowTooltip(false)}
    >
      <div
        style={{
          width: size,
          height: size,
          borderRadius: '50%',
          backgroundColor: bgColor,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          color: '#fff',
          fontWeight: 'bold',
          fontSize: size * 0.4,
          border: isTeacher ? '2px solid gold' : '2px solid #ccc',
        }}
      >
        {letter}
      </div>
      {/* Score badge */}
      <span
        style={{
          position: 'absolute',
          top: -4,
          right: -4,
          backgroundColor: '#e74c3c',
          color: '#fff',
          borderRadius: 8,
          padding: '1px 4px',
          fontSize: 9,
          fontWeight: 'bold',
          minWidth: 14,
          textAlign: 'center',
        }}
      >
        {searchCount}
      </span>
      {/* Tooltip */}
      {showTooltip && (
        <div
          style={{
            position: 'absolute',
            bottom: '100%',
            left: '50%',
            transform: 'translateX(-50%)',
            backgroundColor: '#333',
            color: '#fff',
            padding: '4px 8px',
            borderRadius: 4,
            fontSize: 11,
            whiteSpace: 'nowrap',
            zIndex: 100,
            marginBottom: 4,
          }}
        >
          {email} • Score: {searchCount}
        </div>
      )}
    </div>
  );
}
