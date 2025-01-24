package util;

import java.sql.Connection;
import java.sql.DriverManager;

// Utility class for database connection management
public class DatabaseUtil {
    
    // Method to establish and return a connection to the database
    public static Connection getConnection() {
        try {
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation"; // Database URL with database name
            String dbID = "root"; // Database username
            String dbPassword = "gPwjd@99"; // Database password
           
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC Driver loaded successfully!"); // Debugging message

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            System.out.println("Database connection established."); // Debugging message
            return conn; // Return the database connection object
            
        } catch (Exception e) {
            System.out.println("Database connection failed!"); // Debugging message for connection failure
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return null; // Return null if the connection fails
    }
}