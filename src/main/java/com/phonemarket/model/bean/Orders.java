package com.phonemarket.model.bean;

import java.util.Date;  // Cho order_date TIMESTAMP

public class Orders {
    private int orderId;  // order_id INT(11)
    private int userId;  // user_id INT(11)
    private Date orderDate;  // order_date TIMESTAMP
    private double totalAmount;  // total_amount DECIMAL(10,2)
    private String shippingAddress;  // shipping_address TEXT
    private String status;  // status ENUM('Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled')

    // THÊM: Fields cho JOIN data
    private String customerName;  // full_name từ users
    private String productNames;  // concat names từ products
    private String productImages;  // concat image_url từ products (comma-separated)

    // Default constructor
    public Orders() {}

    // Full constructor (core fields)
    public Orders(int orderId, int userId, Date orderDate, double totalAmount, String shippingAddress, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = status;
    }

    // Getters & Setters core
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // THÊM: Getters/Setters cho JOIN data
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getProductNames() { return productNames; }
    public void setProductNames(String productNames) { this.productNames = productNames; }

    public String getProductImages() { return productImages; }
    public void setProductImages(String productImages) { this.productImages = productImages; }
}