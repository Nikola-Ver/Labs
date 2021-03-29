import styled from "@emotion/styled";
import { useEffect, useState } from "react";
import { Post } from "./post/post";
import { Header } from "../../components/header/header";
import { getBackendApi } from "../../helpers/getBackendApi";

const MainComponent = styled.main`
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
`;

export const post1 = {
  id: 1,
  header: "Header",
  content: `Многие компании активно переносят свои данные в облако, обеспечивая тем самым гибкость и масштабируемость своих приложений. Но те, кто впервые пробуют облачные технологии, нередко сталкиваются с проблемой выбора правильного облачного хранилища под конкретную задачу. Какой тип диска подключить? Когда использовать объектное хранилище, а когда файловое? Какие преимущества и недостатки у каждого из них в облаке? Как можно использовать их совместно, чтобы улучшить утилизацию ресурсов?

  Я Хамзет Шогенов, архитектор облачной платформы Mail.ru Cloud Solutions, расскажу о системах хранения данных, доступных на нашей платформе, подробно остановлюсь на их технических характеристиках и оптимальных вариантах использования.
  
  `,
  author: "Author",
  date: new Date(),
  description: `Многие компании активно переносят свои данные в облако, обеспечивая тем самым гибкость и масштабируемость своих приложений. Но те, кто впервые пробуют облачные технологии, нередко сталкиваются с проблемой выбора правильного облачного хранилища под конкретную задачу. Какой тип диска подключить? Когда использовать объектное хранилище, а когда файловое? Какие преимущества и недостатки у каждого из них в облаке? Как можно использовать их совместно, чтобы улучшить утилизацию ресурсов?
  Я, Хамзет Шогенов, архитектор облачной платформы Mail.ru Cloud Solutions, расскажу о системах хранения данных, доступных на нашей платформе, подробно остановлюсь на их технических характеристиках и оптимальных вариантах использования.`,
  tags: ["tag1", "tag2"],
  img: "1.jpg",
};

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

export const Main = () => {
  const [posts, setPosts] = useState([]);
  useEffect(() => {
    fetch(`${getBackendApi()}/post`, { credentials: "include" })
      .then((response) => response.json())
      // eslint-disable-next-line no-shadow
      .then(({ posts }) => {
        setPosts(posts);
      })
      .catch((e) => console.error(e));
  }, []);

  return <MainCmp posts={posts}></MainCmp>;
};
