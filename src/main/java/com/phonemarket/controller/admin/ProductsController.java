package com.phonemarket.controller.admin;

import com.phonemarket.model.bean.Products;
import com.phonemarket.model.bo.ProductsBo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.swing.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/products/*")
//để chương trình có thể truy xuất và xử lý các yêu cầu tải lên tệp tin
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if("/".equals(action) || action == null) {
            ProductsBo productsBo = new ProductsBo();
            try {
                req.setAttribute("productsList", productsBo.getAllProducts());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            req.getRequestDispatcher("/jsp/admin/products/homeProducts.jsp").forward(req, resp);
        }
        else if ("/add".equals(action)) {
            req.getRequestDispatcher("/jsp/admin/products/addProducts.jsp").forward(req, resp);
        } else if ("/edit".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("id"));
            ProductsBo productsBo = new ProductsBo();
            try {
                Products product = productsBo.getProductById(productId);
                if (product != null) {
                    req.setAttribute("product", product);
                    req.getRequestDispatcher("/jsp/admin/products/updateProduct.jsp").forward(req, resp);
                } else {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if ("/add".equals(action)) {
            String name = req.getParameter("name");
            int price = Integer.parseInt(req.getParameter("price"));
            String description = req.getParameter("description");
            int stock_quantity = Integer.parseInt(req.getParameter("stock_quantity"));

            // Xử lý tải lên hình ảnh
            //1. Lấy phần tệp tin từ yêu cầu
            Part imagePart = req.getPart("imageUrl");
            //2. Lấy tên tệp tin
            String imageFileName = imagePart.getSubmittedFileName();
            //3. Xác định đường dẫn lưu trữ tệp tin trên server
            // Tạo đường dẫn đến thư mục bạn muốn lưu (giống trong hình: /assets/images/products)
            String uploadPath = getServletContext().getRealPath("") + "assets/images/products/";
            //4. Tạo thư mục nếu chưa tồn tại
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String imageDbPath = "/assets/images/products/" + imageFileName;
            Products newProduct = new Products(0, name, price, description, imageDbPath, stock_quantity);
            ProductsBo productsBo = new ProductsBo();
            boolean isAdded = false;
            try {
                isAdded = productsBo.addProduct(newProduct);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (isAdded) {
                // Lưu tệp tin vào thư mục đã chỉ định
                imagePart.write(uploadPath + imageFileName);
                resp.sendRedirect(req.getContextPath() + "/admin/products/");
            }

        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}