# ============================================================
# TASKMANAGER - FUTURISTIC UI UPDATE SCRIPT (Windows PowerShell)
# Frontend folder mein jaake chalao:
#   .\update_frontend.ps1
# ============================================================

Write-Host "Futuristic UI update shuru ho raha hai..." -ForegroundColor Cyan

# ── index.css ─────────────────────────────────────────────
@'
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=JetBrains+Mono:wght@300;400;500&display=swap');

@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --bg-primary: #050508;
  --bg-secondary: #0c0c14;
  --bg-card: #0f0f1a;
  --bg-card-hover: #141428;
  --border: rgba(99, 102, 241, 0.15);
  --border-bright: rgba(99, 102, 241, 0.4);
  --accent: #6366f1;
  --accent-glow: rgba(99, 102, 241, 0.3);
  --accent-2: #06b6d4;
  --text-primary: #e2e8f0;
  --text-secondary: #94a3b8;
  --text-muted: #475569;
  --success: #10b981;
  --warning: #f59e0b;
  --danger: #ef4444;
  --font-display: 'Syne', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
}

* { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }

body {
  background: var(--bg-primary);
  color: var(--text-primary);
  font-family: var(--font-display);
  min-height: 100vh;
  overflow-x: hidden;
}

body::before {
  content: '';
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background:
    radial-gradient(ellipse 60% 50% at 20% 10%, rgba(99,102,241,0.07) 0%, transparent 60%),
    radial-gradient(ellipse 40% 40% at 80% 80%, rgba(6,182,212,0.05) 0%, transparent 60%);
  pointer-events: none;
  z-index: 0;
}

#root { position: relative; z-index: 1; }

::-webkit-scrollbar { width: 4px; }
::-webkit-scrollbar-track { background: var(--bg-primary); }
::-webkit-scrollbar-thumb { background: var(--accent); border-radius: 4px; }

.glass-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  backdrop-filter: blur(12px);
  transition: all 0.3s ease;
}
.glass-card:hover {
  border-color: var(--border-bright);
  background: var(--bg-card-hover);
  transform: translateY(-2px);
  box-shadow: 0 8px 32px rgba(0,0,0,0.4);
}

.gradient-border {
  position: relative;
  background: var(--bg-card);
  border-radius: 12px;
}
.gradient-border::before {
  content: '';
  position: absolute;
  inset: -1px;
  border-radius: 13px;
  background: linear-gradient(135deg, var(--accent), var(--accent-2), transparent, var(--accent));
  background-size: 300% 300%;
  animation: gradientShift 4s ease infinite;
  z-index: -1;
  opacity: 0;
  transition: opacity 0.3s;
}
.gradient-border:hover::before { opacity: 1; }

@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.pulse-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: var(--success);
  box-shadow: 0 0 0 0 rgba(16,185,129,0.4);
  animation: pulse 2s infinite;
}
@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(16,185,129,0.4); }
  70% { box-shadow: 0 0 0 8px rgba(16,185,129,0); }
  100% { box-shadow: 0 0 0 0 rgba(16,185,129,0); }
}

.futuristic-input {
  background: rgba(99,102,241,0.05);
  border: 1px solid var(--border);
  color: var(--text-primary);
  font-family: var(--font-display);
  transition: all 0.3s;
  outline: none;
  width: 100%;
  border-radius: 10px;
  padding: 12px 16px;
  font-size: 14px;
}
.futuristic-input::placeholder { color: var(--text-muted); }
.futuristic-input:focus {
  border-color: var(--accent);
  background: rgba(99,102,241,0.08);
  box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
}

