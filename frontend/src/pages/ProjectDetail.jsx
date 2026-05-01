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
