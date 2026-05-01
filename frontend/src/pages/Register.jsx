import { useState } from "react";
import { useAuth } from "../context/AuthContext";
import { useNavigate, Link } from "react-router-dom";

export default function Register() {
  const auth = useAuth();
  const navigate = useNavigate();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("member");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true); setError("");
    try {
      await auth.register(name, email, password, role);
      navigate("/dashboard");
    } catch (err) {
      setError(err.response?.data?.message || "Registration failed.");
    } finally { setLoading(false); }
  };

  return (
    <div style={{ minHeight: '100vh', background: 'var(--bg-primary)', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 24 }}>
      <div style={{ position: 'fixed', top: '30%', left: '50%', transform: 'translateX(-50%)', width: 400, height: 400, borderRadius: '50%', background: 'radial-gradient(circle, rgba(6,182,212,0.06) 0%, transparent 70%)', pointerEvents: 'none' }} />
      <div className="fade-up" style={{ width: '100%', maxWidth: 440 }}>
        <div style={{ textAlign: 'center', marginBottom: 40 }}>
          <div style={{ width: 56, height: 56, margin: '0 auto 20px', background: 'linear-gradient(135deg, #6366f1, #06b6d4)', borderRadius: 14, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22, fontWeight: 800, color: 'white', boxShadow: '0 0 30px rgba(99,102,241,0.4)' }}>T</div>
          <h1 style={{ fontFamily: 'Syne, sans-serif', fontSize: 28, fontWeight: 800, color: '#e2e8f0', marginBottom: 8 }}>Create Account</h1>
          <p style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)', letterSpacing: '0.08em' }}>JOIN TASKMANAGER</p>
        </div>
        <div style={{ background: 'var(--bg-card)', borderRadius: 16, border: '1px solid var(--border)', padding: 32, boxShadow: '0 20px 60px rgba(0,0,0,0.5)' }}>
          {error && <div style={{ background: 'rgba(239,68,68,0.08)', border: '1px solid rgba(239,68,68,0.2)', color: '#f87171', borderRadius: 10, padding: '12px 16px', marginBottom: 20, fontSize: 13 }}>{error}</div>}
          <form onSubmit={handleSubmit}>
            {[
              { label: 'Full Name', type: 'text', val: name, set: setName, ph: 'John Doe' },
              { label: 'Email', type: 'email', val: email, set: setEmail, ph: 'you@example.com' },
              { label: 'Password', type: 'password', val: password, set: setPassword, ph: 'min 6 characters' },
            ].map(f => (
              <div key={f.label} style={{ marginBottom: 16 }}>
                <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>{f.label}</label>
                <input type={f.type} required placeholder={f.ph} className="futuristic-input" value={f.val} onChange={e => f.set(e.target.value)} />
              </div>
            ))}
            <div style={{ marginBottom: 28 }}>
              <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Role</label>
              <div style={{ display: 'flex', gap: 10 }}>
                {['member', 'admin'].map(r => (
                  <button key={r} type="button" onClick={() => setRole(r)} style={{
                    flex: 1, padding: '10px', borderRadius: 10, cursor: 'pointer',
                    fontFamily: 'Syne, sans-serif', fontWeight: 600, fontSize: 13, textTransform: 'capitalize', transition: 'all 0.2s',
                    background: role === r ? 'rgba(99,102,241,0.15)' : 'rgba(255,255,255,0.03)',
                    color: role === r ? '#818cf8' : 'var(--text-muted)',
                    border: role === r ? '1px solid rgba(99,102,241,0.4)' : '1px solid var(--border)',
                  }}>{r}</button>
                ))}
              </div>
            </div>
            <button type="submit" disabled={loading} className="btn-primary" style={{ width: '100%', padding: '13px', borderRadius: 10, fontSize: 15 }}>
              {loading ? "Creating Account..." : "Get Started"}
            </button>
          </form>
          <p style={{ textAlign: 'center', marginTop: 24, fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)' }}>
            Have an account? <Link to="/login" style={{ color: '#818cf8', textDecoration: 'none', fontWeight: 500 }}>Sign in</Link>
          </p>
        </div>
      </div>
    </div>
  );
}
