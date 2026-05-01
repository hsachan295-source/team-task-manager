import { useState } from "react";
import { useAuth } from "../context/AuthContext";
import { useNavigate, Link } from "react-router-dom";

export default function Login() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ email: "", password: "" });
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true); setError("");
    try {
      await login(form.email, form.password);
      navigate("/dashboard");
    } catch (err) {
      setError(err.response?.data?.message || "Login failed. Check credentials.");
    } finally { setLoading(false); }
  };

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg-primary)', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 24 }}>
      <div style={{ position: 'fixed', top: '30%', left: '50%', transform: 'translateX(-50%)', width: 400, height: 400, borderRadius: '50%', background: 'radial-gradient(circle, rgba(99,102,241,0.08) 0%, transparent 70%)', pointerEvents: 'none' }} />
      <div className="fade-up" style={{ width: '100%', maxWidth: 420 }}>
        <div style={{ textAlign: 'center', marginBottom: 40 }}>
          <div style={{
            width: 56, height: 56, margin: '0 auto 20px',
            background: 'linear-gradient(135deg, #6366f1, #06b6d4)',
            borderRadius: 14, display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 22, fontWeight: 800, color: 'white',
            boxShadow: '0 0 30px rgba(99,102,241,0.4)',
          }}>T</div>
          <h1 style={{ fontFamily: 'Syne, sans-serif', fontSize: 28, fontWeight: 800, color: '#e2e8f0', marginBottom: 8 }}>Welcome back</h1>
          <p style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)', letterSpacing: '0.08em' }}>SIGN IN TO CONTINUE</p>
        </div>
        <div style={{ background: 'var(--bg-card)', borderRadius: 16, border: '1px solid var(--border)', padding: 32, boxShadow: '0 20px 60px rgba(0,0,0,0.5)' }}>
          {error && (
            <div style={{ background: 'rgba(239,68,68,0.08)', border: '1px solid rgba(239,68,68,0.2)', color: '#f87171', borderRadius: 10, padding: '12px 16px', marginBottom: 20, fontSize: 13 }}>
              {error}
            </div>
          )}
          <form onSubmit={handleSubmit}>
            <div style={{ marginBottom: 16 }}>
              <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Email</label>
              <input type="email" required placeholder="you@example.com" className="futuristic-input"
                value={form.email} onChange={e => setForm({ ...form, email: e.target.value })} />
            </div>
            <div style={{ marginBottom: 28 }}>
              <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Password</label>
              <input type="password" required placeholder="â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢" className="futuristic-input"
                value={form.password} onChange={e => setForm({ ...form, password: e.target.value })} />
            </div>
            <button type="submit" disabled={loading} className="btn-primary" style={{ width: '100%', padding: '13px', borderRadius: 10, fontSize: 15 }}>
              {loading ? "Authenticating..." : "Sign In"}
            </button>
          </form>
          <p style={{ textAlign: 'center', marginTop: 24, fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)' }}>
            No account? <Link to="/register" style={{ color: '#818cf8', textDecoration: 'none', fontWeight: 500 }}>Create one</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
