import styled from "@emotion/styled";
import Card from "@material-ui/core/Card";
import { Link } from "react-router-dom";
import { getBackendApi } from "../../../helpers/getBackendApi";
import { Tag, Tags } from "../../../components/tags/Tags";

const Wrapper = styled(Link)`
  display: flex;
  flex-direction: column;
  max-width: 780px;
  padding: 8 0px;
  text-decoration: none;
  width: 100%;
  margin: 16px 16px 0;
`;

const Title = styled.h2`
  font-size: 32px;
  margin: 8px 0;
  padding: 0 8px;
`;

const Img = styled.img`
  border-radius: 0px;
`;

const Description = styled.div`
  padding: 8px;
`;

const Author = styled.div`
  color: ${(props) => props.theme.font.primary};
  margin: 0 8px 8px;
`;

const StyledCard = styled(Card)`
  transition: all 0.2s ease-out !important;
  &:hover {
    box-shadow: 0px 4px 4px rgba(38, 38, 38, 0.2);
    transform: translate(1px, 1px);
    background-color: white;
  }
`;

export const Post = ({ post }) => {
  return (
    // eslint-disable-next-line no-underscore-dangle
    <Wrapper to={`post/${post._id}`}>
      <StyledCard>
        <Title>{post.header}</Title>
        <Tags>
          {post.tags.map((tag) => (
            <Tag key={tag}>{tag}</Tag>
          ))}
        </Tags>
        <Img src={`${getBackendApi()}/${post.img}`}></Img>
        <Description>{post.description}</Description>
        <Author>{post.author}</Author>
      </StyledCard>
    </Wrapper>
  );
};
