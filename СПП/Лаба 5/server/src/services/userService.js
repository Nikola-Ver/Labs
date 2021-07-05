import { User } from "../models/User.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

const saltRounds = 10;

class UserService {
  async create({ login, password, name }) {
    const salt = await bcrypt.genSalt(saltRounds);
    const hash = bcrypt.hashSync(password, salt);

    let user = new User({ login, hash, name });
    const token = jwt.sign({ user }, process.env.SECRET_KEY, {
      expiresIn: "7 days",
    });
    user = (await user.save()).toObject();
    user.token = token;

    return user;
  }

  async getByLogin({ login }) {
    return User.findOne({ login });
  }
}

export const userService = new UserService();
