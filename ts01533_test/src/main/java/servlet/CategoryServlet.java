package servlet;

import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import entity.Category;
import entity.User;
import utils.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User nv = (User) req.getSession().getAttribute("user");
        if (nv == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String status = ParamUtil.getString(req, "status");
        List<Category> list;
        if ("1".equals(status)) {
            list = categoryDAO.findByStatus(true);
        } else if ("0".equals(status)) {
            list = categoryDAO.findByStatus(false);
        } else {
            list = categoryDAO.findAll();
        }


        req.setAttribute("categories", list);
        req.setAttribute("status", status);
        req.getRequestDispatcher("views/category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    }
}