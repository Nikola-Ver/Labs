<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Test (results)</title>
</head>
<body>
<header>
    <h3>Test completed!</h3>
</header>

<main>
    <h4>Your result is:</h4>
    <p><b><c:out value="${rightAnswers}"/> right answers out of <c:out value="${numOfQuestions}"/></b></p>
    <br/>
    <br/>

    <button onclick="location.href='Controller?command=go_to_tests'"><- Back to tests selection</button>
</main>

<!-- footer -->
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
