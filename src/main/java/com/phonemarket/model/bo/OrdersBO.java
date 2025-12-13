package com.phonemarket.model.bo;

import com.phonemarket.model.bean.OrderDetailItem;
import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.dao.OrdersDAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class OrdersBO {

    private OrdersDAO ordersDao;

    public OrdersBO() {
        this.ordersDao = new OrdersDAO();
    }

    /** Lấy toàn bộ danh sách đơn hàng */
    public List<Orders> getAllOrders() throws SQLException {
        return ordersDao.findAll();
    }

    /** Lấy đơn hàng theo ID (không có detail) */
    public Orders getOrderById(int id) throws SQLException {
        return ordersDao.findById(id);
    }

    /** Lấy đầy đủ detail (thông tin khách + product_names + images + tổng) */
    public Orders getOrderDetails(int id) throws SQLException {
        return ordersDao.getOrderWithDetails(id);
    }

    /** Lấy danh sách sản phẩm trong đơn hàng */
    public List<OrderDetailItem> getOrderDetailItems(int orderId) throws SQLException {
        return ordersDao.getOrderDetailsByOrderId(orderId);
    }

    /** Soft delete (hủy đơn) */
    public boolean cancelOrder(int id) throws SQLException {
        return ordersDao.deleteOrder(id);
    }

    /** Hard delete (xóa khỏi DB) */
    public boolean hardDeleteOrder(int id) throws SQLException {
        return ordersDao.hardDeleteOrder(id);
    }
    public boolean updateOrder(Orders order) throws SQLException {
        return ordersDao.updateOrder(order);
    }

    public List<Orders> getOrdersByUserId(int userId) throws SQLException {
        return ordersDao.findByUserId(userId);
    }

    /** Create order and its details from cart. Returns created order id or -1 on failure */
    public int createOrder(Orders order, java.util.List<com.phonemarket.model.bean.CartItem> cart) throws SQLException {
        int orderId = ordersDao.createOrder(order);
        if (orderId <= 0) return -1;
        // Insert details
        boolean ok = ordersDao.addOrderDetails(orderId, cart);
        if (!ok) return -1;

        // Decrement stock for each item
        com.phonemarket.model.dao.ProductsDao pDao = new com.phonemarket.model.dao.ProductsDao();
        for (com.phonemarket.model.bean.CartItem item : cart) {
            boolean s = pDao.decrementStock(item.getProduct().getId(), item.getQuantity());
            if (!s) System.err.println("Warning: could not decrement stock for product id=" + item.getProduct().getId());
        }

        return orderId;
    }

    /** Create order and its details in a transactional manner. Returns created order id or -1 on failure */
    public int createOrderTransactional(Orders order, java.util.List<com.phonemarket.model.bean.CartItem> cart) throws SQLException {
        Connection conn = null;
        try {
            conn = com.phonemarket.connection.ConnectJDBC.getConnection();
            conn.setAutoCommit(false);

            OrdersDAO ordersDao = new OrdersDAO();
            int orderId = ordersDao.createOrder(conn, order);
            if (orderId <= 0) {
                conn.rollback();
                return -1;
            }

            boolean added = ordersDao.addOrderDetails(conn, orderId, cart);
            if (!added) {
                conn.rollback();
                return -1;
            }

            // Decrement inventory for each cart item
            com.phonemarket.model.dao.ProductsDao pDao = new com.phonemarket.model.dao.ProductsDao();
            for (com.phonemarket.model.bean.CartItem item : cart) {
                boolean dec = pDao.decrementStock(conn, item.getProduct().getId(), item.getQuantity());
                if (!dec) {
                    conn.rollback();
                    throw new SQLException("Insufficient stock for product id=" + item.getProduct().getId());
                }
            }

            conn.commit();
            return orderId;
        } catch (SQLException ex) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException e) { /* ignore */ }
            }
            throw ex;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { /* ignore */ }
            }
        }
    }

}
