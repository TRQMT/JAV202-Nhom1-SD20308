package servlet;

import java.io.IOException;

import dao.UserDAO;
import entity.User;
import utils.ParamUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("views/login.jsp").forward(req, resp); 
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = ParamUtil.getString(req, "email");
        String password = ParamUtil.getString(req, "password");

        User user = userDAO.findByEmailAndPassword(email, password);
        if (user == null) {
            req.setAttribute("error", "Sai email hoặc mật khẩu");
            req.getRequestDispatcher("views/login.jsp").forward(req, resp);
            return;
        } 

        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        resp.sendRedirect(req.getContextPath() + "/users");

    }
}