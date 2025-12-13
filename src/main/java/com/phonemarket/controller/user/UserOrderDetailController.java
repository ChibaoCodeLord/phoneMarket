package com.phonemarket.controller.user;

import com.phonemarket.model.bean.OrderDetailItem;
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

@WebServlet("/order-detail")
public class UserOrderDetailController extends HttpServlet {
    private final OrdersBO ordersBO = new OrdersBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=/order-detail?id=" + request.getParameter("id"));
            return;
        }

        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }

            int orderId = Integer.parseInt(idParam);
            
            // Lấy thông tin đơn hàng
            Orders order = ordersBO.getOrderDetails(orderId);
            
            if (order == null) {
                request.setAttribute("error", "Đơn hàng không tồn tại.");
                request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xem đơn hàng có thuộc về user hiện tại không
            if (order.getUserId() != currentUser.getUserId()) {
                request.setAttribute("error", "Bạn không có quyền xem đơn hàng này.");
                request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách sản phẩm trong đơn hàng
            List<OrderDetailItem> orderItems = ordersBO.getOrderDetailItems(orderId);
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/jsp/user/order_detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn hàng không hợp lệ.");
            request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể lấy chi tiết đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/jsp/user/orders.jsp").forward(request, response);
        }
    }
}

