package com.polycoffee.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.utils.JdbcUtil;

public class BillDAO implements CrudDAO<Bill, Integer> {

	@Override
	public int create(Bill entity) {
		String sql = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), entity.getCode(), entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Bill entity) {
		String sql = "UPDATE bills SET user_id = ?, code = ?, created_at = ?, total = ?, status = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), entity.getCode(), entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sqlDeleteBillDetails = "DELETE FROM bill_details WHERE bill_id = ?";
		String sqlDeleteBill = "DELETE FROM bills WHERE id = ?";
		try {
			JdbcUtil.executeUpdate(sqlDeleteBillDetails, id);
			return JdbcUtil.executeUpdate(sqlDeleteBill, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Bill> findAll() {
		return this.findBySql("SELECT * FROM bills");
	}

	@Override
	public Bill findById(Integer id) {
		String sql = "SELECT * FROM bills WHERE id = ?";
		List<Bill> bills = this.findBySql(sql, id);
		return bills.isEmpty() ? null : bills.get(0);
	}

	@Override
	public List<Bill> findBySql(String sql, Object... value) {
		List<Bill> list = new ArrayList<Bill>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);
			while (rs.next()) {
				Bill bill = new Bill();
				bill.setId(rs.getInt("id"));
				bill.setUserId(rs.getInt("user_id"));
				bill.setCode(rs.getString("code"));
				bill.setCreatedAt(rs.getDate("created_at"));
				bill.setTotal(rs.getInt("total"));
				bill.setStatus(rs.getString("status"));
				if (hasColumn(rs, "payment_method")) {
					bill.setPaymentMethod(rs.getString("payment_method"));
				}
				if (hasColumn(rs, "vnpay_transaction_id")) {
					bill.setVnpTransactionId(rs.getString("vnpay_transaction_id"));
				}
				if (hasColumn(rs, "vnp_txn_ref")) {
					bill.setVnpTxnRef(rs.getString("vnp_txn_ref"));
				}
				list.add(bill);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private boolean hasColumn(ResultSet rs, String columnName) {
		try {
			ResultSetMetaData meta = rs.getMetaData();
			for (int i = 1; i <= meta.getColumnCount(); i++) {
				if (columnName.equalsIgnoreCase(meta.getColumnName(i))) {
					return true;
				}
			}
		} catch (Exception e) {
			return false;
		}
		return false;
	}

//	Trạng thái hóa đơn
	public static final String STATUS_WAITING = "waiting";
	public static final String STATUS_FINISH = "finish";
	public static final String STATUS_CANCEL = "cancel";

	public Bill findByIdAndUserId(Integer id, Integer userId) {
		String sql = "SELECT * FROM bills WHERE id = ? AND user_id = ?";
		try {
			List<Bill> bills = this.findBySql(sql, id, userId);
			if (!bills.isEmpty()) {
				return bills.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

//	Tạo hóa đơn cùng với chi tiết hóa đơn
	public int createWithBillDetails(Bill bill, List<BillDetail> billDetails) {
		String sqlBill = "INSERT INTO bills(user_id, code, created_at, total, status) OUTPUT INSERTED.ID values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement stmt = JdbcUtil.createPreStmt(sqlBill, bill.getUserId(), bill.getCode(),
					bill.getCreatedAt(), bill.getTotal(), bill.getStatus());
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				int billId = rs.getInt(1);
				BillDetailDAO billDetailDAO = new BillDetailDAO();
				for (BillDetail billDetail : billDetails) {
					billDetail.setBillId(billId);
					billDetailDAO.create(billDetail);
				}
				updateTotal(billId);
				return billId;
			}
		} catch (Exception e) {
			try {
				String fallbackInsert = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
				JdbcUtil.executeUpdate(fallbackInsert, bill.getUserId(), bill.getCode(), bill.getCreatedAt(), bill.getTotal(),
						bill.getStatus());
				ResultSet scopeRs = JdbcUtil.executeQuery("SELECT CAST(SCOPE_IDENTITY() AS INT) AS id");
				if (scopeRs.next()) {
					int billId = scopeRs.getInt("id");
					if (billId > 0) {
						BillDetailDAO billDetailDAO = new BillDetailDAO();
						for (BillDetail billDetail : billDetails) {
							billDetail.setBillId(billId);
							billDetailDAO.create(billDetail);
						}
						updateTotal(billId);
						return billId;
					}
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return 0;
	}

//	Cập nhật trạng thái hóa đơn
	public int updateStatus(Integer billId, String status) {
		Bill bill = this.findById(billId);
		if (bill == null) {
			return 0;
		}
		if (bill.getStatus().equals(STATUS_WAITING)) {
			if (status.equals(STATUS_FINISH) || status.equals(STATUS_CANCEL)) {
				String sql = "UPDATE bills SET status = ? WHERE id = ?";
				try {
					return JdbcUtil.executeUpdate(sql, status, billId);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (bill.getStatus().equals(STATUS_FINISH)) {
			if (status.equals(STATUS_CANCEL)) {
				String sql = "UPDATE bills SET status = ? WHERE id = ?";
				try {
					return JdbcUtil.executeUpdate(sql, status, billId);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}

	public int updateAfterVnpaySuccess(Integer billId, String transactionId, String txnRef) {
		String sql = "UPDATE bills SET status = ?, payment_method = ?, vnpay_transaction_id = ?, vnp_txn_ref = ? WHERE id = ?";
		try {
			int rs = JdbcUtil.executeUpdate(sql, STATUS_FINISH, "vnpay", transactionId, txnRef, billId);
			if (rs > 0) {
				occupyCardIfNeeded(billId);
			}
			return rs;
		} catch (Exception e) {
			String fallback = "UPDATE bills SET status = ? WHERE id = ?";
			try {
				int rs = JdbcUtil.executeUpdate(fallback, STATUS_FINISH, billId);
				if (rs > 0) {
					occupyCardIfNeeded(billId);
				}
				return rs;
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return 0;
	}

	public int markVnpayAttempt(Integer billId, String txnRef) {
		String sql = "UPDATE bills SET payment_method = ?, vnp_txn_ref = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, "vnpay", txnRef, billId);
		} catch (Exception e) {
			return 0;
		}
	}

	public int updatePaymentMethod(Integer billId, String paymentMethod) {
		String sql = "UPDATE bills SET payment_method = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, paymentMethod, billId);
		} catch (Exception e) {
			return 0;
		}
	}

	public int completeCashPayment(Integer billId) {
		int rs = updatePaymentMethod(billId, "cash");
		if (rs >= 0) {
			rs = updateStatus(billId, STATUS_FINISH);
			if (rs > 0) {
				occupyCardIfNeeded(billId);
			}
		}
		return rs;
	}

	private int occupyCardIfNeeded(Integer billId) {
		Bill bill = findById(billId);
		if (bill == null) {
			return 0;
		}
		try {
			ResultSet currentCard = JdbcUtil.executeQuery("SELECT card_id FROM bills WHERE id = ?", billId);
			if (currentCard.next()) {
				int cardId = currentCard.getInt("card_id");
				if (cardId > 0) {
					JdbcUtil.executeUpdate("UPDATE cards SET status = ? WHERE id = ?", 1, cardId);
					return cardId;
				}
			}

			ResultSet availableCard = JdbcUtil.executeQuery(
					"SELECT TOP 1 id FROM cards WHERE ISNULL(status, 0) = 0 ORDER BY id");
			if (availableCard.next()) {
				int selectedCardId = availableCard.getInt("id");
				JdbcUtil.executeUpdate("UPDATE bills SET card_id = ? WHERE id = ?", selectedCardId, billId);
				JdbcUtil.executeUpdate("UPDATE cards SET status = ? WHERE id = ?", 1, selectedCardId);
				return selectedCardId;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

//	Cập nhật tổng tiền hóa đơn
	public int updateTotal(Integer billId) {
		BillDetailDAO billDetailDAO = new BillDetailDAO();
		List<BillDetail> billDetails = billDetailDAO.findByBillId(billId);
		int total = 0;
		for (BillDetail billDetail : billDetails) {
			total += billDetail.getPrice() * billDetail.getQuantity();
		}
		String sql = "UPDATE bills SET total = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, total, billId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

//	Lấy danh sách hóa đơn của user theo userId
	public List<Bill> findByUserId(Integer userId) {
//		Lấy danh sách hóa đơn của user, sắp xếp theo trạng thái: waiting, finish, cancel
		String sql = "SELECT * FROM bills WHERE user_id = ? ORDER BY CASE status WHEN 'waiting' THEN 1 WHEN 'finish' THEN 2 WHEN 'cancel' THEN 3 END";
		try {
			return this.findBySql(sql, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<Bill>();
	}

}

