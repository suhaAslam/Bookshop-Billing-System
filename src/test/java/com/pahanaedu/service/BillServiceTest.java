package com.pahanaedu.service;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
class BillServiceTest {
    private BillService billService;

    @BeforeEach
    void setUp() {
        billService = new BillService();

    }

    @Test
    void addBill() {
        Bill bill = new Bill();
        bill.setCustomerId(1003);
        bill.setItemId(14);
        bill.setQuantity(5);
        bill.setTotalPrice(new BigDecimal("250.0"));

        boolean result = billService.addBill(bill);
        assertTrue(result, "Bill should be added successfully");
    }

    @Test
    void getBillById() {
        Bill bill = billService.getBillById(92);
        assertNotNull(bill, "Bill should not be null");
    }

    @Test
    void getAllBills() {
        List<Bill> bills = billService.getAllBills();
        assertNotNull(bills, "getAllBills should not return null");
        assertTrue(bills.size() > 0, "There should be at least one bill");
    }

    @Test
    void deleteBill() {
        boolean deleted = billService.deleteBill(93);
        assertTrue(deleted, "Bill should be deleted successfully");
    }

    @Test
    void getCustomers() {
        List<Customer> customers = billService.getCustomers();
        assertNotNull(customers, "Customer list should not be null");
    }

    @Test
    void getItems() {
        List<Item> items = billService.getItems();
        assertNotNull(items, "Item list should not be null");
    }

    @Test
    void getItemById() {
        Item item = billService.getItemById(14);
        assertNotNull(item, "Item should not be null");
    }
  
}