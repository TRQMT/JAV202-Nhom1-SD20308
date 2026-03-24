package com.polycoffee.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.BillDAO;
import com.polycoffee.dao.BillDetailDAO;
import com.polycoffee.dao.DrinkDAO;
import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.entity.Drink;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/employee/pos", "/employee/pos/init", "/employee/pos/add-item", "/employee/pos/update-quantity",
		"/employee/pos/checkout", "/employee/pos/cancel" })
public class PosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DrinkDAO drinkDAO = new DrinkDAO();
	private BillDAO billDAO = new BillDAO();
	private BillDetailDAO billDetailDAO = new BillDetailDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AuthUtil.getUser(req) == null) {
			req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
			resp.sendRedirect(req.getContextPath() + "/dang-nhap");
			return;
		}

		String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, moTa AS description, hinhAnh AS image, donGia AS price, trangThai AS active FROM DOUONG WHERE trangThai = ?";
		List<Drink> drinks = drinkDAO.findBySql(sql, 1);

		int billId = ParamUtil.getInt(req, "billId");
		req.setAttribute("drinks", drinks);
		req.setAttribute("billId", billId);

		int userId = AuthUtil.getUser(req).getId();
		List<Bill> userBills = billDAO.findByUserId(userId);
		List<Bill> waitingBills = new ArrayList<>();
		for (Bill item : userBills) {
			if (BillDAO.STATUS_WAITING.equals(item.getStatus())) {
				waitingBills.add(item);
			}
		}
		req.setAttribute("waitingBills", waitingBills);

		if (billId == 0 && !waitingBills.isEmpty()) {
			billId = waitingBills.get(0).getId();
		}

		if (billId != 0) {
			Bill bill = billDAO.findByIdAndUserId(billId, userId);
			if (bill != null) {
				List<BillDetail> billDetail = billDetailDAO.findByBillId(billId);
				Map<Integer, Drink> detailDrinkMap = new HashMap<>();
				for (BillDetail item : billDetail) {
					Drink drink = drinkDAO.findById(item.getDrinkId());
					if (drink != null) {
						detailDrinkMap.put(item.getDrinkId(), drink);
					}
				}
				req.setAttribute("bill", bill);
				req.setAttribute("billDetails", billDetail);
				req.setAttribute("detailDrinkMap", detailDrinkMap);
				req.setAttribute("billId", bill.getId());
			}
		}

		req.getRequestDispatcher("/views/pos/view.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (AuthUtil.getUser(req) == null) {
			req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
			resp.sendRedirect(req.getContextPath() + "/dang-nhap");
			return;
		}

		String uri = req.getRequestURI();
		if (uri.contains("/employee/pos/add-item")) {
			create(req, resp);
			return;
		}
		if (uri.contains("/employee/pos/update-quantity")) {
			updateOrder(req, resp);
			return;
		}
		if (uri.contains("/employee/pos/checkout")) {
			checkout(req, resp);
			return;
		}
		if (uri.contains("/employee/pos/cancel")) {
			cancel(req, resp);
			return;
		}

		resp.sendRedirect(req.getContextPath() + "/employee/pos");
	}

	public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();
		Integer drinkId = ParamUtil.getInt(req, "drinkId");
		Drink drink = drinkDAO.findById(drinkId);
		if (drink == null || !drink.isActive()) {
			resp.sendRedirect(req.getContextPath() + "/employee/pos");
			return;
		}

		if (billId == 0) {
			Date now = new Date();
			Bill bill = new Bill();
			bill.setUserId(userId);
			bill.setCode(generateBillCode(now.getTime()));
			bill.setCreatedAt(now);
			bill.setTotal(drink.getPrice());
			bill.setStatus(BillDAO.STATUS_WAITING);

			List<BillDetail> billDetails = List.of(new BillDetail(null, null, drinkId, 1, drink.getPrice()));

			int billIdDB = billDAO.createWithBillDetails(bill, billDetails);
			if (billIdDB > 0) {
				resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billIdDB);
				return;
			}
			resp.sendRedirect(req.getContextPath() + "/employee/pos?message=add-item-failed");
			return;
		} else {
			int rs = billDetailDAO.addDrinkToBill(billId, drinkId);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
				return;
			}
			resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId + "&message=add-item-failed");
			return;
		}

	}

	private String generateBillCode(long epochMillis) {
		long value = Math.abs(epochMillis % 1_000_000_000L);
		return "B" + String.format("%09d", value);
	}

	public void updateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer billId = ParamUtil.getInt(req, "billId");
		Integer billDetailId = ParamUtil.getInt(req, "billDetailId");
		String action = ParamUtil.getString(req, "action");
		Integer userId = AuthUtil.getUser(req).getId();

		Bill bill = billDAO.findByIdAndUserId(billId, userId);
		if (bill == null || action == null) {
			resp.sendRedirect(req.getContextPath() + "/employee/pos");
			return;
		}

		if (action.equals("increase")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null && billDetail.getBillId().equals(billId)) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() + 1);
			}
		} else if (action.equals("decrease")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null && billDetail.getBillId().equals(billId)) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() - 1);
			}
		} else if (action.equals("remove")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null && billDetail.getBillId().equals(billId)) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), 0);
			}
		}
		resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
	}

	public void checkout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();
		String paymentMethod = ParamUtil.getString(req, "paymentMethod");

		Bill bill = billDAO.findByIdAndUserId(billId, userId);
		if (bill != null) {
			if ("vnpay".equalsIgnoreCase(paymentMethod) || "transfer".equalsIgnoreCase(paymentMethod)
					|| "qr".equalsIgnoreCase(paymentMethod)) {
				resp.sendRedirect(req.getContextPath() + "/employee/payment/init?billId=" + billId);
				return;
			}
			billDAO.completeCashPayment(billId);
			resp.sendRedirect(req.getContextPath() + "/employee/pos?message=paid-cash");
			return;
		}
		resp.sendRedirect(req.getContextPath() + "/employee/pos");
	}

	public void cancel(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();

		Bill bill = billDAO.findByIdAndUserId(billId, userId);
		if (bill != null) {
			billDAO.updateStatus(billId, BillDAO.STATUS_CANCEL);
			resp.sendRedirect(req.getContextPath() + "/employee/pos");
			return;
		}
		resp.sendRedirect(req.getContextPath() + "/employee/pos");
	}
}
