package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAOImpl;
import com.pahanaedu.model.Customer;

public class CustomerService extends GenericService<Customer> {

    public CustomerService() {
        super(new CustomerDAOImpl());
    }

    public boolean addCustomer(Customer customer) {
        if (isValid(customer)) {
            return super.addEntity(customer);
        }
        return false;
    }

    public boolean updateCustomer(Customer customer) {
        if (isValid(customer)) {
            return super.updateEntity(customer);
        }
        return false;
    }

    private boolean isValid(Customer customer) {
        return customer.getName() != null && !customer.getName().isEmpty()
                && customer.getAddress() != null && !customer.getAddress().isEmpty()
                && customer.getPhoneNumber() != null && customer.getPhoneNumber().matches("\\d{10}")
                && customer.getUnitsConsumed() >= 0;
    }
}
