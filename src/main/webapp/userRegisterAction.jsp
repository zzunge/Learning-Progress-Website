<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8"); // Ensure UTF-8 encoding for handling special characters

// Check if the user is already logged in
String sessionUserID = null;
if (session.getAttribute("userID") != null) {
	sessionUserID = (String) session.getAttribute("userID");
}

// Redirect logged-in users trying to access the registration page
if (sessionUserID != null) {
	try (PrintWriter script = response.getWriter()) {
		script.println("<script>");
		script.println("alert('You are already logged in.');"); // Notify that the user is already logged in
		script.println("location.href = 'index.jsp';"); // Redirect to the main page
		script.println("</script>");
	}
	return; // Stop further execution
}

// Retrieve user input values from the form
String userID = request.getParameter("userID"); // User ID entered by the user
String userPassword = request.getParameter("userPassword"); // Password entered by the user
String userEmail = request.getParameter("userEmail"); // Email entered by the user

// Check if all required fields are provided
if (userID == null || userPassword == null || userEmail == null || userID.trim().isEmpty()
		|| userPassword.trim().isEmpty() || userEmail.trim().isEmpty()) {
	// Alert the user and redirect back if any field is missing
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('All fields are required!');"); // Notify the user
	script.println("history.back();"); // Redirect back to the previous page
	script.println("</script>");
	script.close();
	return;
}

// Process the registration by interacting with the database
UserDAO userDAO = new UserDAO(); // DAO to handle database operations
PrintWriter script = response.getWriter();

// Call the `join` method to attempt user registration
int result = userDAO.join(new UserDTO(
	userID, 
	userPassword, 
	userEmail, 
	SHA256.getSHA256(userEmail), // Use SHA-256 hash for secure processing of email (e.g., for verification)
	false // Default value for isAdmin
));

// Handle the result of the registration attempt
if (result == 1) { // Registration successful
	script.println("<script>");
	script.println("alert('Registration successful!');"); // Notify success
	script.println("location.href='userLogin.jsp';"); // Redirect to the login page
	script.println("</script>");
} else if (result == -1) { // Duplicate userID
	script.println("<script>");
	script.println("alert('This userID already exists. Please try another.');"); // Notify duplicate ID
	script.println("history.back();"); // Redirect back to the registration form
	script.println("</script>");
} else { // Other errors
	script.println("<script>");
	script.println("alert('An unexpected error occurred. Please try again.');"); // Notify general error
	script.println("history.back();"); // Redirect back to the registration form
	script.println("</script>");
}
script.close(); // Close the PrintWriter
%>