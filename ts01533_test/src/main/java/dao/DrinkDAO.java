package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Drink;
import utils.JdbcUtil;

public class DrinkDAO implements CrudDAO<Drink, Integer> {

    @Override
    public List<Drink> findAll() {
        List<Drink> list = new ArrayList<>();
        String sql = "SELECT d.MaDoUong AS id, d.maLoai AS category_id, "
                   + "d.tenDoUong AS name, l.tenLoai AS category_name, "
                   + "d.donGia AS price, d.trangThai AS active "
                   + "FROM DOUONG d JOIN LOAIDOUONG l ON d.maLoai = l.maLoai";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Integer id           = rs.getInt("id");
                Integer categoryId   = rs.getInt("category_id");
                String name          = rs.getString("name");
                String categoryName  = rs.getString("category_name");
                int price            = rs.getInt("price");
                boolean active       = rs.getBoolean("active");
                list.add(new Drink(id, categoryId, name, categoryName, price, active));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Drink findById(Integer id) {
        String sql = "SELECT d.MaDoUong AS id, d.maLoai AS category_id, "
                   + "d.tenDoUong AS name, l.tenLoai AS category_name, "
                   + "d.donGia AS price, d.trangThai AS active "
                   + "FROM DOUONG d JOIN LOAIDOUONG l ON d.maLoai = l.maLoai "
                   + "WHERE d.MaDoUong = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                Integer categoryId   = rs.getInt("category_id");
                String name          = rs.getString("name");
                String categoryName  = rs.getString("category_name");
                int price            = rs.getInt("price");
                boolean active       = rs.getBoolean("active");
                return new Drink(id, categoryId, name, categoryName, price, active);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Drink> findBySql(String sql, Object... value) {
        List<Drink> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, value);
            while (rs.next()) {
                Integer id           = rs.getInt("id");
                Integer categoryId   = rs.getInt("category_id");
                String name          = rs.getString("name");
                String categoryName  = rs.getString("category_name");
                int price            = rs.getInt("price");
                boolean active       = rs.getBoolean("active");
                list.add(new Drink(id, categoryId, name, categoryName, price, active));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Câu 4: lọc theo trạng thái
    // public List<Drink> findByStatus(boolean active) {
    //     String sql = "SELECT d.MaDoUong AS id, d.maLoai AS category_id, "
    //                + "d.tenDoUong AS name, l.tenLoai AS category_name, "
    //                + "d.donGia AS price, d.trangThai AS active "
    //                + "FROM DOUONG d JOIN LOAIDOUONG l ON d.maLoai = l.maLoai "
    //                + "WHERE d.trangThai = ?";
    //     return findBySql(sql, active);
    // }
}