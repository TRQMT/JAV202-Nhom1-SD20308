package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.polycoffee.dao.CategoryDAO;
import com.polycoffee.dao.DrinkDAO;
import com.polycoffee.entity.Drink;
import com.polycoffee.util.FileUtil;
import com.polycoffee.util.ParamUtil;

@MultipartConfig
@WebServlet({ "/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit", "/manager/drinks/delete" })
public class DrinkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DrinkDAO drinkDAO = new DrinkDAO();
	private CategoryDAO categoryDAO = new CategoryDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("add")) {
			req.setAttribute("categories", categoryDAO.findAll());
			req.getRequestDispatcher("/views/drink/drink-form.jsp").forward(req, resp);
			return;
		}

		if (uriString.contains("edit")) {
			int drinkId = ParamUtil.getInt(req, "id");
			if (drinkId == 0) {
				drinkId = ParamUtil.getInt(req, "drinkId");
			}
			Drink drink = drinkDAO.findById(drinkId);
			if (drink == null) {
				resp.sendRedirect(req.getContextPath() + "/manager/drinks");
				return;
			}
			req.setAttribute("drink", drink);
			req.setAttribute("categories", categoryDAO.findAll());
			req.getRequestDispatcher("/views/drink/drink-form.jsp").forward(req, resp);
			return;
		}

		if (uriString.contains("delete")) {
			delete(req, resp);
			return;
		}

		if (uriString.contains("/manager/drinks")) {
			getDrinksManager(req);
			req.getRequestDispatcher("/views/drink/manager-list.jsp").forward(req, resp);
			return;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("add")) {
			create(req, resp);
			return;
		}
		if (uriString.contains("edit")) {
			edit(req, resp);
			return;
		}
		if (uriString.contains("delete")) {
			delete(req, resp);
			return;
		}
	}

	// Danh sách đồ uống cho Manager
	private void getDrinksManager(HttpServletRequest request) {
		 String keyword = ParamUtil.getString(request, "keyword");

    // Lấy số trang hiện tại, mặc định là 1
    int page = ParamUtil.getInt(request, "page");
    if (page <= 0) page = 1;

    final int PAGE_SIZE = 10;
    int offset = (page - 1) * PAGE_SIZE;

    int totalRecords;
    List<Drink> list;

    if (keyword != null && !keyword.isBlank()) {
        totalRecords = drinkDAO.countByName(keyword);
        list = drinkDAO.findByNameAndPage(keyword, offset, PAGE_SIZE);
        request.setAttribute("keyword", keyword);
    } else {
        totalRecords = drinkDAO.countAll();
        list = drinkDAO.findByPage(offset, PAGE_SIZE);
    }

    // Tính tổng số trang (làm tròn lên)
    int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

    request.setAttribute("drinks", list);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("totalRecords", totalRecords);
}
	// Thêm mới đồ uống
	private void create(HttpServletRequest request, HttpServletResponse response) {
		try {
			Drink drink = getDrinkFromRequestAndValidate(request, response, false);
			if (drink != null) {
				int rs = drinkDAO.create(drink);

				if (rs > 0) {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
				} else {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
				}

			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}

	// Chỉnh sửa đồ uống
	private void edit(HttpServletRequest request, HttpServletResponse response) {
		try {
			Drink drink = getDrinkFromRequestAndValidate(request, response, true);
			if (drink != null) {
				int drinkId = ParamUtil.getInt(request, "drinkId");
				if (drinkId == 0) {
					drinkId = ParamUtil.getInt(request, "id");
				}
				drink.setId(drinkId);
				int rs = drinkDAO.update(drink);

				if (rs > 0) {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
				} else {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
				}

			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}

	// Xóa đồ uống
	private void delete(HttpServletRequest request, HttpServletResponse response) {
		try {
			int drinkId = ParamUtil.getInt(request, "drinkId");
			if (drinkId == 0) {
				drinkId = ParamUtil.getInt(request, "id");
			}

			Drink drink = drinkDAO.findById(drinkId);
			if (drink == null) {
				response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
				return;
			}

			int rs;
			int usedCount = drinkDAO.countInBillDetails(drinkId);
			if (usedCount > 0) {
				drink.setActive(false);
				rs = drinkDAO.update(drink);
			} else {
				rs = drinkDAO.delete(drinkId);
			}

			if (rs > 0) {
				response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
			} else {
				response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// Lấy dữ liệu từ form và validate
	private Drink getDrinkFromRequestAndValidate(HttpServletRequest request, HttpServletResponse response, boolean isEdit)
			throws ServletException, IOException {
//		Lấy dữ liệu từ form
		int categoryId = ParamUtil.getInt(request, "categoryId");
		String name = ParamUtil.getString(request, "name");
		String description = ParamUtil.getString(request, "description");
		int price = ParamUtil.getInt(request, "price");
		int active = ParamUtil.getInt(request, "active");
		Part imagePart = request.getPart("imageFile");

		Drink currentDrink = null;
		if (isEdit) {
			int drinkId = ParamUtil.getInt(request, "drinkId");
			if (drinkId == 0) {
				drinkId = ParamUtil.getInt(request, "id");
			}
			currentDrink = drinkDAO.findById(drinkId);
			if (currentDrink == null) {
				response.sendRedirect(request.getContextPath() + "/manager/drinks");
				return null;
			}
		}

//		Validate dữ liệu
		boolean hasError = false;
		if (categoryId == 0) {
			request.setAttribute("errCat", "Vui lòng chọn danh mục");
			hasError = true;
		}
		if (name == null || name.isBlank()) {
			request.setAttribute("errName", "Vui lòng nhập tên đồ uống");
			hasError = true;
		}
		if (price <= 0) {
			request.setAttribute("errPrice", "Giá phải lớn hơn 0");
			hasError = true;
		}
		if (description == null || description.isBlank()) {
			request.setAttribute("errDesc", "Vui lòng nhập mô tả");
			hasError = true;
		}
		if (!isEdit && (imagePart == null || imagePart.getSize() == 0)) {
			request.setAttribute("errImage", "Vui lòng chọn hình ảnh");
			hasError = true;
		}
		if (hasError) {
			Drink draftDrink = new Drink();
			draftDrink.setCategoryId(categoryId == 0 ? null : categoryId);
			draftDrink.setName(name);
			draftDrink.setDescription(description);
			draftDrink.setPrice(price);
			draftDrink.setActive(active == 1);
			if (currentDrink != null) {
				draftDrink.setId(currentDrink.getId());
				draftDrink.setImage(currentDrink.getImage());
			}

			request.setAttribute("categories", categoryDAO.findAll());
			request.setAttribute("drink", draftDrink);
			request.getRequestDispatcher("/views/drink/drink-form.jsp").forward(request, response);
			return null;
		}

//		Xử lý upload hình ảnh
		String imageName = currentDrink != null ? currentDrink.getImage() : null;
		if (imagePart != null && imagePart.getSize() > 0) {
			imageName = FileUtil.upload(request, "imageFile");
			if (imageName == null || imageName.isBlank()) {
				request.setAttribute("errImage", "Tải ảnh thất bại, vui lòng thử lại");
				Drink draftDrink = new Drink();
				draftDrink.setCategoryId(categoryId == 0 ? null : categoryId);
				draftDrink.setName(name);
				draftDrink.setDescription(description);
				draftDrink.setPrice(price);
				draftDrink.setActive(active == 1);
				if (currentDrink != null) {
					draftDrink.setId(currentDrink.getId());
					draftDrink.setImage(currentDrink.getImage());
				}

				request.setAttribute("categories", categoryDAO.findAll());
				request.setAttribute("drink", draftDrink);
				request.getRequestDispatcher("/views/drink/drink-form.jsp").forward(request, response);
				return null;
			}
		}
//		Lưu dữ liệu vào đối tượng Drink
		Drink drink = new Drink();
		drink.setCategoryId(categoryId);
		drink.setName(name);
		drink.setDescription(description);
		drink.setPrice(price);
		drink.setActive(active == 1);
		drink.setImage(imageName);

		return drink;
	}


}
