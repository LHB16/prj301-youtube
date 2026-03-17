<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Video - YouTube Clone</title>
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
    
    <h1>Add New Video</h1>
    
    <c:if test="${not empty error}">
        <p style="color: red;"><c:out value="${error}"/></p>
    </c:if>
    
    <form method="post" action="video">
        <input type="hidden" name="action" value="add">
        <div>
            <label>Title:</label><br>
            <input type="text" name="title" required>
        </div>
        <div>
            <label>Description:</label><br>
            <textarea name="description" rows="3"></textarea>
        </div>
        <div>
            <label>Category:</label><br>
            <select name="categoryId" required>
                <c:forEach items="${categories}" var="cat">
                    <option value="${cat.categoryId}"><c:out value="${cat.categoryName}"/></option>
                </c:forEach>
            </select>
        </div>
        <div>
            <button type="submit">Add Video</button>
        </div>
    </form>
    <p><a href="video?action=list">Back to My Videos</a></p>
</body>
</html>
