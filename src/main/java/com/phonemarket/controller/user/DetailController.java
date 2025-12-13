package com.phonemarket.controller.user;

import com.phonemarket.model.bo.ProductsBo;
import com.phonemarket.model.bean.Products;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/detail")
public class DetailController extends HttpServlet {
    private final ProductsBo productsBo = new ProductsBo();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🚀 =========== DETAIL CONTROLLER START ===========");
        String requestURI = request.getRequestURI();
        System.out.println("Request URI: " + requestURI);

        try {
            // Lấy id từ query param
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("✅ Fetching product with ID: " + id);

            // Lấy sản phẩm từ DB qua BO
            Products product = productsBo.getProductById(id);
            if (product == null) {
                System.err.println("❌ Product not found for ID: " + id);
                request.setAttribute("errorMsg", "Sản phẩm không tồn tại.");
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            System.out.println("✅ Loaded product: " + product.getName() + " - " + product.getPrice() + "đ");

            // Set attribute cho JSP
            request.setAttribute("product", product);
            System.out.println("✅ SET product attribute");

            // Forward đến detailProduct.jsp
            request.getRequestDispatcher("/jsp/user/detailProduct.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid ID: " + e.getMessage());
            request.setAttribute("errorMsg", "ID sản phẩm không hợp lệ.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (SQLException e) {
            System.err.println("❌ Database error: " + e.getMessage());
            request.setAttribute("errorMsg", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } catch (Exception e) {
            System.err.println("❌ Unexpected error: " + e.getMessage());
            request.setAttribute("errorMsg", "Lỗi không mong muốn: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        System.out.println("=========== DETAIL CONTROLLER END ===========");
    }
}