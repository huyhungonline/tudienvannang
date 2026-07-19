import { useState, type FormEvent } from 'react';
import { Link } from 'react-router-dom';
import { post, ApiError } from '../api/client';

export function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (!email.trim()) { setError('Please enter your email.'); return; }
    setLoading(true);
    setError(null);
    try {
      await post('/auth/forgot-password', { email });
      setSent(true);
    } catch (err) {
      if (err instanceof ApiError) {
        setError(err.message);
      } else {
        setError('Unable to connect. Please try again later.');
      }
    } finally {
      setLoading(false);
    }
  };

  if (sent) {
    return (
      <div className="login-page">
        <h2>Check your email</h2>
        <p style={{ marginTop: '1rem', color: '#555' }}>
          If an account with that email exists, a new password has been sent. Please check your inbox (and spam folder).
        </p>
        <p className="auth-link" style={{ marginTop: '1rem' }}>
          <Link to="/login">Back to Login</Link>
        </p>
      </div>
    );
  }

  return (
    <div className="login-page">
      <h2>Forgot Password</h2>
      <form className="auth-form" onSubmit={handleSubmit}>
        {error && <div className="form-error">{error}</div>}
        <div className="form-field">
          <label htmlFor="email">Email</label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Enter your registered email"
            autoComplete="email"
          />
        </div>
        <button type="submit" className="btn-submit" disabled={loading}>
          {loading ? 'Sending...' : 'Send Reset Link'}
        </button>
        <p className="auth-link">
          <Link to="/login">Back to Login</Link>
        </p>
      </form>
    </div>
  );
}
