import { useState, type FormEvent } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { post, ApiError } from '../api/client';
import type { User } from 'shared';

interface RegisterResponse {
  token: string;
  user: User;
}

function validateEmail(email: string): string | null {
  if (!email.trim()) return 'Email is required.';
  const atIndex = email.indexOf('@');
  if (atIndex < 1) return 'Email must contain @ with a valid local part.';
  const domain = email.slice(atIndex + 1);
  if (!domain.includes('.') || domain.startsWith('.') || domain.endsWith('.')) {
    return 'Email domain must contain at least one dot.';
  }
  return null;
}

function validatePassword(password: string): string | null {
  if (password.length < 8) return 'Password must be at least 8 characters.';
  if (!/[A-Z]/.test(password)) return 'Password must contain at least one uppercase letter.';
  if (!/[a-z]/.test(password)) return 'Password must contain at least one lowercase letter.';
  if (!/\d/.test(password)) return 'Password must contain at least one digit.';
  return null;
}

export function RegisterPage() {
  const navigate = useNavigate();
  const { login } = useAuth();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [captchaToken, setCaptchaToken] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const emailError = email ? validateEmail(email) : null;
  const passwordError = password ? validatePassword(password) : null;
  const confirmError = confirmPassword && confirmPassword !== password
    ? 'Passwords do not match.'
    : null;

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);

    const emailErr = validateEmail(email);
    if (emailErr) {
      setError(emailErr);
      return;
    }

    const passErr = validatePassword(password);
    if (passErr) {
      setError(passErr);
      return;
    }

    if (password !== confirmPassword) {
      setError('Passwords do not match.');
      return;
    }

    if (!captchaToken) {
      setError('Please complete the CAPTCHA verification.');
      return;
    }

    setLoading(true);

    try {
      const result = await post<RegisterResponse>('/auth/register', {
        email,
        password,
        captchaToken,
      });
      login(result.token, result.user);
      navigate('/');
    } catch (err) {
      if (err instanceof ApiError) {
        if (err.status === 403) {
          setError('CAPTCHA verification failed. Please try again.');
        } else if (err.status === 400 && err.message.toLowerCase().includes('already')) {
          setError('This email is already registered.');
        } else {
          setError(err.message);
        }
      } else {
        setError('Unable to connect. Please try again later.');
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="register-page">
      <h2>Register</h2>
      <form className="auth-form" onSubmit={handleSubmit}>
        {error && <div className="form-error">{error}</div>}

        <div className="form-field">
          <label htmlFor="email">Email</label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Enter your email"
            autoComplete="email"
          />
          {emailError && <span className="field-error">{emailError}</span>}
        </div>

        <div className="form-field">
          <label htmlFor="password">Password</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="At least 8 characters"
            autoComplete="new-password"
          />
          {passwordError && <span className="field-error">{passwordError}</span>}
        </div>

        <div className="form-field">
          <label htmlFor="confirmPassword">Confirm Password</label>
          <input
            id="confirmPassword"
            type="password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            placeholder="Re-enter your password"
            autoComplete="new-password"
          />
          {confirmError && <span className="field-error">{confirmError}</span>}
        </div>

        <div className="form-field captcha-field">
          <label>
            <input
              type="checkbox"
              checked={!!captchaToken}
              onChange={(e) => setCaptchaToken(e.target.checked ? 'dev-captcha-token' : '')}
            />
            {' '}I am not a robot
          </label>
          <div
            className="captcha-placeholder"
            data-sitekey={import.meta.env.VITE_RECAPTCHA_SITE_KEY || ''}
          />
        </div>

        <button type="submit" className="btn-submit" disabled={loading}>
          {loading ? 'Creating account...' : 'Register'}
        </button>

        <p className="auth-link">
          Already have an account? <Link to="/login">Login</Link>
        </p>
      </form>
    </div>
  );
}
