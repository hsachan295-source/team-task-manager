const express = require("express");
const cors = require("cors");
const morgan = require("morgan");
const authRoutes = require("./routes/authRoutes");
const projectRoutes = require("./routes/projectRoutes");
const { getDashboard } = require("./controllers/taskController");
const { protect } = require("./middleware/auth");

const app = express();

app.use(cors({
  origin: ["http://localhost:5173", "http://localhost:3000"],
  credentials: true
}));
app.use(express.json());
app.use(morgan("dev"));

app.use("/api/auth", authRoutes);
app.use("/api/projects", projectRoutes);
app.get("/api/dashboard", protect, getDashboard);

app.get("/", (req, res) => res.json({ message: "API is running" }));

module.exports = app;