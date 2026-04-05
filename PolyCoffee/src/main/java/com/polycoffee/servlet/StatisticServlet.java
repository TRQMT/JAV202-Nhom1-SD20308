package com.polycoffee.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.StatisticDAO;
import com.polycoffee.entity.RevenueByDay;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.DateUtil;
import com.polycoffee.util.ParamUtil;

@WebServlet("/manager/statistics")
public class StatisticServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final StatisticDAO statisticDAO = new StatisticDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = AuthUtil.getUser(req);
        if (user == null) {
            req.getSession().setAttribute("REDIRECT_URL", req.getRequestURI());
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        if (!user.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/trang-chu");
            return;
        }

        Date fromDate = ParamUtil.getDate(req, "fromDate", "yyyy-MM-dd");
        Date toDate = ParamUtil.getDate(req, "toDate", "yyyy-MM-dd");

        String fromDateRaw = ParamUtil.getString(req, "fromDate");
        String toDateRaw = ParamUtil.getString(req, "toDate");

        List<RevenueByDay> revenues;

        try {
            revenues = statisticDAO.getRevenueByDay(fromDate, toDate);
        } catch (Exception e) {
            revenues = List.of();
            req.setAttribute("error", "Không thể tải dữ liệu thống kê. Vui lòng kiểm tra dữ liệu hoặc stored procedure.");
        }

        req.setAttribute("revenues", revenues);
        req.setAttribute("fromDate", fromDateRaw);
        req.setAttribute("toDate", toDateRaw);
        req.setAttribute("chartLabels", toJsonDateLabels(revenues));
        req.setAttribute("chartRevenueData", toJsonRevenueData(revenues));

        req.getRequestDispatcher("/views/statistics/index.jsp").forward(req, resp);
    }

    private String toJsonDateLabels(List<RevenueByDay> revenues) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < revenues.size(); i++) {
            String date = DateUtil.toString(revenues.get(i).getRevenueDate(), "dd/MM/yyyy");
            sb.append('"').append(date.replace("\"", "\\\"")).append('"');
            if (i < revenues.size() - 1) {
                sb.append(',');
            }
        }
        sb.append(']');
        return sb.toString();
    }

    private String toJsonRevenueData(List<RevenueByDay> revenues) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < revenues.size(); i++) {
            sb.append(revenues.get(i).getTotalRevenue());
            if (i < revenues.size() - 1) {
                sb.append(',');
            }
        }
        sb.append(']');
        return sb.toString();
    }
}
