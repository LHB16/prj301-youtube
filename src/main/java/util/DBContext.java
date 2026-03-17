package util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection conn = null;

    public DBContext() {
        try {
            // Use environment variable for production (Supabase PostgreSQL)
            // Fallback to local SQL Server for development
            String dbURL = System.getenv("DATABASE_URL") != null 
                ? convertSupabaseUrlToJdbc(System.getenv("DATABASE_URL"))
                : "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=PRJ301_YouTube;"
                    + "user=sa;"
                    + "password=123456;"
                    + "encrypt=true;trustServerCertificate=true;";

            // Load appropriate driver based on URL
            if (dbURL.contains("postgresql")) {
                Class.forName("org.postgresql.Driver");
            } else {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            }

            conn = DriverManager.getConnection(dbURL);

            if (conn != null) {
                DatabaseMetaData dm = (DatabaseMetaData) conn.getMetaData();
                System.out.println("Driver name: " + dm.getDriverName());
                System.out.println("Driver version: " + dm.getDriverVersion());
                System.out.println("Product name: " + dm.getDatabaseProductName());
                System.out.println("Product version: " + dm.getDatabaseProductVersion());
            } else {
                System.out.println("Ket noi that bai (NULL)");
            }
        } catch (SQLException ex) {
            System.out.println("Khong ket noi duoc roi em oi...........");
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private String convertSupabaseUrlToJdbc(String supabaseUrl) {
        // Convert postgresql://user:pass@host:port/db to jdbc:postgresql://host:port/db?user=user&password=pass
        String url = supabaseUrl.replace("postgres://", "jdbc:postgresql://");
        
        // Extract user:pass from URL
        if (url.contains("@")) {
            String[] parts = url.split("@");
            String credentials = parts[0].replace("jdbc:postgresql://", "");
            String hostPart = parts[1];
            
            // Split user and password
            String[] credParts = credentials.split(":");
            String user = credParts[0];
            String password = credParts.length > 1 ? credParts[1] : "";
            
            // Reconstruct URL with query parameters
            String jdbcUrl = "jdbc:postgresql://" + hostPart;
            if (!url.contains("?")) {
                jdbcUrl += "?user=" + user + "&password=" + password;
            } else {
                // Keep existing query params and add user/password
                String[] urlParts = url.split("\\?");
                jdbcUrl = "jdbc:postgresql://" + parts[1] + "?" + urlParts[1] + "&user=" + user + "&password=" + password;
            }
            
            return jdbcUrl;
        }
        
        return url;
    }

    public static void main(String[] args) {
        DBContext c = new DBContext();
    }
}
