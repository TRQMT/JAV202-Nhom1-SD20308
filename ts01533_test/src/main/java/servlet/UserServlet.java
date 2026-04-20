package servlet;

import java.io.IOException;
import java.util.List;

// import utils.ParamUtil;

import dao.UserDAO;
// import entity.Drink;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User nv = (User) req.getSession().getAttribute("user");
        if (nv==null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        List<User> list=userDAO.findAll();
        req.setAttribute("users", list);
        req.getRequestDispatcher("views/user.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    }
}