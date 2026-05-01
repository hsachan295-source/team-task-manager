const Task = require("../models/Task");
exports.getTasks = async (req, res) => {
  try {
    const tasks = await Task.find({ project: req.params.projectId })
      .populate("assignedTo", "name email").populate("createdBy", "name email");
    res.json(tasks);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.createTask = async (req, res) => {
  try {
    const task = await Task.create({ ...req.body, project: req.params.projectId, createdBy: req.user._id });
    res.status(201).json(task);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.updateTask = async (req, res) => {
  try {
    const task = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!task) return res.status(404).json({ message: "Task not found" });
    res.json(task);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.deleteTask = async (req, res) => {
  try {
    const task = await Task.findByIdAndDelete(req.params.id);
    if (!task) return res.status(404).json({ message: "Task not found" });
    res.json({ message: "Task deleted" });
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.getDashboard = async (req, res) => {
  try {
    const all = await Task.find({ assignedTo: req.user._id });
    const now = new Date();
    res.json({
      total: all.length,
      todo: all.filter(t => t.status === "todo").length,
      inProgress: all.filter(t => t.status === "in-progress").length,
      done: all.filter(t => t.status === "done").length,
      overdue: all.filter(t => t.dueDate && t.dueDate < now && t.status !== "done").length,
    });
  } catch (err) { res.status(500).json({ message: err.message }); }
};
