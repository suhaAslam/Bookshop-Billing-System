package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl implements ItemDAO {
    @Override
    public boolean addItem(Item item) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO items VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, item.getItemId());
            ps.setString(2, item.getName());
            ps.setString(3, item.getDescription());
            ps.setDouble(4, item.getPrice());
            ps.setInt(5, item.getQuantityInStock());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public boolean updateItem(Item item) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE items SET name=?, description=?,price=?, quantity_in_stock=? WHERE item_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, item.getName());
            ps.setString(2, item.getDescription());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getQuantityInStock());
            ps.setInt(5,item.getItemId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteItem(int itemId) {
        return false;
    }

    @Override
    public Item getItemById(int itemId) {
        return null;
    }

    @Override
    public List<Item> getAllItems() {
        return List.of();
    }

}
