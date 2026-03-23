package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Drink {
    Integer maDoUong;
    String moTa;
    boolean trangThai;
    String hinhAnh;
    BigDecimal donGia;
    String tenDoUong;
    Integer maLoai;
}