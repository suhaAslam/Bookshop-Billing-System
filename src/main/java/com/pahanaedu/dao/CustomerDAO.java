package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import java.util.List;

public interface CustomerDAO {
    boolean addCustomer(Customer customer);
    Customer getCustomerById(int id);
    List<Customer> getAllCustomers();
    boolean updateCustomer(Customer customer);
    boolean deleteCustomer(int id);
}
