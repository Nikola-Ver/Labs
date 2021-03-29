import styled from "@emotion/styled";
import Button from "@material-ui/core/Button";
import TextField from "@material-ui/core/TextField";
import { toast } from "react-toastify";
import { Dialog } from "@material-ui/core";
import { useContext, useEffect } from "react";
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

export const RegistrationDialog = ({
  registration,
  closeRegistrationDialog,
}) => {
  const { setLogin, socket } = useContext(MyContext);

  useEffect(() => {
    socket?.on("res/user/create", (msg) => {
      if (msg.status === "success") {
        localStorage.setItem("user", JSON.stringify(msg.user));
        toast.success("Registration success");
        setLogin({ ...msg.user });
        closeRegistrationDialog();
      } else {
        toast.error("Auth error");
      }
    });

    return () => socket?.off("res/user/create");
  }, [socket]);

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (event.target.password.value !== event.target.password2.value) {
      // eslint-disable-next-line no-alert
      alert("Passwords do not match");
      return;
    }
    socket.emit("req/user/create", {
      login: event.target.login.value,
      password: event.target.password.value,
      name: event.target.name.value,
    });
  };

  return (
    <Dialog open={registration} onClose={closeRegistrationDialog}>
      <Form onSubmit={handleSubmit}>
        <TextField name="login" type="email" required label="Login" />
        <TextField name="password" required type="password" label="Password" />
        <TextField name="password2" required type="password" label="Password" />
        <TextField name="name" required type="text" label="Name" />
        <Submit type="submit">Submit</Submit>
      </Form>
    </Dialog>
  );
};
