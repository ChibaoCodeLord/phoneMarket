package com.phonemarket.controller.admin;

import com.phonemarket.model.bean.Orders;
import com.phonemarket.model.bo.OrdersBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/orders/*")
public class OrdersController extends HttpServlet {

    private OrdersBO ordersBO = new OrdersBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getPathInfo(); // / , /view , /delete

        try {
            // ----- 1. LIST -----
            if (action == null || "/".equals(action)) {
                List<Orders> orders = ordersBO.getAllOrders();
                req.setAttribute("ordersList", orders);
                req.getRequestDispatcher("/jsp/admin/orders/list_orders.jsp").forward(req, resp);
                return;
            }

            // ----- 2. VIEW DETAILS -----
            if ("/view".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Orders order = ordersBO.getOrderDetails(id);
                req.setAttribute("order", order);
                req.getRequestDispatcher("/jsp/admin/orders/order_detail.jsp").forward(req, resp);
                return;
            }

            // ----- 3. DELETE (SOFT) -----
            if ("/delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                ordersBO.cancelOrder(id);
                resp.sendRedirect(req.getContextPath() + "/admin/orders/");
                return;
            }

            // Không trùng action nào → báo lỗi
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Action không hợp lệ");

        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/admin/orders/list_orders.jsp").forward(req, resp);
            e.printStackTrace();

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
}
