package com.pahanaedu.service;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.model.customer;

import java.util.List;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAOImpl();

    public boolean addCustomer(customer cust) {
        if (validateCustomer(cust)) {
            return customerDAO.addCustomer(cust);
        }
        return false;
    }

    public boolean updateCustomer(customer cust) {
        if (validateCustomer(cust)) {
            return customerDAO.updateCustomer(cust);
        }
        return false;
    }

    public boolean deleteCustomer(int id) {
        return customerDAO.deleteCustomer(id);
    }

    public customer getCustomerById(int id) {
        return customerDAO.getCustomerById(id);
    }

    public List<customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    private boolean validateCustomer(customer cust) {
        return cust.getName() != null && !cust.getName().isEmpty() &&
                cust.getPhone() != null && cust.getPhone().matches("\\d{10}");
    }
}
