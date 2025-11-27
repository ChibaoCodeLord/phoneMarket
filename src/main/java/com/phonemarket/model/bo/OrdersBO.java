package com.phonemarket.model.bo;

import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.dao.OrdersDAO;

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

    /** Lấy đầy đủ detail của đơn hàng */
    public Orders getOrderDetails(int id) throws SQLException {
        return ordersDao.getOrderWithDetails(id);
    }

    /** Soft delete (hủy đơn) */
    public boolean cancelOrder(int id) throws SQLException {
        return ordersDao.deleteOrder(id);
    }

    /** Hard delete (xóa khỏi DB) */
    public boolean hardDeleteOrder(int id) throws SQLException {
        return ordersDao.hardDeleteOrder(id);
    }
}
