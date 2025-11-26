package com.phonemarket.model.dao;

import com.phonemarket.connection.ConnectJDBC;
import com.phonemarket.model.bean.MonthlySale;
import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.bean.Products;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatisticsDAO {

    private Connection getConn() throws SQLException {
        return ConnectJDBC.getConnection();
    }

    // ================================
    // 1. Tổng số user (từ table users)
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
    // 2. Tổng số sản phẩm active (từ table products)
    // ================================
    public int totalProducts() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = 1";  // Chỉ đếm sản phẩm active

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
    // 3. Tổng doanh thu (từ table orders, status Completed)
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
    // 4. Tổng số đơn hàng (từ table orders)
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
    // 5. Doanh thu theo tháng (từ table orders, status Completed)
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
                        "Tháng " + rs.getInt("month"),  // Label tiếng Việt
                        rs.getDouble("amount")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 6. Đơn hàng gần nhất (JOIN users và order_details/products, GROUP_CONCAT products)
    // Trả về List<Orders> với full_name và product_names
    // ================================
    public List<Orders> recentOrders() {
        String sql = """
            SELECT 
                o.order_id,
                o.user_id,
                o.order_date,
                o.total_amount,
                o.shipping_address,
                o.status,
                u.full_name AS customer_name,
                GROUP_CONCAT(p.name SEPARATOR ', ') AS product_names
            FROM orders o
            JOIN users u ON o.user_id = u.user_id
            LEFT JOIN order_details od ON o.order_id = od.order_id
            LEFT JOIN products p ON od.product_id = p.product_id
            GROUP BY o.order_id, o.user_id, o.order_date, o.total_amount, o.shipping_address, o.status, u.full_name
            ORDER BY o.order_date DESC
            LIMIT 5
        """;

        List<Orders> list = new ArrayList<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("order_date"),  // Timestamp → Date
                        rs.getDouble("total_amount"),
                        rs.getString("shipping_address"),
                        rs.getString("status")
                );
                // Lưu thêm info (thêm method vào Orders bean nếu cần)
                order.setCustomerName(rs.getString("customer_name"));  // Giả sử Orders có setCustomerName
                order.setProductNames(rs.getString("product_names"));  // Giả sử Orders có setProductNames
                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 7. Sản phẩm bán chạy nhất (top 5, JOIN order_details/orders)
    // ================================
    public List<Map<String, Object>> topSellingProducts() {
        String sql = """
            SELECT p.name AS product_name, SUM(od.quantity) AS sold_quantity, p.image_url AS image_url
            FROM products p
            JOIN order_details od ON p.product_id = od.product_id
            JOIN orders o ON od.order_id = o.order_id
            WHERE o.status = 'Completed' AND p.is_active = 1
            GROUP BY p.product_id, p.name
            ORDER BY SUM(od.quantity) DESC
            LIMIT 5
        """;

        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("label", rs.getString("product_name"));
                item.put("image", rs.getString("image_url"));
                item.put("value", rs.getInt("sold_quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 8. Số lượng đơn hàng theo trạng thái (GROUP BY status)
    // ================================
    public Map<String, Integer> orderStatusCount() {
        String sql = "SELECT status, COUNT(*) AS count FROM orders GROUP BY status";

        Map<String, Integer> map = new HashMap<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                map.put(rs.getString("status"), rs.getInt("count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    // ================================
    // 9. Doanh thu theo sản phẩm (thay vì category, vì schema không có category)
    // ================================
    // ================================
// 9. Doanh thu theo sản phẩm (JOIN order_details/orders, thêm image_url)
    public List<Map<String, Object>> revenueByProduct() {
        String sql = """
        SELECT p.name AS product_name, SUM(od.price_at_purchase * od.quantity) AS revenue, p.image_url AS image_url
        FROM products p
        JOIN order_details od ON p.product_id = od.product_id
        JOIN orders o ON od.order_id = o.order_id
        WHERE o.status = 'Completed' AND p.is_active = 1
        GROUP BY p.product_id, p.name, p.image_url
        ORDER BY revenue DESC
        LIMIT 5
    """;

        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("label", rs.getString("product_name"));
                item.put("image", rs.getString("image_url"));  // THÊM: Ảnh sản phẩm
                item.put("value", rs.getDouble("revenue"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 10. Số lượng user theo role (thay monthlyNewUsers, vì không có created_date)
    // ================================
    public Map<String, Integer> usersByRole() {
        String sql = "SELECT role, COUNT(*) AS count FROM users GROUP BY role";

        Map<String, Integer> map = new HashMap<>();

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                boolean isAdmin = rs.getBoolean("role");  // tinyint1 → boolean
                map.put(isAdmin ? "Admin" : "User", rs.getInt("count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}