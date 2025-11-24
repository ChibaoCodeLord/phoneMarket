package com.phonemarket.controller.admin.products;

import com.phonemarket.model.bo.ProductsBo;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.sql.SQLException;

@WebServlet("/admin/products/")
public class phoneListServlet extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, java.io.IOException {
        String action = req.getPathInfo();
            ProductsBo productsBo = new ProductsBo();
            try {
                req.setAttribute("productsList", productsBo.getAllProducts());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.getRequestDispatcher("/jsp/admin/products/homeProducts.jsp").forward(req, resp);
    }
}
