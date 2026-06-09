import { useState, useRef, type FormEvent } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import ReCAPTCHA from 'react-google-recaptcha';
import { useAuth } from '../context/AuthContext';
import { post, ApiError } from '../api/client';
import type { User } from 'shared';

interface LoginResponse {
  token: string;
  user: User;
}

const SITE_KEY = import.meta.env.VITE_RECAPTCHA_SITE_KEY || '';

export function LoginPage() {
  const navigate = useNavigate();
  const { login } = useAuth();
  const recaptchaRef = useRef<ReCAPTCHA>(null);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [captchaToken, setCaptchaToken] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleCaptchaChange = (token: string | null) => {
    setCaptchaToken(token || '');
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!email.trim() || !password.trim()) {
      setError('Please fill in all fields.');
      return;
    }

    if (!captchaToken) {
      setError('Please complete the CAPTCHA verification.');
      return;
    }

    setLoading(true);

    try {
      const result = await post<LoginResponse>('/auth/login', {
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
          recaptchaRef.current?.reset();
          setCaptchaToken('');
        } else {
          setError('Invalid credentials.');
        }
      } else {
        setError('Unable to connect. Please try again later.');
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      <h2>Login</h2>
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
        </div>

        <div className="form-field">
          <label htmlFor="password">Password</label>
          <input
            id="password"
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Enter your password"
            autoComplete="current-password"
          />
        </div>

        {SITE_KEY && (
          <div className="form-field">
            <ReCAPTCHA
              ref={recaptchaRef}
              sitekey={SITE_KEY}
              onChange={handleCaptchaChange}
            />
          </div>
        )}

        <button type="submit" className="btn-submit" disabled={loading}>
          {loading ? 'Logging in...' : 'Login'}
        </button>

        <p className="auth-link">
          Don't have an account? <Link to="/register">Register</Link>
        </p>
      </form>
    </div>
  );
}
