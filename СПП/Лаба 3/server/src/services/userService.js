import { User } from "../models/User.js";
import bcrypt from "bcrypt";

const saltRounds = 10;

class UserService {
  async create({ login, password, name }) {
    const salt = await bcrypt.genSalt(saltRounds);
    const hash = bcrypt.hashSync(password, salt);
    const newUser = new User({ login, hash });
    return newUser.save();
  }

  async getByLogin({ login }) {
    return User.findOne({ login });
  }
}

export const userService = new UserService();
