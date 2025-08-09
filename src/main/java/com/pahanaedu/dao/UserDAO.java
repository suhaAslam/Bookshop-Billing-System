package com.pahanaedu.dao;
import com.pahanaedu.model.User;
import com.pahanaedu.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    public boolean validateUser(User user) {
        boolean valid = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            System.out.println("Username: " + user.getUsername());
            System.out.println("Hashed Password (already hashed): " + user.getPassword());

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("✅ User found!");
                valid = true;
            } else {
                System.out.println("❌ No user found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return valid;
    }
}