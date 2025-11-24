package com.phonemarket.model.dao;

import com.phonemarket.model.bean.Products;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductsDao {

    public ProductsDao() {
    }
    //TODO: sửa lại thông tin kết nối database cho đúng
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/phone_market_db", "root", "112233");
        return conn;
    }

    public Products findById(int id) throws SQLException {
        String sql = "SELECT product_id, name, description, price, image_url, stock_quantity FROM products WHERE product_id = ?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return (mapRow(rs));
            }
        }
        return null;
    }

    public List<Products> findByName(String name) throws SQLException {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT product_id, name, description, price, image_url, stock_quantity FROM products WHERE name LIKE ?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            String pattern = "%" + (name == null ? "" : name.trim()) + "%";
            ps.setString(1, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public List<Products> findAll() throws SQLException {
        String sql = "SELECT product_id, name, description, price, image_url, stock_quantity  FROM products";
        List<Products> list = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public boolean insert(Products p) throws SQLException {
        String sql = "INSERT INTO products (name, price, description, image_url, stock_quantity) VALUES (?, ?, ?, ?, ?)";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getImage());
            ps.setInt(5, p.getStock_quantity());
            int affected = ps.executeUpdate();
            if (affected == 0) return false;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return true;
            }
        }
        return false;
    }

    public boolean update(Products p) throws SQLException {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, image_url = ?, stock_quantity = ?  WHERE product_id = ?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setInt(3, p.getPrice());
            ps.setString(4, p.getImage());
            ps.setInt(5, p.getStock_quantity());
            ps.setInt(6, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    public List<Products> getAllProducts() throws SQLException {
        return findAll();
    }

    public Products getProductById(int id) throws SQLException {
        return findById(id);
    }

    public boolean addProduct(Products product) throws SQLException {
        return insert(product);
    }

    public List<Products> searchProductsByName(String keyword) throws SQLException {
        String sql = "SELECT id, name, description, price FROM products WHERE name LIKE ?";
        List<Products> list = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
    private Products mapRow(ResultSet rs) throws SQLException {
        return new Products(
                rs.getInt("product_id"),
                rs.getString("name"),
                rs.getInt("price"),
                rs.getString("description"),
                rs.getString("image_url"),
                rs.getInt("stock_quantity")
        );
    }
}
