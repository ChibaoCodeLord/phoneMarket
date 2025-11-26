package com.phonemarket.model.bo;

import com.phonemarket.model.bean.MonthlySale;
import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.dao.StatisticsDAO;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class StatisticsBO {

    private StatisticsDAO dao = new StatisticsDAO();

    public int getTotalUsers() throws SQLException {
        return dao.totalUsers();
    }

    public int getTotalProducts() throws SQLException {
        return dao.totalProducts();
    }

    public double getTotalRevenue() throws SQLException {
        return dao.totalRevenue();
    }

    public int getTotalOrders() throws SQLException {
        return dao.totalOrders();
    }

    public List<MonthlySale> getMonthlySales() throws SQLException {
        return dao.monthlySales();
    }

    // Recent orders: Trả về List<Orders> với customerName và productNames từ JOIN
    public List<Orders> getRecentOrders() throws SQLException {
        return dao.recentOrders();  // DAO đã JOIN users và products
    }

    // Top sản phẩm bán chạy (dữ liệu bar chart)
    public List<Map<String, Object>> getTopSellingProducts() throws SQLException {
        return dao.topSellingProducts();
    }

    // Số lượng đơn hàng theo trạng thái (dữ liệu pie chart)
    public Map<String, Integer> getOrderStatusCount() throws SQLException {
        return dao.orderStatusCount();
    }

    // Doanh thu theo sản phẩm (dữ liệu doughnut chart)
    public List<Map<String, Object>> getRevenueByProduct() throws SQLException {
        return dao.revenueByProduct();
    }

    // Số lượng user theo role (dữ liệu line chart thay monthlyNewUsers)
    public Map<String, Integer> getUsersByRole() throws SQLException {
        return dao.usersByRole();
    }
}