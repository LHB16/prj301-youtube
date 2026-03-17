<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Video - YouTube Clone</title>
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
                <a href="register.jsp" style="text-decoration: none; color: #0967d2;">Register</a>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
    
    <h1>Delete Video</h1>
    
    <p>Are you sure you want to delete this video?</p>
    
    <div style="border: 1px solid #ccc; margin: 10px; padding: 10px;">
        <h3><c:out value="${video.title}"/></h3>
        <p>Video ID: <c:out value="${video.videoId}"/></p>
        <p>Channel: <c:out value="${video.user.fullName}"/></p>
        <p>Category: <c:out value="${video.category.categoryName}"/></p>
        <p>Upload Date: <c:out value="${video.uploadDate}"/></p>
        <p><c:out value="${video.description}"/></p>
    </div>
    
    <form method="post" action="video">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="videoId" value="${video.videoId}">
        <button type="submit">Yes, Delete</button>
    </form>
    <p><a href="video?action=list">Cancel</a></p>
</body>
</html>
