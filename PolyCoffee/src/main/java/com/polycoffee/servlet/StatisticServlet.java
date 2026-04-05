package com.polycoffee.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.StatisticDAO;
import com.polycoffee.entity.BestSellingDrink;
import com.polycoffee.util.ParamUtil;

@WebServlet("/manager/statistics")
public class StatisticServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final StatisticDAO statisticDAO = new StatisticDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDateStr = ParamUtil.getString(request, "fromDate");
        String toDateStr   = ParamUtil.getString(request, "toDate");

        Date fromDate = parseDate(fromDateStr);
        Date toDate   = parseDate(toDateStr);

        List<BestSellingDrink> top5;
        try {
            top5 = statisticDAO.getTop5BestSellingDrinks(fromDate, toDate);
        } catch (Exception e) {
            e.printStackTrace();
            top5 = java.util.Collections.emptyList();
        }

        // Giữ lại giá trị filter trên form
        if (fromDateStr != null && !fromDateStr.isEmpty()) {
            request.setAttribute("fromDate", fromDateStr);
        }
        if (toDateStr != null && !toDateStr.isEmpty()) {
            request.setAttribute("toDate", toDateStr);
        }

        // Build data cho chart — dùng "||" separator để split bên JS
        StringBuilder labels     = new StringBuilder();
        StringBuilder quantities = new StringBuilder();

        for (int i = 0; i < top5.size(); i++) {
            BestSellingDrink item = top5.get(i);
            if (i > 0) {
                labels.append("||");
                quantities.append(",");
            }
            labels.append(item.getDrinkName());
            quantities.append(item.getTotalQuantitySold());
        }

        request.setAttribute("top5",           top5);
        request.setAttribute("chartLabels",    labels.toString());
        request.setAttribute("chartQuantities", quantities.toString());

        request.getRequestDispatcher("/views/statistic/top5-drink.jsp")
               .forward(request, response);
    }

    // Parse String "yyyy-MM-dd" → Date, trả null nếu rỗng hoặc sai format
    private Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) return null;
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr.trim());
        } catch (ParseException e) {
            return null;
        }
    }
}