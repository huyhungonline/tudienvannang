import { useState } from 'react';
import { post } from '../api/client';

export function ResetPasswordPage() {
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError('');
    setSuccess('');

    if (!currentPassword) { setError('Please enter current password'); return; }
    if (!newPassword) { setError('Please enter new password'); return; }
    if (newPassword !== confirmPassword) { setError('New passwords do not match'); return; }

    setLoading(true);
    try {
      await post<{ message: string }>('/auth/change-password', {
        currentPassword,
        newPassword,
      });
      setSuccess('Password changed successfully!');
      setCurrentPassword('');
      setNewPassword('');
      setConfirmPassword('');
    } catch (err: any) {
      setError(err?.message || 'Failed to change password');
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="login-page">
      <h2>Reset Password</h2>
      <form className="auth-form" onSubmit={handleSubmit}>
        <div className="form-field">
          <label>Current Password</label>
          <input type="password" value={currentPassword} onChange={e => setCurrentPassword(e.target.value)} />
        </div>
        <div className="form-field">
          <label>New Password</label>
          <input type="password" value={newPassword} onChange={e => setNewPassword(e.target.value)} />
        </div>
        <div className="form-field">
          <label>Confirm New Password</label>
          <input type="password" value={confirmPassword} onChange={e => setConfirmPassword(e.target.value)} />
        </div>
        {error && <p className="form-error">{error}</p>}
        {success && <p className="save-success">{success}</p>}
        <button className="btn-submit" type="submit" disabled={loading}>
          {loading ? 'Changing...' : 'Change Password'}
        </button>
      </form>
    </div>
  );
}
