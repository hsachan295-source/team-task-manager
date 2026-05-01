const router = require("express").Router();
const { protect } = require("../middleware/auth");
const { getProjects, createProject, getProject, updateProject, deleteProject, addMember } = require("../controllers/projectController");
const taskRoutes = require("./taskRoutes");
router.use("/:projectId/tasks", taskRoutes);
router.route("/").get(protect, getProjects).post(protect, createProject);
router.route("/:id").get(protect, getProject).put(protect, updateProject).delete(protect, deleteProject);
router.post("/:id/members", protect, addMember);
module.exports = router;
