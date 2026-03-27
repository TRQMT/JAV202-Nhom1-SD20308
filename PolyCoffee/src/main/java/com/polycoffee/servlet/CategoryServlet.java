package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.CategoryDAO;
import com.polycoffee.entity.Category;
import com.polycoffee.util.ParamUtil;

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet({"/manager/categories",
            "/manager/categories/add",
            "/manager/categories/edit",
            "/manager/categories/delete"})
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CategoryDAO categoryDAO = new CategoryDAO();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //kiểm tra id trường hợp chỉnh sửa
        int id = ParamUtil.getInt(request, "id");
        if (id > 0) {
            Category category = categoryDAO.getById(id);
            request.setAttribute("editCategory", category);
        }

        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/categories/list.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uriString = request.getRequestURI();
        if (uriString.contains("add")) {
            create(request);
        }
        if (uriString.contains("edit")) {
            update(request);
        }
        if (uriString.contains("delete")) {
            delete(request);
        }

        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/categories/list.jsp").forward(request, response);
    }

    //xử lý thêm mới
    public void create(HttpServletRequest request) {
        String tenLoai = ParamUtil.getString(request, "name");
        if (tenLoai == null || tenLoai.trim().isEmpty()) {
            request.setAttribute("error", "Tên loại không được để trống");
        } else {
            Category category = new Category(0, tenLoai.trim(), "default.jpg", true, "");
            if (categoryDAO.insert(category)) {
                request.setAttribute("message", "Thêm mới thành công");
            } else {
                request.setAttribute("error", "Thêm mới thất bại");
            }
        }
    }

    //xử lý cập nhật
    public void update(HttpServletRequest request) {
        int id         = ParamUtil.getInt(request, "id");
        String tenLoai = ParamUtil.getString(request, "name");
        Category category = categoryDAO.getById(id);
        if (category != null) {
            category.setTenLoai(tenLoai);
            if (categoryDAO.update(category)) {
                request.setAttribute("message", "Cập nhật thành công");
            } else {
                request.setAttribute("error", "Cập nhật thất bại");
            }
            request.setAttribute("editCategory", category);
        } else {
            request.setAttribute("error", "Loại không tồn tại");
        }
    }

    //xử lý xóa
    public void delete(HttpServletRequest request) {
        int id = ParamUtil.getInt(request, "id");
        if (id > 0) {
            Category category = categoryDAO.getById(id);
            if (category != null) {
                //còn hoạt động → ẩn mềm | đã ẩn → xóa hẳn
                if (category.isTrangThai()) {
                    categoryDAO.softDelete(id);
                } else {
                    categoryDAO.delete(id);
                }
                request.setAttribute("message", "Xóa thành công");
            } else {
                request.setAttribute("error", "Không tìm thấy loại đồ uống");
            }
        } else {
            request.setAttribute("error", "Không tìm thấy loại đồ uống");
        }
    }
}