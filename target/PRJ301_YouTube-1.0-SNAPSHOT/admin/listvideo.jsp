<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - List Videos</title>
</head>
<body>
    <nav style="background-color: #f8f9fa; padding: 10px 20px; border-bottom: 1px solid #dadce0;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: #0967d2; font-size: 24px; font-weight: bold;">PRJTube Admin</a>
            <div>
                <a href="${pageContext.request.contextPath}/admin?action=list" style="margin-right: 15px; font-weight: bold;">Videos</a>
                <a href="${pageContext.request.contextPath}/admin?action=categories" style="margin-right: 15px;">Categories</a>
                <a href="${pageContext.request.contextPath}/admin?action=users" style="margin-right: 15px;">Users</a>
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
        <h2>Manage Videos</h2>
    
    <h2>All Videos</h2>
    <c:if test="${not empty videos}">
        <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead>
                <tr style="background-color: #f2f2f2;">
                    <th style="padding: 8px;">ID</th>
                    <th style="padding: 8px;">Title</th>
                    <th style="padding: 8px;">Channel</th>
                    <th style="padding: 8px;">Category</th>
                    <th style="padding: 8px;">Upload Date</th>
                    <th style="padding: 8px;">Status</th>
                    <th style="padding: 8px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${videos}" var="v">
                    <tr>
                        <td style="padding: 8px;"><c:out value="${v.videoId}"/></td>
                        <td style="padding: 8px;"><c:out value="${v.title}"/></td>
                        <td style="padding: 8px;"><c:out value="${v.user.fullName}"/></td>
                        <td style="padding: 8px;"><c:out value="${v.category.categoryName}"/></td>
                        <td style="padding: 8px;"><c:out value="${v.uploadDate}"/></td>
                        <td style="padding: 8px;">
                            <c:choose>
                                <c:when test="${v.status == 0}"><span style="color: red; font-weight: bold;">Hidden</span></c:when>
                                <c:otherwise><span style="color: green; font-weight: bold;">Visible</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td style="padding: 8px;">
                            <c:choose>
                                <c:when test="${v.status == 0}">
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="showVideo">
                                        <input type="hidden" name="videoId" value="${v.videoId}">
                                        <button type="submit" style="color: white; background-color: #2196F3; border: none; padding: 5px 10px; cursor: pointer;">Show</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="hideVideo">
                                        <input type="hidden" name="videoId" value="${v.videoId}">
                                        <button type="submit" style="color: white; background-color: #ff9800; border: none; padding: 5px 10px; cursor: pointer;">Hide</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty videos}">
        <p>No videos found.</p>
    </c:if>
</body>
</html>
