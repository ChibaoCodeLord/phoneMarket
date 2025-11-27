package com.phonemarket.model.dao;

import com.phonemarket.connection.ConnectJDBC;
import com.phonemarket.model.bean.OrderDetailItem;
import com.phonemarket.model.bean.Orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

    public OrdersDAO() {}

    private Connection getConn() throws SQLException {
        return ConnectJDBC.getConnection();
    }

    /** MAP ROW -> Orders object */
    private Orders mapRow(ResultSet rs) throws SQLException {
        Orders order = new Orders(
                rs.getInt("order_id"),
                rs.getInt("user_id"),
                rs.getTimestamp("order_date"),
                rs.getDouble("total_amount"),
                rs.getString("shipping_address"),
                rs.getString("status")
        );
        order.setCustomerName(rs.getString("customer_name"));
        order.setProductNames(rs.getString("product_names"));
        return order;
    }

    /** Tìm đơn hàng theo ID */
    public Orders findById(int id) throws SQLException {
        String sql = """
            SELECT o.order_id, o.user_id, o.order_date, o.total_amount, 
                   o.shipping_address, o.status,
                   u.fullname AS customer_name,
                   GROUP_CONCAT(p.name SEPARATOR ', ') AS product_names
            FROM orders o
            JOIN users u ON o.user_id = u.user_id
            LEFT JOIN order_details od ON o.order_id = od.order_id
            LEFT JOIN products p ON od.product_id = p.product_id
            WHERE o.order_id = ?
            GROUP BY o.order_id
        """;

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    /** Lấy tất cả đơn hàng */
    public List<Orders> findAll() throws SQLException {
        String sql = """
            SELECT o.order_id, o.user_id, o.order_date, o.total_amount,
                   o.shipping_address, o.status,
                   u.fullname AS customer_name,
                   GROUP_CONCAT(p.name SEPARATOR ', ') AS product_names
            FROM orders o
            JOIN users u ON o.user_id = u.user_id
            LEFT JOIN order_details od ON o.order_id = od.order_id
            LEFT JOIN products p ON od.product_id = p.product_id
            GROUP BY o.order_id
            ORDER BY o.order_date DESC
        """;

        List<Orders> list = new ArrayList<>();

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));
        }

        return list;
    }

    /** Lấy đơn hàng + chi tiết (ảnh, giá, số lượng) */
    public Orders getOrderWithDetails(int id) throws SQLException {
        String sql = """
            SELECT o.order_id, o.user_id, o.order_date, o.total_amount,
                   o.shipping_address, o.status,
                   u.fullname AS customer_name,
                   u.email AS customer_email,
                   u.phone_number AS customer_phone,
                   GROUP_CONCAT(p.name SEPARATOR ', ') AS product_names,
                   GROUP_CONCAT(p.image_url SEPARATOR ', ') AS product_images,
                   GROUP_CONCAT(CONCAT(od.quantity, ' x ', od.price_at_purchase) SEPARATOR ', ') AS detail_items
            FROM orders o
            JOIN users u ON o.user_id = u.user_id
            LEFT JOIN order_details od ON o.order_id = od.order_id
            LEFT JOIN products p ON od.product_id = p.product_id
            WHERE o.order_id = ?
            GROUP BY o.order_id
        """;

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("order_date"),
                        rs.getDouble("total_amount"),
                        rs.getString("shipping_address"),
                        rs.getString("status")
                );

                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                order.setCustomerPhone(rs.getString("customer_phone"));
                order.setProductNames(rs.getString("product_names"));
                order.setProductImages(rs.getString("product_images"));
                order.setDetailItems(rs.getString("detail_items"));

                return order;
            }
        }
        return null;
    }

    public boolean deleteOrder(int id) throws SQLException {
        // 1️⃣ Kiểm tra trạng thái đơn hàng trước
        String selectSql = "SELECT status FROM orders WHERE order_id = ?";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(selectSql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Order found with status: " + rs.getString("status"));
                } else {
                    System.out.println("No order found with id = " + id);
                    return false; // Không có order → không xóa
                }
            }
        }

        // 2️⃣ Cập nhật trạng thái đơn hàng thành 'Cancelled'
        String updateSql = "UPDATE orders SET status = 'Cancelled' WHERE order_id = ?";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(updateSql)) {

            ps.setInt(1, id);
            int updated = ps.executeUpdate();
            System.out.println("Rows updated: " + updated);
            return updated > 0;
        }
    }



    /** Hard delete — xóa thật */
    public boolean hardDeleteOrder(int id) throws SQLException {

        // Xóa chi tiết trước
        String sql1 = "DELETE FROM order_details WHERE order_id = ?";

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql1)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }

        // Xóa order
        String sql2 = "DELETE FROM orders WHERE order_id = ?";

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql2)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
    /** Lấy danh sách order_detail theo order_id */
    public List<OrderDetailItem> getOrderDetailsByOrderId(int orderId) throws SQLException {

        String sql = """
        SELECT od.order_detail_id, od.product_id, od.quantity, od.price_at_purchase,
               p.name AS product_name,
               p.image_url AS product_image
        FROM order_details od
        JOIN products p ON od.product_id = p.product_id
        WHERE od.order_id = ?
        ORDER BY od.order_detail_id ASC
    """;

        List<OrderDetailItem> list = new ArrayList<>();

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new OrderDetailItem(
                        rs.getInt("order_detail_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("price_at_purchase"),
                        rs.getString("product_name"),
                        rs.getString("product_image")
                ));
            }
        }
        return list;
    }
    /** Cập nhật thông tin đơn hàng */
    public boolean updateOrder(Orders order) throws SQLException {
        String sql = """
        UPDATE orders 
        SET user_id = ?, 
            order_date = ?, 
            total_amount = ?, 
            shipping_address = ?, 
            status = ?
        WHERE order_id = ?
    """;

        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, new java.sql.Timestamp(order.getOrderDate().getTime()));
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getStatus());
            ps.setInt(6, order.getOrderId());

            int updated = ps.executeUpdate();
            System.out.println("OrdersDAO.updateOrder - rows updated: " + updated);
            return updated > 0;
        }
    }

}
