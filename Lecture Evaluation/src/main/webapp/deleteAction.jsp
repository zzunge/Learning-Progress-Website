<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("UTF-8");

// Check if user is already logged in
String userID = null;
if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
}

if (userID == null) {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Please log in.');");
        script.println("location.href = 'userLogin.jsp';");
        script.println("</script>");
    }
    return;
}

// Get evaluationID from the request
String evaluationID = request.getParameter("evaluationID");
if (evaluationID == null || evaluationID.trim().isEmpty()) {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Invalid evaluation ID.');");
        script.println("history.back();");
        script.println("</script>");
    }
    return;
}

// Instantiate DAO and perform deletion
EvaluationDAO evaluationDAO = new EvaluationDAO();
String evaluationOwnerID = evaluationDAO.getUserID(evaluationID);

// Debugging logs
System.out.println("Session userID: " + userID);
System.out.println("Evaluation ID: " + evaluationID);
System.out.println("Evaluation owner userID: " + evaluationOwnerID);

// Check if evaluation exists
if (evaluationOwnerID == null) {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('Evaluation does not exist or invalid ID.');");
        script.println("history.back();");
        script.println("</script>");
    }
    return;
}

// Check ownership
if (userID.equals(evaluationOwnerID)) {
    int result = evaluationDAO.delete(evaluationID);
    if (result == 1) {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('Deleted!');");
            script.println("location.href = 'index.jsp';");
            script.println("</script>");
        }
        return;
    } else {
        try (PrintWriter script = response.getWriter()) {
            script.println("<script>");
            script.println("alert('Database Error! Please try again later.');");
            script.println("history.back();");
            script.println("</script>");
        }
        return;
    }
} else {
    try (PrintWriter script = response.getWriter()) {
        script.println("<script>");
        script.println("alert('You can only delete your own posts.');");
        script.println("history.back();");
        script.println("</script>");
    }
    return;
}
%>