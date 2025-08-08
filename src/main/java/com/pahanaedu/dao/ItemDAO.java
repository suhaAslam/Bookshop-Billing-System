package com.pahanaedu.dao;

import com.pahanaedu.model.Item;

import java.util.List;
public interface ItemDAO {
    boolean addItem(Item item);
    boolean updateItem(Item item);
    boolean deleteItem(int itemId);
    Item getItemById(int itemId);
    List<Item> getAllItems();
}
