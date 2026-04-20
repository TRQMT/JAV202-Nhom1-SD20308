package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Bill;
import utils.JdbcUtil;

public class BillDAO implements CrudDAO<Bill, Integer> {

    @Override
    public List<Bill> findAll() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT h.MaHD AS id, n.hoTen AS tenNhanVien, "
                   + "CAST(h.ngayTao AS DATE) AS ngayTao, "
                   + "h.tongTien, h.trangThai "
                   + "FROM HOADON h JOIN NHANVIEN n ON h.MaNV = n.MaNV";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Integer id           = rs.getInt("id");
                String tenNhanVien   = rs.getString("tenNhanVien");
                String ngayTao       = rs.getString("ngayTao");
                double tongTien      = rs.getDouble("tongTien");
                String trangThai     = rs.getString("trangThai");
                list.add(new Bill(id, tenNhanVien, ngayTao, tongTien, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Bill findById(Integer id) {
        throw new UnsupportedOperationException("Unimplemented method 'findById'");
    }

    @Override
    public List<Bill> findBySql(String sql, Object... value) {
        List<Bill> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, value);
            while (rs.next()) {
                Integer id           = rs.getInt("id");
                String tenNhanVien   = rs.getString("tenNhanVien");
                String ngayTao       = rs.getString("ngayTao");
                double tongTien      = rs.getDouble("tongTien");
                String trangThai     = rs.getString("trangThai");
                list.add(new Bill(id, tenNhanVien, ngayTao, tongTien, trangThai));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> findAllNhanVienNames() {
        List<String> names = new ArrayList<>();
        String sql = "SELECT DISTINCT n.hoTen FROM HOADON h JOIN NHANVIEN n ON h.MaNV = n.MaNV";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                names.add(rs.getString("hoTen"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return names;
    }

    public List<Bill> findByNhanVien(String tenNhanVien) {
    String sql = "SELECT h.MaHD AS id, n.hoTen AS tenNhanVien, "
               + "CAST(h.ngayTao AS DATE) AS ngayTao, "
               + "h.tongTien, h.trangThai "
               + "FROM HOADON h JOIN NHANVIEN n ON h.MaNV = n.MaNV "
               + "WHERE n.hoTen = ?";
    return findBySql(sql, tenNhanVien);
}
}