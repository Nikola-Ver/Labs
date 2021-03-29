import { userService } from "./userService.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

class AuthService {
  authenticate(token) {
    const decoded = jwt.verify(token, process.env.SECRET_KEY);
    return decoded;
  }

  async authorize({ login, password }) {
    const user = await userService.getByLogin({ login });
    if (!user) {
      return false;
    }
    const { hash } = user;
    const status = await bcrypt.compare(password, hash);
    const token = jwt.sign({ user }, process.env.SECRET_KEY, {
      expiresIn: "7 days",
    });
    return { status, token, user };
  }
}

export const authService = new AuthService();
