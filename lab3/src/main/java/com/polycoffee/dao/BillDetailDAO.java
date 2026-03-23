package com.polycoffee.dao;


import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.entity.Drink;
import com.polycoffee.utils.JdbcUtil;

public class BillDetailDAO implements CrudDAO<BillDetail, Integer> {
	DrinkDAO drinkDAO = new DrinkDAO();

	public List<BillDetail> findByBillId(Integer billId) {
		String sql = "SELECT * FROM bill_details WHERE bill_id = ?";
		try {
			return this.findBySql(sql, billId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<BillDetail>();
	}

	public int addDrinkToBill(Integer billId, Integer drinkId) {
		BillDAO billDAO = new BillDAO();
		Bill bill = billDAO.findById(billId);
		if (bill == null || !bill.getStatus().equals(BillDAO.STATUS_WAITING)) {
			return 0;
		}
		String sqlCheck = "SELECT * FROM bill_details WHERE bill_id = ? AND drink_id = ?";
		try {
			List<BillDetail> list = this.findBySql(sqlCheck, billId, drinkId);
			if (list.size() > 0) {
				BillDetail billDetail = list.get(0);
				return this.updateQuantity(billId, drinkId, billDetail.getQuantity() + 1);
			} else {
				Drink drink = drinkDAO.findById(drinkId);
				String sqlInsert = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) VALUES(?, ?, ?, ?)";
				int rs = JdbcUtil.executeUpdate(sqlInsert, billId, drinkId, 1, drink.getDonGia());
				if (rs > 0) {
					billDAO.updateTotal(billId);
				}
				return rs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int updateQuantity(Integer billId, Integer drinkId, int quantity) {
		BillDAO billDAO = new BillDAO();
		Bill bill = billDAO.findById(billId);
		if (bill != null && bill.getStatus().equals(BillDAO.STATUS_WAITING)) {
			if (quantity <= 0) {
				String sql = "DELETE FROM bill_details WHERE bill_id = ? AND drink_id = ?";
				try {
					int rs = JdbcUtil.executeUpdate(sql, billId, drinkId);
					if (rs > 0) {
						billDAO.updateTotal(billId);
					}
					return rs;
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				String sql = "UPDATE bill_details SET quantity = ? WHERE bill_id = ? AND drink_id = ?";
				try {
					int rs = JdbcUtil.executeUpdate(sql, quantity, billId, drinkId);
					if (rs > 0) {
						billDAO.updateTotal(billId);
					}
					return rs;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}

	@Override
	public int create(BillDetail entity) {
		String sql = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) values(?, ?, ?, ?)";
		try {
			int rs = JdbcUtil.executeUpdate(sql, entity.getBillId(), entity.getDrinkId(), entity.getQuantity(),
					entity.getPrice());
			if (rs > 0) {
				new BillDAO().updateTotal(entity.getBillId());
			}
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(BillDetail entity) {
		String sql = "UPDATE bill_details SET bill_id = ?, drink_id = ?, quantity = ?, price = ? WHERE id = ?";
		try {
			BillDetail currentBillDetail = this.findById(entity.getId());
			int rs = JdbcUtil.executeUpdate(sql, entity.getBillId(), entity.getDrinkId(), entity.getQuantity(),
					entity.getPrice(), entity.getId());
			if (rs > 0) {
				BillDAO billDAO = new BillDAO();
				billDAO.updateTotal(entity.getBillId());
				if (currentBillDetail != null && !currentBillDetail.getBillId().equals(entity.getBillId())) {
					billDAO.updateTotal(currentBillDetail.getBillId());
				}
			}
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sql = "DELETE FROM bill_details WHERE id = ?";
		try {
			BillDetail billDetail = this.findById(id);
			int rs = JdbcUtil.executeUpdate(sql, id);
			if (rs > 0 && billDetail != null) {
				new BillDAO().updateTotal(billDetail.getBillId());
			}
			return rs;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<BillDetail> findAll() {
		return this.findBySql("SELECT * FROM bill_details");
	}

	@Override
	public BillDetail findById(Integer id) {
		String sql = "SELECT * FROM bill_details WHERE id = ?";
		List<BillDetail> billDetails = this.findBySql(sql, id);
		return billDetails.isEmpty() ? null : billDetails.get(0);
	}

	@Override
	public List<BillDetail> findBySql(String sql, Object... value) {
		List<BillDetail> list = new ArrayList<BillDetail>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);
			while (rs.next()) {
				BillDetail billDetail = new BillDetail(rs.getInt("id"), rs.getInt("bill_id"), rs.getInt("drink_id"),
						rs.getInt("quantity"), rs.getInt("price"));
				list.add(billDetail);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}

