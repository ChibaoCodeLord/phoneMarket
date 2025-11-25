package com.phonemarket.model.bean;

public class Orders {
    private int id;
    private String customer;
    private String product;
    private String status;
    private double amount;

    // Constructor
    public Orders(int id, String customer, String product, String status, double amount) {
        this.id = id;
        this.customer = customer;
        this.product = product;
        this.status = status;
        this.amount = amount;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
