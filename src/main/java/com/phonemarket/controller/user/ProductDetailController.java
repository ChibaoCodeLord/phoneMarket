package com.phonemarket.controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(name = "ProductDetailController", urlPatterns = "/product-detail")
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số id");
            return;
        }

        int productId = Integer.parseInt(idStr);
        Map<String, Object> product = loadProduct(productId);

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            return;
        }

        request.setAttribute("p", product);
        request.getRequestDispatcher("/detail/detailProduct.jsp")
                .forward(request, response);
    }

    private Map<String, Object> loadProduct(int id) {
        // Thay bằng DAO + DB sau
        if (id == 1) {
            Map<String, Object> p = new LinkedHashMap<>();
            p.put("id", 1);
            p.put("name", "Xiaomi POCO X7 Pro 5G 12GB 256GB");
            p.put("priceSale", "9.990.000đ");
            p.put("priceOld", "10.990.000đ");
            p.put("image", "https://placehold.co/600x600/333/FFF?text=POCO+X7+Pro");

            Map<String, String> specs = new LinkedHashMap<>();
            specs.put("Màn hình", "6.67\" AMOLED 120Hz");
            specs.put("Chip", "Snapdragon 7+ Gen 3");
            specs.put("RAM", "12GB");
            specs.put("Bộ nhớ", "256GB");
            specs.put("Pin", "5500mAh - Sạc 67W");
            p.put("specs", specs);

            return p;
        }
        return null;
    }
}