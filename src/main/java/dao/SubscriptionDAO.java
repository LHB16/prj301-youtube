package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Subscription;
import model.User;
import util.DBContext;

public class SubscriptionDAO extends DBContext {
    public List<User> getSubscribers(int channelOwnerId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.userid, u.username, u.fullname, u.email "
                + "FROM subscriptions s "
                + "INNER JOIN users u ON s.subscriberid = u.userid "
                + "WHERE s.channelownerid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, channelOwnerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> getSubscriptions(int subscriberId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.userid, u.username, u.fullname, u.email "
                + "FROM subscriptions s "
                + "INNER JOIN users u ON s.channelownerid = u.userid "
                + "WHERE s.subscriberid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, subscriberId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean subscribe(int subscriberId, int channelOwnerId) {
        String sql = "INSERT INTO subscriptions (subscriberid, channelownerid) VALUES (?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, subscriberId);
            ps.setInt(2, channelOwnerId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean unsubscribe(int subscriberId, int channelOwnerId) {
        String sql = "DELETE FROM subscriptions WHERE subscriberid = ? AND channelownerid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, subscriberId);
            ps.setInt(2, channelOwnerId);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isSubscribed(int subscriberId, int channelOwnerId) {
        String sql = "SELECT * FROM subscriptions WHERE subscriberid = ? AND channelownerid = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, subscriberId);
            ps.setInt(2, channelOwnerId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        SubscriptionDAO dao = new SubscriptionDAO();
        for (User u : dao.getSubscribers(3)) {
            System.out.println(u);
        }
    }
}
