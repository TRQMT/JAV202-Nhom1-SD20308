package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/manager/staff", "/manager/staff/add", "/manager/staff/edit", "/manager/staff/update-status" })
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("/manager/staff/add")) {
			req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
			return;
		}

		if (uriString.contains("/manager/staff/edit")) {
			int userId = ParamUtil.getInt(req, "id");
			if (userId == 0) {
				userId = ParamUtil.getInt(req, "userId");
			}
			User user = userDAO.findById(userId);
			if (user == null || user.isRole()) {
				resp.sendRedirect(req.getContextPath() + "/manager/staff");
				return;
			}
			req.setAttribute("user", user);
			req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
			return;
		}

		if (uriString.contains("/manager/staff/update-status")) {
			updateStatus(req, resp);
			return;
		}

		listStaff(req, resp);
		req.getRequestDispatcher("/views/staff/staff-list.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("/manager/staff/add")) {
			create(req, resp);
			return;
		}
		if (uriString.contains("/manager/staff/edit")) {
			edit(req, resp);
			return;
		}
		if (uriString.contains("/manager/staff/update-status")) {
			updateStatus(req, resp);
			return;
		}

		resp.sendRedirect(req.getContextPath() + "/manager/staff");
	}

//	Phương thức lấy danh sách nhân viên
	public void listStaff(HttpServletRequest req, HttpServletResponse resp) {
		List<User> staffList = userDAO.findByRole(false);
		req.setAttribute("staffList", staffList);
	}

//	Phương thức tạo mới nhân viên
	public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User staff = getStaffFromRequestAndValidate(req, resp, false);
		if (staff != null) {
//			Kiểm tra email đã tồn tại chưa
			User existingUser = userDAO.findByEmail(staff.getEmail());
			if (existingUser != null) {
				req.setAttribute("emailError", "Email đã được sử dụng.");
				req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
				return;
			}
			int rs = userDAO.create(staff);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
			} else {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
			}
		}
	}

//	Phương thức chỉnh sửa thông tin nhân viên
	public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User staff = getStaffFromRequestAndValidate(req, resp, true);
		if (staff != null) {
			int userId = ParamUtil.getInt(req, "userId");
			if (userId == 0) {
				userId = ParamUtil.getInt(req, "id");
			}
			staff.setId(userId);
			int rs = userDAO.updateUserInfo(staff);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
			} else {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
			}
		}
	}

//	Phương thức cập nhật trạng thái nhân viên
	public void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int userId = ParamUtil.getInt(req, "userId");
		if (userId == 0) {
			userId = ParamUtil.getInt(req, "id");
		}

		int status = ParamUtil.getInt(req, "status");
		if (status == 0 && req.getParameter("active") != null) {
			status = ParamUtil.getInt(req, "active");
		}
		int rs = userDAO.updateStatus(userId, status == 1);
		if (rs > 0) {
			resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
		} else {
			resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
		}
	}

//	Phương thức lấy thông tin nhân viên từ request và xác thực dữ liệu
	public User getStaffFromRequestAndValidate(HttpServletRequest req, HttpServletResponse resp, boolean isEdit)
			throws ServletException, IOException {
		String email = ParamUtil.getString(req, "email");
		String password = ParamUtil.getString(req, "password");
		String fullName = ParamUtil.getString(req, "fullName");
		String phone = ParamUtil.getString(req, "phone");
		int active = ParamUtil.getInt(req, "active");

		boolean hasError = false;
		if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
			req.setAttribute("emailError", "Email không hợp lệ.");
			hasError = true;
		}
		if (!isEdit && (password == null || password.length() < 6)) {
			req.setAttribute("passwordError", "Mật khẩu phải có ít nhất 6 ký tự.");
			hasError = true;
		}
		if (fullName == null || fullName.isBlank()) {
			req.setAttribute("fullNameError", "Họ và tên không được để trống.");
			hasError = true;
		}
		if (phone == null || !phone.matches("^0\\d{9}$")) {
			req.setAttribute("phoneError", "Số điện thoại không hợp lệ.");
			hasError = true;
		}
		if (hasError) {
			req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
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
