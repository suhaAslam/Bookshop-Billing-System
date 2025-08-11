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
    public void addBill(Bill bill) {
        String sql = "INSERT INTO bill (customer_id, item_id, quantity, total_price, bill_date) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Add debug logging
            System.out.println("DAO: Attempting to save bill:");
            System.out.println("DAO: Customer ID: " + bill.getCustomerId());
            System.out.println("DAO: Item ID: " + bill.getItemId());
            System.out.println("DAO: Quantity: " + bill.getQuantity());
            System.out.println("DAO: Total Price: " + bill.getTotalPrice());

            stmt.setInt(1, bill.getCustomerId());
            stmt.setInt(2, bill.getItemId());
            stmt.setInt(3, bill.getQuantity());
            stmt.setBigDecimal(4, bill.getTotalPrice());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("DAO: Rows affected: " + rowsAffected);

            if (rowsAffected > 0) {
                System.out.println("DAO: Bill saved successfully!");
            } else {
                System.out.println("DAO: No rows were inserted!");
            }

        } catch (SQLException e) {
            System.err.println("DAO: SQL Error in addBill: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to save bill", e);
        }
    }

    @Override
    public Bill getBillById(int billId) {
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
            System.err.println("DAO: Error fetching bill by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return bill;
    }

    @Override
    public List<Bill> getAllBills() {
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
            System.out.println("DAO: Retrieved " + bills.size() + " bills from database");
        } catch (SQLException e) {
            System.err.println("DAO: Error fetching all bills: " + e.getMessage());
            e.printStackTrace();
        }
        return bills;
    }

    @Override
    public void deleteBill(int billId) {
        String sql = "DELETE FROM bill WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("DAO: Deleted " + rowsAffected + " bill(s)");
        } catch (SQLException e) {
            System.err.println("DAO: Error deleting bill: " + e.getMessage());
            e.printStackTrace();
        }
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
            System.out.println("DAO: Retrieved " + customers.size() + " customers");
        } catch (SQLException e) {
            System.err.println("DAO: Error fetching customers: " + e.getMessage());
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
            System.out.println("DAO: Retrieved " + items.size() + " items");
        } catch (SQLException e) {
            System.err.println("DAO: Error fetching items: " + e.getMessage());
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
                System.out.println("DAO: Found item: " + item.getName());
            } else {
                System.out.println("DAO: No item found with ID: " + itemId);
            }
        } catch (SQLException e) {
            System.err.println("DAO: Error fetching item by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return item;
    }
}