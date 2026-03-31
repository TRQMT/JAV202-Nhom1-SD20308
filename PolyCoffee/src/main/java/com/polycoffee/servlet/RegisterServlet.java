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

@WebServlet("/dang-ky")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String OTP_PURPOSE_REGISTER = "REGISTER";
    private static final String SESSION_PENDING_REGISTER_EMAIL = "PENDING_REGISTER_EMAIL";
    private static final String SESSION_PENDING_REGISTER_PASSWORD = "PENDING_REGISTER_PASSWORD";
    private static final String SESSION_PENDING_REGISTER_NAME = "PENDING_REGISTER_NAME";
    private static final String SESSION_PENDING_REGISTER_PHONE = "PENDING_REGISTER_PHONE";
    private static final String SESSION_AUTH_SUCCESS = "AUTH_SUCCESS";

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = ParamUtil.getString(request, "action");
        if ("verify".equals(action)) {
            verifyRegisterOtp(request, response);
            return;
        }
        sendRegisterOtp(request, response);
    }

    private void sendRegisterOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = ParamUtil.getString(request, "email");
        String password = ParamUtil.getString(request, "password");
        String confirmPassword = ParamUtil.getString(request, "confirmPassword");
        String fullName = ParamUtil.getString(request, "fullName");
        String phone = ParamUtil.getString(request, "phone");

        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("step", "request");

        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Email không hợp lệ.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải từ 6 ký tự.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        if (fullName == null || fullName.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập họ tên.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        if (phone == null || !phone.matches("^\\d{10}$")) {
            request.setAttribute("error", "Số điện thoại phải gồm 10 chữ số.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email đã tồn tại.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        String otp = OtpUtil.issueOtp(request, OTP_PURPOSE_REGISTER, email, 5);
        boolean sent = MailUtil.sendOtp(email, otp, "Đăng ký tài khoản");

        if (!sent) {
            OtpUtil.clearOtp(request, OTP_PURPOSE_REGISTER);
            request.getSession().removeAttribute(SESSION_PENDING_REGISTER_EMAIL);
            request.getSession().removeAttribute(SESSION_PENDING_REGISTER_PASSWORD);
            request.getSession().removeAttribute(SESSION_PENDING_REGISTER_NAME);
            request.getSession().removeAttribute(SESSION_PENDING_REGISTER_PHONE);
            request.setAttribute("step", "request");
            request.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình mail.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        request.getSession().setAttribute(SESSION_PENDING_REGISTER_EMAIL, email);
        request.getSession().setAttribute(SESSION_PENDING_REGISTER_PASSWORD, password);
        request.getSession().setAttribute(SESSION_PENDING_REGISTER_NAME, fullName);
        request.getSession().setAttribute(SESSION_PENDING_REGISTER_PHONE, phone);

        request.setAttribute("step", "verify");
        request.setAttribute("success", "Đã gửi OTP đến email của bạn.");
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    private void verifyRegisterOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute(SESSION_PENDING_REGISTER_EMAIL);
        String password = (String) request.getSession().getAttribute(SESSION_PENDING_REGISTER_PASSWORD);
        String fullName = (String) request.getSession().getAttribute(SESSION_PENDING_REGISTER_NAME);
        String phone = (String) request.getSession().getAttribute(SESSION_PENDING_REGISTER_PHONE);
        String otp = ParamUtil.getString(request, "otp");

        request.setAttribute("step", "verify");
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);

        if (email == null || password == null || fullName == null || phone == null) {
            request.setAttribute("error", "Phiên đăng ký hết hạn. Vui lòng thử lại.");
            request.setAttribute("step", "request");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        boolean valid = OtpUtil.verifyOtp(request, OTP_PURPOSE_REGISTER, email, otp);
        if (!valid) {
            request.setAttribute("error", "OTP không đúng hoặc đã hết hạn.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setFullName(fullName);
        newUser.setPhone(phone);
        newUser.setActive(true);

        int created = userDAO.createGuest(newUser);
        if (created <= 0) {
            request.setAttribute("error", "Không tạo được tài khoản. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        request.getSession().removeAttribute(SESSION_PENDING_REGISTER_EMAIL);
        request.getSession().removeAttribute(SESSION_PENDING_REGISTER_PASSWORD);
        request.getSession().removeAttribute(SESSION_PENDING_REGISTER_NAME);
        request.getSession().removeAttribute(SESSION_PENDING_REGISTER_PHONE);
        request.getSession().setAttribute(SESSION_AUTH_SUCCESS, "Đăng ký thành công. Vui lòng đăng nhập.");
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
    }
}