.btn-primary {
  background: linear-gradient(135deg, #6366f1, #4f46e5);
  color: white;
  font-family: var(--font-display);
  font-weight: 600;
  letter-spacing: 0.05em;
  transition: all 0.3s;
  position: relative;
  overflow: hidden;
  border: none;
  cursor: pointer;
}
.btn-primary::before {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
  transition: left 0.5s;
}
.btn-primary:hover::before { left: 100%; }
.btn-primary:hover {
  box-shadow: 0 0 20px rgba(99,102,241,0.4), 0 4px 15px rgba(99,102,241,0.3);
  transform: translateY(-1px);
}
.btn-primary:disabled { opacity: 0.5; cursor: not-allowed; transform: none; }

.btn-ghost {
  background: rgba(255,255,255,0.03);
  color: var(--text-secondary);
  border: 1px solid var(--border);
  font-family: var(--font-display);
  cursor: pointer;
  transition: all 0.2s;
}
.btn-ghost:hover {
  background: rgba(255,255,255,0.06);
  color: var(--text-primary);
  border-color: rgba(99,102,241,0.3);
}

.task-card {
  background: var(--bg-secondary);
  border: 1px solid var(--border);
  border-radius: 10px;
  transition: all 0.25s;
}
.task-card:hover {
  border-color: var(--border-bright);
  box-shadow: 0 4px 20px rgba(0,0,0,0.4);
  transform: translateY(-2px);
}

.modal-overlay {
  background: rgba(5,5,8,0.85);
  backdrop-filter: blur(8px);
}
.modal-box {
  background: var(--bg-card);
  border: 1px solid var(--border-bright);
  border-radius: 16px;
  box-shadow: 0 25px 60px rgba(0,0,0,0.6), 0 0 0 1px rgba(99,102,241,0.1);
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(16px); }
  to { opacity: 1; transform: translateY(0); }
}
.fade-up { animation: fadeUp 0.4s ease forwards; }
.fade-up-1 { animation: fadeUp 0.4s ease 0.05s forwards; opacity: 0; }
.fade-up-2 { animation: fadeUp 0.4s ease 0.1s forwards; opacity: 0; }
.fade-up-3 { animation: fadeUp 0.4s ease 0.15s forwards; opacity: 0; }
.fade-up-4 { animation: fadeUp 0.4s ease 0.2s forwards; opacity: 0; }
.fade-up-5 { animation: fadeUp 0.4s ease 0.25s forwards; opacity: 0; }

@keyframes spin { to { transform: rotate(360deg); } }
.spinner {
  width: 36px; height: 36px;
  border: 2px solid var(--border);
  border-top-color: var(--accent);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
'@ | Set-Content -Encoding UTF8 src\index.css
Write-Host "index.css updated" -ForegroundColor Green

# ── App.jsx ───────────────────────────────────────────────
@'
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "./context/AuthContext";
import Navbar from "./components/Navbar";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import Projects from "./pages/Projects";
import ProjectDetail from "./pages/ProjectDetail";

const PrivateRoute = ({ children }) => {
  const { user, loading } = useAuth();
  if (loading) return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 16, background: 'var(--bg-primary)' }}>
      <div className="spinner" />
      <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 13, color: 'var(--text-muted)', letterSpacing: '0.1em' }}>INITIALIZING...</span>
    </div>
  );
  return user ? children : <Navigate to="/login" replace />;
};

function AppRoutes() {
  const { user } = useAuth();
  return (
    <>
      {user && <Navbar />}
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/dashboard" element={<PrivateRoute><Dashboard /></PrivateRoute>} />
        <Route path="/projects" element={<PrivateRoute><Projects /></PrivateRoute>} />
        <Route path="/projects/:id" element={<PrivateRoute><ProjectDetail /></PrivateRoute>} />
        <Route path="*" element={<Navigate to={user ? "/dashboard" : "/login"} replace />} />
      </Routes>
    </>
  );
}

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <AppRoutes />
      </AuthProvider>
    </BrowserRouter>
  );
}
'@ | Set-Content -Encoding UTF8 src\App.jsx
Write-Host "App.jsx updated" -ForegroundColor Green

