import { useState, FormEvent } from 'react';
import { post } from '../api/client';
import { ApiError } from '../api/client';

export function NewsSubscribePage() {
  const [email, setEmail] = useState('');
  const [targetLanguage, setTargetLanguage] = useState('en');
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState('');
  const [error, setError] = useState('');

  const validateEmail = (value: string): boolean => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setSuccess('');
    setError('');

    if (!email.trim()) {
      setError('Please enter your email address.');
      return;
    }

    if (!validateEmail(email)) {
      setError('Please enter a valid email address.');
      return;
    }

    setLoading(true);
    try {
      const result = await post<{ success: boolean; message: string }>('/nhk/subscribe', {
        email,
        target_language: targetLanguage,
      });
      setSuccess(result.message || 'Subscription successful! You will receive daily NHK news.');
      setEmail('');
    } catch (err) {
      if (err instanceof ApiError) {
        setError(err.message);
      } else {
        setError('Something went wrong. Please try again later.');
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="subscribe-page">
      <div className="subscribe-content">
        <h1>Subscribe to NHK Daily News</h1>
        <p className="subscribe-description">
          Receive a daily email with NHK news tokenized and translated to your preferred language.
        </p>

        <form onSubmit={handleSubmit} className="subscribe-form" noValidate>
          <div className="form-group">
            <label htmlFor="subscribe-email">Email address</label>
            <input
              id="subscribe-email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
              aria-required="true"
              aria-invalid={error ? 'true' : undefined}
              aria-describedby={error ? 'subscribe-error' : undefined}
              disabled={loading}
            />
          </div>

          <div className="form-group">
            <label htmlFor="subscribe-language">Translation language</label>
            <select
              id="subscribe-language"
              value={targetLanguage}
              onChange={(e) => setTargetLanguage(e.target.value)}
              aria-required="true"
              disabled={loading}
            >
              <option value="en">English</option>
              <option value="vi">Vietnamese</option>
            </select>
          </div>

          <button type="submit" className="subscribe-btn" disabled={loading}>
            {loading ? 'Subscribing...' : 'Subscribe'}
          </button>
        </form>

        {success && (
          <p className="subscribe-success" role="status" aria-live="polite">
            {success}
          </p>
        )}

        {error && (
          <p className="subscribe-error" id="subscribe-error" role="alert" aria-live="assertive">
            {error}
          </p>
        )}
      </div>
    </div>
  );
}
