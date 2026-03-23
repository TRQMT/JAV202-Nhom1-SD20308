package com.polycoffee.dao;

import com.polycoffee.entity.User;
import com.polycoffee.utils.JdbcUtil;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements CrudDAO<User, Integer> {

    @Override
    public int create(User entity) {
        String sql = "INSERT INTO NHANVIEN(email, hoTen, trangThai, sdt, vaiTro, matKhau) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getEmail(),
                    entity.getHoTen(),
                    entity.isTrangThai(),
                    entity.getSdt(),
                    entity.getVaiTro(),
                    entity.getMatKhau());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(User entity) {
        String sql = "UPDATE NHANVIEN SET email = ?, hoTen = ?, trangThai = ?, sdt = ?, vaiTro = ?, matKhau = ? WHERE MaNV = ?";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getEmail(),
                    entity.getHoTen(),
                    entity.isTrangThai(),
                    entity.getSdt(),
                    entity.getVaiTro(),
                    entity.getMatKhau(),
                    entity.getMaNV());
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
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM NHANVIEN";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                User user = new User(
                        rs.getInt("MaNV"),
                        rs.getString("email"),
                        rs.getString("hoTen"),
                        rs.getBoolean("trangThai"),
                        rs.getString("sdt"),
                        rs.getString("vaiTro"),
                        rs.getString("matKhau")
                );
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User findById(Integer id) {
        String sql = "SELECT * FROM NHANVIEN WHERE MaNV = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new User(
                        rs.getInt("MaNV"),
                        rs.getString("email"),
                        rs.getString("hoTen"),
                        rs.getBoolean("trangThai"),
                        rs.getString("sdt"),
                        rs.getString("vaiTro"),
                        rs.getString("matKhau")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> findBySql(String sql, Object... values) {
        List<User> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, values);
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("MaNV"),
                        rs.getString("email"),
                        rs.getString("hoTen"),
                        rs.getBoolean("trangThai"),
                        rs.getString("sdt"),
                        rs.getString("vaiTro"),
                        rs.getString("matKhau")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
	}