<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <h1>User : home</h1>
    <c:if test="${not empty userObj}">
        <h1>Name : ${userObj.name}</h1>
        <h1>Email : ${userObj.email}</h1>
    </c:if>
</head>
<body>

</body>
</html>
