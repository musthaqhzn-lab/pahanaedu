package com.icbt.model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int accountNumber;
    private double totalAmount;
    private Date billDate;
    private List<BillItem> billItems;

    public Bill(int billId, int accountNumber, double totalAmount, Date billDate, List<BillItem> billItems) {
        this.billId = billId;
        this.accountNumber = accountNumber;
        this.totalAmount = totalAmount;
        this.billDate = billDate;
        this.billItems = billItems;
    }

    public Bill(){}


    public List<BillItem> getBillItems() {
        return billItems;
    }

    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }
    public void setBillId(int billId) {
        this.billId = billId;
    }



    public int getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getBillDate() {
        return billDate;
    }
    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }
}
