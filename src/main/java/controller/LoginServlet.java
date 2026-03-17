package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        User u = dao.loginByEmail(email, password);

        if (u.getUserId() == -1) {
            String redirectParam = request.getParameter("redirect");
            if (redirectParam != null && !redirectParam.isEmpty()) {
                response.sendRedirect("login?redirect=" + redirectParam);
            } else {
                response.sendRedirect("login");
            }
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            String redirectParam = request.getParameter("redirect");
            if (redirectParam != null && !redirectParam.isEmpty()) {
                response.sendRedirect(redirectParam);
            } else {
                response.sendRedirect("home");
            }
        }
    }
}
