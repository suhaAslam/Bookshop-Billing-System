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
        return itemDAO.add(item);
    }

    public boolean updateItem(Item item) {
        return itemDAO.update(item);
    }

    public boolean deleteItem(int itemId) {
        return itemDAO.delete(itemId);
    }

    public Item getItemById(int itemId) {
        return itemDAO.getById(itemId);
    }

    public List<Item> getAllItems() {
        return itemDAO.getAll();
    }
}
