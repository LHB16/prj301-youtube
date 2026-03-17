package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.User;
import model.Video;
import util.DBContext;

public class CommentDAO extends DBContext {
    public List<Comment> getCommentsByVideoId(int videoId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.commentid, c.content, c.commentdate, c.status, "
                + "u.userid, u.username, u.fullname, u.email "
                + "FROM comments c "
                + "INNER JOIN users u ON c.userid = u.userid "
                + "WHERE c.videoid=? "
                + "ORDER BY c.commentdate DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, videoId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));

                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("commentid"));
                comment.setContent(rs.getString("content"));
                comment.setCommentDate(rs.getTimestamp("commentdate"));
                comment.setStatus(rs.getInt("status"));
                comment.setUser(user);

                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addComment(String content, int userId, int videoId) {
        String sql = "INSERT INTO comments (content, userid, videoid) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, content);
            ps.setInt(2, userId);
            ps.setInt(3, videoId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeCommentStatus(int commentId, int newStatus) {
        String sql = "UPDATE comments SET status = ? WHERE commentid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newStatus);
            ps.setInt(2, commentId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        CommentDAO dao = new CommentDAO();
        for (Comment c : dao.getCommentsByVideoId(1)) {
            System.out.println(c);
        }
    }
}
