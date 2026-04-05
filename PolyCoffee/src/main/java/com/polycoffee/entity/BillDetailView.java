package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BillDetailView {
    Integer id;
    Integer billId;
    Integer drinkId;
    String drinkName;
    int quantity;
    int price;
    long lineTotal;
}
