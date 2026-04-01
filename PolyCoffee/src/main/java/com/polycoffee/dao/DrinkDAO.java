package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Drink;
import com.polycoffee.util.JdbcUtil;

public class DrinkDAO implements CrudDAO<Drink, Integer> {

	@Override
	public int create(Drink entity) {
		String sql = "INSERT INTO DOUONG(maLoai, tenDoUong, moTa, hinhAnh, donGia, trangThai) values (?, ?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getCategoryId(), entity.getName(), entity.getDescription(),
					entity.getImage(), entity.getPrice(), entity.isActive());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Drink entity) {
		String sql = "UPDATE DOUONG SET maLoai = ?, tenDoUong = ?, moTa = ?, hinhAnh = ?, donGia = ?, trangThai = ? WHERE MaDoUong = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getCategoryId(), entity.getName(), entity.getDescription(),
					entity.getImage(), entity.getPrice(), entity.isActive(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sql = "DELETE FROM DOUONG WHERE MaDoUong = ?";
		try {
			return JdbcUtil.executeUpdate(sql, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int countInBillDetails(Integer drinkId) {
		String sql = "SELECT COUNT(MaCTHD) AS total FROM CHITIETHOADON WHERE MaDoUong = ?";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, drinkId);
			if (rs.next()) {
				return rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Drink> findAll() {
		List<Drink> list = new ArrayList<Drink>();
		String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, moTa AS description, hinhAnh AS image, donGia AS price, trangThai AS active FROM DOUONG";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql);
			while (rs.next()) {
				Integer id = rs.getInt("id");
				Integer categoryId = rs.getInt("category_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String image = rs.getString("image");
				int price = rs.getInt("price");
				boolean active = rs.getBoolean("active");
				Drink d = new Drink(id, categoryId, name, description, image, price, active);
				list.add(d);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Drink findById(Integer id) {
		Drink d = null;
		String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, moTa AS description, hinhAnh AS image, donGia AS price, trangThai AS active FROM DOUONG WHERE MaDoUong = ?";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, id);
			while (rs.next()) {
				Integer categoryId = rs.getInt("category_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String image = rs.getString("image");
				int price = rs.getInt("price");
				boolean active = rs.getBoolean("active");
				d = new Drink(id, categoryId, name, description, image, price, active);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return d;
	}

	@Override
	public List<Drink> findBySql(String sql, Object... value) {
		List<Drink> list = new ArrayList<Drink>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);
			while (rs.next()) {
				Integer id = rs.getInt("id");
				Integer categoryId = rs.getInt("category_id");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String image = rs.getString("image");
				int price = rs.getInt("price");
				boolean active = rs.getBoolean("active");
				Drink d = new Drink(id, categoryId, name, description, image, price, active);
				list.add(d);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Drink> findByName(String keyword) {
    String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, moTa AS description, "
               + "hinhAnh AS image, donGia AS price, trangThai AS active "
               + "FROM DOUONG WHERE tenDoUong LIKE ?";
    return findBySql(sql, "%" + keyword + "%");
}

// Đếm tổng số đồ uống
public int countAll() {
    String sql = "SELECT COUNT(*) AS total FROM DOUONG";
    try {
        ResultSet rs = JdbcUtil.executeQuery(sql);
        if (rs.next()) return rs.getInt("total");
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

// Đếm kết quả theo từ khóa
public int countByName(String keyword) {
    String sql = "SELECT COUNT(*) AS total FROM DOUONG WHERE tenDoUong LIKE ?";
    try {
        ResultSet rs = JdbcUtil.executeQuery(sql, "%" + keyword + "%");
        if (rs.next()) return rs.getInt("total");
    } catch (Exception e) { e.printStackTrace(); }
    return 0;
}

// Lấy đồ uống theo trang (không tìm kiếm)
public List<Drink> findByPage(int offset, int limit) {
    String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, "
               + "moTa AS description, hinhAnh AS image, donGia AS price, trangThai AS active "
               + "FROM DOUONG ORDER BY MaDoUong "
               + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    return findBySql(sql, offset, limit);
}

// Lấy đồ uống theo trang + từ khóa
public List<Drink> findByNameAndPage(String keyword, int offset, int limit) {
    String sql = "SELECT MaDoUong AS id, maLoai AS category_id, tenDoUong AS name, "
               + "moTa AS description, hinhAnh AS image, donGia AS price, trangThai AS active "
               + "FROM DOUONG WHERE tenDoUong LIKE ? ORDER BY MaDoUong "
               + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    return findBySql(sql, "%" + keyword + "%", offset, limit);
}
}
