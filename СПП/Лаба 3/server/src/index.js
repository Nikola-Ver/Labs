import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import { postRouter } from "./routes/postRoutes.js";
import cors from "cors";
import { userRouter } from "./routes/userRoutes.js";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";

dotenv.config();

const app = express();
app.use(cors({ origin: "http://localhost:3000", credentials: true }));
app.use(cookieParser());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/post", postRouter);
app.use("/user", userRouter);
app.use(express.static("."));

app.listen(5000, async () => {
  await mongoose.connect(process.env.DB_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

  console.info("Hello world");
});
