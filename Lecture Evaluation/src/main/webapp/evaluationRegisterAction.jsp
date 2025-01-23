<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8");
//Check if user is already logged in
String sessionUserID = null;
if (session.getAttribute("userID") != null) {
	sessionUserID = (String) session.getAttribute("userID");
}

if (sessionUserID == null) {
	try (PrintWriter script = response.getWriter()) {
		script.println("<script>");
		script.println("alert('Please log in.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
	}
	return;
}

// Retrieve user input values
	String lectureName = request.getParameter("lectureName");
    String professorName = request.getParameter("professorName");
    String lectureYearStr = request.getParameter("lectureYear"); // String 
    String evaluationTitle = request.getParameter("evaluationTitle");
    String evaluationContent = request.getParameter("evaluationContent");

// Check for required fields
if (lectureName == null || professorName == null || lectureYearStr == null || evaluationTitle == null || evaluationContent == null
        || lectureName.trim().isEmpty() || professorName.trim().isEmpty()
        || lectureYearStr.trim().isEmpty() || evaluationTitle.trim().isEmpty()
        || evaluationContent.trim().isEmpty()) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('All fields are required!');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
}

int lectureYear;
try {
    lectureYear = Integer.parseInt(lectureYearStr);
} catch (NumberFormatException e) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('Lecture year must be a valid number!');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
}

// Process database insertion
EvaluationDTO evaluationDTO = new EvaluationDTO(0, sessionUserID, lectureName, professorName, lectureYear, evaluationTitle, evaluationContent);
EvaluationDAO evaluationDAO = new EvaluationDAO();

PrintWriter script = response.getWriter();
int result = evaluationDAO.write(evaluationDTO);

if (result == 1) { // Success
    script.println("<script>");
    script.println("alert('Evaluation registered successfully!');");
    script.println("location.href = 'index.jsp';");
    script.println("</script>");
} else {
    script.println("<script>");
    script.println("alert('Failed to register evaluation. Please try again.');");
    script.println("history.back();");
    script.println("</script>");
}
script.close();
%>