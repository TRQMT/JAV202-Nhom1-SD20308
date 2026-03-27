package com.polycoffee.dao;

import com.polycoffee.entity.Category;
import com.polycoffee.utils.JdbcUtil;
import lombok.NoArgsConstructor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;  

@NoArgsConstructor

public class CategoryDAO {
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT maLoai, tenLoai, hinhAnh, trangThai, moTa FROM LOAIDOUONG";

        try (ResultSet rs = JdbcUtil.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category getById(int maLoai) {
        String sql = "SELECT maLoai, tenLoai, hinhAnh, trangThai, moTa "
                   + "FROM LOAIDOUONG WHERE maLoai = ?";

        try (ResultSet rs = JdbcUtil.executeQuery(sql, maLoai)) {
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Category> getByStatus(boolean trangThai) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT maLoai, tenLoai, hinhAnh, trangThai, moTa "
                   + "FROM LOAIDOUONG WHERE trangThai = ?";

        try (ResultSet rs = JdbcUtil.executeQuery(sql, trangThai)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> searchByName(String keyword) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT maLoai, tenLoai, hinhAnh, trangThai, moTa "
                   + "FROM LOAIDOUONG WHERE tenLoai LIKE ?";

        try (ResultSet rs = JdbcUtil.executeQuery(sql, "%" + keyword + "%")) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insert(Category c) {
        String sql = "INSERT INTO LOAIDOUONG (tenLoai, hinhAnh, trangThai, moTa) "
                   + "VALUES (?, ?, ?, ?)";
        try {
            return JdbcUtil.executeUpdate(sql,
                c.getTenLoai(), c.getHinhAnh(), c.isTrangThai(), c.getMoTa()
            ) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Category c) {
        String sql = "UPDATE LOAIDOUONG "
                   + "SET tenLoai = ?, hinhAnh = ?, trangThai = ?, moTa = ? "
                   + "WHERE maLoai = ?";
        try {
            return JdbcUtil.executeUpdate(sql,
                c.getTenLoai(), c.getHinhAnh(), c.isTrangThai(), c.getMoTa(), c.getMaLoai()
            ) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean softDelete(int maLoai) {
        String sql = "UPDATE LOAIDOUONG SET trangThai = 0 WHERE maLoai = ?";
        try {
            return JdbcUtil.executeUpdate(sql, maLoai) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maLoai) {
        String sql = "DELETE FROM LOAIDOUONG WHERE maLoai = ?";
        try {
            return JdbcUtil.executeUpdate(sql, maLoai) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isNameExist(String tenLoai) {
        String sql = "SELECT COUNT(*) FROM LOAIDOUONG WHERE tenLoai = ?";
        try (ResultSet rs = JdbcUtil.executeQuery(sql, tenLoai)) {
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Category mapRow(ResultSet rs) throws SQLException {
        return new Category(
            rs.getInt("maLoai"),
            rs.getString("tenLoai"),
            rs.getString("hinhAnh"),
            rs.getBoolean("trangThai"),
            rs.getString("moTa")
        );
    }
public List<Category> findAll() {
    List<Category> list = new ArrayList<>();
    String sql = "SELECT maLoai, tenLoai, hinhAnh, trangThai, moTa FROM LOAIDOUONG WHERE trangThai = 1";
    try {
        ResultSet resultSet = JdbcUtil.executeQuery(sql);
        while(resultSet.next()) {
            Integer maLoai    = resultSet.getInt("maLoai");
            String tenLoai    = resultSet.getString("tenLoai");
            String hinhAnh    = resultSet.getString("hinhAnh");
            boolean trangThai = resultSet.getBoolean("trangThai");
            String moTa       = resultSet.getString("moTa");
            Category category = new Category(maLoai, tenLoai, hinhAnh, trangThai, moTa);
            list.add(category);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public int create(Category entity) {
    String sql = "INSERT INTO LOAIDOUONG(tenLoai, hinhAnh, trangThai, moTa) VALUES (?, ?, ?, ?)";
    try {
        return JdbcUtil.executeUpdate(sql,
            entity.getTenLoai(),    // sửa: getName() → getTenLoai()
            entity.getHinhAnh(),    // sửa: "default.jpg" hardcode → lấy từ entity
            entity.isTrangThai(),   // sửa: isActive() → isTrangThai()
            entity.getMoTa()        // sửa: "" hardcode → lấy từ entity
        );
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

}
