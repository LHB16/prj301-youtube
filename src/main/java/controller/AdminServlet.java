package controller;

import dao.CategoryDAO;
import dao.VideoDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Video;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        VideoDAO videoDao = new VideoDAO();
        CategoryDAO categoryDao = new CategoryDAO();

        if (action.equals("list")) {
            List<Video> videos = videoDao.getAll();
            request.setAttribute("videos", videos);
            request.getRequestDispatcher("admin/listvideo.jsp").forward(request, response);
        } else if (action.equals("categories")) {
            List<Category> categories = categoryDao.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("admin/listcategory.jsp").forward(request, response);
        } else if (action.equals("users")) {
            dao.UserDAO userDao = new dao.UserDAO();
            List<model.User> users = userDao.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("admin/listuser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("admin");
            return;
        }

        if (action.equals("banUser")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            new dao.UserDAO().changeUserStatus(userId, 0);
            response.sendRedirect("admin?action=users");
        } else if (action.equals("unbanUser")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            new dao.UserDAO().changeUserStatus(userId, 1);
            response.sendRedirect("admin?action=users");
        } else if (action.equals("hideVideo")) {
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            new dao.VideoDAO().changeVideoStatus(videoId, 0);
            response.sendRedirect("admin?action=list");
        } else if (action.equals("showVideo")) {
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            new dao.VideoDAO().changeVideoStatus(videoId, 1);
            response.sendRedirect("admin?action=list");
        } else if (action.equals("hideComment")) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            new dao.CommentDAO().changeCommentStatus(commentId, 0);
            response.sendRedirect("videodetail?id=" + videoId);
        } else if (action.equals("showComment")) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            new dao.CommentDAO().changeCommentStatus(commentId, 1);
            response.sendRedirect("videodetail?id=" + videoId);
        }
    }
}
