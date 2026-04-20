package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Bill {
    Integer id;
    String tenNhanVien;
    String ngayTao;
    double tongTien;
    String trangThai;
}