package com.polycoffee.dao;

import com.polycoffee.entity.Drink;
import com.polycoffee.utils.JdbcUtil;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DrinkDAO implements CrudDAO<Drink, Integer> {

    @Override
    public int create(Drink entity) {
        String sql = "INSERT INTO DOUONG(moTa, trangThai, hinhAnh, donGia, tenDoUong, maLoai) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getMoTa(),
                    entity.isTrangThai(),
                    entity.getHinhAnh(),
                    entity.getDonGia(),
                    entity.getTenDoUong(),
                    entity.getMaLoai());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(Drink entity) {
        String sql = "UPDATE DOUONG SET moTa = ?, trangThai = ?, hinhAnh = ?, donGia = ?, tenDoUong = ?, maLoai = ? WHERE MaDoUong = ?";
        try {
            return JdbcUtil.executeUpdate(sql,
                    entity.getMoTa(),
                    entity.isTrangThai(),
                    entity.getHinhAnh(),
                    entity.getDonGia(),
                    entity.getTenDoUong(),
                    entity.getMaLoai(),
                    entity.getMaDoUong());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int delete(Integer id) {
        String sql = "DELETE FROM DOUONG WHERE MaDoUong = ?";
        try {
            return JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Drink> findAll() {
        List<Drink> list = new ArrayList<>();
        String sql = "SELECT * FROM DOUONG";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Drink drink = new Drink(
                        rs.getInt("MaDoUong"),
                        rs.getString("moTa"),
                        rs.getBoolean("trangThai"),
                        rs.getString("hinhAnh"),
                        rs.getBigDecimal("donGia"),
                        rs.getString("tenDoUong"),
                        rs.getInt("maLoai")
                );
                list.add(drink);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Drink findById(Integer id) {
        String sql = "SELECT * FROM DOUONG WHERE MaDoUong = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new Drink(
                        rs.getInt("MaDoUong"),
                        rs.getString("moTa"),
                        rs.getBoolean("trangThai"),
                        rs.getString("hinhAnh"),
                        rs.getBigDecimal("donGia"),
                        rs.getString("tenDoUong"),
                        rs.getInt("maLoai")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Drink> findBySql(String sql, Object... values) {
        List<Drink> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, values);
            while (rs.next()) {
                list.add(new Drink(
                        rs.getInt("MaDoUong"),
                        rs.getString("moTa"),
                        rs.getBoolean("trangThai"),
                        rs.getString("hinhAnh"),
                        rs.getBigDecimal("donGia"),
                        rs.getString("tenDoUong"),
                        rs.getInt("maLoai")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Phương thức thêm: tìm theo loại đồ uống
    public List<Drink> findByCategory(Integer maLoai) {
        String sql = "SELECT * FROM DOUONG WHERE maLoai = ?";
        return findBySql(sql, maLoai);
    }

    // Phương thức thêm: tìm đồ uống đang hoạt động
    public List<Drink> findActiveDrinks() {
        String sql = "SELECT * FROM DOUONG WHERE trangThai = 1";
        return findBySql(sql);
    }
}