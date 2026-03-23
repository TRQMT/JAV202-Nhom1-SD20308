package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class BillDetail {
	Integer id;
	Integer billId;
	Integer drinkId;
	int quantity;
	int price;
}
