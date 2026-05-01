import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import api from "../services/api";
import { useAuth } from "../context/AuthContext";

const STAT_CONFIG = [
  { key: 'total',      label: 'Total Tasks', icon: 'â—ˆ', color: '#6366f1', bg: 'rgba(99,102,241,0.1)',  border: 'rgba(99,102,241,0.2)' },
  { key: 'todo',       label: 'To Do',       icon: 'â—‹', color: '#f59e0b', bg: 'rgba(245,158,11,0.08)', border: 'rgba(245,158,11,0.2)' },
  { key: 'inProgress', label: 'In Progress', icon: 'â—‘', color: '#06b6d4', bg: 'rgba(6,182,212,0.08)',  border: 'rgba(6,182,212,0.2)' },
  { key: 'done',       label: 'Completed',   icon: 'â—', color: '#10b981', bg: 'rgba(16,185,129,0.08)', border: 'rgba(16,185,129,0.2)' },
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
            <div style={{ fontSize: 40, marginBottom: 12 }}>â—ˆ</div>
            <p style={{ fontFamily: 'Syne, sans-serif' }}>No projects yet. <Link to="/projects" style={{ color: '#818cf8' }}>Create one!</Link></p>
          </div>
        )}
      </div>
    </div>
  );
}
