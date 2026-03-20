package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.BillDAO;
import com.polycoffee.entity.Bill;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;

@WebServlet("/bills")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = AuthUtil.getUser(req);
        if (user == null) {
            req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        List<Bill> bills;
        if (user.isRole()) {
            bills = billDAO.findAll();
        } else {
            bills = billDAO.findByUserId(user.getId());
        }

        req.setAttribute("bills", bills);
        req.getRequestDispatcher("/views/bill/list.jsp").forward(req, resp);
    }
}
