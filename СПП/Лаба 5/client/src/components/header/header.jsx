import styled from "@emotion/styled";
import AccountCircleIcon from "@material-ui/icons/AccountCircle";
import { Link } from "react-router-dom";
import { usePopover } from "../../hooks/usePopover";
import { UserPopover } from "./userPopover";

const Logo = styled(Link)`
  display: flex;
  font-size: 30px;
  text-transform: capitalize;
  font-weight: bold;
  color: white;
  text-decoration: none;
`;

const HeaderComponent = styled.div`
  display: flex;
  max-width: 960px;
  justify-content: space-between;
  color: white;
  align-items: center;
  width: 100%;
`;

const AccountButton = styled.button`
  background: inherit;
  border: 0;
  color: white;
  cursor: pointer;
`;

const HeaderContainer = styled.header`
  height: 40px;
  background: ${(props) => {
    return props.theme.palette.primary;
  }};
  padding: 4px 0;
  width: 100%;
  display: flex;
  justify-content: center;
`;

export const Header = () => {
  const [popover, openPopover, closePopover] = usePopover();

  return (
    <HeaderContainer>
      <HeaderComponent>
        <Logo to="/">News</Logo>
        <AccountButton onClick={openPopover}>
          <AccountCircleIcon></AccountCircleIcon>
        </AccountButton>
      </HeaderComponent>
      <UserPopover popover={popover} closePopover={closePopover}></UserPopover>
    </HeaderContainer>
  );
};
