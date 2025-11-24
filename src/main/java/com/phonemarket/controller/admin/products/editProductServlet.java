package com.phonemarket.controller.admin.products;

import com.phonemarket.model.bean.Products;
import com.phonemarket.model.bo.ProductsBo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/products/update")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class editProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("id"));
        ProductsBo productsBo = new ProductsBo();
        try {
            Products product = productsBo.getProductById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("product", product);
            req.getRequestDispatcher("/jsp/admin/products/updateProduct.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required.");
            return;
        }
        int id = Integer.parseInt(idStr);
        String name = req.getParameter("name");
        int price = Integer.parseInt(req.getParameter("price"));
        String description = req.getParameter("description");
        int stockQuantity = Integer.parseInt(req.getParameter("stock_quantity"));

        ProductsBo productsBo = new ProductsBo();
        try {
            Products existingProduct = productsBo.getProductById(id);
            if (existingProduct == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            String imageDbPath = existingProduct.getImage();
            Part imagePart = req.getPart("imageUrl");
            if (imagePart != null && imagePart.getSize() > 0) {
                String imageFileName = imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "assets/images/products/";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                imageDbPath = "/assets/images/products/" + imageFileName;
                imagePart.write(uploadPath + imageFileName);
            }
            Products updatedProduct = new Products(id, name, price, description, imageDbPath, stockQuantity);
            boolean isUpdated = productsBo.updateProduct(updatedProduct);
            if (isUpdated) {
                req.getSession().setAttribute("success", "Cập nhật sản phẩm thành công.");
                resp.sendRedirect(req.getContextPath() + "/admin/products/");
            } else {
                req.setAttribute("error", "Cập nhật sản phẩm thất bại.");
                req.getRequestDispatcher("/jsp/admin/products/updateProduct.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
