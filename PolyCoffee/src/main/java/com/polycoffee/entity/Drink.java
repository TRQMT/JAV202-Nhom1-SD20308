package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Drink {
	Integer id;
	Integer categoryId;
	String name;
	String description;
	String image;
	int price;
	boolean active;
}

