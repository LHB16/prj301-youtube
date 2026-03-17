package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import util.DBContext;

public class CategoryDAO extends DBContext {
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("categoryID");
                String name = rs.getString("categoryName");
                list.add(new Category(id, name));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM Categories WHERE categoryID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int categoryId = rs.getInt("categoryID");
                String categoryName = rs.getString("categoryName");
                return new Category(categoryId, categoryName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        for (Category c : dao.getAll()) {
            System.out.println(c);
        }
    }
}
