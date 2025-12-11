package com.phonemarket.controller.user;

import com.phonemarket.model.bo.ProductsBo;
import com.phonemarket.model.bean.Products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/", "/home"})
public class ProductController extends HttpServlet {
    private final ProductsBo productsBo = new ProductsBo();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ FILTER favicon.ico — don't process it
        String requestURI = request.getRequestURI();
        if (requestURI.endsWith(".ico") || requestURI.contains("favicon")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        System.out.println("🚀 =========== PRODUCT CONTROLLER START ===========");
        System.out.println("Request URI: " + requestURI);

        try {
            List<Products> productList = productsBo.getAllProducts();
            if (productList == null) productList = java.util.Collections.emptyList();
            
            System.out.println("✅ Loaded " + productList.size() + " products");
            for (int i = 0; i < Math.min(3, productList.size()); i++) {
                Products p = productList.get(i);
                System.out.println("   " + (i+1) + ". " + p.getName() + " - " + p.getPrice() + "đ");
            }

            // ✅ SET ATTRIBUTE
            request.setAttribute("productList", productList);
            System.out.println("✅ SET productList attribute");

        } catch (Exception e) {
            System.err.println("❌ ERROR: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
        }

        
            System.out.println("=========== PRODUCT CONTROLLER END ===========");
        // ✅ FORWARD TO home.jsp
        request.getRequestDispatcher("/jsp/user/home.jsp").forward(request, response);
    
    }
}