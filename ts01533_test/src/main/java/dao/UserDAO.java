package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.User;
import utils.JdbcUtil;

public class UserDAO implements CrudDAO<User, Integer> {

    @Override
    public List<User> findAll() {
       List<User> list = new ArrayList<>();
        String sql = "SELECT MaNV AS id, email, hoTen, matKhau, vaiTro, trangThai FROM NHANVIEN";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Integer id        = rs.getInt("id");
                String dbEmail    = rs.getString("email");
                String hoTen      = rs.getString("hoTen");
                String mk         = rs.getString("matKhau");
                String vaiTro     = rs.getString("vaiTro");
                boolean trangThai = rs.getBoolean("trangThai");
                list.add(new User(id, dbEmail, hoTen, mk, vaiTro, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    @Override
    public User findById(Integer id) {
        
         String sql = "SELECT MaNV AS id, email, hoTen, matKhau, vaiTro, trangThai "
                   + "FROM NHANVIEN WHERE MaNV = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                String dbEmail    = rs.getString("email");
                String hoTen      = rs.getString("hoTen");
                String mk         = rs.getString("matKhau");
                String vaiTro     = rs.getString("vaiTro");
                boolean trangThai = rs.getBoolean("trangThai");
                return new User(id, dbEmail, hoTen, mk, vaiTro, trangThai);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> findBySql(String sql, Object... value) {
       
       List<User> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, value);
            while (rs.next()) {
                Integer id        = rs.getInt("id");
                String dbEmail    = rs.getString("email");
                String hoTen      = rs.getString("hoTen");
                String mk         = rs.getString("matKhau");
                String vaiTro     = rs.getString("vaiTro");
                boolean trangThai = rs.getBoolean("trangThai");
                list.add(new User(id, dbEmail, hoTen, mk, vaiTro, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

     public User findByEmailAndPassword(String email, String matKhau) {
        String sql = "SELECT MaNV AS id, email, hoTen, matKhau, vaiTro, trangThai "
                   + "FROM NHANVIEN WHERE email = ? AND matKhau = ? AND trangThai = 1";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, email, matKhau);
            if (rs.next()) {
                Integer id     = rs.getInt("id");
                String hoTen   = rs.getString("hoTen");
                String mk      = rs.getString("matKhau");
                String vaiTro  = rs.getString("vaiTro");
                boolean trangThai = rs.getBoolean("trangThai");

                return new User(id, email, hoTen, mk, vaiTro, trangThai);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    
}