# ── Navbar.jsx ────────────────────────────────────────────
@'
import { Link, useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "../context/AuthContext";

export default function Navbar() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const handleLogout = () => { logout(); navigate("/login"); };

  const navLinks = [
    { to: "/dashboard", label: "Dashboard" },
    { to: "/projects", label: "Projects" },
  ];

  return (
    <nav style={{
      position: 'sticky', top: 0, zIndex: 100,
      background: 'rgba(5,5,8,0.85)',
      backdropFilter: 'blur(20px)',
      borderBottom: '1px solid rgba(99,102,241,0.15)',
    }}>
      <div style={{ maxWidth: 1200, margin: '0 auto', padding: '0 24px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: 60 }}>

        <Link to="/dashboard" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{
            width: 32, height: 32,
            background: 'linear-gradient(135deg, #6366f1, #06b6d4)',
            borderRadius: 8,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 14, fontWeight: 800, color: 'white',
            boxShadow: '0 0 16px rgba(99,102,241,0.4)',
          }}>T</div>
          <span style={{ fontFamily: 'Syne, sans-serif', fontWeight: 700, fontSize: 18, color: '#e2e8f0', letterSpacing: '0.02em' }}>
            Task<span style={{ color: '#6366f1' }}>Manager</span>
          </span>
        </Link>

        <div style={{ display: 'flex', gap: 4 }}>
          {navLinks.map(link => {
            const active = location.pathname === link.to;
            return (
              <Link key={link.to} to={link.to} style={{
                textDecoration: 'none', padding: '6px 16px', borderRadius: 8,
                fontFamily: 'Syne, sans-serif', fontWeight: 500, fontSize: 14,
                color: active ? '#6366f1' : '#94a3b8',
                background: active ? 'rgba(99,102,241,0.1)' : 'transparent',
                border: active ? '1px solid rgba(99,102,241,0.3)' : '1px solid transparent',
                transition: 'all 0.2s',
              }}>
                {link.label}
              </Link>
            );
          })}
        </div>

        {user && (
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
              <div className="pulse-dot" />
              <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: '#94a3b8' }}>{user.name}</span>
              <span style={{
                fontFamily: 'JetBrains Mono, monospace', fontSize: 10,
                padding: '2px 8px', borderRadius: 4,
                background: user.role === 'admin' ? 'rgba(99,102,241,0.15)' : 'rgba(6,182,212,0.1)',
                color: user.role === 'admin' ? '#818cf8' : '#67e8f9',
                border: `1px solid ${user.role === 'admin' ? 'rgba(99,102,241,0.3)' : 'rgba(6,182,212,0.2)'}`,
                textTransform: 'uppercase', letterSpacing: '0.1em',
              }}>{user.role}</span>
            </div>
            <button onClick={handleLogout} style={{
              background: 'rgba(239,68,68,0.08)', color: '#f87171',
              border: '1px solid rgba(239,68,68,0.2)', borderRadius: 8,
              padding: '6px 14px', fontFamily: 'Syne, sans-serif',
              fontWeight: 500, fontSize: 13, cursor: 'pointer', transition: 'all 0.2s',
            }}
            onMouseEnter={e => { e.currentTarget.style.background = 'rgba(239,68,68,0.15)'; }}
            onMouseLeave={e => { e.currentTarget.style.background = 'rgba(239,68,68,0.08)'; }}
            >Logout</button>
          </div>
        )}
      </div>
    </nav>
  );
}
'@ | Set-Content -Encoding UTF8 src\components\Navbar.jsx
Write-Host "Navbar.jsx updated" -ForegroundColor Green

# ── Login.jsx ─────────────────────────────────────────────
@'
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
              <input type="password" required placeholder="••••••••" className="futuristic-input"
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
'@ | Set-Content -Encoding UTF8 src\pages\Login.jsx
Write-Host "Login.jsx updated" -ForegroundColor Green

# ── Register.jsx ──────────────────────────────────────────
@'
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
'@ | Set-Content -Encoding UTF8 src\pages\Register.jsx
Write-Host "Register.jsx updated" -ForegroundColor Green

# ── Dashboard.jsx ─────────────────────────────────────────
@'
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../services/api";
import { useAuth } from "../context/AuthContext";

const STAT_CONFIG = [
  { key: 'total',      label: 'Total Tasks', icon: '◈', color: '#6366f1', bg: 'rgba(99,102,241,0.1)',  border: 'rgba(99,102,241,0.2)' },
  { key: 'todo',       label: 'To Do',       icon: '○', color: '#f59e0b', bg: 'rgba(245,158,11,0.08)', border: 'rgba(245,158,11,0.2)' },
  { key: 'inProgress', label: 'In Progress', icon: '◑', color: '#06b6d4', bg: 'rgba(6,182,212,0.08)',  border: 'rgba(6,182,212,0.2)' },
  { key: 'done',       label: 'Completed',   icon: '●', color: '#10b981', bg: 'rgba(16,185,129,0.08)', border: 'rgba(16,185,129,0.2)' },
  { key: 'overdue',   label: 'Overdue',      icon: '!', color: '#ef4444', bg: 'rgba(239,68,68,0.08)',  border: 'rgba(239,68,68,0.2)' },
];

