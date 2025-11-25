package com.phonemarket.controller.admin;

import com.phonemarket.model.bo.StatisticsBO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/statistics")
public class StatisticsController extends HttpServlet {

    private StatisticsBO statisticsBO;

    @Override
    public void init() {
        statisticsBO = new StatisticsBO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Các số liệu tổng
            req.setAttribute("totalUsers", statisticsBO.getTotalUsers());
            req.setAttribute("totalProducts", statisticsBO.getTotalProducts());
            req.setAttribute("totalRevenue", statisticsBO.getTotalRevenue());
            req.setAttribute("totalOrders", statisticsBO.getTotalOrders());

            // Dữ liệu Chart (list tháng)
            req.setAttribute("monthlySales", statisticsBO.getMonthlySales());

            // Recent orders
            req.setAttribute("recentOrders", statisticsBO.getRecentOrders());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi tải thống kê: " + e.getMessage());
        }

        req.getRequestDispatcher("/jsp/admin/home.jsp")
                .forward(req, resp);
    }
}

