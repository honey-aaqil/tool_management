import React, { useState, useEffect } from 'react';
import api from '../../services/api';

const EmailSettings = () => {
  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isAdmin = user && (user.admin_access === true || user.admin_access === 1 || user.admin_access === '1');

  const [settings, setSettings] = useState({
    smtp_host: 'smtp.gmail.com',
    smtp_port: 587,
    smtp_username: '',
    smtp_password: '',
    from_email: '',
    from_name: 'Tool Management System',
    notification_email: ''
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState({ type: '', text: '' });

  useEffect(() => {
    if (isAdmin) {
      fetchSettings();
    } else {
      setLoading(false);
    }
  }, []);

  const fetchSettings = async () => {
    try {
      const data = await api.getEmailSettings();
      if (data.success) {
        setSettings({
          ...data.settings,
          smtp_password: '' // Don't show saved password
        });
      }
    } catch (error) {
      setMessage({ type: 'error', text: 'Failed to load email settings' });
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setSettings(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSave = async (e) => {
    e.preventDefault();
    setSaving(true);
    setMessage({ type: '', text: '' });

    try {
      const data = await api.updateEmailSettings(settings);
      
      if (data.success) {
        setMessage({ type: 'success', text: 'Settings saved successfully!' });
      } else {
        setMessage({ type: 'error', text: data.error || 'Failed to save settings' });
      }
    } catch (error) {
      setMessage({ type: 'error', text: 'Failed to save settings' });
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return <div className="email-settings">Loading...</div>;
  }

  if (!isAdmin) {
    return (
      <div className="email-settings">
        <div className="page-header">
          <h1>📧 Email Settings</h1>
        </div>
        <div className="access-denied">
          <i className="fas fa-lock"></i>
          <h2>Access Denied</h2>
          <p>You do not have permission to access email settings.</p>
          <p>Only administrators can manage email configuration.</p>
        </div>
      </div>
    );
  }

  return (
    <div className="email-settings">
      <div className="page-header">
        <h1>📧 Email Notification Settings</h1>
        <p>Configure email notifications to receive alerts about tool renewals</p>
      </div>

      {message.text && (
        <div className={`message ${message.type}`}>
          {message.text}
        </div>
      )}

      <form onSubmit={handleSave} className="settings-form">
        <div className="settings-section">
          <h3>SMTP Configuration</h3>
          <p className="section-note">
            🔑 For Gmail, use an <strong>App Password</strong> instead of your regular password.
            <a href="https://myaccount.google.com/apppasswords" target="_blank" rel="noopener noreferrer">
              Get App Password
            </a>
          </p>
          
          <div className="form-row">
            <div className="form-group">
              <label>SMTP Host</label>
              <input
                type="text"
                name="smtp_host"
                value={settings.smtp_host}
                onChange={handleChange}
                placeholder="smtp.gmail.com"
              />
            </div>
            <div className="form-group">
              <label>SMTP Port</label>
              <input
                type="number"
                name="smtp_port"
                value={settings.smtp_port}
                onChange={handleChange}
                placeholder="587"
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-group">
              <label>Email Address (SMTP Username)</label>
              <input
                type="email"
                name="smtp_username"
                value={settings.smtp_username}
                onChange={handleChange}
                placeholder="your-email@gmail.com"
              />
            </div>
            <div className="form-group">
              <label>App Password (SMTP Password)</label>
              <input
                type="password"
                name="smtp_password"
                value={settings.smtp_password}
                onChange={handleChange}
                placeholder="Enter 16-character app password"
              />
            </div>
          </div>
        </div>

        <div className="settings-section">
          <h3>Email Sender Details</h3>
          
          <div className="form-row">
            <div className="form-group">
              <label>From Email</label>
              <input
                type="email"
                name="from_email"
                value={settings.from_email}
                onChange={handleChange}
                placeholder="noreply@yourdomain.com"
              />
            </div>
            <div className="form-group">
              <label>From Name</label>
              <input
                type="text"
                name="from_name"
                value={settings.from_name}
                onChange={handleChange}
                placeholder="Tool Management System"
              />
            </div>
          </div>
        </div>

        <div className="settings-section">
          <h3>🔔 Notification Email</h3>
          <p className="section-note">
            Enter the email address where you want to receive renewal alerts and notifications.
          </p>
          
          <div className="form-row">
            <div className="form-group full-width">
              <label>Alert Notification Email</label>
              <input
                type="email"
                name="notification_email"
                value={settings.notification_email}
                onChange={handleChange}
                placeholder="admin@yourcompany.com"
              />
            </div>
          </div>
        </div>

        <div className="form-actions">
          <button type="submit" className="btn-primary" disabled={saving}>
            {saving ? 'Saving...' : 'Save Settings'}
          </button>
        </div>
      </form>

      <style>{`
        .email-settings {
          padding: 20px;
          max-width: 800px;
          margin: 0 auto;
        }

        .page-header {
          margin-bottom: 30px;
        }

        .page-header h1 {
          color: #2196F3;
          margin-bottom: 10px;
        }

        .page-header p {
          color: #666;
        }

        .message {
          padding: 15px;
          border-radius: 5px;
          margin-bottom: 20px;
        }

        .message.success {
          background-color: #d4edda;
          color: #155724;
          border: 1px solid #c3e6cb;
        }

        .message.error {
          background-color: #f8d7da;
          color: #721c24;
          border: 1px solid #f5c6cb;
        }

        .settings-form {
          background: white;
          border-radius: 8px;
          padding: 25px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .settings-section {
          margin-bottom: 30px;
          padding-bottom: 20px;
          border-bottom: 1px solid #eee;
        }

        .settings-section:last-of-type {
          border-bottom: none;
          margin-bottom: 0;
        }

        .settings-section h3 {
          color: #333;
          margin-bottom: 15px;
        }

        .section-note {
          background: #fff3cd;
          padding: 10px 15px;
          border-radius: 5px;
          font-size: 14px;
          margin-bottom: 20px;
          color: #856404;
        }

        .section-note a {
          color: #0056b3;
          text-decoration: underline;
        }

        .form-row {
          display: flex;
          gap: 20px;
          margin-bottom: 15px;
        }

        .form-group {
          flex: 1;
          margin-bottom: 15px;
        }

        .form-group.full-width {
          flex: 1;
        }

        .form-group label {
          display: block;
          margin-bottom: 5px;
          font-weight: 600;
          color: #333;
        }

        .form-group input {
          width: 100%;
          padding: 10px;
          border: 1px solid #ddd;
          border-radius: 5px;
          font-size: 14px;
          box-sizing: border-box;
        }

        .form-group input:focus {
          outline: none;
          border-color: #2196F3;
        }

        .form-actions {
          display: flex;
          gap: 15px;
          margin-top: 20px;
        }

        .btn-primary {
          background: #2196F3;
          color: white;
          border: none;
          padding: 12px 24px;
          border-radius: 5px;
          cursor: pointer;
          font-size: 14px;
          font-weight: 600;
        }

        .btn-primary:hover {
          background: #1976D2;
        }

        .btn-primary:disabled {
          background: #ccc;
          cursor: not-allowed;
        }

        .btn-secondary {
          background: #28a745;
          color: white;
          border: none;
          padding: 12px 24px;
          border-radius: 5px;
          cursor: pointer;
          font-size: 14px;
          font-weight: 600;
        }

        .btn-secondary:hover {
          background: #218838;
        }

        .btn-secondary:disabled {
          background: #ccc;
          cursor: not-allowed;
        }

        @media (max-width: 600px) {
          .form-row {
            flex-direction: column;
            gap: 0;
          }
        }

        .access-denied {
          text-align: center;
          padding: 60px 20px;
          background: #f8f9fa;
          border-radius: 8px;
          margin: 20px 0;
        }

        .access-denied i {
          font-size: 48px;
          color: #dc3545;
          margin-bottom: 20px;
        }

        .access-denied h2 {
          color: #333;
          margin-bottom: 10px;
        }

        .access-denied p {
          color: #666;
          font-size: 14px;
        }
      `}</style>
    </div>
  );
};

export default EmailSettings;