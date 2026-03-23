package com.polycoffee.test;

import com.polycoffee.dao.CategoryDAO;
import com.polycoffee.entity.Category;
import java.util.List;


public class TestDAO {
        public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();

        System.out.println("========== TEST getAll() ==========");
        List<Category> list = dao.getAll();
        if (list.isEmpty()) {
            System.out.println("❌ Không có dữ liệu!");
        } else {
            list.forEach(c -> System.out.printf(
                "ID: %-3d | %-15s | active: %-5b | %s%n",
                c.getMaLoai(), c.getTenLoai(), c.isTrangThai(), c.getMoTa()
            ));
        }

    //     System.out.println("\n========== TEST getById(1) ==========");
    //     Category found = dao.getById(1);
    //     System.out.println(found != null ? "✅ " + found : "❌ Không tìm thấy");

    //     System.out.println("\n========== TEST searchByName(\"Trà\") ==========");
    //     dao.searchByName("Trà").forEach(c -> System.out.println("   → " + c.getTenLoai()));

    //     System.out.println("\n========== TEST insert() ==========");
    //     // Lombok @AllArgsConstructor — không cần setter thủ công
    //     Category newCat = new Category(0, "Test Loại", "test.jpg", true, "Mô tả test");
    //     System.out.println(dao.insert(newCat) ? "✅ Insert OK" : "❌ Insert thất bại");

    //     System.out.println("\n========== TEST update() ==========");
    //     List<Category> all = dao.getAll();
    //     Category last = all.get(all.size() - 1);
    //     last.setTenLoai("Test Loại (Updated)"); // Lombok @Data sinh setter
    //     System.out.println(dao.update(last) ? "✅ Update OK | ID = " + last.getMaLoai() : "❌ Update thất bại");

    //     System.out.println("\n========== TEST softDelete() ==========");
    //     System.out.println(dao.softDelete(last.getMaLoai()) ? "✅ Soft delete OK" : "❌ Thất bại");

    //     System.out.println("\n========== TEST delete() ==========");
    //     System.out.println(dao.delete(last.getMaLoai()) ? "✅ Delete OK — đã dọn test data" : "❌ Thất bại");

    //     System.out.println("\n========== DONE ==========");
    }

}
