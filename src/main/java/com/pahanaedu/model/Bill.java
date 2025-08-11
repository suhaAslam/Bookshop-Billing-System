package com.pahanaedu.model;
import java.util.Date;

public class Bill {
    private int billId;
    private int customerId;
    private Date billDate;
    private double totalAmount;

    public Bill() {}

    public Bill(int billId, int customerId, Date billDate, double totalAmount) {
        this.billId = billId;
        this.customerId = customerId;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount;}
}