const STATUS_MAP = {
  active:    { color: '#10b981', bg: 'rgba(16,185,129,0.1)', label: 'Active' },
  completed: { color: '#6366f1', bg: 'rgba(99,102,241,0.1)', label: 'Done' },
  archived:  { color: '#475569', bg: 'rgba(71,85,105,0.1)',  label: 'Archived' },
};

export default function Dashboard() {
  const { user } = useAuth();
  const [stats, setStats] = useState(null);
  const [projects, setProjects] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([api.get("/dashboard"), api.get("/projects")])
      .then(([s, p]) => { setStats(s.data); setProjects(p.data); })
      .finally(() => setLoading(false));
  }, []);

  if (loading) return (
    <div style={{ minHeight: '80vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 16 }}>
      <div className="spinner" />
      <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)', letterSpacing: '0.1em' }}>LOADING DASHBOARD...</span>
    </div>
  );

  return (
    <div style={{ maxWidth: 1200, margin: '0 auto', padding: '40px 24px' }}>
      <div className="fade-up" style={{ marginBottom: 40 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 6 }}>
          <div className="pulse-dot" />
          <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.15em', textTransform: 'uppercase' }}>Live Dashboard</span>
        </div>
        <h1 style={{ fontFamily: 'Syne, sans-serif', fontSize: 36, fontWeight: 800, color: '#e2e8f0', lineHeight: 1.1 }}>
          Hello, <span style={{ color: '#6366f1' }}>{user?.name}</span>
        </h1>
        <p style={{ color: 'var(--text-muted)', marginTop: 6, fontSize: 15 }}>Here is what is happening with your tasks today.</p>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: 16, marginBottom: 48 }}>
        {STAT_CONFIG.map((s, i) => (
          <div key={s.key} className={`fade-up-${i + 1}`}
            style={{ background: s.bg, border: `1px solid ${s.border}`, borderRadius: 14, padding: '20px 16px', textAlign: 'center', transition: 'transform 0.2s', cursor: 'default' }}
            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-3px)'}
            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
            <div style={{ fontSize: 22, color: s.color, marginBottom: 8 }}>{s.icon}</div>
            <div style={{ fontFamily: 'Syne, sans-serif', fontSize: 32, fontWeight: 800, color: s.color, lineHeight: 1 }}>{stats?.[s.key] || 0}</div>
            <div style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 10, color: 'var(--text-muted)', marginTop: 6, letterSpacing: '0.08em', textTransform: 'uppercase' }}>{s.label}</div>
          </div>
        ))}
      </div>

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 }}>
        <h2 style={{ fontFamily: 'Syne, sans-serif', fontSize: 20, fontWeight: 700, color: '#e2e8f0' }}>Recent Projects</h2>
        <Link to="/projects" style={{ textDecoration: 'none', fontFamily: 'Syne, sans-serif', fontWeight: 600, fontSize: 13, color: '#818cf8', background: 'rgba(99,102,241,0.1)', border: '1px solid rgba(99,102,241,0.25)', padding: '7px 16px', borderRadius: 8 }}>View All</Link>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16 }}>
        {projects.slice(0, 6).map((p, i) => {
          const s = STATUS_MAP[p.status] || STATUS_MAP.active;
          return (
            <Link key={p._id} to={`/projects/${p._id}`} className={`glass-card fade-up-${(i % 3) + 1}`}
              style={{ borderRadius: 14, padding: 22, textDecoration: 'none', display: 'block' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 10 }}>
                <h3 style={{ fontFamily: 'Syne, sans-serif', fontWeight: 700, fontSize: 16, color: '#e2e8f0', lineHeight: 1.3 }}>{p.name}</h3>
                <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 10, padding: '3px 8px', borderRadius: 4, background: s.bg, color: s.color, textTransform: 'uppercase', letterSpacing: '0.08em', flexShrink: 0, marginLeft: 8 }}>{s.label}</span>
              </div>
              <p style={{ color: 'var(--text-muted)', fontSize: 13, marginBottom: 14, lineHeight: 1.5 }}>{p.description || "No description provided."}</p>
              <div style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)' }}>{p.members?.length || 0} members</div>
            </Link>
          );
        })}
        {projects.length === 0 && (
          <div style={{ gridColumn: '1/-1', textAlign: 'center', padding: '60px 24px', color: 'var(--text-muted)' }}>
            <div style={{ fontSize: 40, marginBottom: 12 }}>◈</div>
            <p style={{ fontFamily: 'Syne, sans-serif' }}>No projects yet. <Link to="/projects" style={{ color: '#818cf8' }}>Create one!</Link></p>
          </div>
        )}
      </div>
    </div>
  );
}
'@ | Set-Content -Encoding UTF8 src\pages\Dashboard.jsx
Write-Host "Dashboard.jsx updated" -ForegroundColor Green

