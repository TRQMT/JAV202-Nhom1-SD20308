package dao;

import java.sql.ResultSet;
import java.util.List;

import entity.NhanVien;
import utils.JdbcUtil;

public class NhanVienDAO implements CrudDAO<NhanVien, Integer> {

    @Override
    public List<NhanVien> findAll() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findAll'");
    }

    @Override
    public NhanVien findById(Integer id) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findById'");
    }

    @Override
    public List<NhanVien> findBySql(String sql, Object... value) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'findBySql'");
    }

     public NhanVien findByEmailAndPassword(String email, String matKhau) {
        String sql = "SELECT MaNV AS id, email, hoTen, matKhau, vaiTro "
                   + "FROM NHANVIEN WHERE email = ? AND matKhau = ? AND trangThai = 1";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, email, matKhau);
            if (rs.next()) {
                Integer id     = rs.getInt("id");
                String hoTen   = rs.getString("hoTen");
                String mk      = rs.getString("matKhau");
                String vaiTro  = rs.getString("vaiTro");
                return new NhanVien(id, email, hoTen, mk, vaiTro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    
}
