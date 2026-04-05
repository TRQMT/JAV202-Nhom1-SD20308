package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.BillDAO;
import com.polycoffee.dao.BillDetailDAO;
import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetailView;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/bills", "/bills/detail", "/bills/cancel" })
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    private final BillDAO billDAO = new BillDAO();
    private final BillDetailDAO billDetailDAO = new BillDetailDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = AuthUtil.getUser(req);
        if (user == null) {
            req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String uri = req.getRequestURI();
        if (uri.contains("/bills/detail")) {
            showDetail(req, resp, user);
            return;
        }

        showList(req, resp, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = AuthUtil.getUser(req);
        if (user == null) {
            req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String uri = req.getRequestURI();
        if (uri.contains("/bills/cancel")) {
            cancelBill(req, resp, user);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/bills");
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int page = ParamUtil.getInt(req, "page");
        if (page <= 0) {
            page = 1;
        }
        int offset = (page - 1) * PAGE_SIZE;

        int totalRecords;
        List<Bill> bills;
        if (user.isRole()) {
            totalRecords = billDAO.countAll();
            bills = billDAO.findByPage(offset, PAGE_SIZE);
        } else {
            totalRecords = billDAO.countByUserId(user.getId());
            bills = billDAO.findByUserIdAndPage(user.getId(), offset, PAGE_SIZE);
        }

        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        if (totalPages == 0) {
            totalPages = 1;
        }

        req.setAttribute("bills", bills);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("pageSize", PAGE_SIZE);
        req.getRequestDispatcher("/views/bill/list.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int billId = ParamUtil.getInt(req, "id");
        if (billId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/bills");
            return;
        }

        Bill bill = user.isRole() ? billDAO.findById(billId) : billDAO.findByIdAndUserId(billId, user.getId());
        if (bill == null) {
            resp.sendRedirect(req.getContextPath() + "/bills");
            return;
        }

        List<BillDetailView> billDetails = billDetailDAO.findDetailViewsByBillId(billId);
        long calculatedTotal = 0;
        for (BillDetailView item : billDetails) {
            calculatedTotal += item.getLineTotal();
        }

        req.setAttribute("bill", bill);
        req.setAttribute("billDetails", billDetails);
        req.setAttribute("calculatedTotal", calculatedTotal);
        req.getRequestDispatcher("/views/bill/detail.jsp").forward(req, resp);
    }

    private void cancelBill(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        int billId = ParamUtil.getInt(req, "id");
        if (billId <= 0) {
            resp.sendRedirect(req.getContextPath() + "/bills?message=cancel-failed");
            return;
        }

        Bill bill = user.isRole() ? billDAO.findById(billId) : billDAO.findByIdAndUserId(billId, user.getId());
        if (bill == null) {
            resp.sendRedirect(req.getContextPath() + "/bills?message=cancel-failed");
            return;
        }

        int rs = billDAO.updateStatus(billId, BillDAO.STATUS_CANCEL);
        if (rs > 0) {
            resp.sendRedirect(req.getContextPath() + "/bills?message=cancel-success");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/bills?message=cancel-failed");
    }
}
