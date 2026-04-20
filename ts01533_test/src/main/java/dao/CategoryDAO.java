package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Category;
import utils.JdbcUtil;

public class CategoryDAO implements CrudDAO<Category, Integer> {

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT maLoai AS id, tenLoai, hinhAnh, moTa, trangThai FROM LOAIDOUONG";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Integer id        = rs.getInt("id");
                String tenLoai    = rs.getString("tenLoai");
                String hinhAnh    = rs.getString("hinhAnh");
                String moTa       = rs.getString("moTa");
                boolean trangThai = rs.getBoolean("trangThai");
                list.add(new Category(id, tenLoai, hinhAnh, moTa, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category findById(Integer id) {
        String sql = "SELECT maLoai AS id, tenLoai, hinhAnh, moTa, trangThai "
                   + "FROM LOAIDOUONG WHERE maLoai = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                String tenLoai    = rs.getString("tenLoai");
                String hinhAnh    = rs.getString("hinhAnh");
                String moTa       = rs.getString("moTa");
                boolean trangThai = rs.getBoolean("trangThai");
                return new Category(id, tenLoai, hinhAnh, moTa, trangThai);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> findBySql(String sql, Object... value) {
        List<Category> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, value);
            while (rs.next()) {
                Integer id        = rs.getInt("id");
                String tenLoai    = rs.getString("tenLoai");
                String hinhAnh    = rs.getString("hinhAnh");
                String moTa       = rs.getString("moTa");
                boolean trangThai = rs.getBoolean("trangThai");
                list.add(new Category(id, tenLoai, hinhAnh, moTa, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> findByStatus(boolean active) {
        String sql = "SELECT maLoai AS id, tenLoai, hinhAnh, moTa, trangThai "
                   + "FROM LOAIDOUONG WHERE trangThai = ?";
        return findBySql(sql, active);
    }
}