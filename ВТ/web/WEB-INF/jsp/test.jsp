<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Test (in progress)</title>
</head>
<body>

<!-- header -->
<header>
    <h3>Question <c:out value="${currQuestion + 1}"/> out of <c:out value="${numOfQuestions}"/></h3>
</header>

<main>
    <h5><b><c:out value="${questions[currQuestion].question}"/></b></h5>
    <form action="Controller" method="post">
        <input type="hidden" name="command" value="next_question">
        <c:choose>
            <c:when test="${questions[currQuestion].rightAnswers == 1}">
                <c:forEach items="${questions[currQuestion].answers}" var="answer">
                    <p><input type="radio" name="answer" value="<c:out value="${answer.answerId}"/>"/><c:out value="${answer.answer}"/></p>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <c:forEach items="${questions[currQuestion].answers}" var="answer">
                    <p><input type="checkbox" name="<c:out value="${answer.answerId}"/>" value="true"/><c:out value="${answer.answer}"/></p>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <br/>

        <c:choose>
            <c:when test="${currQuestion + 1 == numOfQuestions}">
                <input type="hidden" name="finishTest" value="true">
                <input type="submit" value="Finish test">
            </c:when>
            <c:otherwise>
                <input type="submit" value="Next question ->">
            </c:otherwise>
        </c:choose>
    </form>
</main>



<!-- footer -->
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>
