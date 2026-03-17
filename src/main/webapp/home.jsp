<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>YouTube Clone</title>
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
                <a href="video?action=list" style="text-decoration: none; color: #0967d2; margin-left: 10px;">My Videos</a>
                <%
                    } else {
                %>
                <a href="login" style="text-decoration: none; color: #0967d2; margin-right: 15px;">Login</a>
                <a href="register.jsp" style="text-decoration: none; color: #0967d2;">Register</a>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
    
    <h1>YouTube Clone</h1>
    
    <div>
        <form method="get" action="search">
            <input type="text" name="q" value="${keyword}">
            <button type="submit">Search</button>
        </form>
    </div>
    
    <h2>Categories</h2>
    <ul>
        <c:forEach items="${categories}" var="cat">
            <li><a href="category?id=${cat.categoryId}"><c:out value="${cat.categoryName}"/></a></li>
        </c:forEach>
    </ul>
    
    <c:if test="${not empty currentCategory}">
        <h2>Category: <c:out value="${currentCategory.categoryName}"/></h2>
    </c:if>
    
    <h2>Recent Videos</h2>
    <c:if test="${not empty videos}">
        <c:forEach items="${videos}" var="video">
            <div style="border: 1px solid #ccc; margin: 10px; padding: 10px;">
                <h3><a href="videodetail?id=${video.videoId}"><c:out value="${video.title}"/></a></h3>
                <p>Channel: <c:out value="${video.user.fullName}"/></p>
                <p>Views: 1000 | Upload Date: <c:out value="${video.uploadDate}"/></p>
                <p><c:out value="${video.description}"/></p>
            </div>
        </c:forEach>
    </c:if>
    <c:if test="${empty videos}">
        <p>No videos found.</p>
    </c:if>
</body>
</html>
