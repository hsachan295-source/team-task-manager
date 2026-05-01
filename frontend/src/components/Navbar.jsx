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
