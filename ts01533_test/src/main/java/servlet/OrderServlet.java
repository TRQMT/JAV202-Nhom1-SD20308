package servlet;

import java.io.IOException;
import java.util.List;

import dao.BillDAO;
import entity.Bill;
// import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

       String tenNhanVien = req.getParameter("tenNhanVien");

    List<Bill> list;
    if (tenNhanVien != null && !tenNhanVien.isEmpty()) {
        list = billDAO.findByNhanVien(tenNhanVien);
    } else {
        list = billDAO.findAll();
    }

        double tongDoanhThu = 0;
        for (Bill b : list) {
            if ("finish".equalsIgnoreCase(b.getTrangThai())) {
                tongDoanhThu += b.getTongTien();
            }
        }

        List<String> danhSachNV = billDAO.findAllNhanVienNames();

        req.setAttribute("bills", list);
        req.setAttribute("tongDoanhThu", tongDoanhThu);
        req.setAttribute("danhSachNV", danhSachNV);
        req.setAttribute("tenNhanVien", tenNhanVien);
        req.getRequestDispatcher("views/order.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    }
}