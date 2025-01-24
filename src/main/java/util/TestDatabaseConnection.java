package util;

import java.sql.Connection;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        try {
            
            Connection conn = DatabaseUtil.getConnection();
            if (conn != null) {
                System.out.println("Database connection test successful!");
                conn.close(); 
            } else {
                System.out.println("Failed to connect to the database.");
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }
    }
}