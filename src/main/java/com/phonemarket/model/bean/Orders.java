package com.phonemarket.model.bean;

import java.util.Date;

public class Orders {

    // CORE FIELDS (từ bảng orders)
    private int orderId;
    private int userId;
    private Date orderDate;
    private double totalAmount;
    private String shippingAddress;
    private String status;

    // JOIN FIELDS (từ users, products, order_details)
    private String customerName;   // full_name từ users
    private String customerEmail;  // email từ users
    private String customerPhone;  // phone_number từ users

    private String productNames;   // tên sản phẩm (GROUP_CONCAT)
    private String productImages;  // ảnh sản phẩm (GROUP_CONCAT)
    private String detailItems;    // quantity x price (GROUP_CONCAT)

    // Default constructor
    public Orders() {}

    // Core constructor
    public Orders(int orderId, int userId, Date orderDate, double totalAmount, String shippingAddress, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = status;
    }

    // --- GETTERS & SETTERS (CORE) ---
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

    // --- JOIN: CUSTOMER INFO ---
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    // --- JOIN: PRODUCTS ---
    public String getProductNames() { return productNames; }
    public void setProductNames(String productNames) { this.productNames = productNames; }

    public String getProductImages() { return productImages; }
    public void setProductImages(String productImages) { this.productImages = productImages; }

    // --- JOIN: ORDER DETAIL ITEMS ---
    public String getDetailItems() { return detailItems; }
    public void setDetailItems(String detailItems) { this.detailItems = detailItems; }
}
