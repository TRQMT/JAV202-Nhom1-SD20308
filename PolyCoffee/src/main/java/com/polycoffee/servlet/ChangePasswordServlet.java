package com.polycoffee.servlet;

import java.io.IOException;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/change-pass")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        if (!AuthUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }
        request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        User current = AuthUtil.getUser(request);
        if (current == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        String currentPassword = ParamUtil.getString(request, "currentPassword");
        String newPassword = ParamUtil.getString(request, "newPassword");
        String confirmPassword = ParamUtil.getString(request, "confirmPassword");

        User fresh = userDAO.findById(current.getId());
        if (fresh == null) {
            AuthUtil.clear(request);
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        if (!fresh.getPassword().equals(currentPassword)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }
        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải từ 6 ký tự.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        int updated = userDAO.updatePasswordByEmail(fresh.getEmail(), newPassword);
        if (updated > 0) {
            request.setAttribute("success", "Đổi mật khẩu thành công.");
        } else {
            request.setAttribute("error", "Không đổi được mật khẩu.");
        }
        request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
    }
}
