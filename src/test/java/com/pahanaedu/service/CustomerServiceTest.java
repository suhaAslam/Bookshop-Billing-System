package com.pahanaedu.service;

import com.pahanaedu.model.Customer;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
class CustomerServiceTest {

    private CustomerService customerService;

    @BeforeEach
    void setUp() {
        customerService = new CustomerService();
    }


    @Test
    void addCustomer() {
        Customer validCustomer = new Customer.CustomerBuilder()
                .setAccountNumber(1005)
                .setName("John Doe")
                .setAddress("123 Main Street")
                .setPhoneNumber("1234567890")
                .setUnitsConsumed(150)
                .build();

        assertDoesNotThrow(() -> customerService.addCustomer(validCustomer));

    }

    @Test
    void updateCustomer() {
        // Test with valid customer
        Customer validCustomer = new Customer.CustomerBuilder()
                .setAccountNumber(1003)
                .setName("Jane Smith")
                .setAddress("456 Update Street")
                .setPhoneNumber("0987654321")
                .setUnitsConsumed(250)
                .build();

        // Should not throw exception for valid customer
        assertDoesNotThrow(() -> customerService.updateCustomer(validCustomer));
    }
}