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

@WebServlet("/admin/products/add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class addProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/admin/products/addProducts.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
            req.setAttribute("success", "Thêm sản phẩm thành công.");
            resp.sendRedirect(req.getContextPath() + "/admin/products/");
        }
        else {
            req.setAttribute("error", "Thêm sản phẩm thất bại. Vui lòng kiểm tra lại dữ liệu.");
            req.getRequestDispatcher("/jsp/admin/products/addProducts.jsp").forward(req, resp);
        }
    }
}