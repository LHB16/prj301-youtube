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
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.User;
import model.Video;

@WebServlet(name = "VideoServlet", urlPatterns = {"/video"})
public class VideoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        VideoDAO videoDao = new VideoDAO();
        CategoryDAO categoryDao = new CategoryDAO();

        if (action == null) {
            action = "list";
        }

        if (action.equals("list")) {
            // Lấy danh sách video của user đang đăng nhập
            if (user != null) {
                List<Video> videos = videoDao.getVideosByUserId(user.getUserId());
                request.setAttribute("videos", videos);
                request.getRequestDispatcher("myvideos.jsp").forward(request, response);
            } else {
                response.sendRedirect("login");
            }
        } else if (action.equals("add")) {
            // Hiển thị form thêm video
            List<Category> categories = categoryDao.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("addvideo.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            // Hiển thị trang xác nhận xóa
            int videoId = Integer.parseInt(request.getParameter("id"));
            Video video = videoDao.getVideoById(videoId);
            request.setAttribute("video", video);
            request.getRequestDispatcher("deletevideo.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        VideoDAO videoDao = new VideoDAO();
        CategoryDAO categoryDao = new CategoryDAO();

        if (action == null) {
            action = "list";
        }

        if (action.equals("add")) {
            // Thêm video mới
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            Video video = new Video();
            video.setTitle(title);
            video.setDescription(description);
            video.setUser(user);
            Category category = categoryDao.getCategoryById(categoryId);
            video.setCategory(category);

            boolean success = videoDao.insert(video);
            if (success) {
                response.sendRedirect("video?action=list");
            } else {
                request.setAttribute("error", "Failed to add video!");
                List<Category> categories = categoryDao.getAll();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("addvideo.jsp").forward(request, response);
            }
        } else if (action.equals("delete")) {
            // Xóa video
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            boolean success = videoDao.delete(videoId);
            if (success) {
                response.sendRedirect("video?action=list");
            } else {
                request.setAttribute("error", "Failed to delete video!");
                Video video = videoDao.getVideoById(videoId);
                request.setAttribute("video", video);
                request.getRequestDispatcher("deletevideo.jsp").forward(request, response);
            }
        }
    }
}
