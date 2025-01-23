<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
    request.setCharacterEncoding("UTF-8");

    // Retrieve user input values
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
   
    System.out.println("Login Attempt - UserID: " + userID);
    
    // Check for required fields
   	if (userID == null || userPassword == null || 
        userID.trim().isEmpty() || userPassword.trim().isEmpty()) {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('All fields are required!');");
            script.println("history.back();");
            script.println("</script>");
        }
        return;
    }


 // Process database login
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(userID, userPassword);

    // Debugging log for result
    System.out.println("Login Result - UserID: " + userID + ", Result: " + result);

    try (PrintWriter script = response.getWriter()) {
        if (result == 1) { // Success
            session.setAttribute("userID", userID);
        	script.println("<script>");
            script.println("alert('Login successful!');");
            script.println("location.href='index.jsp';");
            script.println("</script>");
            script.close();
            return;
        } else if (result == 0) { // Wrong password
            script.println("<script>");
            script.println("alert('Wrong Password!');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        } else if (result == -1) { // Non-existent userID
            script.println("<script>");
            script.println("alert('Non-existent ID');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        } else if (result == -2) { // Database error
            script.println("<script>");
            script.println("alert('Database Error');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        } else { // Unexpected error
            script.println("<script>");
            script.println("alert('Unexpected error occurred. Please try again.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }
    }
%>