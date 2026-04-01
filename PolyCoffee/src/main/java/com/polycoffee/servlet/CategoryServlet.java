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

@WebServlet({ "/manager/categories",
        "/manager/categories/add",
        "/manager/categories/edit",
        "/manager/categories/delete" })
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CategoryDAO categoryDAO = new CategoryDAO();

    public CategoryServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Đọc flash message từ session (sau redirect) ──
        String flashMsg = (String) request.getSession().getAttribute("flashMessage");
        String flashErr = (String) request.getSession().getAttribute("flashError");
        if (flashMsg != null) {
            request.setAttribute("message", flashMsg);
            request.getSession().removeAttribute("flashMessage");
        }
        if (flashErr != null) {
            request.setAttribute("error", flashErr);
            request.getSession().removeAttribute("flashError");
        }

        // ── Tìm kiếm theo keyword ──
        String keyword = ParamUtil.getString(request, "keyword");
        List<Category> categories;
        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = categoryDAO.searchByName(keyword.trim());
            request.setAttribute("keyword", keyword.trim());
        } else {
            categories = categoryDAO.getAll();
        }

        // ── Nạp dữ liệu cho modal sửa (nếu có id) ──
        int id = ParamUtil.getInt(request, "id");
        if (id > 0) {
            Category category = categoryDAO.getById(id);
            request.setAttribute("editCategory", category);
        }

        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/categories/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();
        if (uri.contains("add"))
            create(request);
        if (uri.contains("edit"))
            update(request);
        if (uri.contains("delete"))
            delete(request);

        // PRG: redirect về GET để tránh resubmit khi F5
        response.sendRedirect(request.getContextPath() + "/manager/categories");
    }

    // ── Thêm mới ──
    private void create(HttpServletRequest request) {
        String tenLoai = ParamUtil.getString(request, "name");
        if (tenLoai == null || tenLoai.trim().isEmpty()) {
            request.getSession().setAttribute("flashError", "Tên loại không được để trống");
            return;
        }
        if (categoryDAO.isNameExist(tenLoai.trim())) {
            request.getSession().setAttribute("flashError", "Tên loại đã tồn tại");
            return;
        }
        Category category = new Category(0, tenLoai.trim(), "default.jpg", true, "");
        if (categoryDAO.insert(category)) {
            request.getSession().setAttribute("flashMessage", "Thêm loại \"" + tenLoai.trim() + "\" thành công");
        } else {
            request.getSession().setAttribute("flashError", "Thêm mới thất bại");
        }
    }

    // ── Cập nhật ──
    private void update(HttpServletRequest request) {
        int id = ParamUtil.getInt(request, "id");
        String tenLoai = ParamUtil.getString(request, "name");

        if (tenLoai == null || tenLoai.trim().isEmpty()) {
            request.getSession().setAttribute("flashError", "Tên loại không được để trống");
            return;
        }

        Category category = categoryDAO.getById(id);
        if (category == null) {
            request.getSession().setAttribute("flashError", "Không tìm thấy loại đồ uống");
            return;
        }

        category.setTenLoai(tenLoai.trim());
        if (categoryDAO.update(category)) {
            request.getSession().setAttribute("flashMessage", "Cập nhật thành công");
        } else {
            request.getSession().setAttribute("flashError", "Cập nhật thất bại");
        }
    }

    // ── Xóa (soft delete nếu đang hoạt động, hard delete nếu đã ẩn) ──
    private void delete(HttpServletRequest request) {
        int id = ParamUtil.getInt(request, "id");
        if (id <= 0) {
            request.getSession().setAttribute("flashError", "Không tìm thấy loại đồ uống");
            return;
        }
        Category category = categoryDAO.getById(id);
        if (category == null) {
            request.getSession().setAttribute("flashError", "Không tìm thấy loại đồ uống");
            return;
        }
        if (category.isTrangThai()) {
            categoryDAO.softDelete(id);
            request.getSession().setAttribute("flashMessage", "Đã ẩn loại \"" + category.getTenLoai() + "\"");
        } else {
            categoryDAO.delete(id);
            request.getSession().setAttribute("flashMessage", "Đã xóa loại \"" + category.getTenLoai() + "\"");
        }
    }
}