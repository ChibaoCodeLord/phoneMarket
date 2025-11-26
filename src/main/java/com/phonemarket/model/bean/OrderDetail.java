package com.phonemarket.model.bean;

public class OrderDetail {
    private int orderDetailId;  // order_detail_id
    private int orderId;  // order_id
    private int productId;  // product_id
    private int quantity;  // quantity
    private double priceAtPurchase;  // price_at_purchase (decimal10,2)

    // Default constructor
    public OrderDetail() {}

    // Full constructor
    public OrderDetail(int orderDetailId, int orderId, int productId, int quantity, double priceAtPurchase) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
    }

    // Getters & Setters
    public int getOrderDetailId() { return orderDetailId; }
    public void setOrderDetailId(int orderDetailId) { this.orderDetailId = orderDetailId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPriceAtPurchase() { return priceAtPurchase; }
    public void setPriceAtPurchase(double priceAtPurchase) { this.priceAtPurchase = priceAtPurchase; }
}