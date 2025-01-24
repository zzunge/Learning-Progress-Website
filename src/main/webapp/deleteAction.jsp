<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8"); // Ensure request parameters are processed in UTF-8

// Check if the user is logged in by verifying the 'userID' in the session
String userID = null;
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID"); // Retrieve user ID from session
}

// If the user is not logged in, redirect them to the login page
if (userID == null) {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Please log in.');"); // Alert the user to log in
        script.println("location.href = 'userLogin.jsp';"); // Redirect to login page
        script.println("</script>");
    }
    return; // Stop further execution
}

// Get the evaluation ID from the request parameters
String evaluationID = request.getParameter("evaluationID");
if (evaluationID == null || evaluationID.trim().isEmpty()) { // Validate if the evaluation ID is provided
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Invalid evaluation ID.');"); // Alert for missing or invalid ID
        script.println("history.back();"); // Redirect the user back to the previous page
        script.println("</script>");
    }
    return;
}

// Instantiate the DAO to interact with the database
EvaluationDAO evaluationDAO = new EvaluationDAO();
String evaluationOwnerID = evaluationDAO.getUserID(evaluationID); // Get the user ID of the evaluation's owner

// Debugging logs for server-side monitoring (optional, for development purposes)
System.out.println("Session userID: " + userID);
System.out.println("Evaluation ID: " + evaluationID);
System.out.println("Evaluation owner userID: " + evaluationOwnerID);

// Check if the evaluation exists in the database
if (evaluationOwnerID == null) {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Evaluation does not exist or invalid ID.');"); // Alert for non-existent evaluation
        script.println("history.back();"); // Redirect the user back
        script.println("</script>");
    }
    return;
}

// Verify if the logged-in user is the owner of the evaluation
if (userID.equals(evaluationOwnerID)) {
    // Perform the deletion operation
    int result = evaluationDAO.delete(evaluationID); // Delete the evaluation from the database
    if (result == 1) { // Check if deletion was successful
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('Deleted!');"); // Notify successful deletion
            script.println("location.href = 'index.jsp';"); // Redirect to the main page
            script.println("</script>");
        }
        return;
    } else { // Handle database-related errors
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('Database Error! Please try again later.');"); // Alert for database failure
            script.println("history.back();"); // Redirect the user back
            script.println("</script>");
        }
        return;
    }
} else {
    // If the logged-in user is not the owner, deny the deletion
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('You can only delete your own posts.');"); // Alert for ownership mismatch
        script.println("history.back();"); // Redirect the user back
        script.println("</script>");
    }
    return;
}
%>