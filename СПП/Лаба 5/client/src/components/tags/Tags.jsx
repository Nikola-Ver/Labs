import styled from "@emotion/styled";

export const Tags = styled.div`
  display: flex;
  margin: 4px 0;
  padding: 0 8px;
`;

export const Tag = styled.div`
  color: ${(props) => {
    return props.theme.font.primary;
  }};
  padding-right: 4px;

  &:not(:first-child) {
    padding-left: 4px;
    border-left: 1px solid #5e6973;
  }
`;
