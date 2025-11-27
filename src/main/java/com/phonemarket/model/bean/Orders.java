package com.phonemarket.model.bean;

import java.util.Date;
import java.util.List;

public class Orders {


    private int orderId;
    private int userId;
    private Date orderDate;
    private double totalAmount;
    private String shippingAddress;
    private String status;


    private String customerName;
    private String customerEmail;
    private String customerPhone;


    private String productNames;
    private String productImages;
    private String detailItems;


    private List<OrderDetailItem> orderDetails;


    public Orders() {}


    public Orders(int orderId, int userId, Date orderDate, double totalAmount,
                  String shippingAddress, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = status;
    }


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


    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    // --- PRODUCT CONCAT FIELDS (LIST PAGE) ---
    public String getProductNames() { return productNames; }
    public void setProductNames(String productNames) { this.productNames = productNames; }

    public String getProductImages() { return productImages; }
    public void setProductImages(String productImages) { this.productImages = productImages; }

    public String getDetailItems() { return detailItems; }
    public void setDetailItems(String detailItems) { this.detailItems = detailItems; }


    public List<OrderDetailItem> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetailItem> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
