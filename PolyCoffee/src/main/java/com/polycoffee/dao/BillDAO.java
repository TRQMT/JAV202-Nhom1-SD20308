package com.polycoffee.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.util.JdbcUtil;

public class BillDAO implements CrudDAO<Bill, Integer> {
	private static final int DEFAULT_CUSTOMER_ID = 1;
	private static final String SELECT_BILL_BASE = "SELECT h.MaHD AS id, h.MaNV AS user_id, nv.hoTen AS user_name, CONCAT('HD', h.MaHD) AS code, h.ngayTao AS created_at, h.tongTien AS total, h.trangThai AS status FROM HOADON h LEFT JOIN NHANVIEN nv ON h.MaNV = nv.MaNV";

	@Override
	public int create(Bill entity) {
		String sql = "INSERT INTO HOADON(MaNV, MaKH, ngayTao, tongTien, trangThai) values (?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), DEFAULT_CUSTOMER_ID, entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Bill entity) {
		String sql = "UPDATE HOADON SET MaNV = ?, ngayTao = ?, tongTien = ?, trangThai = ? WHERE MaHD = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sqlDeleteBillDetails = "DELETE FROM CHITIETHOADON WHERE MaHD = ?";
		String sqlDeleteBill = "DELETE FROM HOADON WHERE MaHD = ?";
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
		return this.findBySql(SELECT_BILL_BASE + " ORDER BY h.ngayTao DESC, h.MaHD DESC");
	}

	@Override
	public Bill findById(Integer id) {
		String sql = SELECT_BILL_BASE + " WHERE h.MaHD = ?";
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
				if (hasColumn(rs, "user_name")) {
					bill.setUserName(rs.getString("user_name"));
				}
				bill.setCode(rs.getString("code"));
				bill.setCreatedAt(rs.getDate("created_at"));
				bill.setTotal(rs.getInt("total"));
				bill.setStatus(normalizeStatus(rs.getString("status")));
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

	private String normalizeStatus(String status) {
		if (status == null) {
			return "";
		}
		String normalized = status.trim().toLowerCase();
		if ("paid".equals(normalized)) {
			return STATUS_FINISH;
		}
		return normalized;
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
		String sql = SELECT_BILL_BASE + " WHERE h.MaHD = ? AND h.MaNV = ?";
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
		String sqlBill = "INSERT INTO HOADON(MaNV, MaKH, ngayTao, tongTien, trangThai) OUTPUT INSERTED.MaHD values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement stmt = JdbcUtil.createPreStmt(sqlBill, bill.getUserId(), DEFAULT_CUSTOMER_ID,
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
				String fallbackInsert = "INSERT INTO HOADON(MaNV, MaKH, ngayTao, tongTien, trangThai) values (?, ?, ?, ?, ?)";
				JdbcUtil.executeUpdate(fallbackInsert, bill.getUserId(), DEFAULT_CUSTOMER_ID, bill.getCreatedAt(), bill.getTotal(),
						bill.getStatus());
				ResultSet scopeRs = JdbcUtil.executeQuery("SELECT CAST(SCOPE_IDENTITY() AS INT) AS MaHD");
				if (scopeRs.next()) {
					int billId = scopeRs.getInt("MaHD");
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
				String sql = "UPDATE HOADON SET trangThai = ? WHERE MaHD = ?";
				try {
					return JdbcUtil.executeUpdate(sql, status, billId);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (bill.getStatus().equals(STATUS_FINISH)) {
			if (status.equals(STATUS_CANCEL)) {
				String sql = "UPDATE HOADON SET trangThai = ? WHERE MaHD = ?";
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
		int rs = 0;
		try {
			rs = JdbcUtil.executeUpdate(
					"UPDATE HOADON SET trangThai = ?, payment_method = ?, vnpay_transaction_id = ?, vnp_txn_ref = ? WHERE MaHD = ?",
					STATUS_FINISH, "vnpay", transactionId, txnRef, billId);
		} catch (Exception e1) {
			try {
				rs = JdbcUtil.executeUpdate(
						"UPDATE HOADON SET trangThai = ?, payment_method = ?, vnp_txn_ref = ? WHERE MaHD = ?",
						STATUS_FINISH, "vnpay", txnRef, billId);
			} catch (Exception e2) {
				try {
					rs = JdbcUtil.executeUpdate("UPDATE HOADON SET trangThai = ?, payment_method = ? WHERE MaHD = ?",
							STATUS_FINISH, "vnpay", billId);
				} catch (Exception e3) {
					try {
						rs = JdbcUtil.executeUpdate("UPDATE HOADON SET trangThai = ? WHERE MaHD = ?", STATUS_FINISH, billId);
					} catch (Exception ex) {
						ex.printStackTrace();
					}
				}
			}
		}

		if (rs > 0) {
			occupyCardIfNeeded(billId);
		}
		return rs;
	}

	public int markVnpayAttempt(Integer billId, String txnRef) {
		try {
			return JdbcUtil.executeUpdate("UPDATE HOADON SET payment_method = ?, vnp_txn_ref = ? WHERE MaHD = ?", "vnpay",
					txnRef, billId);
		} catch (Exception e1) {
			try {
				return JdbcUtil.executeUpdate("UPDATE HOADON SET vnp_txn_ref = ? WHERE MaHD = ?", txnRef, billId);
			} catch (Exception e2) {
				try {
					return JdbcUtil.executeUpdate("UPDATE HOADON SET payment_method = ? WHERE MaHD = ?", "vnpay", billId);
				} catch (Exception e3) {
					try {
						return JdbcUtil.executeUpdate("UPDATE HOADON SET trangThai = trangThai WHERE MaHD = ?", billId);
					} catch (Exception e4) {
						return 0;
					}
				}
			}
		}
	}

	public int updatePaymentMethod(Integer billId, String paymentMethod) {
		try {
			return JdbcUtil.executeUpdate("UPDATE HOADON SET payment_method = ? WHERE MaHD = ?", paymentMethod, billId);
		} catch (Exception e) {
			try {
				return JdbcUtil.executeUpdate("UPDATE HOADON SET trangThai = trangThai WHERE MaHD = ?", billId);
			} catch (Exception ex) {
				return 0;
			}
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
		String sql = "UPDATE HOADON SET tongTien = ? WHERE MaHD = ?";
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
		String sql = SELECT_BILL_BASE
				+ " WHERE h.MaNV = ? ORDER BY CASE LOWER(h.trangThai) WHEN 'waiting' THEN 1 WHEN 'finish' THEN 2 WHEN 'cancel' THEN 3 WHEN 'paid' THEN 2 ELSE 4 END, h.ngayTao DESC";
		try {
			return this.findBySql(sql, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<Bill>();
	}

	public int countAll() {
		String sql = "SELECT COUNT(*) AS total FROM HOADON";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql);
			if (rs.next()) {
				return rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int countByUserId(Integer userId) {
		String sql = "SELECT COUNT(*) AS total FROM HOADON WHERE MaNV = ?";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, userId);
			if (rs.next()) {
				return rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<Bill> findByPage(int offset, int limit) {
		String sql = SELECT_BILL_BASE + " ORDER BY h.ngayTao DESC, h.MaHD DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		return this.findBySql(sql, offset, limit);
	}

	public List<Bill> findByUserIdAndPage(Integer userId, int offset, int limit) {
		String sql = SELECT_BILL_BASE + " WHERE h.MaNV = ? ORDER BY h.ngayTao DESC, h.MaHD DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		return this.findBySql(sql, userId, offset, limit);
	}

}
