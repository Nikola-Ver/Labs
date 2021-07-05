import React, { useEffect, useState } from "react";
import { ToastContainer } from "react-toastify";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import { ApolloProvider, ApolloClient, InMemoryCache } from "@apollo/client";
import { io } from "socket.io-client";
import { ThemeProvider } from "@emotion/react";
import { Main } from "./pages/main/main";
import { Post } from "./pages/post/post";
import { MyContext } from "./context/context";
import { CreatePost } from "./pages/createPost/createPost";
import "react-toastify/dist/ReactToastify.css";
import { ProtectedRoute } from "./helpers/authRoute";
import { LoginDialog } from "./components/header/loginDialog";
import { UseDialog } from "./hooks/useDialog";
import { theme } from "./pages/theme";
import { getBackendApi } from "./helpers/getBackendApi";

const client = new ApolloClient({
  cache: new InMemoryCache(),
  uri: `${getBackendApi()}/graphql`,
});

function App() {
  const [login, setLogin] = useState(null);
  const [socket, setSocket] = useState(null);

  useEffect(() => {
    try {
      const user = JSON.parse(localStorage.getItem("user"));
      setLogin(user);
    } catch (e) {
      setLogin(null);
    }
  }, []);

  useEffect(() => {
    const newSocket = io(`${getBackendApi()}`, {
      extraHeaders: { token: login?.token },
    });
    setSocket(newSocket);
    return () => newSocket.close();
  }, [login]);

  const [loginDialog, closeLoginDialog, openLoginDialog] = UseDialog();

  return (
    <div className="App">
      <MyContext.Provider value={{ login, setLogin, openLoginDialog, socket }}>
        <ApolloProvider client={client}>
          <ThemeProvider theme={theme}>
            <Router>
              <Switch>
                <Route path="/post/:id" component={Post}></Route>
                <ProtectedRoute
                  loggedIn={!!login}
                  path="/create"
                  component={CreatePost}
                ></ProtectedRoute>
                <Route path="/" component={Main}></Route>
              </Switch>
            </Router>
            <LoginDialog
              closeLoginDialog={closeLoginDialog}
              loginDialog={loginDialog}
            ></LoginDialog>
          </ThemeProvider>
        </ApolloProvider>
      </MyContext.Provider>
      <ToastContainer></ToastContainer>
    </div>
  );
}

export default App;
