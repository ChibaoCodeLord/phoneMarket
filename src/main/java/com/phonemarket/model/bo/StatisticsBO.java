package com.phonemarket.model.bo;

import com.phonemarket.model.bean.MonthlySale;
import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.dao.StatisticsDAO;

import java.sql.SQLException;
import java.util.List;


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

    public List<Orders> getRecentOrders() throws SQLException {
        return dao.recentOrders();
    }
}

