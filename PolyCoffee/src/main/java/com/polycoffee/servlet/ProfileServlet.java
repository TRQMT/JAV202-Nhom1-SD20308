package com.polycoffee.servlet;

import java.io.IOException;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.dao.UserSecurityDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.MailUtil;
import com.polycoffee.util.OtpUtil;
import com.polycoffee.util.ParamUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/edit-profile", "/profile" })
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String OTP_PURPOSE_2FA_TOGGLE = "PROFILE_2FA_TOGGLE";
    private static final String SESSION_PENDING_2FA_TARGET = "PROFILE_PENDING_2FA_TARGET";

    private final UserDAO userDAO = new UserDAO();
    private final UserSecurityDAO securityDAO = new UserSecurityDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        User current = AuthUtil.getUser(request);
        if (current == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        User fresh = userDAO.findById(current.getId());
        if (fresh == null) {
            AuthUtil.clear(request);
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        request.setAttribute("profile", fresh);
        request.setAttribute("twoFactorEnabled", securityDAO.isTwoFactorEnabled(fresh.getId()));
        request.getRequestDispatcher("/views/auth/profile.jsp").forward(request, response);
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

        String action = ParamUtil.getString(request, "action");
        if ("update-info".equals(action)) {
            updateInfo(request, response, current);
            return;
        }
        if ("request-2fa-toggle".equals(action)) {
            requestToggleOtp(request, response, current);
            return;
        }
        if ("confirm-2fa-toggle".equals(action)) {
            confirmToggleOtp(request, response, current);
            return;
        }

        doGet(request, response);
    }

    private void updateInfo(HttpServletRequest request, HttpServletResponse response, User current)
            throws ServletException, IOException {
        String fullName = ParamUtil.getString(request, "fullName");
        String phone = ParamUtil.getString(request, "phone");

        if (fullName == null || fullName.isBlank()) {
            request.setAttribute("error", "Họ tên không được để trống.");
            doGet(request, response);
            return;
        }
        if (phone == null || !phone.matches("^\\d{10}$")) {
            request.setAttribute("error", "Số điện thoại phải gồm 10 chữ số.");
            doGet(request, response);
            return;
        }

        User updated = userDAO.findById(current.getId());
        if (updated == null) {
            request.setAttribute("error", "Không tìm thấy tài khoản.");
            doGet(request, response);
            return;
        }

        updated.setFullName(fullName.trim());
        updated.setPhone(phone.trim());

        int result = userDAO.updateUserInfo(updated);
        if (result > 0) {
            AuthUtil.setUser(request, updated);
            request.setAttribute("success", "Cập nhật thông tin thành công.");
        } else {
            request.setAttribute("error", "Cập nhật thất bại.");
        }
        doGet(request, response);
    }

    private void requestToggleOtp(HttpServletRequest request, HttpServletResponse response, User current)
            throws ServletException, IOException {
        boolean currentlyEnabled = securityDAO.isTwoFactorEnabled(current.getId());
        String target = currentlyEnabled ? "disable" : "enable";
        String otp = OtpUtil.issueOtp(request, OTP_PURPOSE_2FA_TOGGLE, current.getEmail(), 5);
        boolean sent = MailUtil.sendOtp(current.getEmail(), otp, "Cấu hình 2FA");

        request.getSession().setAttribute(SESSION_PENDING_2FA_TARGET, target);
        request.setAttribute("pendingToggle", true);
        request.setAttribute("twoFactorEnabled", currentlyEnabled);
        if (sent) {
            request.setAttribute("success", "Đã gửi OTP xác nhận cấu hình 2FA đến email của bạn.");
        } else {
            request.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình mail.");
        }
        doGet(request, response);
    }

    private void confirmToggleOtp(HttpServletRequest request, HttpServletResponse response, User current)
            throws ServletException, IOException {
        String otp = ParamUtil.getString(request, "otp");
        String target = (String) request.getSession().getAttribute(SESSION_PENDING_2FA_TARGET);
        boolean currentlyEnabled = securityDAO.isTwoFactorEnabled(current.getId());

        if (target == null) {
            request.setAttribute("error", "Không có yêu cầu 2FA nào đang chờ xác nhận.");
            doGet(request, response);
            return;
        }

        boolean valid = OtpUtil.verifyOtp(request, OTP_PURPOSE_2FA_TOGGLE, current.getEmail(), otp);
        if (!valid) {
            request.setAttribute("error", "OTP không đúng hoặc đã hết hạn.");
            request.setAttribute("pendingToggle", true);
            request.setAttribute("twoFactorEnabled", currentlyEnabled);
            doGet(request, response);
            return;
        }

        boolean enable = "enable".equals(target);
        int result = securityDAO.setTwoFactorEnabled(current.getId(), enable);
        request.getSession().removeAttribute(SESSION_PENDING_2FA_TARGET);

        if (result > 0) {
            request.setAttribute("success", enable ? "Đã bật 2FA." : "Đã tắt 2FA.");
        } else {
            request.setAttribute("error", "Cập nhật 2FA thất bại.");
        }
        doGet(request, response);
    }
}
