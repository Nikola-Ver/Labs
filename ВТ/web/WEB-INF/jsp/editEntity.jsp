<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Edit <c:out value="${param.entity}"/></title>
</head>
<body>

<!-- content -->
<main>
    <form action="Controller" method="post">
        <input type="hidden" name="command" value="editEntity"/>
        <input type="hidden" name="entity" value="<c:out value="${param.entity}"/>">
        <input type="hidden" name="id" value="<c:out value="${param.id}"/>">
        <c:choose>
            <c:when test="${param.entity == 'subject' || param.entity == 'test'}">
                <input type="text" value="<c:out value="${param.text}"/>" name="text"/>
            </c:when>
            <c:otherwise>
                <textarea name="text"><c:out value="${param.text}"/></textarea>
            </c:otherwise>
        </c:choose>
        <c:if test="${param.entity == 'answer'}">
            <input type="checkbox" name="isRight" value="true" <c:if test="${param.isRight == 'true'}"><c:out value="checked"/></c:if>/>
        </c:if>
        <input type="submit" value="Save">
    </form>
</main>

<!-- footer -->
<footer>
    <jsp:include page="footer.jsp"/>
</footer>
</body>
</html>