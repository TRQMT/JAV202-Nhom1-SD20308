package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.User;
import com.polycoffee.util.JdbcUtil;

public class UserDAO implements CrudDAO<User, Integer> {

	@Override
	public int update(User entity) {
		String sql = "UPDATE NHANVIEN SET email = ?, matKhau = ?, hoTen = ?, sdt = ?, vaiTro = ?, trangThai = ? WHERE MaNV = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole() ? "admin" : "employee", entity.isActive(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sql = "DELETE FROM NHANVIEN WHERE MaNV = ?";
		try {
			return JdbcUtil.executeUpdate(sql, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<User> findAll() {
		String sql = "SELECT MaNV AS id, email, matKhau AS password, hoTen AS full_name, sdt AS phone, CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role, trangThai AS active FROM NHANVIEN";
		return this.findBySql(sql);
	}

	@Override
	public User findById(Integer id) {
		String sql = "SELECT MaNV AS id, email, matKhau AS password, hoTen AS full_name, sdt AS phone, CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role, trangThai AS active FROM NHANVIEN WHERE MaNV = ?";
		List<User> users = this.findBySql(sql, id);
		return users.isEmpty() ? null : users.get(0);
	}

	@Override
	public List<User> findBySql(String sql, Object... value) {
		List<User> users = new ArrayList<User>();
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);
			while (rs.next()) {
				User user = new User(rs.getInt("id"), rs.getString("email"), rs.getString("password"),
						rs.getString("full_name"), rs.getString("phone"), rs.getBoolean("role"), rs.getBoolean("active"));
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	public User findByEmail(String email) {
		User user = null;
		String sql = "select MaNV AS id, email, matKhau AS password, hoTen AS full_name, sdt AS phone, CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role, trangThai AS active from NHANVIEN where email = ?";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, email);
			while (rs.next()) {
				Integer id = rs.getInt("id");
				String password = rs.getString("password");
				String fullName = rs.getString("full_name");
				String phone = rs.getString("phone");
				boolean role = rs.getBoolean("role");
				boolean active = rs.getBoolean("active");
				user = new User(id, email, password, fullName, phone, role, active);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public List<User> findByRole(boolean role) {
		String sql = "SELECT MaNV AS id, email, matKhau AS password, hoTen AS full_name, sdt AS phone, CASE WHEN vaiTro = 'admin' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS role, trangThai AS active FROM NHANVIEN WHERE vaiTro = ?";
		try {
			return findBySql(sql, role ? "admin" : "employee");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<User>();
	}

	@Override
	public int create(User entity) {
		String sql = "INSERT INTO NHANVIEN(email, matKhau, hoTen, sdt, vaiTro, trangThai) values (?, ?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole() ? "admin" : "employee", entity.isActive());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int updateUserInfo(User entity) {
		String sql = "UPDATE NHANVIEN SET hoTen = ?, sdt = ? WHERE MaNV = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getFullName(), entity.getPhone(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int updateStatus(Integer id, boolean active) {
		String sql = "UPDATE NHANVIEN SET trangThai = ? WHERE MaNV = ?";
		try {
			return JdbcUtil.executeUpdate(sql, active, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
