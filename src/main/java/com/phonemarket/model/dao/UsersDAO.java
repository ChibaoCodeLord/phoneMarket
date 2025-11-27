package com.phonemarket.model.dao;

import com.phonemarket.connection.ConnectJDBC;
import com.phonemarket.model.bean.Users;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsersDAO {

    public UsersDAO() {}

    // ============================
    // FIND BY FULL NAME
    // ============================
    public Users findByName(String fullName) throws SQLException {
        String sql = "SELECT * FROM users WHERE fullname = ?";
        try (Connection c = ConnectJDBC.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        }
        return null;
    }

    // ============================
    // FIND ALL USERS
    // ============================
    public List<Users> findAll() throws SQLException {
        String sql = "SELECT * FROM users";
        List<Users> list = new ArrayList<>();

        try (Connection c = ConnectJDBC.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ============================
    // MAP RESULTSET → USER OBJECT
    // ============================
    private Users mapRow(ResultSet rs) throws SQLException {
        Users u = new Users();
        u.setUserId(rs.getInt("user_id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));   // DB: password_hash
        u.setEmail(rs.getString("email"));
        u.setFullName(rs.getString("fullname"));
        u.setPhone(rs.getString("phone_number"));
        u.setAddress(rs.getString("address"));
        u.setRole(rs.getBoolean("role"));               // TINYINT → boolean

        return u;
    }

    public Users findById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection c = ConnectJDBC.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection c = ConnectJDBC.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Users user) {
        String sql = "UPDATE users SET fullname = ?, email = ?, phone_number = ?, address = ?, role = ? WHERE user_id = ?";

        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setBoolean(5, user.isRole());
            ps.setInt(6, user.getUserId());  // ⚠ Bắt buộc set user_id

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkPassword(int userId, String password) {
        String sql = "SELECT password FROM users WHERE user_id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
