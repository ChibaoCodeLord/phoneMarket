package com.phonemarket.controller.user;

import com.phonemarket.model.bean.CartItem;
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
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private final OrdersBO ordersBo = new OrdersBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (currentUser == null) {
            String redirectUrl = request.getContextPath() + "/login?redirect=/cart";
            response.sendRedirect(redirectUrl);
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Compute total
        double total = 0;
        for (CartItem i : cart) total += i.getTotalPrice();

        Orders order = new Orders();
        order.setUserId(currentUser.getUserId());
        order.setOrderDate(new Date());
        order.setTotalAmount(total);
        order.setShippingAddress(currentUser.getAddress() != null ? currentUser.getAddress() : "");
        order.setStatus("Processing");

        try {
            int orderId = ordersBo.createOrderTransactional(order, cart);
            if (orderId > 0) {
                // Clear cart
                session.removeAttribute("cart");
                // forward to success page
                request.setAttribute("orderId", orderId);
                request.getRequestDispatcher("/jsp/user/order_success.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng thử lại.");
                request.getRequestDispatcher("/jsp/user/cart.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/jsp/user/cart.jsp").forward(request, response);
            return;
        }
    }
}
