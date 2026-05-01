const Project = require("../models/Project");
exports.getProjects = async (req, res) => {
  try {
    const projects = await Project.find({ $or: [{ owner: req.user._id }, { "members.user": req.user._id }] })
      .populate("owner", "name email").populate("members.user", "name email");
    res.json(projects);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.createProject = async (req, res) => {
  try {
    const { name, description } = req.body;
    const project = await Project.create({ name, description, owner: req.user._id, members: [{ user: req.user._id, role: "admin" }] });
    res.status(201).json(project);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.getProject = async (req, res) => {
  try {
    const project = await Project.findById(req.params.id).populate("owner", "name email").populate("members.user", "name email");
    if (!project) return res.status(404).json({ message: "Project not found" });
    res.json(project);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.updateProject = async (req, res) => {
  try {
    const project = await Project.findById(req.params.id);
    if (!project) return res.status(404).json({ message: "Project not found" });
    if (project.owner.toString() !== req.user._id.toString())
      return res.status(403).json({ message: "Not authorized" });
    Object.assign(project, req.body);
    await project.save();
    res.json(project);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.deleteProject = async (req, res) => {
  try {
    const project = await Project.findById(req.params.id);
    if (!project) return res.status(404).json({ message: "Project not found" });
    if (project.owner.toString() !== req.user._id.toString())
      return res.status(403).json({ message: "Not authorized" });
    await project.deleteOne();
    res.json({ message: "Project deleted" });
  } catch (err) { res.status(500).json({ message: err.message }); }
};
exports.addMember = async (req, res) => {
  try {
    const project = await Project.findById(req.params.id);
    if (!project) return res.status(404).json({ message: "Project not found" });
    const already = project.members.find(m => m.user.toString() === req.body.userId);
    if (already) return res.status(400).json({ message: "Already a member" });
    project.members.push({ user: req.body.userId, role: req.body.role || "member" });
    await project.save();
    res.json(project);
  } catch (err) { res.status(500).json({ message: err.message }); }
};
