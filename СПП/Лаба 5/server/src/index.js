import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import { postRouter } from "./routes/postRoutes.js";
import cors from "cors";
import { userRouter } from "./routes/userRoutes.js";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";
import { Server } from "socket.io";
import http from "http";
import { authService } from "./services/authService.js";
import { userService } from "./services/userService.js";
import { postService } from "./services/postService.js";
import { promises as fs } from "fs";
import { graphqlHTTP } from "express-graphql";
import { schema } from "./schema.js";

dotenv.config();

const app = express();
const httpServer = http.Server(app);

app.use(cors({ origin: process.env.ORIGIN, credentials: true }));
app.use(cookieParser());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(
  "/graphql",
  graphqlHTTP({
    schema,
    graphiql: true,
  })
);

app.use("/post", postRouter);
app.use("/user", userRouter);
app.use(express.static("."));

export const io = new Server(httpServer, {
  cors: {
    origin: process.env.ORIGIN,
    methods: ["GET", "POST"],
  },
});

io.on("connection", async (socket) => {
  socket.on("req/user/auth", async ({ login, password }) => {
    const result = await authService.authorize({ login, password });
    if (result.status) {
      socket.emit("res/user/auth", {
        status: "success",
        user: { ...result.user, token: result.token },
      });
    } else {
      socket.emit("res/user/auth", {
        status: "error",
      });
    }
  });

  socket.on("req/user/create", async ({ login, password, name }) => {
    const result = await userService.create({ login, password, name });
    socket.emit("res/user/create", {
      status: "success",
      user: result,
    });
  });

  socket.on("req/posts", async ({}) => {
    const posts = await postService.getAll();
    socket.emit("res/posts", {
      status: "success",
      posts,
    });
  });

  socket.on("req/post", async ({ id }) => {
    const post = await postService.getById(id);
    socket.emit("res/post", {
      status: "success",
      post,
    });
  });

  socket.on(
    "req/post/create",
    async ({ header, content, date, description, tags, user, img }) => {
      const filePath = `uploads/${Math.random()}`;
      await fs.writeFile(filePath, img);

      const post = await postService.create({
        header,
        content,
        date,
        description,
        tags,
        user,
        img: filePath,
      });
      socket.emit("res/post/create", {
        status: "success",
        post,
      });
    }
  );
});

httpServer.listen(5000, async () => {
  await mongoose.connect(process.env.DB_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
});
