package controller;

import dao.CommentDAO;
import dao.SubscriptionDAO;
import dao.VideoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Comment;
import model.User;
import model.Video;

@WebServlet(name = "VideoDetailServlet", urlPatterns = {"/videodetail"})
public class VideoDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int videoId = Integer.parseInt(request.getParameter("id"));
        VideoDAO videoDao = new VideoDAO();
        CommentDAO commentDao = new CommentDAO();

        Video video = videoDao.getVideoById(videoId);
        List<Comment> comments = commentDao.getCommentsByVideoId(videoId);

        request.setAttribute("video", video);
        request.setAttribute("comments", comments);

        // Check subscription status if user is logged in
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            SubscriptionDAO subDao = new SubscriptionDAO();
            boolean isSubscribed = subDao.isSubscribed(user.getUserId(), video.getUser().getUserId());
            request.setAttribute("isSubscribed", isSubscribed);
        }

        request.getRequestDispatcher("videodetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int videoId = Integer.parseInt(request.getParameter("videoId"));
        String commentContent = request.getParameter("comment");

        if (commentContent != null && !commentContent.trim().isEmpty()) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                CommentDAO commentDao = new CommentDAO();
                commentDao.addComment(commentContent, user.getUserId(), videoId);
            }
        }

        response.sendRedirect("videodetail?id=" + videoId);
    }
}
