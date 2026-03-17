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
        String sql = "SELECT v.videoid, v.title, v.description, v.uploaddate, v.status, "
                + "u.userid, u.username, u.fullname, u.email, "
                + "c.categoryid, c.categoryname "
                + "FROM videos v "
                + "INNER JOIN users u ON v.userid = u.userid "
                + "INNER JOIN categories c ON v.categoryid = c.categoryid";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryid"));
                category.setCategoryName(rs.getString("categoryname"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoid"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploaddate"));
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
        String sql = "SELECT v.videoid, v.title, v.description, v.uploaddate, v.status, "
                + "u.userid, u.username, u.fullname, u.email, "
                + "c.categoryid, c.categoryname "
                + "FROM videos v "
                + "INNER JOIN users u ON v.userid = u.userid "
                + "INNER JOIN categories c ON v.categoryid = c.categoryid "
                + "WHERE v.videoid=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryid"));
                category.setCategoryName(rs.getString("categoryname"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoid"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploaddate"));
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
        String sql = "SELECT v.videoid, v.title, v.description, v.uploaddate, v.status, "
                + "u.userid, u.username, u.fullname, u.email, "
                + "c.categoryid, c.categoryname "
                + "FROM videos v "
                + "INNER JOIN users u ON v.userid = u.userid "
                + "INNER JOIN categories c ON v.categoryid = c.categoryid "
                + "WHERE v.categoryid=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryid"));
                category.setCategoryName(rs.getString("categoryname"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoid"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploaddate"));
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
        String sql = "INSERT INTO videos (title, description, userid, categoryid) VALUES (?, ?, ?, ?)";
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
        // Phai xoa comments truoc vi co FK constraint
        String deleteComments = "DELETE FROM comments WHERE videoid = ?";
        String deleteVideo = "DELETE FROM videos WHERE videoid = ?";
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
        String sql = "SELECT v.videoid, v.title, v.description, v.uploaddate, v.status, "
                + "u.userid, u.username, u.fullname, u.email, "
                + "c.categoryid, c.categoryname "
                + "FROM videos v "
                + "INNER JOIN users u ON v.userid = u.userid "
                + "INNER JOIN categories c ON v.categoryid = c.categoryid "
                + "WHERE v.userid=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("categoryid"));
                category.setCategoryName(rs.getString("categoryname"));

                Video video = new Video();
                video.setVideoId(rs.getInt("videoid"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setUploadDate(rs.getTimestamp("uploaddate"));
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
        String sql = "UPDATE videos SET status = ? WHERE videoid = ?";
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
