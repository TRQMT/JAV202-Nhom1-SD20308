package com.polycoffee.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class RevenueByDay {
	private Date revenueDate;
	private int totalBills;
	private long totalRevenue;
}
