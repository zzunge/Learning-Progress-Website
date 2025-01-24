<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8"); // Ensure the request is encoded in UTF-8 to handle special characters

// Check if the user is logged in by verifying the session attribute 'userID'
String sessionUserID = null;
if (session.getAttribute("userID") != null) {
	sessionUserID = (String) session.getAttribute("userID"); // Retrieve user ID from the session
}

// Redirect to the login page if the user is not logged in
if (sessionUserID == null) {
	try (PrintWriter script = response.getWriter()) {
		script.println("<script>");
		script.println("alert('Please log in.');"); // Alert the user to log in
		script.println("location.href = 'userLogin.jsp';"); // Redirect to the login page
		script.println("</script>");
	}
	return; // Stop further execution
}

// Retrieve user input values from the form
String lectureName = request.getParameter("lectureName");
String professorName = request.getParameter("professorName");
String lectureYearStr = request.getParameter("lectureYear"); // Lecture year as a string
String evaluationTitle = request.getParameter("evaluationTitle");
String evaluationContent = request.getParameter("evaluationContent");

// Check if all required fields are provided and not empty
if (lectureName == null || professorName == null || lectureYearStr == null || evaluationTitle == null || evaluationContent == null
        || lectureName.trim().isEmpty() || professorName.trim().isEmpty()
        || lectureYearStr.trim().isEmpty() || evaluationTitle.trim().isEmpty()
        || evaluationContent.trim().isEmpty()) {
    // If any field is missing, show an alert and redirect back
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('All fields are required!');"); // Alert for missing fields
    script.println("history.back();"); // Redirect back to the previous page
    script.println("</script>");
    script.close();
    return;
}

// Parse the lecture year to an integer
int lectureYear;
try {
    lectureYear = Integer.parseInt(lectureYearStr); // Convert the string to an integer
} catch (NumberFormatException e) {
    // Handle invalid number format for lecture year
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('Lecture year must be a valid number!');"); // Alert for invalid year
    script.println("history.back();"); // Redirect back to the previous page
    script.println("</script>");
    script.close();
    return;
}

// Create an EvaluationDTO object to encapsulate the evaluation details
EvaluationDTO evaluationDTO = new EvaluationDTO(
    0, // ID will be auto-generated
    sessionUserID, // User ID of the logged-in user
    lectureName, // Lecture name entered by the user
    professorName, // Professor name entered by the user
    lectureYear, // Lecture year parsed as an integer
    evaluationTitle, // Title of the evaluation
    evaluationContent // Content of the evaluation
);

// Instantiate the DAO for database interaction
EvaluationDAO evaluationDAO = new EvaluationDAO();

// Attempt to insert the evaluation into the database
PrintWriter script = response.getWriter();
int result = evaluationDAO.write(evaluationDTO); // Perform the database write operation

// Check the result of the database operation
if (result == 1) { // If insertion is successful
    script.println("<script>");
    script.println("alert('Evaluation registered successfully!');"); // Notify success
    script.println("location.href = 'index.jsp';"); // Redirect to the main page
    script.println("</script>");
} else { // If insertion fails
    script.println("<script>");
    script.println("alert('Failed to register evaluation. Please try again.');"); // Notify failure
    script.println("history.back();"); // Redirect back to the previous page
    script.println("</script>");
}
script.close(); // Close the PrintWriter
%>