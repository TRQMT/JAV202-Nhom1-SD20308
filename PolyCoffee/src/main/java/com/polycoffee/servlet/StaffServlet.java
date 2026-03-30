package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/manager/staff", "/manager/staff/add", "/manager/staff/edit", "/manager/staff/update-status" })
public class StaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // ===== ADD =====
        if (uri.contains("/manager/staff/add")) {
            req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
            return;
        }

        // ===== EDIT =====
        if (uri.contains("/manager/staff/edit")) {
            int userId = ParamUtil.getInt(req, "id");
            if (userId == 0) {
                userId = ParamUtil.getInt(req, "userId");
            }

            User user = userDAO.findById(userId);
            if (user == null || user.isRole()) {
                resp.sendRedirect(req.getContextPath() + "/manager/staff");
                return;
            }

            req.setAttribute("staff", user);
            req.getRequestDispatcher("/views/staff/staff-edit.jsp").forward(req, resp);
            return;
        }

        // ===== UPDATE STATUS =====
        if (uri.contains("/manager/staff/update-status")) {
            updateStatus(req, resp);
            return;
        }

        // ===== LIST =====
        listStaff(req);
        req.getRequestDispatcher("/views/staff/staff-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/manager/staff/add")) {
            create(req, resp);
            return;
        }

        if (uri.contains("/manager/staff/edit")) {
            edit(req, resp);
            return;
        }

        if (uri.contains("/manager/staff/update-status")) {
            updateStatus(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // ===== LIST =====
    public void listStaff(HttpServletRequest req) {
        List<User> staffList = userDAO.findByRole(false);
        req.setAttribute("staffList", staffList);
    }

    // ===== CREATE =====
    public void create(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User staff = getStaffFromRequestAndValidate(req, resp, false);
        if (staff == null) return;

        User existing = userDAO.findByEmail(staff.getEmail());
        if (existing != null) {
            req.setAttribute("emailError", "Email đã tồn tại");
            req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
            return;
        }

        userDAO.create(staff); // ✔ KHÔNG còn warning

        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // ===== EDIT =====
    public void edit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User staff = getStaffFromRequestAndValidate(req, resp, true);
        if (staff == null) return;

        int userId = ParamUtil.getInt(req, "userId");
        if (userId == 0) {
            userId = ParamUtil.getInt(req, "id");
        }

        staff.setId(userId);

        userDAO.updateUserInfo(staff); // ✔ KHÔNG warning

        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // ===== UPDATE STATUS =====
    public void updateStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int userId = ParamUtil.getInt(req, "id");

        User user = userDAO.findById(userId);
        boolean newStatus = !user.isActive();

        userDAO.updateStatus(userId, newStatus);

        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // ===== VALIDATE =====
    public User getStaffFromRequestAndValidate(HttpServletRequest req,
            HttpServletResponse resp, boolean isEdit)
            throws ServletException, IOException {

        String email = ParamUtil.getString(req, "email");
        String password = ParamUtil.getString(req, "password");
        String fullName = ParamUtil.getString(req, "fullName");
        String phone = ParamUtil.getString(req, "phone");
        int active = ParamUtil.getInt(req, "active");

        boolean hasError = false;

        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            req.setAttribute("emailError", "Email không hợp lệ");
            hasError = true;
        }

        if (!isEdit && (password == null || password.length() < 6)) {
            req.setAttribute("passwordError", "Mật khẩu >= 6 ký tự");
            hasError = true;
        }

        if (fullName == null || fullName.isBlank()) {
            req.setAttribute("fullNameError", "Không để trống tên");
            hasError = true;
        }

        if (phone == null || !phone.matches("^0\\d{9}$")) {
            req.setAttribute("phoneError", "SĐT không hợp lệ");
            hasError = true;
        }

        if (hasError) {
            String view = isEdit
                    ? "/views/staff/staff-edit.jsp"
                    : "/views/staff/staff-form.jsp";

            req.getRequestDispatcher(view).forward(req, resp);
            return null;
        }

        User staff = new User();
        staff.setEmail(email);
        staff.setPassword(password == null ? "" : password);
        staff.setFullName(fullName);
        staff.setPhone(phone);
        staff.setActive(active == 1);
        staff.setRole(false);

        return staff;
    }
}
