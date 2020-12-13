<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Add new <c:out value="${param.entity}"/></title>
</head>
<body>

    <!-- content -->
    <main>
        <form action="Controller" method="post">
            <input type="hidden" name="command" value="addEntity"/>
            <input type="hidden" name="entity" value="<c:out value="${param.entity}"/>">
            <input type="hidden" name="id" value="<c:out value="${param.id}"/>"/>
            <c:choose>
                <c:when test="${param.entity == 'subject' || param.entity == 'test'}">
                    <input type="text" value="Add new <c:out value="${param.entity}"/>" name="name"/>
                </c:when>
                <c:otherwise>
                    <textarea name="name">Add new <c:out value="${param.entity}"/></textarea>
                </c:otherwise>
            </c:choose>
            <c:if test="${param.entity == 'answer'}">
                <input type="checkbox" name="isRight" value="true"/>
            </c:if>
            <input type="submit" value="Add...">
        </form>
    </main>

    <!-- footer -->
    <footer>
        <jsp:include page="footer.jsp"/>
    </footer>
</body>
</html>
