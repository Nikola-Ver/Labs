import React, { useEffect, useState } from "react";
import { ToastContainer } from "react-toastify";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
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

function App() {
  const [login, setLogin] = useState(null);

  useEffect(() => {
    try {
      const user = localStorage.getItem("user");
      setLogin(user);
    } catch (e) {
      setLogin(null);
    }
  }, []);

  const [loginDialog, closeLoginDialog, openLoginDialog] = UseDialog();

  return (
    <div className="App">
      <MyContext.Provider value={{ login, setLogin, openLoginDialog }}>
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
      </MyContext.Provider>
      <ToastContainer></ToastContainer>
    </div>
  );
}

export default App;
