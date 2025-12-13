package com.phonemarket.controller.user;

import com.phonemarket.model.bean.CartItem;
import com.phonemarket.model.bean.Products;
import com.phonemarket.model.bo.ProductsBo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/add-to-cart")
public class AddToCartController extends HttpServlet {
    private final ProductsBo productsBo = new ProductsBo();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🚀 =========== ADD TO CART CONTROLLER START ===========");

        try {
            // Lấy productId từ form
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1; // Mặc định 1, có thể lấy từ form nếu cần

            // Lấy sản phẩm từ DB
            Products product = productsBo.getProductById(productId);
            if (product == null || !product.is_active() || product.getStock_quantity() < quantity) {
                System.err.println("❌ Product invalid or out of stock: ID " + productId);
                request.setAttribute("errorMsg", "Sản phẩm không tồn tại hoặc hết hàng.");
                response.sendRedirect(request.getContextPath() + "/detail?id=" + productId); // Quay lại detail
                return;
            }

            // Lấy session và giỏ hàng (nếu chưa có thì tạo mới)
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Kiểm tra item đã tồn tại trong cart chưa
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }

            // Nếu chưa có, thêm mới
            if (!found) {
                cart.add(new CartItem(product, quantity));
            }

            // Cập nhật session
            session.setAttribute("cart", cart);
            System.out.println("✅ Added to cart: " + product.getName() + " (Qty: " + quantity + ")");

            // Redirect đến cart.jsp
            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (NumberFormatException e) {
            System.err.println("❌ Invalid product ID: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
        } catch (SQLException e) {
            System.err.println("❌ Database error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu");
        } catch (Exception e) {
            System.err.println("❌ Unexpected error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        System.out.println("=========== ADD TO CART CONTROLLER END ===========");
    }
}