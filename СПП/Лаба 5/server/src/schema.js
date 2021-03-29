import {
  GraphQLString,
  GraphQLObjectType,
  GraphQLSchema,
  GraphQLList,
  GraphQLNonNull,
} from "graphql";
import { postService } from "./services/postService.js";
import { userService } from "./services/userService.js";

const UserType = new GraphQLObjectType({
  name: "User",
  fields: () => ({
    login: { type: GraphQLString },
    hash: { type: GraphQLString },
    name: { type: GraphQLString },
    _id: { type: GraphQLString },
  }),
});

const PostType = new GraphQLObjectType({
  name: "Post",
  fields: () => ({
    header: { type: GraphQLString },
    content: { type: GraphQLString },
    date: { type: GraphQLString },
    tags: { type: GraphQLList(GraphQLString) },
    description: { type: GraphQLString },
    img: { type: GraphQLString },
    user: { type: UserType },
    _id: { type: GraphQLString },
  }),
});

const RootQuery = new GraphQLObjectType({
  name: "RootQueryType",
  fields: {
    user: {
      type: UserType,
      args: {
        login: { type: GraphQLString },
      },
      async resolve(parentValue, args) {
        return userService.getByLogin(args.login);
      },
    },
    post: {
      type: PostType,
      args: {
        id: { type: GraphQLString },
      },
      async resolve(parentValue, args) {
        return postService.getById(args.id);
      },
    },
    posts: {
      type: new GraphQLList(PostType),
      resolve() {
        return postService.getAll();
      },
    },
  },
});

const mutation = new GraphQLObjectType({
  name: "Mutation",
  fields: {
    addPost: {
      type: PostType,
      args: {
        header: { type: new GraphQLNonNull(GraphQLString) },
        content: { type: new GraphQLNonNull(GraphQLString) },
        date: { type: new GraphQLNonNull(GraphQLString) },
        tags: { type: new GraphQLNonNull(GraphQLList(GraphQLString)) },
        description: { type: new GraphQLNonNull(GraphQLString) },
        img: { type: new GraphQLNonNull(GraphQLString) },
      },
      resolve: async (parentValue, args) => {
        const { header, content, date, description, tags, user, img } = args;
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
        return post;
      },
    },
  },
});

export const schema = new GraphQLSchema({ query: RootQuery, mutation });
