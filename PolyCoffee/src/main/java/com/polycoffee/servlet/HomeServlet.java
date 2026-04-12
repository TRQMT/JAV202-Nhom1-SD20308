package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import com.polycoffee.dao.DrinkDAO;
import com.polycoffee.entity.Drink;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/trang-chu")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DrinkDAO drinkDAO = new DrinkDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 LẤY DATA (CHỈ LẤY ACTIVE)
        List<Drink> drinks = drinkDAO.findActiveByFilters(null, null);

        // 🔥 TRUYỀN SANG JSP
        request.setAttribute("drinks", drinks);

        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
