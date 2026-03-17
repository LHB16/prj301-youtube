package controller;

import dao.SubscriptionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "SubscribeServlet", urlPatterns = {"/subscribe"})
public class SubscribeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        String channelId = request.getParameter("channelId");
        
        if (channelId != null) {
            int channelOwnerId = Integer.parseInt(channelId);
            SubscriptionDAO subDao = new SubscriptionDAO();
            
            if ("subscribe".equals(action)) {
                subDao.subscribe(user.getUserId(), channelOwnerId);
            } else if ("unsubscribe".equals(action)) {
                subDao.unsubscribe(user.getUserId(), channelOwnerId);
            }
        }
        
        response.sendRedirect(request.getHeader("Referer"));
    }
}
