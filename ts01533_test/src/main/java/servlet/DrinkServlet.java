package servlet;

import java.io.IOException;
import java.util.List;

// import utils.ParamUtil;

import dao.DrinkDAO;
import entity.Drink;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/drinks")
public class DrinkServlet extends HttpServlet {
    private DrinkDAO drinkDAO = new DrinkDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User nv = (User) req.getSession().getAttribute("user");
        if (nv==null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // String status= ParamUtil.getString(req, "status");
        // List<Drink> list;
        // if ("1".equals(status)) {
        //     list=drinkDAO.findByStatus(true);           
        // }else if ("0".equals(status)) {
        //     list=drinkDAO.findByStatus(false);
        // }else{
        //     list=drinkDAO.findAll();
        // }
        // req.setAttribute("drinks", list);
        // req.setAttribute("status",status);
        // req.getRequestDispatcher("views/drink.jsp").forward(req, resp);
        List<Drink> list=drinkDAO.findAll();
        req.setAttribute("drinks", list);
        req.getRequestDispatcher("views/drink.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    }
}