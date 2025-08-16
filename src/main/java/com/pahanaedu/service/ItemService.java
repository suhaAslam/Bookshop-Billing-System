package com.pahanaedu.service;

import com.pahanaedu.dao.ItemDAOImpl;
import com.pahanaedu.model.Item;

public class ItemService extends GenericService<Item> {

    public ItemService() {
        super(new ItemDAOImpl());
    }

    public boolean addItem(Item item) {
        if (isValid(item)) {
            return super.addEntity(item);
        }
        return false;
    }

    public boolean updateItem(Item item) {
        if (isValid(item)) {
            return super.updateEntity(item);
        }
        return false;
    }

    public boolean deleteItem(int itemId) {
        return super.deleteEntity(itemId);
    }

    public Item getItemById(int itemId) {
        return super.getEntityById(itemId);
    }

    // This method name stays the same to maintain compatibility with ItemServlet
    public java.util.List<Item> getAllItems() {
        return super.getAllEntities();
    }

    private boolean isValid(Item item) {
        return item.getName() != null && !item.getName().trim().isEmpty()
                && item.getDescription() != null && !item.getDescription().trim().isEmpty()
                && item.getPrice() > 0
                && item.getQuantityInStock() >= 0;
    }
}