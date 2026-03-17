<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register - YouTube Clone</title>
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
    
    <h1>Register</h1>
    
    <c:if test="${not empty error}">
        <p style="color: red;"><c:out value="${error}"/></p>
    </c:if>
    
    <form method="post" action="register">
        <div>
            <label>Username:</label><br>
            <input type="text" name="username" required>
        </div>
        <div>
            <label>Password:</label><br>
            <input type="password" name="password" required>
        </div>
        <div>
            <label>Full Name:</label><br>
            <input type="text" name="fullName">
        </div>
        <div>
            <label>Email:</label><br>
            <input type="email" name="email" required>
        </div>
        <div>
            <button type="submit">Register</button>
        </div>
    </form>
    <p>Already have an account? <a href="login">Login</a></p>
</body>
</html>
