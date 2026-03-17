package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "TestDBServlet", urlPatterns = {"/testdb"})
public class TestDBServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        
        String dbUrl = System.getenv("DATABASE_URL");
        
        response.getWriter().println("<h2>Test Database Connection</h2>");
        response.getWriter().println("<p>DATABASE_URL: " + (dbUrl != null ? "SET" : "NOT SET") + "</p>");
        
        if (dbUrl != null) {
            response.getWriter().println("<p>URL (masked): postgresql://***:***@...</p>");
        }
        
        try {
            // Test connection
            if (dbUrl != null) {
                String jdbcUrl = dbUrl;
                
                // Handle both "postgresql://" and "postgres://" formats
                if (jdbcUrl.startsWith("postgresql://")) {
                    jdbcUrl = "jdbc:" + jdbcUrl;
                } else if (jdbcUrl.startsWith("postgres://")) {
                    jdbcUrl = jdbcUrl.replace("postgres://", "jdbc:postgresql://");
                }
                
                // Extract credentials and rebuild URL
                if (jdbcUrl.contains("@")) {
                    String[] parts = jdbcUrl.split("@");
                    String credentials = parts[0].replace("jdbc:postgresql://", "");
                    String hostAndPath = parts[1];
                    
                    String[] credParts = credentials.split(":");
                    String user = credParts[0];
                    String password = credParts.length > 1 ? credParts[1] : "";
                    
                    jdbcUrl = "jdbc:postgresql://" + hostAndPath 
                            + "?user=" + user 
                            + "&password=" + password
                            + "&sslmode=require";
                }
                
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(jdbcUrl);
                
                response.getWriter().println("<p style='color: green;'>✓ Connected successfully!</p>");
                response.getWriter().println("<p>Driver: " + conn.getMetaData().getDriverName() + "</p>");
                conn.close();
            } else {
                response.getWriter().println("<p style='color: red;'>✗ DATABASE_URL not set!</p>");
            }
        } catch (ClassNotFoundException e) {
            response.getWriter().println("<p style='color: red;'>✗ Driver not found: " + e.getMessage() + "</p>");
        } catch (SQLException e) {
            response.getWriter().println("<p style='color: red;'>✗ Connection failed: " + e.getMessage() + "</p>");
        }
    }
}