# ── Projects.jsx ──────────────────────────────────────────
@'
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../services/api";

const STATUS_MAP = {
  active:    { color: '#10b981', bg: 'rgba(16,185,129,0.1)',  label: 'Active' },
  completed: { color: '#6366f1', bg: 'rgba(99,102,241,0.1)', label: 'Done' },
  archived:  { color: '#475569', bg: 'rgba(71,85,105,0.1)',  label: 'Archived' },
};

export default function Projects() {
  const [projects, setProjects] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [form, setForm] = useState({ name: "", description: "" });
  const [loading, setLoading] = useState(true);
  const [creating, setCreating] = useState(false);

  const fetchProjects = () => {
    api.get("/projects").then(r => setProjects(r.data)).finally(() => setLoading(false));
  };
  useEffect(() => { fetchProjects(); }, []);

  const handleCreate = async (e) => {
    e.preventDefault();
    setCreating(true);
    await api.post("/projects", form);
    setForm({ name: "", description: "" });
    setShowModal(false);
    fetchProjects();
    setCreating(false);
  };

  if (loading) return (
    <div style={{ minHeight: '80vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 16 }}>
      <div className="spinner" />
      <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)', letterSpacing: '0.1em' }}>LOADING PROJECTS...</span>
    </div>
  );

  return (
    <div style={{ maxWidth: 1100, margin: '0 auto', padding: '40px 24px' }}>
      <div className="fade-up" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 36 }}>
        <div>
          <h1 style={{ fontFamily: 'Syne, sans-serif', fontSize: 32, fontWeight: 800, color: '#e2e8f0' }}>Projects</h1>
          <p style={{ color: 'var(--text-muted)', marginTop: 4, fontFamily: 'JetBrains Mono, monospace', fontSize: 12, letterSpacing: '0.05em' }}>{projects.length} project{projects.length !== 1 ? 's' : ''} total</p>
        </div>
        <button onClick={() => setShowModal(true)} className="btn-primary" style={{ padding: '10px 22px', borderRadius: 10, fontSize: 14 }}>+ New Project</button>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: 16 }}>
        {projects.map((p, i) => {
          const s = STATUS_MAP[p.status] || STATUS_MAP.active;
          return (
            <Link key={p._id} to={`/projects/${p._id}`} className={`glass-card gradient-border fade-up-${(i % 4) + 1}`}
              style={{ textDecoration: 'none', display: 'block', padding: 24, borderRadius: 14 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 12 }}>
                <h3 style={{ fontFamily: 'Syne, sans-serif', fontWeight: 700, fontSize: 17, color: '#e2e8f0', lineHeight: 1.3 }}>{p.name}</h3>
                <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 10, padding: '3px 9px', borderRadius: 4, flexShrink: 0, marginLeft: 10, background: s.bg, color: s.color, textTransform: 'uppercase', letterSpacing: '0.08em' }}>{s.label}</span>
              </div>
              <p style={{ color: 'var(--text-muted)', fontSize: 13, lineHeight: 1.6, marginBottom: 16, minHeight: 40 }}>{p.description || "No description provided."}</p>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)' }}>{p.members?.length || 0} member{p.members?.length !== 1 ? 's' : ''}</span>
                <span style={{ fontFamily: 'Syne, sans-serif', fontSize: 12, color: '#6366f1' }}>View</span>
              </div>
            </Link>
          );
        })}
        {projects.length === 0 && (
          <div style={{ gridColumn: '1/-1', textAlign: 'center', padding: '80px 24px', color: 'var(--text-muted)' }}>
            <div style={{ fontSize: 48, marginBottom: 16 }}>◈</div>
            <p style={{ fontFamily: 'Syne, sans-serif', fontSize: 16, marginBottom: 8 }}>No projects yet</p>
            <p style={{ fontSize: 13 }}>Click + New Project to get started</p>
          </div>
        )}
      </div>

      {showModal && (
        <div className="modal-overlay" style={{ position: 'fixed', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 999, padding: 24 }}>
          <div className="modal-box" style={{ width: '100%', maxWidth: 460, padding: 32 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 28 }}>
              <h2 style={{ fontFamily: 'Syne, sans-serif', fontWeight: 800, fontSize: 22, color: '#e2e8f0' }}>New Project</h2>
              <button onClick={() => setShowModal(false)} style={{ background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: 22, lineHeight: 1 }}>x</button>
            </div>
            <form onSubmit={handleCreate}>
              <div style={{ marginBottom: 16 }}>
                <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Project Name</label>
                <input required placeholder="My Awesome Project" className="futuristic-input" value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} />
              </div>
              <div style={{ marginBottom: 28 }}>
                <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Description</label>
                <textarea placeholder="What is this project about?" className="futuristic-input" style={{ resize: 'vertical', minHeight: 90 }} value={form.description} onChange={e => setForm({ ...form, description: e.target.value })} rows={3} />
              </div>
              <div style={{ display: 'flex', gap: 12 }}>
                <button type="submit" disabled={creating} className="btn-primary" style={{ flex: 1, padding: '12px', borderRadius: 10, fontSize: 14 }}>{creating ? "Creating..." : "Create Project"}</button>
                <button type="button" onClick={() => setShowModal(false)} className="btn-ghost" style={{ flex: 1, padding: '12px', borderRadius: 10, fontSize: 14 }}>Cancel</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
'@ | Set-Content -Encoding UTF8 src\pages\Projects.jsx
Write-Host "Projects.jsx updated" -ForegroundColor Green

# ── ProjectDetail.jsx ─────────────────────────────────────
@'
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import api from "../services/api";
import { useAuth } from "../context/AuthContext";

const PRIORITY_CONFIG = {
  low:    { color: '#10b981', bg: 'rgba(16,185,129,0.1)',  label: 'Low' },
  medium: { color: '#f59e0b', bg: 'rgba(245,158,11,0.08)', label: 'Medium' },
  high:   { color: '#ef4444', bg: 'rgba(239,68,68,0.08)',  label: 'High' },
};

const COLUMNS = [
  { id: 'todo',        label: 'To Do',       color: '#f59e0b', icon: 'O' },
  { id: 'in-progress', label: 'In Progress', color: '#06b6d4', icon: '~' },
  { id: 'done',        label: 'Done',        color: '#10b981', icon: 'V' },
];

export default function ProjectDetail() {
  const { id } = useParams();
  const { user } = useAuth();
  const [project, setProject] = useState(null);
  const [tasks, setTasks] = useState([]);
  const [showModal, setShowModal] = useState(false);
  const [form, setForm] = useState({ title: "", description: "", priority: "medium", dueDate: "", status: "todo" });
  const [loading, setLoading] = useState(true);

  const fetchAll = () => {
    Promise.all([api.get(`/projects/${id}`), api.get(`/projects/${id}/tasks`)])
      .then(([p, t]) => { setProject(p.data); setTasks(t.data); })
      .finally(() => setLoading(false));
  };
  useEffect(() => { fetchAll(); }, [id]);

  const handleCreate = async (e) => {
    e.preventDefault();
    await api.post(`/projects/${id}/tasks`, form);
    setForm({ title: "", description: "", priority: "medium", dueDate: "", status: "todo" });
    setShowModal(false);
    fetchAll();
  };

  const handleStatusChange = async (taskId, status) => {
    await api.put(`/projects/${id}/tasks/${taskId}`, { status });
    fetchAll();
  };

  const handleDelete = async (taskId) => {
    if (!window.confirm("Delete this task?")) return;
    await api.delete(`/projects/${id}/tasks/${taskId}`);
    fetchAll();
  };

  if (loading) return (
    <div style={{ minHeight: '80vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 16 }}>
      <div className="spinner" />
      <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 12, color: 'var(--text-muted)', letterSpacing: '0.1em' }}>LOADING PROJECT...</span>
    </div>
  );

  return (
    <div style={{ maxWidth: 1200, margin: '0 auto', padding: '40px 24px' }}>
      <div className="fade-up" style={{ marginBottom: 36 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div>
            <h1 style={{ fontFamily: 'Syne, sans-serif', fontSize: 30, fontWeight: 800, color: '#e2e8f0', marginBottom: 6 }}>{project?.name}</h1>
            {project?.description && <p style={{ color: 'var(--text-muted)', fontSize: 14, marginBottom: 10 }}>{project.description}</p>}
            <div style={{ display: 'flex', gap: 16, alignItems: 'center' }}>
              <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)' }}>Owner: <span style={{ color: '#818cf8' }}>{project?.owner?.name}</span></span>
              <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)' }}>{project?.members?.length || 0} members</span>
              <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)' }}>{tasks.length} tasks</span>
            </div>
          </div>
          <button onClick={() => setShowModal(true)} className="btn-primary" style={{ padding: '10px 22px', borderRadius: 10, fontSize: 14, flexShrink: 0 }}>+ Add Task</button>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 18 }}>
        {COLUMNS.map((col, ci) => {
          const colTasks = tasks.filter(t => t.status === col.id);
          return (
            <div key={col.id} className={`fade-up-${ci + 1}`}
              style={{ background: 'rgba(15,15,26,0.8)', border: '1px solid var(--border)', borderRadius: 14, overflow: 'hidden' }}>
              <div style={{ padding: '16px 18px', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <span style={{ color: col.color, fontSize: 16 }}>{col.icon}</span>
                  <span style={{ fontFamily: 'Syne, sans-serif', fontWeight: 700, fontSize: 14, color: '#e2e8f0' }}>{col.label}</span>
                </div>
                <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 11, padding: '2px 8px', borderRadius: 4, background: `${col.color}18`, color: col.color }}>{colTasks.length}</span>
              </div>
              <div style={{ padding: 12, minHeight: 200, display: 'flex', flexDirection: 'column', gap: 10 }}>
                {colTasks.map(task => {
                  const pr = PRIORITY_CONFIG[task.priority] || PRIORITY_CONFIG.medium;
                  const isOverdue = task.dueDate && new Date(task.dueDate) < new Date() && task.status !== 'done';
                  return (
                    <div key={task._id} className="task-card" style={{ padding: 14 }}>
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 8 }}>
                        <h4 style={{ fontFamily: 'Syne, sans-serif', fontWeight: 600, fontSize: 14, color: '#e2e8f0', lineHeight: 1.3, flex: 1 }}>{task.title}</h4>
                        <button onClick={() => handleDelete(task._id)}
                          style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--text-muted)', fontSize: 16, paddingLeft: 8, flexShrink: 0, lineHeight: 1, transition: 'color 0.2s' }}
                          onMouseEnter={e => e.currentTarget.style.color = '#ef4444'}
                          onMouseLeave={e => e.currentTarget.style.color = 'var(--text-muted)'}>x</button>
                      </div>
                      {task.description && <p style={{ color: 'var(--text-muted)', fontSize: 12, lineHeight: 1.5, marginBottom: 10 }}>{task.description}</p>}
                      <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', marginBottom: 10 }}>
                        <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 10, padding: '2px 8px', borderRadius: 4, background: pr.bg, color: pr.color, textTransform: 'uppercase', letterSpacing: '0.05em' }}>{pr.label}</span>
                        {task.dueDate && (
                          <span style={{ fontFamily: 'JetBrains Mono, monospace', fontSize: 10, padding: '2px 8px', borderRadius: 4, background: isOverdue ? 'rgba(239,68,68,0.1)' : 'rgba(255,255,255,0.04)', color: isOverdue ? '#f87171' : 'var(--text-muted)', border: isOverdue ? '1px solid rgba(239,68,68,0.2)' : '1px solid transparent' }}>
                            {isOverdue ? '! ' : ''}Due: {new Date(task.dueDate).toLocaleDateString()}
                          </span>
                        )}
                      </div>
                      <select value={task.status} onChange={e => handleStatusChange(task._id, e.target.value)} className="futuristic-input" style={{ padding: '6px 10px', fontSize: 12, borderRadius: 8 }}>
                        <option value="todo">To Do</option>
                        <option value="in-progress">In Progress</option>
                        <option value="done">Done</option>
                      </select>
                    </div>
                  );
                })}
                {colTasks.length === 0 && (
                  <div style={{ textAlign: 'center', padding: '40px 16px', color: 'var(--text-muted)', fontFamily: 'JetBrains Mono, monospace', fontSize: 12 }}>empty</div>
                )}
              </div>
            </div>
          );
        })}
      </div>

      {showModal && (
        <div className="modal-overlay" style={{ position: 'fixed', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 999, padding: 24 }}>
          <div className="modal-box" style={{ width: '100%', maxWidth: 480, padding: 32 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 28 }}>
              <h2 style={{ fontFamily: 'Syne, sans-serif', fontWeight: 800, fontSize: 22, color: '#e2e8f0' }}>New Task</h2>
              <button onClick={() => setShowModal(false)} style={{ background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: 22, lineHeight: 1 }}>x</button>
            </div>
            <form onSubmit={handleCreate}>
              {[
                { label: 'Title', key: 'title', type: 'text', ph: 'Task title...' },
                { label: 'Description', key: 'description', type: 'textarea', ph: 'Details (optional)' },
              ].map(f => (
                <div key={f.key} style={{ marginBottom: 16 }}>
                  <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>{f.label}</label>
                  {f.type === 'textarea'
                    ? <textarea placeholder={f.ph} className="futuristic-input" style={{ minHeight: 80, resize: 'vertical' }} rows={3} value={form[f.key]} onChange={e => setForm({ ...form, [f.key]: e.target.value })} />
                    : <input required={f.key === 'title'} type={f.type} placeholder={f.ph} className="futuristic-input" value={form[f.key]} onChange={e => setForm({ ...form, [f.key]: e.target.value })} />
                  }
                </div>
              ))}
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12, marginBottom: 28 }}>
                <div>
                  <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Priority</label>
                  <select value={form.priority} onChange={e => setForm({ ...form, priority: e.target.value })} className="futuristic-input" style={{ padding: '10px 12px' }}>
                    <option value="low">Low</option>
                    <option value="medium">Medium</option>
                    <option value="high">High</option>
                  </select>
                </div>
                <div>
                  <label style={{ display: 'block', fontFamily: 'JetBrains Mono, monospace', fontSize: 11, color: 'var(--text-muted)', letterSpacing: '0.1em', marginBottom: 8, textTransform: 'uppercase' }}>Due Date</label>
                  <input type="date" value={form.dueDate} onChange={e => setForm({ ...form, dueDate: e.target.value })} className="futuristic-input" style={{ padding: '10px 12px', colorScheme: 'dark' }} />
                </div>
              </div>
              <div style={{ display: 'flex', gap: 12 }}>
                <button type="submit" className="btn-primary" style={{ flex: 1, padding: '12px', borderRadius: 10, fontSize: 14 }}>Create Task</button>
                <button type="button" onClick={() => setShowModal(false)} className="btn-ghost" style={{ flex: 1, padding: '12px', borderRadius: 10, fontSize: 14 }}>Cancel</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
'@ | Set-Content -Encoding UTF8 src\pages\ProjectDetail.jsx
Write-Host "ProjectDetail.jsx updated" -ForegroundColor Green

# ── App.css ───────────────────────────────────────────────
@'
/* All styles are in index.css */
'@ | Set-Content -Encoding UTF8 src\App.css
Write-Host "App.css cleared" -ForegroundColor Green

# ── tailwind.config.js ────────────────────────────────────
@'
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: { extend: {} },
  plugins: [],
}
'@ | Set-Content -Encoding UTF8 tailwind.config.js
Write-Host "tailwind.config.js updated" -ForegroundColor Green

Write-Host ""
Write-Host "Saare files update ho gaye! Ab run karo:" -ForegroundColor Cyan
Write-Host "  npm run dev" -ForegroundColor Yellow