package com.polycoffee.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {
	Integer id;
	String email;
	String password;
	String fullName;
	String phone;
	boolean role;
	boolean active;
}
