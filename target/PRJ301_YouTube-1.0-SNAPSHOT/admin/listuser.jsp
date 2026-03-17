<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - List Users</title>
</head>
<body>
    <nav style="background-color: #f8f9fa; padding: 10px 20px; border-bottom: 1px solid #dadce0;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: #0967d2; font-size: 24px; font-weight: bold;">PRJTube Admin</a>
            <div>
                <a href="${pageContext.request.contextPath}/admin?action=list" style="margin-right: 15px;">Videos</a>
                <a href="${pageContext.request.contextPath}/admin?action=categories" style="margin-right: 15px;">Categories</a>
                <a href="${pageContext.request.contextPath}/admin?action=users" style="margin-right: 15px; font-weight: bold;">Users</a>
                <%
                    Object userObj = session.getAttribute("user");
                    if (userObj != null) {
                        model.User user = (model.User) userObj;
                %>
                <span style="margin-right: 15px;">Admin <%= user.getUsername() %></span>
                <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #0967d2;">Logout</a>
                <%
                    }
                %>
            </div>
        </div>
    </nav>
    
    <div style="padding: 20px;">
        <h2>Manage Users</h2>
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead>
                <tr style="background-color: #f2f2f2;">
                    <th style="padding: 8px;">ID</th>
                    <th style="padding: 8px;">Username</th>
                    <th style="padding: 8px;">Full Name</th>
                    <th style="padding: 8px;">Email</th>
                    <th style="padding: 8px;">Role</th>
                    <th style="padding: 8px;">Status</th>
                    <th style="padding: 8px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="u">
                    <tr>
                        <td style="padding: 8px;"><c:out value="${u.userId}"/></td>
                        <td style="padding: 8px;"><c:out value="${u.username}"/></td>
                        <td style="padding: 8px;"><c:out value="${u.fullName}"/></td>
                        <td style="padding: 8px;"><c:out value="${u.email}"/></td>
                        <td style="padding: 8px;">
                            <c:if test="${u.role == 1}"><span style="color: blue;">Admin</span></c:if>
                            <c:if test="${u.role == 0}">User</c:if>
                        </td>
                        <td style="padding: 8px;">
                            <c:if test="${u.status == 1}"><span style="color: green; font-weight: bold;">Active</span></c:if>
                            <c:if test="${u.status == 0}"><span style="color: red; font-weight: bold;">Banned</span></c:if>
                        </td>
                        <td style="padding: 8px;">
                            <c:if test="${u.role != 1}">
                                <c:if test="${u.status == 1}">
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="banUser">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" style="color: white; background-color: red; border: none; padding: 5px 10px; cursor: pointer;">Ban</button>
                                    </form>
                                </c:if>
                                <c:if test="${u.status == 0}">
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="unbanUser">
                                        <input type="hidden" name="userId" value="${u.userId}">
                                        <button type="submit" style="color: white; background-color: green; border: none; padding: 5px 10px; cursor: pointer;">Unban</button>
                                    </form>
                                </c:if>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
