package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
    
    public static Connection getConnection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";
            String dbID = "root";
            String dbPassword = "gPwjd@99";
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC Driver loaded successfully!");
            
            Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
            System.out.println("Database connection established.");
            return conn;
            
        } catch (Exception e) {
        	System.out.println("Database connection failed!");
        	e.printStackTrace();
        }
        return null;
    }
}


