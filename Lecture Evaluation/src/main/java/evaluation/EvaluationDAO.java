package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	
	public int write(EvaluationDTO evaluationDTO) {
        String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, evaluationDTO.getUserID()); pstmt.setString(1, escapeInput(evaluationDTO.getUserID()));
            pstmt.setString(2, escapeInput(evaluationDTO.getLectureName()));
            pstmt.setString(3, escapeInput(evaluationDTO.getProfessorName()));
            pstmt.setInt(4, evaluationDTO.getLectureYear());
            pstmt.setString(5, escapeInput(evaluationDTO.getEvaluationTitle()));
            pstmt.setString(6, escapeInput(evaluationDTO.getEvaluationContent()));

            return pstmt.executeUpdate();
 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1; // Database error
    }
	private String escapeInput(String input) {
	    if (input == null) return null;
	    return input.replaceAll("<", "&lt;")
	                .replaceAll(">", "&gt;")
	                .replaceAll("\"", "&quot;")
	                .replaceAll("'", "&#x27;")
	                .replaceAll("&", "&amp;");
	}
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String search, int pageNumber) {
	    ArrayList<EvaluationDTO> evaluationList = new ArrayList<>(); // Null 방지
	    String SQL = "SELECT * FROM EVALUATION WHERE LectureDivide LIKE ? AND evaluationTitle LIKE ? LIMIT ?, 10";
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DatabaseUtil.getConnection();

	        // Null 값 처리
	        if (lectureDivide == null || lectureDivide.isEmpty()) {
	            lectureDivide = "ALL";
	        }
	        if (search == null) {
	            search = "";
	        }

	        // 조건에 따라 SQL 쿼리 변경
	        if ("ALL".equalsIgnoreCase(lectureDivide)) {
	            SQL = "SELECT * FROM EVALUATION WHERE evaluationTitle LIKE ? LIMIT ?, 10";
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, "%" + search + "%");
	            pstmt.setInt(2, (pageNumber - 1) * 10);
	        } else {
	            pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, "%" + lectureDivide + "%");
	            pstmt.setString(2, "%" + search + "%");
	            pstmt.setInt(3, (pageNumber - 1) * 10);
	        }

	        rs = pstmt.executeQuery();

	        // ResultSet에서 데이터 읽기
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
	            evaluationList.add(evaluation);
	        }

	    } catch (SQLException e) {
	        System.out.println("SQL Exception occurred: " + e.getMessage());
	        e.printStackTrace();
	    } catch (Exception e) {
	        System.out.println("An unexpected error occurred: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        // 리소스 해제
	        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	    }

	    return evaluationList;
	}
	
	public int getTotalRecords(String lectureDivide, String search) {
	    String SQL = "SELECT COUNT(*) FROM EVALUATION WHERE LectureDivide LIKE ? AND evaluationTitle LIKE ?";
	    try (Connection conn = DatabaseUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(SQL)) {
	        pstmt.setString(1, "%" + lectureDivide + "%");
	        pstmt.setString(2, "%" + search + "%");
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	public int delete(String evaluationID) {
	    String SQL = "DELETE FROM EVALUATION WHERE evaluationID = ?";
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	        conn = DatabaseUtil.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, Integer.parseInt(evaluationID)); // evaluationID를 Integer로 변환
	        return pstmt.executeUpdate(); // 삭제된 행의 수를 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	    }
	    return -1; // 실패 시 -1 반환
	}

	public String getUserID(String evaluationID) {
	    String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = DatabaseUtil.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, Integer.parseInt(evaluationID)); // evaluationID를 Integer로 변환
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getString(1); // userID 반환
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
	        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
	    }
	    return null; // userID가 없을 경우 null 반환
	}
}