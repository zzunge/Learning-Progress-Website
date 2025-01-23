<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8");
//Check if user is already logged in
String sessionUserID = null;
if (session.getAttribute("userID") != null) {
	sessionUserID = (String) session.getAttribute("userID");
}

if (sessionUserID != null) {
	try (PrintWriter script = response.getWriter()) {
		script.println("<script>");
		script.println("alert('You are already logged in.');");
		script.println("location.href = 'index.jsp';");
		script.println("</script>");
	}
	return;
}

// Retrieve user input values
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");
String userEmail = request.getParameter("userEmail");

// Check for required fields
if (userID == null || userPassword == null || userEmail == null || userID.trim().isEmpty()
		|| userPassword.trim().isEmpty() || userEmail.trim().isEmpty()) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('All fields are required!');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
}

// Process database insertion
UserDAO userDAO = new UserDAO();
PrintWriter script = response.getWriter();
int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));

if (result == 1) { // Success
	script.println("<script>");
	script.println("alert('Registration successful!');");
	script.println("location.href='userLogin.jsp';");
	script.println("</script>");
} else if (result == -1) { // Duplicate userID
	script.println("<script>");
	script.println("alert('This userID already exists. Please try another.');");
	script.println("history.back();");
	script.println("</script>");
} else { // Other errors
	script.println("<script>");
	script.println("alert('An unexpected error occurred. Please try again.');");
	script.println("history.back();");
	script.println("</script>");
}
script.close();
%>