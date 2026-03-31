package com.polycoffee.servlet;

import java.io.IOException;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.MailUtil;
import com.polycoffee.util.OtpUtil;
import com.polycoffee.util.ParamUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/quen-mat-khau")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String OTP_PURPOSE_RESET_PASSWORD = "RESET_PASSWORD";
    private static final String SESSION_RESET_EMAIL = "RESET_EMAIL";
    private static final String SESSION_AUTH_SUCCESS = "AUTH_SUCCESS";

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = ParamUtil.getString(request, "action");
        if ("reset".equals(action)) {
            resetPassword(request, response);
            return;
        }
        sendResetOtp(request, response);
    }

    private void sendResetOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = ParamUtil.getString(request, "email");
        request.setAttribute("email", email);
        request.setAttribute("step", "request");

        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Email không hợp lệ.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userDAO.findByEmail(email);
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản với email này.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        String otp = OtpUtil.issueOtp(request, OTP_PURPOSE_RESET_PASSWORD, email, 5);
        boolean sent = MailUtil.sendOtp(email, otp, "Đặt lại mật khẩu");
        request.getSession().setAttribute(SESSION_RESET_EMAIL, email);

        request.setAttribute("step", "verify");
        request.setAttribute("success", "Đã gửi OTP đến email của bạn.");
        if (!sent) {
            request.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình mail.");
        }
        request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute(SESSION_RESET_EMAIL);
        String otp = ParamUtil.getString(request, "otp");
        String newPassword = ParamUtil.getString(request, "newPassword");
        String confirmPassword = ParamUtil.getString(request, "confirmPassword");

        request.setAttribute("step", "verify");
        request.setAttribute("email", email);

        if (email == null) {
            request.setAttribute("error", "Phiên đặt lại mật khẩu hết hạn. Vui lòng thử lại.");
            request.setAttribute("step", "request");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        if (newPassword == null || newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu mới phải từ 6 ký tự.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        boolean valid = OtpUtil.verifyOtp(request, OTP_PURPOSE_RESET_PASSWORD, email, otp);
        if (!valid) {
            request.setAttribute("error", "OTP không đúng hoặc đã hết hạn.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        int updated = userDAO.updatePasswordByEmail(email, newPassword);
        if (updated <= 0) {
            request.setAttribute("error", "Không cập nhật được mật khẩu.");
            request.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(request, response);
            return;
        }

        request.getSession().removeAttribute(SESSION_RESET_EMAIL);
        request.getSession().setAttribute(SESSION_AUTH_SUCCESS, "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
    }
}
