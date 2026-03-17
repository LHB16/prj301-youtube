package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import util.DBContext;

public class UserDAO extends DBContext {
    public String hashMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public User login(String username, String password) {
        User u = new User();
        String sql = "select * from users where username = ? and password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashMD5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setUserId(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getInt("role"));
                u.setStatus(rs.getInt("status"));
                if (u.getStatus() == 0) {
                    u.setUserId(-1); // Block login if status is 0
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public User getUserByUsername(String username) {
        User u = new User();
        String sql = "select * from users where username = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setUserId(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getInt("role"));
                u.setStatus(rs.getInt("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public User loginByEmail(String email, String password) {
        User u = new User();
        String sql = "select * from users where email = ? and password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashMD5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setUserId(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getInt("role"));
                u.setStatus(rs.getInt("status"));
                if (u.getStatus() == 0) {
                    u.setUserId(-1); // Block login if status is 0
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    public boolean register(String username, String password, String fullName, String email) {
        // Check if email already exists
        String checkSql = "select * from users where email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(checkSql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false; // Email already exists
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        String sql = "INSERT INTO users (username, password, fullname, email) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashMD5(password));
            ps.setString(3, fullName);
            ps.setString(4, email);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getInt("role"));
                u.setStatus(rs.getInt("status"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean changeUserStatus(int userId, int newStatus) {
        String sql = "UPDATE users SET status = ? WHERE userid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newStatus);
            ps.setInt(2, userId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        System.out.println(dao.login("binh_fpt", "123"));
    }
}
