package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Category;
import com.polycoffee.util.JdbcUtil;

public class CategoryDAO implements CrudDAO<Category, Integer>{
	//Thêm mới loại đồ uống
	@Override
	public int create(Category entity) {
	
		String sql = "INSERT INTO LOAIDOUONG(tenLoai, hinhAnh, trangThai, moTa) values (?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getName(), "default.jpg", entity.isActive(), "");
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return 0;
	}
	//Cập nhật loại đồ uống
	@Override
	public int update(Category entity) {
	
		String sql = "UPDATE LOAIDOUONG SET tenLoai = ?, trangThai = ? WHERE maLoai = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getName(), entity.isActive(), entity.getId());
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return 0;
	}
	//Xóa loại đồ uống
	@Override
	public int delete(Integer id) {
		
		String sql = "DELETE FROM LOAIDOUONG WHERE maLoai = ?";
		try {
			return JdbcUtil.executeUpdate(sql, id);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return 0;
	}
	//Lấy danh sách loại đồ uống
	@Override
	public List<Category> findAll() {
		
		List<Category> list = new ArrayList<Category>();
		String sql = "SELECT maLoai AS id, tenLoai AS name, trangThai AS active FROM LOAIDOUONG";
		try {
			ResultSet resultSet = JdbcUtil.executeQuery(sql);
			while(resultSet.next()) {
				Integer id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				boolean active = resultSet.getBoolean("active");
				Category category = new Category(id, name, active);
				list.add(category);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return list;
	}
	//Lấy thông tin loại đồ uống theo id
	@Override
	public Category findById(Integer id) {
		
		Category category = null;
		String sql = "SELECT maLoai AS id, tenLoai AS name, trangThai AS active FROM LOAIDOUONG WHERE maLoai = ?";
		try {
			ResultSet resultSet = JdbcUtil.executeQuery(sql, id);
			while(resultSet.next()) {
				String name = resultSet.getString("name");
				boolean active = resultSet.getBoolean("active");
				category = new Category(id, name, active);
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return category;
	}
	
	@Override
	public List<Category> findBySql(String sql, Object... values) {
		
		List<Category> list = new ArrayList<Category>();
		try {
			ResultSet resultSet = JdbcUtil.executeQuery(sql, values);
			while(resultSet.next()) {
				Integer id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				boolean active = resultSet.getBoolean("active");
				Category category = new Category(id, name, active);
				list.add(category);
			}
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		return list;
	}
	public int countDrinkInCategory(int categoryId) {
		int rs = 0;
		String sql = "select count(MaDoUong) as num_drink from DOUONG where maLoai = ?";
		try {
			ResultSet resultSet = JdbcUtil.executeQuery(sql, categoryId);
			
			while(resultSet.next()) {
				rs = resultSet.getInt("num_drink");
			}
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return rs;
		
	}
}

