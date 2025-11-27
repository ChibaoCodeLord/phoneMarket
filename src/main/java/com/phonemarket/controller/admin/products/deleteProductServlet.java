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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDelete(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDelete(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            ProductsBo productsBo = new ProductsBo();

            boolean isDeleted = productsBo.deleteProduct(productId);
            if (isDeleted) {
                req.getSession().setAttribute("success", "Xóa sản phẩm thành công.");
            } else {
                req.getSession().setAttribute("error", "Xóa sản phẩm thất bại.");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } catch (SQLException e) {
            req.getSession().setAttribute("error", "Lỗi khi xóa sản phẩm: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("error", "ID sản phẩm không hợp lệ.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
