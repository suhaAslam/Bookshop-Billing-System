package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.util.DBConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BillDAOImplTest {

    private BillDAOImpl billDAO;

    @BeforeEach
    void setUp() throws Exception {
        billDAO = new BillDAOImpl();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // Clean tables
            stmt.executeUpdate("DELETE FROM bill");
            stmt.executeUpdate("DELETE FROM customers");
            stmt.executeUpdate("DELETE FROM items");

            // Insert test customer
            stmt.executeUpdate("""
            INSERT INTO customers (account_number, name, address, phone_number, units_consumed)
            VALUES (1, 'John Doe', '123 Main St', '1234567890', 100)
        """);

            // Insert test item
            stmt.executeUpdate("""
            INSERT INTO items (item_id, name, description, price, quantity_in_stock)
            VALUES (1, 'Item A', 'Test description', 10.00, 50)
        """);
        }
    }

    @Test
    void testAddAndGetBillById() {
        Bill bill = new Bill(0, 1, 1, 2, new BigDecimal("20.00"), null);
        boolean added = billDAO.add(bill);
        assertTrue(added);

        List<Bill> allBills = billDAO.getAll();
        assertEquals(1, allBills.size());

        Bill retrieved = billDAO.getById(allBills.get(0).getBillId());
        assertNotNull(retrieved);
        assertEquals(1, retrieved.getCustomerId());
        assertEquals(1, retrieved.getItemId());
        assertEquals(2, retrieved.getQuantity());
        assertEquals(new BigDecimal("20.00"), retrieved.getTotalPrice());
    }

    @Test
    void testDeleteBill() {
        Bill bill = new Bill(0, 1, 1, 1, new BigDecimal("10.00"), new Timestamp(System.currentTimeMillis()));
        billDAO.add(bill);

        int billId = billDAO.getAll().get(0).getBillId();
        assertTrue(billDAO.delete(billId));
        assertNull(billDAO.getById(billId));
    }

    @Test
    void testGetAllCustomers() {
        List<Customer> customers = billDAO.getAllCustomers();
        assertFalse(customers.isEmpty());
        assertEquals("John Doe", customers.get(0).getName());
    }

    @Test
    void testGetAllItems() {
        List<Item> items = billDAO.getAllItems();
        assertFalse(items.isEmpty());
        assertEquals("Item A", items.get(0).getName());
    }

    @Test
    void testGetItemById() {
        Item item = billDAO.getItemById(1);
        assertNotNull(item);
        assertEquals("Item A", item.getName());
    }
}
