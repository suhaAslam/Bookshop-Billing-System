package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {

    @Override
    public boolean add(Bill bill) {
        String sql = "INSERT INTO bill (customer_id, item_id, quantity, total_price, bill_date) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bill.getCustomerId());
            stmt.setInt(2, bill.getItemId());
            stmt.setInt(3, bill.getQuantity());
            stmt.setBigDecimal(4, bill.getTotalPrice());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Bill getById(int billId) {
        String sql = "SELECT * FROM bill WHERE bill_id = ?";
        Bill bill = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bill = new Bill(
                        rs.getInt("bill_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("item_id"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("total_price"),
                        rs.getTimestamp("bill_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }

    @Override
    public List<Bill> getAll() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bill ORDER BY bill_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                bills.add(new Bill(
                        rs.getInt("bill_id"),
                        rs.getInt("customer_id"),
                        rs.getInt("item_id"),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("total_price"),
                        rs.getTimestamp("bill_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    @Override
    public boolean delete(int billId) {
        String sql = "DELETE FROM bill WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean update(Bill bill) {
        // Not needed for this system
        throw new UnsupportedOperationException("Update operation is not supported for bills.");
    }


    @Override
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                customers.add(new Customer.CustomerBuilder()
                        .setAccountNumber(rs.getInt("account_number"))
                        .setName(rs.getString("name"))
                        .setAddress(rs.getString("address"))
                        .setPhoneNumber(rs.getString("phone_number"))
                        .setUnitsConsumed(rs.getInt("units_consumed"))
                        .build());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    @Override
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                items.add(new Item.Builder()
                        .setItemId(rs.getInt("item_id"))
                        .setName(rs.getString("name"))
                        .setDescription(rs.getString("description"))
                        .setPrice(rs.getDouble("price"))
                        .setQuantityInStock(rs.getInt("quantity_in_stock"))
                        .build());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    @Override
    public Item getItemById(int itemId) {
        Item item = null;
        String sql = "SELECT * FROM items WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                item = new Item.Builder()
                        .setItemId(rs.getInt("item_id"))
                        .setName(rs.getString("name"))
                        .setDescription(rs.getString("description"))
                        .setPrice(rs.getDouble("price"))
                        .setQuantityInStock(rs.getInt("quantity_in_stock"))
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }
}
