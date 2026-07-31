import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { getClassroomState, joinSeat, leaveClassroom, becomeTeacher, ApiError } from '../api/client';
import type { ClassroomState } from '../types/classroom';
import Blackboard from '../components/classroom/Blackboard';
import Podium from '../components/classroom/Podium';
import SeatingGrid from '../components/classroom/SeatingGrid';

export default function ClassroomPage() {
  const { user, isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const [classroom, setClassroom] = useState<ClassroomState | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login');
    }
  }, [isAuthenticated, navigate]);

  const fetchState = useCallback(async () => {
    try {
      const res = await getClassroomState();
      setClassroom(res.classroom);
      setError(null);
    } catch {
      // Silent fail for polling
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchState();
    const interval = setInterval(fetchState, 5000);
    return () => clearInterval(interval);
  }, [fetchState]);

  const isSeated = classroom?.seats.some((s) => s.user_id === user?.id);
  const isTeacher = classroom?.teacher?.id === user?.id;

  const handleSeatClick = async (row: number, seat: number) => {
    if (!isAuthenticated || isSeated || isTeacher) return;
    try {
      await joinSeat(row, seat);
      await fetchState();
    } catch (e) {
      if (e instanceof ApiError) {
        setError(e.message);
        setTimeout(() => setError(null), 3000);
      }
    }
  };

  const handleLeave = async () => {
    try {
      await leaveClassroom();
      await fetchState();
    } catch (e) {
      if (e instanceof ApiError) {
        setError(e.message);
        setTimeout(() => setError(null), 3000);
      }
    }
  };

  const handleBecomeTeacher = async () => {
    try {
      await becomeTeacher();
      await fetchState();
    } catch (e) {
      if (e instanceof ApiError) {
        setError(e.message);
        setTimeout(() => setError(null), 3000);
      }
    }
  };

  if (loading) {
    return <div style={{ padding: 40, textAlign: 'center' }}>Loading classroom...</div>;
  }

  return (
    <div style={{ maxWidth: 900, margin: '0 auto', padding: '20px 16px' }}>
      {/* Error toast */}
      {error && (
        <div style={{
          position: 'fixed', top: 20, right: 20, backgroundColor: '#e74c3c',
          color: '#fff', padding: '10px 16px', borderRadius: 6, zIndex: 1000,
          boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
        }}>
          {error}
        </div>
      )}

      {/* Header info */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
        <span style={{ fontSize: 14, color: '#666' }}>
          Students: {classroom?.total_students ?? 0}/100
        </span>
        <div style={{ display: 'flex', gap: 8 }}>
          {!isSeated && !isTeacher && !classroom?.teacher && (
            <button
              onClick={handleBecomeTeacher}
              style={{ padding: '6px 12px', fontSize: 12, backgroundColor: '#f39c12', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer' }}
            >
              Become Teacher
            </button>
          )}
          {(isSeated || isTeacher) && (
            <button
              onClick={handleLeave}
              style={{ padding: '6px 12px', fontSize: 12, backgroundColor: '#e74c3c', color: '#fff', border: 'none', borderRadius: 4, cursor: 'pointer' }}
            >
              Leave Class
            </button>
          )}
        </div>
      </div>

      {/* Classroom layout */}
      <Blackboard topStudents={classroom?.top_students ?? []} />
      <Podium teacher={classroom?.teacher ?? null} />

      {/* Instruction */}
      {!isSeated && !isTeacher && (
        <p style={{ textAlign: 'center', fontSize: 13, color: '#888', margin: '8px 0' }}>
          Click on an empty seat to choose your position
        </p>
      )}

      {classroom?.total_students === 100 && !isSeated && !isTeacher && (
        <p style={{ textAlign: 'center', fontSize: 14, color: '#e74c3c', fontWeight: 'bold' }}>
          Classroom is full
        </p>
      )}

      {/* Seating grid */}
      <SeatingGrid
        seats={classroom?.seats ?? []}
        currentUserId={user?.id ?? null}
        onSeatClick={handleSeatClick}
      />
    </div>
  );
}
