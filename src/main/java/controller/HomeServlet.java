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

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        VideoDAO videoDao = new VideoDAO();
        CategoryDAO categoryDao = new CategoryDAO();

        List<Video> videos = videoDao.getAll();
        List<Category> categories = categoryDao.getAll();

        request.setAttribute("videos", videos);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
