package controller;

import dao.VideoDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Video;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("q");
        VideoDAO videoDao = new VideoDAO();

        List<Video> videos = videoDao.getAll();
        if (keyword != null && !keyword.trim().isEmpty()) {
            videos.removeIf(v -> !v.getTitle().toLowerCase().contains(keyword.toLowerCase()));
        }

        request.setAttribute("videos", videos);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
