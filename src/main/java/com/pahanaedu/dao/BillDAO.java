package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import java.util.List;

public interface BillDAO {
    void addBill(Bill bill);
    Bill getBillById(int billId);
    List<Bill> getAllBills();
    void deleteBill(int billId);

    // For dropdowns
    List<Customer> getAllCustomers();
    List<Item> getAllItems();
    Item getItemById(int itemId);
}
