/* eslint-disable no-unused-vars */
import styled from "@emotion/styled";
import { gql, useQuery } from "@apollo/client";
import { Post } from "./post/post";
import { Header } from "../../components/header/header";

const MainComponent = styled.main`
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
`;

const MainCmp = ({ posts }) => {
  return (
    <div>
      <Header></Header>
      <MainComponent>
        {posts.map((post) => (
          <Post key={`${post._id}`} post={post}></Post>
        ))}
      </MainComponent>
    </div>
  );
};

const query = gql`
  {
    posts {
      header
      content
      date
      description
      tags
      img
      _id
    }
  }
`;

export const Main = () => {
  const { loading, error, data } = useQuery(query);
  const realPosts = data?.posts || [];

  return <MainCmp posts={realPosts}></MainCmp>;
};
