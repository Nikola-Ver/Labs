import express from "express";
import { postService } from "../services/postService.js";
import multer from "multer";
import { authMiddleware } from "../middlewares/authMiddleware.js";

export const postRouter = express.Router();

const upload = multer({ dest: "uploads/" });

postRouter.post("/", authMiddleware, upload.single("img"), async (req, res) => {
  const { header, content, date, description, tags, user } = req.body;
  const {
    file: { path: img },
  } = req;
  const result = await postService.create({
    header,
    content,
    date,
    description,
    tags,
    user,
    img,
  });
  res.send(result);
});

postRouter.get("/:id", async (req, res) => {
  const { id } = req.params;

  const post = await postService.getById(id);
  res.send({ post });
});

postRouter.get("/", async (req, res) => {
  const posts = await postService.getAll();
  res.send({ posts });
});
