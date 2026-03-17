<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><c:out value="${video.title}"/> - YouTube Clone</title>
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
    
    <h1><c:out value="${video.title}"/></h1>
    
    <div>
        <h2>Video Player</h2>
        <p>Channel: <c:out value="${video.user.fullName}"/>
            <%-- Nút Subscribe/Unsubscribe --%>
            <c:if test="${not empty sessionScope.user && sessionScope.user.userId != video.user.userId}">
                <c:choose>
                    <c:when test="${isSubscribed}">
                        <form action="subscribe" method="post" style="display:inline; margin-left: 10px;">
                            <input type="hidden" name="action" value="unsubscribe">
                            <input type="hidden" name="channelId" value="${video.user.userId}">
                            <button type="submit" style="background-color: #aaa; color: white; border: none; padding: 5px 12px; cursor: pointer; border-radius: 3px;">Subscribed ✓</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="subscribe" method="post" style="display:inline; margin-left: 10px;">
                            <input type="hidden" name="action" value="subscribe">
                            <input type="hidden" name="channelId" value="${video.user.userId}">
                            <button type="submit" style="background-color: #cc0000; color: white; border: none; padding: 5px 12px; cursor: pointer; border-radius: 3px;">Subscribe</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </p>
        <p>Upload Date: <c:out value="${video.uploadDate}"/></p>
        <p><c:out value="${video.description}"/></p>
    </div>
    
    <div>
        <h2>Comments</h2>
        <c:if test="${not empty comments}">
            <c:forEach items="${comments}" var="comment">
                <%-- User thường chỉ thấy comment status=1 --%>
                <c:if test="${comment.status == 1}">
                    <div style="border: 1px solid #eee; margin: 5px; padding: 5px;">
                        <p><strong><c:out value="${comment.user.fullName}"/></strong> - <c:out value="${comment.commentDate}"/></p>
                        <p><c:out value="${comment.content}"/></p>
                        <%-- Nút Hide cho Admin --%>
                        <c:if test="${sessionScope.user.role == 1}">
                            <form action="admin" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="hideComment">
                                <input type="hidden" name="commentId" value="${comment.commentId}">
                                <input type="hidden" name="videoId" value="${video.videoId}">
                                <button type="submit" style="color:white; background-color:#ff9800; border:none; padding:3px 8px; cursor:pointer; font-size:12px;">Hide</button>
                            </form>
                        </c:if>
                    </div>
                </c:if>
                <%-- Admin cũng thấy comment bị ẩn, với nút Show --%>
                <c:if test="${comment.status == 0 && sessionScope.user.role == 1}">
                    <div style="border: 1px solid #f5c6cb; margin: 5px; padding: 5px; background-color: #fff3cd;">
                        <p><strong><c:out value="${comment.user.fullName}"/></strong> - <c:out value="${comment.commentDate}"/> <span style="color:red;">[HIDDEN]</span></p>
                        <p><c:out value="${comment.content}"/></p>
                        <form action="admin" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="showComment">
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                            <input type="hidden" name="videoId" value="${video.videoId}">
                            <button type="submit" style="color:white; background-color:#2196F3; border:none; padding:3px 8px; cursor:pointer; font-size:12px;">Show</button>
                        </form>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
        <c:if test="${empty comments}">
            <p>No comments yet.</p>
        </c:if>
        
        <%
            Object userObj2 = session.getAttribute("user");
            if (userObj2 != null) {
        %>
        <form method="post" action="videodetail">
            <input type="hidden" name="videoId" value="${video.videoId}">
            <textarea name="comment" rows="3" placeholder="Add a comment..."></textarea><br>
            <button type="submit">Comment</button>
        </form>
        <%
            } else {
        %>
        <p><a href="login?redirect=videodetail?id=${video.videoId}">Login</a> to comment.</p>
        <%
            }
        %>
    </div>
    
    <p><a href="home">Back to Home</a></p>
</body>
</html>
