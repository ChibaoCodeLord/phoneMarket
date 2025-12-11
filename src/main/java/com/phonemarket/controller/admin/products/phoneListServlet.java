package com.phonemarket.controller.admin.products;

import com.phonemarket.model.bean.Products;
import com.phonemarket.model.bo.ProductsBo;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/products")
public class phoneListServlet extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws jakarta.servlet.ServletException, java.io.IOException {
        String action = req.getPathInfo();
            ProductsBo productsBo = new ProductsBo();
            try {
                List<Products> list = productsBo.getAllProducts();
                System.out.println(list.get(0).is_active());
                req.setAttribute("productsList", list);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.getRequestDispatcher("/jsp/admin/products/homeProducts.jsp").forward(req, resp);
    }
}
