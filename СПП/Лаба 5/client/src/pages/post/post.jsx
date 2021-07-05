/* eslint-disable no-unused-vars */
import styled from "@emotion/styled";
import { Suspense } from "react";
import { gql, useQuery } from "@apollo/client";
import { useParams } from "react-router";
import { Tag, Tags } from "../../components/tags/Tags";
import { Header } from "../../components/header/header";
import { getBackendApi } from "../../helpers/getBackendApi";

const Main = styled.main`
  display: flex;
  justify-content: center;
`;

const Container = styled.main`
  display: flex;
  max-width: 780px;
  flex-direction: column;
  margin-top: 20px;
`;

const ArticleHeader = styled.h1`
  margin: 8px 0;
`;

const Img = styled.img``;

const Content = styled.div`
  margin: 8px 0px;
`;

const Author = styled.div`
  color: ${(props) => props.theme.font.primary};
`;

export const PostComponent = ({ post }) => {
  if (!post) {
    return null;
  }
  return (
    <Main>
      <Container>
        <ArticleHeader>{post.header}</ArticleHeader>
        <Tags>
          {post.tags?.map((tag) => (
            <Tag key={tag}>{tag}</Tag>
          ))}
        </Tags>
        <Img src={`${getBackendApi()}/${post.img}`}></Img>
        <Content dangerouslySetInnerHTML={{ __html: post.content }}></Content>
        <Author>{post.author}</Author>
      </Container>
    </Main>
  );
};

const query = gql`
  query GetPost($id: String!) {
    post(id: $id) {
      header
      content
      date
      description
      tags
      img
    }
  }
`;

export const Post = () => {
  const { id } = useParams();
  const { loading, error, data } = useQuery(query, {
    variables: { id },
  });
  const post = data?.post || {};

  return (
    <>
      <Header></Header>
      <Suspense fallback={<h1>...Error</h1>}>
        <PostComponent post={post}></PostComponent>
      </Suspense>
    </>
  );
};
