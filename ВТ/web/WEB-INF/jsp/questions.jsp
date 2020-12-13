<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Garbage Testing System : Questions</title>
</head>
<body>

<!-- content -->
<main>
    <h2>Now browsing questions</h2>
    <h3>Your role is <i><c:out value="${user.roleName}"/></i>.</h3>
    <br/>

    <div>
        <c:forEach items="${questions}" var="question">

            <b><c:out value="${question.question}"/></b>
            <button onclick="location.href='Controller?command=go_to_edit&entity=question&' +
                    'id=<c:out value="${question.questionId}"/>&text=<c:out value="${question.question}"/>'">Edit</button>
            <button onclick="location.href='Controller?command=delete&entity=question&id=<c:out value="${question.questionId}"/>'">Delete</button>
            <br/>

            <!-- Answers -->
            <c:forEach items="${question.answers}" var="answer">
                <c:choose>
                    <c:when test="${answer.right}">
                        <p><font color="green"><c:out value="${answer.answer}"/></font></p>
                    </c:when>
                    <c:otherwise>
                        <p><c:out value="${answer.answer}"/></p>
                    </c:otherwise>
                </c:choose>
                <button onclick="location.href='Controller?command=go_to_edit&entity=answer&' +
                        'id=<c:out value="${answer.answerId}"/>&text=<c:out value="${answer.answer}"/>&isRight=<c:out value="${answer.right}"/>'">Edit</button>
                <button onclick="location.href='Controller?command=delete&entity=answer&id=<c:out value="${answer.answerId}"/>'">Delete</button>
                <br/>
            </c:forEach>

            <c:if test="${user.roleName != 'student'}">
                <div>
                    <br/>
                    <button onclick="location.href='Controller?command=go_to_add&entity=answer&id=<c:out value="${question.questionId}"/>'">Add answer</button>
                </div>
            </c:if>
            <br/><br/>

        </c:forEach>
    </div>

    <c:if test="${user.roleName != 'student'}">
        <div>
            <br/>
            <button onclick="location.href='Controller?command=go_to_add&entity=question&id=<c:out value="${testId}"/>'">Add question</button>
        </div>
    </c:if>
    <br/>

    <div>    <!-- buttons holder -->
        <button onclick="location.href='Controller?command=go_to_tests'">Back</button>
    </div>
</main>

<!-- footer -->
<footer>
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>