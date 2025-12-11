package com.phonemarket.model.bo;

import com.phonemarket.model.bean.Products;
import com.phonemarket.model.dao.ProductsDao;

import java.sql.SQLException;
import java.util.List;

public class ProductsBo {
    private final ProductsDao productsDao;

    public ProductsBo() {
        this.productsDao = new ProductsDao();
    }

    // Lấy tất cả sản phẩm
    public List<Products> getAllProducts() throws SQLException {
        System.out.println("DEBUG BO - Calling DAO findAll()");  // Log gọi DAO
        List<Products> list = productsDao.findAll();
        System.out.println("DEBUG BO - DAO returned " + (list != null ? list.size() : 0) + " products");  // Log size
        return list;
    }

    // Lấy sản phẩm theo ID
    public Products getProductById(int id) throws SQLException {
        return productsDao.getProductById(id);
    }

    // Thêm sản phẩm mới
    public boolean addProduct(Products product) throws SQLException {
        // Kiểm tra validation trước khi thêm
        if (product == null || product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() <= 0) {
            return false;
        }
        return productsDao.addProduct(product);
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Products product) throws SQLException {
        if (product == null || product.getId() <= 0) {
            return false;
        }
        return productsDao.update(product);
    }

    // Xóa sản phẩm
    public boolean deleteProduct(int id) throws SQLException {
        if (id <= 0) {
            return false;
        }
        return productsDao.delete(id);
    }

    // Tìm kiếm sản phẩm theo tên
    public List<Products> searchProductsByName(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productsDao.searchProductsByName(keyword);
    }
}
