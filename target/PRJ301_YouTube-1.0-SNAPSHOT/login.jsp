<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - YouTube Clone</title>
</head>
<body>
    <nav style="background-color: #f8f9fa; padding: 10px 20px; border-bottom: 1px solid #dadce0;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="home" style="text-decoration: none; color: #0967d2; font-size: 24px; font-weight: bold;">PRJTube</a>
            <div>
                <a href="login" style="text-decoration: none; color: #0967d2; margin-right: 15px;">Login</a>
                <a href="register.jsp" style="text-decoration: none; color: #0967d2;">Register</a>
            </div>
        </div>
    </nav>
    
    <h1>Login</h1>
    <form method="post" action="login">
        <!-- Input ẩn chứa URL chuyển hướng -->
        <input type="hidden" name="redirect" value="<c:out value="${param.redirect}"/>">
        <div>
            <label>Email:</label><br>
            <input type="email" name="email" required>
        </div>
        <div>
            <label>Password:</label><br>
            <input type="password" name="pass" required>
        </div>
        <div>
            <button type="submit">Login</button>
        </div>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register</a></p>
</body>
</html>
