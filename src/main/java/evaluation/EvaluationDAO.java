package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {

    // Method to write a new evaluation
    public int write(EvaluationDTO evaluationDTO) {
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection(); // Get database connection
            pstmt = conn.prepareStatement(SQL);

            // Set values for the placeholders in the SQL query
            pstmt.setString(1, escapeInput(evaluationDTO.getUserID()));
            pstmt.setString(2, escapeInput(evaluationDTO.getLectureName()));
            pstmt.setString(3, escapeInput(evaluationDTO.getProfessorName()));
            pstmt.setInt(4, evaluationDTO.getLectureYear());
            pstmt.setString(5, escapeInput(evaluationDTO.getEvaluationTitle()));
            pstmt.setString(6, escapeInput(evaluationDTO.getEvaluationContent()));

            return pstmt.executeUpdate(); // Execute the query and return rows affected

        } catch (Exception e) {
            e.printStackTrace(); // Print stack trace for debugging
        } finally {
            // Close resources
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // Return -1 in case of failure
    }

    // Helper method to escape input for security (e.g., to prevent XSS attacks)
    private String escapeInput(String input) {
        if (input == null) return null;
        return input.replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#x27;")
                    .replaceAll("&", "&amp;");
    }

 // Method to retrieve a list of evaluations with pagination
    public ArrayList<EvaluationDTO> getList(String search, int pageNumber) {
        ArrayList<EvaluationDTO> evaluationList = new ArrayList<>();
        String SQL = "SELECT * FROM EVALUATION WHERE evaluationTitle LIKE ? LIMIT ?, 10"; // Query for pagination
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseUtil.getConnection(); // Get a connection from the utility class

            if (search == null) { // Handle null search keyword
                search = "";
            }

            pstmt = conn.prepareStatement(SQL); // Prepare the SQL statement
            pstmt.setString(1, "%" + search + "%"); // Bind search keyword
            pstmt.setInt(2, (pageNumber - 1) * 10); // Calculate the offset for pagination

            rs = pstmt.executeQuery(); // Execute the query

            // Populate the evaluation list from the ResultSet
            while (rs.next()) {
                EvaluationDTO evaluation = new EvaluationDTO(
                    rs.getInt("evaluationID"),
                    rs.getString("userID"),
                    rs.getString("lectureName"),
                    rs.getString("professorName"),
                    rs.getInt("lectureYear"),
                    rs.getString("evaluationTitle"),
                    rs.getString("evaluationContent")
                );
                evaluationList.add(evaluation); // Add each evaluation to the list
            }

        } catch (SQLException e) {
            System.out.println("SQL Exception occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Release resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        return evaluationList; // Return the list of evaluations
    }

    // Method to get the total number of records for pagination
    public int getTotalRecords(String search) {
        String SQL = "SELECT COUNT(*) FROM EVALUATION WHERE evaluationTitle LIKE ?"; // Query to count total records
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            if (search == null) { // Handle null search keyword
                search = "";
            }
            pstmt.setString(1, "%" + search + "%"); // Bind search keyword
            ResultSet rs = pstmt.executeQuery(); // Execute the query
            if (rs.next()) {
                return rs.getInt(1); // Return the total count of records
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // Return 0 in case of failure
    }

    // Method to delete an evaluation by ID
    public int delete(String evaluationID) {
        String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID)); // Convert evaluationID to integer
            return pstmt.executeUpdate(); // Return rows affected
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Release resources
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // Return -1 in case of failure
    }

    // Method to retrieve the userID of an evaluation by evaluationID
    public String getUserID(String evaluationID) {
        String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID)); // Convert evaluationID to integer
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1); // Return the userID
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Release resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return null; // Return null if userID not found
    }
}