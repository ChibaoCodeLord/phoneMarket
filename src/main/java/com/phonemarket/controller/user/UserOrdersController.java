package com.phonemarket.controller.user;

import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.bean.Users;
import com.phonemarket.model.bo.OrdersBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders")
public class UserOrdersController extends HttpServlet {
    private final OrdersBO ordersBo = new OrdersBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=/orders");
            return;
        }

        try {
            List<Orders> orders = ordersBo.getOrdersByUserId(currentUser.getUserId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể lấy lịch sử đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
        }
    }
}
