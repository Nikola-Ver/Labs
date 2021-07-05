/* eslint-disable react/jsx-props-no-spreading */
import { Redirect, Route } from "react-router";

export const ProtectedRoute = ({ component: Component, path, loggedIn }) => (
  <Route
    path={path}
    component={(props) => {
      if (!loggedIn) {
        return <Redirect to="/" />;
      }
      return <Component {...props} />;
    }}
  />
);
