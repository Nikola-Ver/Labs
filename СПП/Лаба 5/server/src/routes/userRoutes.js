import express from "express";
import { authService } from "../services/authService.js";
import { userService } from "../services/userService.js";

export const userRouter = express.Router();

userRouter.post("/", async (req, res) => {
  const { login, password, name } = req.body;
  const result = await userService.create({ login, password, name });
  res.send(result);
});

userRouter.post("/auth/logout", async (req, res) => {
  res.cookie("token", null, { httpOnly: true });
  res.send({});
});

userRouter.post("/auth", async (req, res) => {
  const { login, password } = req.body;
  const result = await authService.authorize({ login, password });
  if (result.status) {
    res.cookie("token", result.token, { httpOnly: true });
    res.send(result);
  } else {
    res.status(403).send();
  }
});
