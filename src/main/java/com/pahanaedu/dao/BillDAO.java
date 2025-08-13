package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import java.util.List;

public interface BillDAO extends GenericDAO<Bill>{

    // For dropdowns
    List<Customer> getAllCustomers();
    List<Item> getAllItems();
    Item getItemById(int itemId);
}
