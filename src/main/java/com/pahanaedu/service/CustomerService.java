package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.model.Customer;

import java.util.List;

public class CustomerService {

    private final CustomerDAO customerDAO = new CustomerDAOImpl();

    public boolean addCustomer(Customer customer) {
        if (isValid(customer)) {
            return customerDAO.addCustomer(customer);
        }
        return false;
    }

    public Customer getCustomerById(int id) {
        return customerDAO.getCustomerById(id);
    }

    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    public boolean updateCustomer(Customer customer) {
        if (isValid(customer)) {
            return customerDAO.updateCustomer(customer);
        }
        return false;
    }

    public boolean deleteCustomer(int id) {
        return customerDAO.deleteCustomer(id);
    }

    private boolean isValid(Customer customer) {
        return customer.getName() != null && !customer.getName().isEmpty()
                && customer.getAddress() != null && !customer.getAddress().isEmpty()
                && customer.getPhoneNumber() != null && customer.getPhoneNumber().matches("\\d{10}")
                && customer.getUnitsConsumed() >= 0;
    }
}
