package com.phonemarket.controller.admin.products;

import com.phonemarket.model.bo.ProductsBo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/products/delete")
public class deleteProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("id"));
        ProductsBo productsBo = new ProductsBo();
        try {
            boolean isDeleted = productsBo.deleteProduct(productId);
            if (isDeleted) {
                req.getSession().setAttribute("success", "Xóa sản phẩm thành công.");
            } else {
                req.getSession().setAttribute("error", "Xóa sản phẩm thất bại.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products/");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
