package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class CustomerDAOImplTest {
    private static CustomerDAOImpl customerDAO;

    @BeforeAll
    static void setup() {
        customerDAO = new CustomerDAOImpl();
    }

    @BeforeEach
    void cleanDB() throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM customers")) {
            ps.executeUpdate();
        }
    }

    private Customer createSampleCustomer(int accountNo) {
        return new Customer.CustomerBuilder()
                .setAccountNumber(accountNo)
                .setName("John Doe")
                .setAddress("123 Main St")
                .setPhoneNumber("0123456789")
                .setUnitsConsumed(50)
                .build();
    }

    @Test
    @Order(1)
    void testAddCustomer() {
        Customer customer = createSampleCustomer(1);
        boolean result = customerDAO.add(customer);
        assertTrue(result, "Customer should be added successfully");
    }

    @Test
    @Order(2)
    void testGetById() {
        Customer customer = createSampleCustomer(2);
        customerDAO.add(customer);

        Customer retrieved = customerDAO.getById(2);
        assertNotNull(retrieved, "Customer should be found");
        assertEquals("John Doe", retrieved.getName());
    }

    @Test
    @Order(3)
    void testGetAllCustomers() {
        customerDAO.add(createSampleCustomer(3));
        customerDAO.add(createSampleCustomer(4));

        List<Customer> customers = customerDAO.getAll();
        assertEquals(2, customers.size(), "Should retrieve all inserted customers");
    }

    @Test
    @Order(4)
    void testUpdateCustomer() {
        Customer customer = createSampleCustomer(5);
        customerDAO.add(customer);

        // Update name
        Customer updated = new Customer.CustomerBuilder()
                .setAccountNumber(5)
                .setName("Jane Smith")
                .setAddress("456 Park Ave")
                .setPhoneNumber("0987654321")
                .setUnitsConsumed(100)
                .build();

        boolean updatedResult = customerDAO.update(updated);
        assertTrue(updatedResult, "Customer should be updated");

        Customer retrieved = customerDAO.getById(5);
        assertEquals("Jane Smith", retrieved.getName(), "Name should be updated");
    }

    @Test
    @Order(5)
    void testDeleteCustomer() {
        customerDAO.add(createSampleCustomer(6));
        boolean deleted = customerDAO.delete(6);
        assertTrue(deleted, "Customer should be deleted");

        Customer retrieved = customerDAO.getById(6);
        assertNull(retrieved, "Deleted customer should not be found");
    }
}