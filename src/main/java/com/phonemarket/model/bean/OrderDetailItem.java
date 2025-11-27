package com.phonemarket.model.bean;

public class OrderDetailItem {
    private int orderDetailId;
    private int productId;
    private int quantity;
    private double priceAtPurchase;
    private String productName;
    private String productImage;

    public OrderDetailItem(int orderDetailId, int productId, int quantity, double priceAtPurchase,
                           String productName, String productImage) {
        this.orderDetailId = orderDetailId;
        this.productId = productId;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
        this.productName = productName;
        this.productImage = productImage;
    }

    public int getOrderDetailId() { return orderDetailId; }
    public int getProductId() { return productId; }
    public int getQuantity() { return quantity; }
    public double getPriceAtPurchase() { return priceAtPurchase; }
    public String getProductName() { return productName; }
    public String getProductImage() { return productImage; }
}
