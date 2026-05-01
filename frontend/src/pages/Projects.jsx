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
            <div style={{ fontSize: 48, marginBottom: 16 }}>â—ˆ</div>
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
