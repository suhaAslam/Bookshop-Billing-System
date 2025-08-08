package com.pahanaedu.service;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Item;

import java.util.List;
public class ItemService {
    private final ItemDAO itemDAO;

    public ItemService() {
        this.itemDAO = new ItemDAOImpl();
    }

    public boolean addItem(Item item) {
        // You can add validation here if needed
        return itemDAO.addItem(item);
    }

    public boolean updateItem(Item item) {
        // You can add validation here if needed
        return itemDAO.updateItem(item);
    }

    public boolean deleteItem(int itemId) {
        return itemDAO.deleteItem(itemId);
    }

    public Item getItemById(int itemId) {
        return itemDAO.getItemById(itemId);
    }

    public List<Item> getAllItems() {
        return itemDAO.getAllItems();
    }
}
