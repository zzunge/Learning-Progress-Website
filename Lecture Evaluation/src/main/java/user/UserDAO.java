package user;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class UserDAO {
    
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // login success
                } else {
                    return 0; // wrong password
                }
            }
            return -1; // Non-exist ID
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -2; // Database error
    }
    
    public int join(UserDTO user) {
        String SQL = "INSERT INTO USER (userID, userPassword, userEmail, userEmailHash, userEmailChecked) VALUES (?, ?, ?, ?, false)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection();
            if (conn == null) {
                System.out.println("Database connection is null!"); // 디버깅 메시지
                return -2; // Database connection error
            }

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserEmailHash());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // Other errors
    }
    
    public String getUserEmail(String userID) {
    	 String SQL = "SELECT userEmail FROM USER WHERE userID = ?";
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         try {
         	conn = DatabaseUtil.getConnection();
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, userID);
             rs = pstmt.executeQuery();
             if (rs.next()) {
             	return rs.getString(1);
             }
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
             try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
             try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
             try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
         }
         return null; // Database error
    }
    
    public boolean getUserEmailChecked(String userID) {
        String SQL = "SELECT userEmailChecked FROM USER WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	return rs.getBoolean(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return false; // Database error
    }
    
    public boolean setUseremailChecked(String userID) {
        String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return false; // Database error
    }
    
}