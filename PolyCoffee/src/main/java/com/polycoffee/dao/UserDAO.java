package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.User;
import com.polycoffee.util.JdbcUtil;

public class UserDAO implements CrudDAO<User, Integer> {

	@Override
	public int update(User entity) {
		String sql = "UPDATE users SET email = ?, password = ?, full_name = ?, phone = ?, role = ?, active = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole(), entity.isActive(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		String sql = "DELETE FROM users WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<User> findAll() {
		String sql = "SELECT * FROM users";
		return this.findBySql(sql);
	}

	@Override
	public User findById(Integer id) {
		String sql = "SELECT * FROM users WHERE id = ?";
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
		String sql = "select * from users where email = ?";
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
		String sql = "SELECT * FROM users WHERE role = ?";
		try {
			return findBySql(sql, role);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<User>();
	}

	@Override
	public int create(User entity) {
		String sql = "INSERT INTO users(email, password, full_name, phone, role, active) values (?, ?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole(), entity.isActive());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int updateUserInfo(User entity) {
		String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getFullName(), entity.getPhone(), entity.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int updateStatus(Integer id, boolean active) {
		String sql = "UPDATE users SET active = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, active, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
