  package com.polycoffee.entity;

  import lombok.AllArgsConstructor;
  import lombok.Data;
  import lombok.NoArgsConstructor;

  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public class Category {
      private int maLoai;
      private String tenLoai;
      private String hinhAnh;
      private boolean trangThai;
      private String moTa;
  }
