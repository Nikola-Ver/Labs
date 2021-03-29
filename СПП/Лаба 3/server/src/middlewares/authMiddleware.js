import { authService } from "../services/authService.js";

export const authMiddleware = (req, res, next) => {
  const { token } = req.cookies;

  try {
    authService.authenticate(token);
  } catch (e) {
    if (e.message === "invalid token") {
      res.cookie("token", null, { httpOnly: true });
      res.send(401);
      return;
    } else {
      throw e;
    }
  }
  next();
};
