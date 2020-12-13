<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "custom" uri = "/WEB-INF/tld/conditionalMsg.tld"%>
<html>
<head>
</head>
<body>
    <custom:condMsg condition="${param.register == 'success'}" message="You have signed up successfully!"/>
    <custom:condMsg condition="${param.signin == 'error'}" message="Invalid login or password."/>

    <div> <!-- login form -->
        <h3>Sign In:</h3>
        <form action="Controller" method="post">
            <input type="hidden" name="command" value="signin"/>

            <br/>
            <label for="login">Login:</label>
            <input type="text" id="login" name="login"/>

            <br/>
            <label for="password">Password</label>
            <input type="password" id="password" name="password"/>

            <br/>
            <input type="submit" value="Sign In!"/>
        </form>
    </div>

    <div>    <!-- buttons holder -->
        <button onclick="location.href='Controller?command=go_to_signup'">Sign Up!</button>
    </div>
</body>
</html>
