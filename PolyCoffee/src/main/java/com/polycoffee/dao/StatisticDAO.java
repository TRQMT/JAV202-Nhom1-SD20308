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

	public List<RevenueByDay> getRevenueByDay(Date fromDate, Date toDate) throws SQLException {
		List<RevenueByDay> result = new ArrayList<>();
		String fromDateStr = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateStr = DateUtil.toString(toDate, "yyyy-MM-dd");

		try {
			String sql = "{CALL sp_revenue_by_day(?, ?)}";
			ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateStr, toDate == null ? null : toDateStr);
			while (rs.next()) {
				RevenueByDay dto = new RevenueByDay();
				dto.setRevenueDate(rs.getDate("revenue_date"));
				dto.setTotalBills(rs.getInt("total_bills"));
				dto.setTotalRevenue(rs.getLong("total_revenue"));
				result.add(dto);
			}
			return result;
		} catch (Exception ex) {
			String fallbackSql = "SELECT CAST(h.ngayTao AS DATE) AS revenue_date, COUNT(DISTINCT h.MaHD) AS total_bills, SUM(ct.soLuong * ct.donGia) AS total_revenue FROM HOADON h INNER JOIN CHITIETHOADON ct ON h.MaHD = ct.MaHD WHERE LOWER(LTRIM(RTRIM(h.trangThai))) IN ('finish', 'paid') AND (? IS NULL OR h.ngayTao >= ?) AND (? IS NULL OR h.ngayTao < DATEADD(day, 1, ?)) GROUP BY CAST(h.ngayTao AS DATE) ORDER BY CAST(h.ngayTao AS DATE)";
			ResultSet rs = JdbcUtil.executeQuery(fallbackSql, fromDate == null ? null : fromDateStr, fromDate == null ? null : fromDateStr,
					toDate == null ? null : toDateStr, toDate == null ? null : toDateStr);
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

	public List<BestSellingDrink> getTop5BestSellingDrinks(Date fromDate, Date toDate) throws SQLException {
		List<BestSellingDrink> result = new ArrayList<>();
		String fromDateStr = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateStr = DateUtil.toString(toDate, "yyyy-MM-dd");

		try {
			String sql = "{CALL sp_top_5_best_selling(?, ?)}";
			ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateStr, toDate == null ? null : toDateStr);
			while (rs.next()) {
				BestSellingDrink dto = new BestSellingDrink();
				dto.setDrinkId(rs.getInt("drink_id"));
				dto.setDrinkName(rs.getString("drink_name"));
				dto.setTotalQuantity(rs.getLong("total_quantity"));
				dto.setTotalRevenue(rs.getLong("total_revenue"));
				result.add(dto);
			}
			return result;
		} catch (Exception ex) {
			String fallbackSql = "SELECT TOP 5 d.MaDoUong AS drink_id, d.tenDoUong AS drink_name, SUM(ct.soLuong) AS total_quantity, SUM(ct.soLuong * ct.donGia) AS total_revenue FROM DOUONG d INNER JOIN CHITIETHOADON ct ON d.MaDoUong = ct.MaDoUong INNER JOIN HOADON h ON h.MaHD = ct.MaHD WHERE LOWER(LTRIM(RTRIM(h.trangThai))) IN ('finish', 'paid') AND (? IS NULL OR h.ngayTao >= ?) AND (? IS NULL OR h.ngayTao < DATEADD(day, 1, ?)) GROUP BY d.MaDoUong, d.tenDoUong ORDER BY SUM(ct.soLuong) DESC, SUM(ct.soLuong * ct.donGia) DESC";
			ResultSet rs = JdbcUtil.executeQuery(fallbackSql, fromDate == null ? null : fromDateStr, fromDate == null ? null : fromDateStr,
					toDate == null ? null : toDateStr, toDate == null ? null : toDateStr);
			while (rs.next()) {
				BestSellingDrink dto = new BestSellingDrink();
				dto.setDrinkId(rs.getInt("drink_id"));
				dto.setDrinkName(rs.getString("drink_name"));
				dto.setTotalQuantity(rs.getLong("total_quantity"));
				dto.setTotalRevenue(rs.getLong("total_revenue"));
				result.add(dto);
			}
			return result;
		}
	}

}
