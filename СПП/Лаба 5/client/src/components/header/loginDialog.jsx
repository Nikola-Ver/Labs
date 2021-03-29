import styled from "@emotion/styled";
import Button from "@material-ui/core/Button";
import TextField from "@material-ui/core/TextField";
import { toast } from "react-toastify";
import { useContext, useEffect } from "react";
import { Dialog, Typography } from "@material-ui/core";
import { MyContext } from "../../context/context";

const Form = styled.form`
  display: flex;
  flex-direction: column;
  padding: 20px;
`;

const Submit = styled(Button)`
  height: 32px !important;
  background: ${(props) => {
    return props.theme.palette.secondary;
  }} !important;
  color: white !important;
  margin-top: 8px !important;
`;

export const LoginDialog = ({ loginDialog, closeLoginDialog }) => {
  const { setLogin, socket } = useContext(MyContext);
  useEffect(() => {
    socket?.on("res/user/auth", (msg) => {
      if (msg.status === "success") {
        localStorage.setItem("user", JSON.stringify(msg.user));
        setLogin({ ...msg.user });
        closeLoginDialog();
        toast.success("Logged in");
      } else {
        toast.error("Auth error");
      }
    });
    return () => socket?.off("res/user/auth");
  }, [socket]);

  const handleSubmit = async (event) => {
    event.preventDefault();

    socket.emit("req/user/auth", {
      login: event.target.login.value,
      password: event.target.password.value,
    });
  };

  return (
    <Dialog open={loginDialog} onClose={closeLoginDialog}>
      <Form onSubmit={handleSubmit}>
        <Typography variant="h5" component="h2">
          Login
        </Typography>
        <TextField type="email" required name="login" label="Login" />
        <TextField name="password" required type="password" label="Password" />
        <Submit type="submit">Submit</Submit>
      </Form>
    </Dialog>
  );
};
