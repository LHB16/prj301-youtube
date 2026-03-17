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

@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryId = request.getParameter("id");
        VideoDAO videoDao = new VideoDAO();
        CategoryDAO categoryDao = new CategoryDAO();

        if (categoryId != null) {
            int catId = Integer.parseInt(categoryId);
            List<Video> videos = videoDao.getVideosByCategoryId(catId);
            Category category = categoryDao.getCategoryById(catId);
            
            request.setAttribute("videos", videos);
            request.setAttribute("currentCategory", category);
        } else {
            List<Category> categories = categoryDao.getAll();
            request.setAttribute("categories", categories);
        }
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
