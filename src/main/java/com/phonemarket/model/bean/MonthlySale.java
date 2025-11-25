package com.phonemarket.model.bean;

public class MonthlySale {

    private String label;
    private double value;

    // Constructor
    public MonthlySale(String label, double value) {
        this.label = label;
        this.value = value;
    }

    // Getter & Setter cho label
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    // Getter & Setter cho value
    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
}
