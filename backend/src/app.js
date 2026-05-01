const express = require("express");
const cors = require("cors");
const morgan = require("morgan");

const authRoutes = require("./routes/authRoutes");
const projectRoutes = require("./routes/projectRoutes");
const { getDashboard } = require("./controllers/taskController");
const { protect } = require("./middleware/auth");

const app = express();

// ✅ Allowed origins (local + production)
const allowedOrigins = [
  "http://localhost:5173",
  "http://localhost:3000",
  "https://team-task-manager-gamma-khaki.vercel.app"
];

// ✅ CORS setup (production ready)
app.use(cors({
  origin: function (origin, callback) {
    // allow requests with no origin (like Postman)
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error("Not allowed by CORS"));
    }
  },
  credentials: true
}));

// Middleware
app.use(express.json());
app.use(morgan("dev"));

// Routes
app.use("/api/auth", authRoutes);
app.use("/api/projects", projectRoutes);
app.get("/api/dashboard", protect, getDashboard);

// Test route
app.get("/", (req, res) => {
  res.json({ message: "API is running" });
});

module.exports = app;