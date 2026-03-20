package com.polycoffee.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet("/dang-nhap")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO = new UserDAO();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response)
					throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/views/auth/login.jsp")
			   .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, 
						  HttpServletResponse response) 
						  throws ServletException, IOException {
		String email = ParamUtil.getString(request, "email");
		String password = ParamUtil.getString(request, "password");
		User user = userDAO.findByEmail(email);

		if (user == null) {
			request.setAttribute("message", "Tài khoản không đúng!");
		} else if (!user.getPassword().equals(password)) {
			request.setAttribute("message", "Tài khoản không đúng!");
		} else if (!user.isActive()) {
			request.setAttribute("message", "Tài khoản đã bị khóa!");
		} else {
			AuthUtil.setUser(request, user);
			String redirectUrl = request.getContextPath() + "/trang-chu";
			if (request.getSession().getAttribute("REDIRECT_URL") != null) {
				redirectUrl = (String) request.getSession().getAttribute("REDIRECT_URL");
				request.getSession().removeAttribute("REDIRECT_URL");
			}
			response.sendRedirect(redirectUrl);
			return;
		}
		request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
	}
}
