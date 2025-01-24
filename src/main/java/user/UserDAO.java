package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {

    // Method to handle user login
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection(); // Establish a database connection
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // Set the userID parameter
            rs = pstmt.executeQuery();

            if (rs.next()) { // If the user exists
                if (rs.getString(1).equals(userPassword)) { // Validate the password
                    return 1; // Login successful
                } else {
                    return 0; // Wrong password
                }
            }
            return -1; // Non-existent userID
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -2; // Database error
    }

    // Method to handle user registration
    public int join(UserDTO user) {
        String SQL = "INSERT INTO USER (userID, userPassword, userEmail, userEmailHash, userEmailChecked) VALUES (?, ?, ?, ?, false)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection(); // Establish a database connection

            if (conn == null) { // Check for a null connection
                System.out.println("Database connection is null!");
                return -2; // Return -2 if connection fails
            }

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserEmailHash());
            return pstmt.executeUpdate(); // Return the number of rows affected

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // Return -1 for other errors
    }

    // Method to retrieve a user's email based on their userID
    public String getUserEmail(String userID) {
        String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection(); // Establish a database connection
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // Set the userID parameter
            rs = pstmt.executeQuery();

            if (rs.next()) { // If a result is found
                return rs.getString(1); // Return the user's email
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return null; // Return null if an error occurs
    }

    // Method to check if a user's email is verified
    public boolean getUserEmailChecked(String userID) {
        String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection(); // Establish a database connection
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // Set the userID parameter
            rs = pstmt.executeQuery();

            if (rs.next()) { // If a result is found
                return rs.getBoolean(1); // Return the email verification status
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return false; // Return false if an error occurs
    }

    // Method to mark a user's email as verified
    public boolean setUseremailChecked(String userID) {
        String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection(); // Establish a database connection
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID); // Set the userID parameter
            pstmt.executeUpdate(); // Update the user's email verification status
            return true; // Return true if the update is successful
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return false; // Return false if an error occurs
    }
}