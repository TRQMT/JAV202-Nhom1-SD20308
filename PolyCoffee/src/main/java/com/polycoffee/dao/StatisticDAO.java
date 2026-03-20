package com.polycoffee.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.polycoffee.entity.BestSellingDrink;
import com.polycoffee.entity.RevenueByDay;
import com.polycoffee.util.DateUtil;
import com.polycoffee.util.JdbcUtil;

public class StatisticDAO {

	public List<BestSellingDrink> getTop5BestSellingDrinks(Date fromDate, Date toDate) throws SQLException {

		List<BestSellingDrink> result = new ArrayList<>();

		String sql = "{CALL sp_top_5_best_selling_drinks(?, ?)}";

		String fromDateStr = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateStr = DateUtil.toString(toDate, "yyyy-MM-dd");

		ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateStr,
				toDate == null ? null : toDateStr);

		while (rs.next()) {
			BestSellingDrink dto = new BestSellingDrink();
			dto.setDrinkId(rs.getInt("drink_id"));
			dto.setDrinkName(rs.getString("drink_name"));
			dto.setTotalQuantitySold(rs.getInt("total_quantity_sold"));
			dto.setTotalRevenue(rs.getLong("total_revenue"));

			result.add(dto);
		}

		return result;
	}

	public List<RevenueByDay> getRevenueByDay(Date fromDate, Date toDate) throws SQLException {

		List<RevenueByDay> result = new ArrayList<>();

		String sql = "{CALL sp_revenue_by_day(?, ?)}";

		String fromDateStr = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateStr = DateUtil.toString(toDate, "yyyy-MM-dd");

		ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateStr,
				toDate == null ? null : toDateStr);

		while (rs.next()) {
			RevenueByDay dto = new RevenueByDay();
			dto.setRevenueDate(rs.getDate("revenue_date"));
			dto.setTotalBills(rs.getInt("total_bills"));
			dto.setTotalRevenue(rs.getLong("total_revenue"));

			result.add(dto);
		}

		return result;
	}

}
