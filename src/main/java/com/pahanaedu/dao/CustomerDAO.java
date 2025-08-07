package com.pahanaedu.dao;
import com.pahanaedu.model.customer;
import java.util.List;

public interface CustomerDAO {
    boolean addCustomer(customer customer);
    customer getCustomerById(int id);
    List<customer> getAllCustomers();
    boolean updateCustomer(customer customer);
    boolean deleteCustomer(int id);
}
