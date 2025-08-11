package com.pahanaedu.service;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import java.util.List;

public class BillService {
    private BillDAO billDAO = new BillDAOImpl();

    public void createBill(Bill bill) {
        billDAO.addBill(bill);
    }

    public List<Bill> getAllBills() {
        return billDAO.getAllBills();
    }

    public void deleteBill(int billId) {
        billDAO.deleteBill(billId);
    }

    public List<Customer> getCustomers() {
        return billDAO.getAllCustomers();
    }

    public List<Item> getItems() {
        return billDAO.getAllItems();
    }

    public Item getItemById(int itemId) {
        return billDAO.getItemById(itemId);
    }
}
