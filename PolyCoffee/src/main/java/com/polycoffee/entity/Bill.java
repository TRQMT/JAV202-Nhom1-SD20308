package com.polycoffee.entity;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Bill {
	Integer id;
	Integer userId;
	String code;
	Date createdAt;
	int total;
	String status;
	String paymentMethod;
	String vnpTransactionId;
	String vnpTxnRef;
//	cancel, finish, waiting
}
