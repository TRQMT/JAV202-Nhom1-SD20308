package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.User;
import com.polycoffee.util.JdbcUtil;

public class UserDAO implements CrudDAO<User, Integer> {

    @Override
    public int create(User entity) {
        String sql = "INSERT INTO NHANVIEN(email, matKhau, hoTen, sdt, vaiTro, trangThai) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getEmail(),
                    entity.getPassword(),
                    entity.getFullName(),
                    entity.getPhone(),
                    entity.isRole() ? "admin" : "employee",
                    entity.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(User entity) {
        String sql = "UPDATE NHANVIEN SET email = ?, matKhau = ?, hoTen = ?, sdt = ?, vaiTro = ?, trangThai = ? WHERE MaNV = ?";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getEmail(),
                    entity.getPassword(),
                    entity.getFullName(),
                    entity.getPhone(),
                    entity.isRole() ? "admin" : "employee",
                    entity.isActive(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int delete(Integer id) {
        String sql = "DELETE FROM NHANVIEN WHERE MaNV = ?";
        try {
            return JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<User> findAll() {
        String sql = """
            SELECT MaNV AS id,
                   email,
                   matKhau AS password,
                   hoTen AS full_name,
                   sdt AS phone,
                   CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role,
                   trangThai AS active
            FROM NHANVIEN
        """;
        return findBySql(sql);
    }

    @Override
    public User findById(Integer id) {
        String sql = """
            SELECT MaNV AS id,
                   email,
                   matKhau AS password,
                   hoTen AS full_name,
                   sdt AS phone,
                   CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role,
                   trangThai AS active
            FROM NHANVIEN
            WHERE MaNV = ?
        """;
        List<User> list = findBySql(sql, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<User> findBySql(String sql, Object... args) {
        List<User> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, args);
            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("phone"),
                        rs.getBoolean("role"),
                        rs.getBoolean("active")
                );
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public User findByEmail(String email) {
        String sql = """
            SELECT MaNV AS id,
                   email,
                   matKhau AS password,
                   hoTen AS full_name,
                   sdt AS phone,
                   CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role,
                   trangThai AS active
            FROM NHANVIEN
            WHERE email = ?
        """;
        List<User> list = findBySql(sql, email);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<User> findByRole(boolean role) {
        String sql = """
            SELECT MaNV AS id,
                   email,
                   matKhau AS password,
                   hoTen AS full_name,
                   sdt AS phone,
                   CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role,
                   trangThai AS active
            FROM NHANVIEN
            WHERE vaiTro = ?
        """;
        return findBySql(sql, role ? "admin" : "employee");
    }

    public List<User> searchStaff(String keyword) {
        String sql = """
            SELECT MaNV AS id,
                   email,
                   matKhau AS password,
                   hoTen AS full_name,
                   sdt AS phone,
                   CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role,
                   trangThai AS active
            FROM NHANVIEN
            WHERE vaiTro = 'employee'
            AND (
                hoTen LIKE ?
                OR email LIKE ?
                OR sdt LIKE ?
            )
        """;

        String key = "%" + keyword + "%";
        return findBySql(sql, key, key, key);
    }

    public int updateUserInfo(User entity) {
        String sql = "UPDATE NHANVIEN SET hoTen = ?, sdt = ? WHERE MaNV = ?";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getFullName(),
                    entity.getPhone(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateStatus(Integer id, boolean active) {
        String sql = "UPDATE NHANVIEN SET trangThai = ? WHERE MaNV = ?";
        try {
            return JdbcUtil.executeUpdate(sql, active, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
