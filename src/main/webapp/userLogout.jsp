<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    // Invalidate the session to log the user out
    if (session != null) {
        session.invalidate(); // Removes all session attributes
    }
%>
<script>
    alert('You have been logged out successfully.'); // Notify the user
    location.href = 'index.jsp'; // Redirect to the homepage
</script>