package com.pahanaedu.dao;
import com.pahanaedu.model.customer;
import com.pahanaedu.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class CustomerDAOImpl implements CustomerDAO {
    @Override
    public boolean addCustomer(customer customer) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO customers VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customer.getAccountNumber());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getPhoneNumber());
            ps.setInt(5, customer.getUnitsConsumed());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public customer getCustomerById(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE account_number = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new customer.CustomerBuilder()
                        .setAccountNumber(rs.getInt(1))
                        .setName(rs.getString(2))
                        .setAddress(rs.getString(3))
                        .setPhoneNumber(rs.getString(4))
                        .setUnitsConsumed(rs.getInt(5))
                        .build();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<customer> getAllCustomers() {
        List<customer> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customer c = new customer.CustomerBuilder()
                        .setAccountNumber(rs.getInt(1))
                        .setName(rs.getString(2))
                        .setAddress(rs.getString(3))
                        .setPhoneNumber(rs.getString(4))
                        .setUnitsConsumed(rs.getInt(5))
                        .build();
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateCustomer(customer customer) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE customers SET name=?, address=?, phone_number=?, units_consumed=? WHERE account_number=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhoneNumber());
            ps.setInt(4, customer.getUnitsConsumed());
            ps.setInt(5, customer.getAccountNumber());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteCustomer(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM customers WHERE account_number = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
}
