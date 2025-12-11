package com.phonemarket.model.dao;

import com.phonemarket.connection.ConnectJDBC;
import com.phonemarket.model.bean.Users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class authDAO {
    public Users findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);  // Nên so sánh hash ở BO
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone_number"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getBoolean("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean register(Users user) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "INSERT INTO users (username, password, email,phone_number, address, fullname) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectJDBC.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set parameters từ User object (giả sử User có getters cho các field)
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getFullName());


            int rowsAffected = pstmt.executeUpdate();
            System.out.println(user.getFullName());
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
