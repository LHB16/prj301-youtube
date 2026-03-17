package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.User;
import model.Video;
import util.DBContext;

public class VideoDAO extends DBContext {
    public List<Video> getAll() {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.videoID, v.title, v.description, v.uploadDate, v.status, "
                + "u.userID, u.username, u.fullName, u.email, "
                + "c.categoryID, c.categoryName "
                + "FROM Videos v "
                + "INNER JOIN Users u ON v.userID = u.userID "
                + "INNER JOIN Categories c ON v.categoryID = c.categoryID";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("categoryName"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoID"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploadDate"));
                video.setStatus(rs.getInt("status"));
                video.setUser(user);
                video.setCategory(category);

                list.add(video);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Video getVideoById(int videoId) {
        String sql = "SELECT v.videoID, v.title, v.description, v.uploadDate, v.status, "
                + "u.userID, u.username, u.fullName, u.email, "
                + "c.categoryID, c.categoryName "
                + "FROM Videos v "
                + "INNER JOIN Users u ON v.userID = u.userID "
                + "INNER JOIN Categories c ON v.categoryID = c.categoryID "
                + "WHERE v.videoID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("categoryName"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoID"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploadDate"));
                video.setStatus(rs.getInt("status"));
                video.setUser(user);
                video.setCategory(category);

                return video;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Video> getVideosByCategoryId(int categoryId) {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.videoID, v.title, v.description, v.uploadDate, v.status, "
                + "u.userID, u.username, u.fullName, u.email, "
                + "c.categoryID, c.categoryName "
                + "FROM Videos v "
                + "INNER JOIN Users u ON v.userID = u.userID "
                + "INNER JOIN Categories c ON v.categoryID = c.categoryID "
                + "WHERE v.categoryID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("categoryName"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoID"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploadDate"));
                video.setStatus(rs.getInt("status"));
                video.setUser(user);
                video.setCategory(category);

                list.add(video);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(Video video) {
        String sql = "INSERT INTO Videos (title, description, userID, categoryID) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, video.getTitle());
            ps.setString(2, video.getDescription());
            ps.setInt(3, video.getUser().getUserId());
            ps.setInt(4, video.getCategory().getCategoryId());
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int videoId) {
        // Phải xóa comments trước vì có FK constraint
        String deleteComments = "DELETE FROM Comments WHERE videoID = ?";
        String deleteVideo = "DELETE FROM Videos WHERE videoID = ?";
        try {
            PreparedStatement ps1 = conn.prepareStatement(deleteComments);
            ps1.setInt(1, videoId);
            ps1.executeUpdate();

            PreparedStatement ps2 = conn.prepareStatement(deleteVideo);
            ps2.setInt(1, videoId);
            int row = ps2.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Video> getVideosByUserId(int userId) {
        List<Video> list = new ArrayList<>();
        String sql = "SELECT v.videoID, v.title, v.description, v.uploadDate, v.status, "
                + "u.userID, u.username, u.fullName, u.email, "
                + "c.categoryID, c.categoryName "
                + "FROM Videos v "
                + "INNER JOIN Users u ON v.userID = u.userID "
                + "INNER JOIN Categories c ON v.categoryID = c.categoryID "
                + "WHERE v.userID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userID"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("categoryName"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoID"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploadDate"));
                video.setStatus(rs.getInt("status"));
                video.setUser(user);
                video.setCategory(category);

                list.add(video);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean changeVideoStatus(int videoId, int newStatus) {
        String sql = "UPDATE Videos SET status = ? WHERE videoID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newStatus);
            ps.setInt(2, videoId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        VideoDAO dao = new VideoDAO();
        for (Video v : dao.getAll()) {
            System.out.println(v);
        }
    }
}
