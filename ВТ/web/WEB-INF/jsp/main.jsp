<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
</head>
<body>
    <h2>Welcome, <c:out value="${user.name}"/></h2>
    <h3>Your role is <i><c:out value="${user.roleName}"/></i>.</h3>
    <br/>

    <div>
        <c:forEach items="${subjects}" var="subject">
            <a href="Controller?command=go_to_tests&subjectId=<c:out value="${subject.subjectId}"/>"><c:out value="${subject.name}"/></a>
            <c:if test="${user.roleName != 'student'}">
                <button onclick="location.href='Controller?command=go_to_edit&entity=subject&' +
                                               'id=<c:out value="${subject.subjectId}"/>&text=<c:out value="${subject.name}"/>'">Edit</button>
                <button onclick="location.href='Controller?command=delete&entity=subject&id=<c:out value="${subject.subjectId}"/>'">Delete</button>
            </c:if>
            <br/><br/>
        </c:forEach>
    </div>

    <c:if test="${user.roleName != 'student'}">
        <div>
            <br/>
            <button onclick="location.href='Controller?command=go_to_add&entity=subject'">Add subject</button>
        </div>
    </c:if>
    <br/>
    <div>    <!-- buttons holder -->
        <button onclick="location.href='Controller?command=signout'">Sign Out</button>
    </div>
</body>
</html>
