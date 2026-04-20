package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Category {
    Integer id;
    String tenLoai;
    String hinhAnh;
    String moTa;
    boolean trangThai;
}