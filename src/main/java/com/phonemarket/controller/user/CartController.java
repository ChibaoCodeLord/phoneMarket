package com.phonemarket.controller.user;

import com.phonemarket.model.bean.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Nothing special required: jsp reads cart from session
        // But we can log for debugging and forward to JSP
        System.out.println("🚀 =========== CART CONTROLLER START ===========");
        try {
            List<CartItem> cart = (List<CartItem>) request.getSession().getAttribute("cart");
            if (cart == null) cart = java.util.Collections.emptyList();
            System.out.println("✅ Cart size: " + cart.size());
        } catch (Exception e) {
            System.err.println("❌ Error reading cart from session: " + e.getMessage());
            e.printStackTrace();
        }
        request.getRequestDispatcher("/jsp/user/cart.jsp").forward(request, response);
        System.out.println("=========== CART CONTROLLER END ===========");
    }
}
