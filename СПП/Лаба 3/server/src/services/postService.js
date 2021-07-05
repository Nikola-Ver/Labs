import { Post } from "../models/Post.js";

export class PostService {
  async create(params) {
    const { header, content, date, description, tags, img, user } = params;
    const newPost = new Post({
      header,
      content,
      date,
      description,
      tags,
      img,
      user: user._id,
    });

    return newPost.save();
  }

  getById(id) {
    
    return Post.findById(id).exec();
  }

  getAll() {
    return Post.find();
  }
}

export const postService = new PostService();
