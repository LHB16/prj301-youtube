<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - List Categories</title>
</head>
<body>
    <nav style="background-color: #f8f9fa; padding: 10px 20px; border-bottom: 1px solid #dadce0;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="home" style="text-decoration: none; color: #0967d2; font-size: 24px; font-weight: bold;">PRJTube</a>
            <div>
                <%
                    Object userObj = session.getAttribute("user");
                    if (userObj != null) {
                        model.User user = (model.User) userObj;
                %>
                <span style="margin-right: 15px;"><%= user.getUsername() %></span>
                <a href="logout" style="text-decoration: none; color: #0967d2;">Logout</a>
                <%
                    } else {
                %>
                <a href="login" style="text-decoration: none; color: #0967d2; margin-right: 15px;">Login</a>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
    
    <h1>Admin - List Categories</h1>
    
    <p><a href="admin">View Videos</a></p>
    
    <h2>All Categories</h2>
    <c:if test="${not empty categories}">
        <c:forEach items="${categories}" var="cat">
            <div style="border: 1px solid #ccc; margin: 10px; padding: 10px;">
                <h3><c:out value="${cat.categoryName}"/></h3>
                <p>Category ID: <c:out value="${cat.categoryId}"/></p>
            </div>
        </c:forEach>
    </c:if>
    <c:if test="${empty categories}">
        <p>No categories found.</p>
    </c:if>
</body>
</html>
