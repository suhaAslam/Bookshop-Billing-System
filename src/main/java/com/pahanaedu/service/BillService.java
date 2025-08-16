package com.pahanaedu.service;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import java.util.List;

public class BillService {

    private final GenericService<Bill> genericService;
    private final BillDAO billDAO;  // Keep this for extra Bill-specific methods

    public BillService() {
        this.billDAO = new BillDAOImpl();
        this.genericService = new GenericService<>(billDAO);
    }


    public boolean addBill(Bill bill) {
        return genericService.addEntity(bill);
    }

    public Bill getBillById(int id) {
        return genericService.getEntityById(id);
    }

    public List<Bill> getAllBills() {
        return genericService.getAllEntities();
    }


    public boolean deleteBill(int id) {
        return genericService.deleteEntity(id);
    }

    public List<Customer> getCustomers() {
        return billDAO.getAllCustomers();
    }

    public List<Item> getItems() {
        return billDAO.getAllItems();
    }

    public Item getItemById(int itemId) {
        return billDAO.getItemById(itemId);
    }
}
