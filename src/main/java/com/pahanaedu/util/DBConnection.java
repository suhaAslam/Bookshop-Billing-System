package com.pahanaedu.util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection;

    private DBConnection() {}

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Use server mode to allow multiple connections
                connection = DriverManager.getConnection(
                        "jdbc:mysql://127.0.0.1:3306/login_schema",
                        "root",
                        "suha123"
                );
                System.out.println("✅ Database connection successful!");
            }
        } catch (Exception e) {
            System.err.println("❌ Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
}