<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
    request.setCharacterEncoding("UTF-8"); // Set request character encoding to UTF-8 to handle special characters

    // Retrieve user input values from the login form
    String userID = request.getParameter("userID"); // Get the user ID
    String userPassword = request.getParameter("userPassword"); // Get the user password
   
    // Debugging log to track login attempts
    System.out.println("Login Attempt - UserID: " + userID);
    
    // Check if the required fields are provided
    if (userID == null || userPassword == null || 
        userID.trim().isEmpty() || userPassword.trim().isEmpty()) {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('All fields are required!');"); // Alert for missing fields
            script.println("history.back();"); // Redirect back to the login page
            script.println("</script>");
        }
        return; // Stop further execution
    }

    // Instantiate the DAO to handle database operations
    UserDAO userDAO = new UserDAO();

    // Perform login validation by calling the DAO's login method
    int result = userDAO.login(userID, userPassword);

    // Debugging log to track the result of the login operation
    System.out.println("Login Result - UserID: " + userID + ", Result: " + result);

    // Handle the result of the login attempt
    try (PrintWriter script = response.getWriter()) {
        if (result == 1) { // Login successful
            session.setAttribute("userID", userID); // Store the user ID in the session
            script.println("<script>");
            script.println("alert('Login successful!');"); // Notify success
            script.println("location.href='index.jsp';"); // Redirect to the main page
            script.println("</script>");
            return; // Stop further execution
        } else if (result == 0) { // Incorrect password
            script.println("<script>");
            script.println("alert('Wrong Password!');"); // Notify the user of a wrong password
            script.println("history.back();"); // Redirect back to the login page
            script.println("</script>");
            return; // Stop further execution
        } else if (result == -1) { // Non-existent user ID
            script.println("<script>");
            script.println("alert('Non-existent ID');"); // Notify the user that the ID doesn't exist
            script.println("history.back();"); // Redirect back to the login page
            script.println("</script>");
            return; // Stop further execution
        } else if (result == -2) { // Database error
            script.println("<script>");
            script.println("alert('Database Error');"); // Notify the user of a database error
            script.println("history.back();"); // Redirect back to the login page
            script.println("</script>");
            return; // Stop further execution
        } else { // Unexpected error
            script.println("<script>");
            script.println("alert('Unexpected error occurred. Please try again.');"); // Notify the user of an unexpected error
            script.println("history.back();"); // Redirect back to the login page
            script.println("</script>");
            return; // Stop further execution
        }
    }
%>