package com.phonemarket.model.dao;

import com.phonemarket.connection.ConnectJDBC;
import com.phonemarket.model.bean.MonthlySale;
import com.phonemarket.model.bean.Orders;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StatisticsDAO {

    private Connection getConn() throws SQLException {
        return ConnectJDBC.getConnection();
    }

    // ================================
    // 1. Tổng số user
    // ================================
    public int totalUsers() {
        String sql = "SELECT COUNT(*) FROM users";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================================
    // 2. Tổng số sản phẩm
    // ================================
    public int totalProducts() {
        String sql = "SELECT COUNT(*) FROM products";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================================
    // 3. Tổng doanh thu
    // ================================
    public double totalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'Completed'";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getDouble(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================================
    // 4. Tổng số đơn hàng
    // ================================
    public int totalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            rs.next();
            return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================================
    // 5. Doanh thu theo tháng
    // ================================
    public List<MonthlySale> monthlySales() {
        String sql = """
            SELECT MONTH(order_date) AS month, SUM(total_amount) AS amount
            FROM orders
            WHERE status = 'Completed'
            GROUP BY MONTH(order_date)
            ORDER BY MONTH(order_date)
        """;

        List<MonthlySale> list = new ArrayList<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new MonthlySale(
                        "T" + rs.getInt("month"),
                        rs.getDouble("amount")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 6. Đơn hàng gần nhất (JOIN đúng chuẩn database)
    // ================================
    public List<Orders> recentOrders() {

        String sql = """
            SELECT 
                o.order_id,
                u.full_name,
                GROUP_CONCAT(p.name SEPARATOR ', ') AS products,
                o.status,
                o.total_amount
            FROM orders o
            JOIN users u ON o.user_id = u.user_id
            JOIN order_details od ON o.order_id = od.order_id
            JOIN products p ON od.product_id = p.product_id
            GROUP BY o.order_id, u.full_name, o.status, o.total_amount
            ORDER BY o.order_date DESC
            LIMIT 5
        """;

        List<Orders> list = new ArrayList<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Orders(
                        rs.getInt("order_id"),
                        rs.getString("full_name"),
                        rs.getString("products"),       // danh sách sản phẩm ghép bởi GROUP_CONCAT
                        rs.getString("status"),
                        rs.getDouble("total_amount")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
