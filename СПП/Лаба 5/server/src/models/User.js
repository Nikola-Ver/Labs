import mongoose from "mongoose";

const UserSchema = new mongoose.Schema(
  {
    login: String,
    hash: String,
    name: String,
  },
  { timestamps: true }
);

export const User = mongoose.model("Users", UserSchema);
