<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
    <title>Garbage Testing System</title>
  </head>
  <body>

  <!-- header -->
  <header>
    <jsp:include page="WEB-INF/jsp/header.jsp"/>
  </header>

  <!-- content -->
  <main>
    <c:choose>
      <c:when test="${user != null}">
        <jsp:include page="WEB-INF/jsp/main.jsp"/>
      </c:when>
      <c:otherwise>
        <jsp:include page="WEB-INF/jsp/mainUnauthorized.jsp"/>
      </c:otherwise>
    </c:choose>
  </main>

  <!-- footer -->
  <footer>
    <jsp:include page="WEB-INF/jsp/footer.jsp"/>
  </footer>

  </body>
</html>
