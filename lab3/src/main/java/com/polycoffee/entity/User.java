package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {
    Integer maNV;
    String email;
    String hoTen;
    boolean trangThai;
    String sdt;
    String vaiTro;
    String matKhau;
}