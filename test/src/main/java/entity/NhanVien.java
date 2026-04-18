package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class NhanVien {
    Integer id;
    String email;
    String hoTen;
    String matKhau;
    String vaiTro;
}