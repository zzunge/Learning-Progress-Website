<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Class Dashboard</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
</head>
<body>
<%
	// Check if the user is already logged in
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID"); // Retrieve the user ID from the session
	}
	// If the user is logged in, redirect them to the main page
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You are logged in.');"); // Notify the user they are already logged in
		script.println("location.href = 'index.jsp';"); // Redirect to the homepage
		script.println("</script>");
		script.close();
		return; // Stop further execution
	}
%>
	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Class Dashboard</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">Home</a> <!-- Link to the homepage -->
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdownMenuButton" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Member Management
					</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					
<%
	// Show different options depending on whether the user is logged in
	if(userID == null) {
%>
						<li><a class="dropdown-item" href="userLogin.jsp">Login</a></li>
						<li><a class="dropdown-item" href="userJoin.jsp">Sign Up</a></li>
<% 	
	} else {
%>
						<li><a class="dropdown-item" href="userLogout.jsp">Logout</a></li>
					</ul>
<%
	}
%>
				</li>
			</ul>
			
			<!-- Search form -->
			<form action="./index.jsp" method="get" class="d-flex">
				<input type="text" name="search" class="form-control me-2" type="search"
					placeholder="Enter keywords." aria-label="Search"> <!-- Search bar -->
				<button class="btn btn-outline-success" type="submit">Search</button> <!-- Search button -->
			</form>
		</div>
	</nav>

	<!-- Sign Up Page Section -->
	<section class="container mt-5" style="max-width: 400px;">
		<div class="card shadow-lg">
			<div class="card-header bg-primary text-white text-center">
				<h4 class="mb-0">Sign Up</h4> <!-- Form header -->
			</div>
			<div class="card-body">
				<!-- Sign-up form -->
				<form method="post" action="./userRegisterAction.jsp"> <!-- Form submission to userRegisterAction.jsp -->
					<div class="mb-3">
						<label for="userID" class="form-label">User ID</label>
						<input type="text" name="userID" id="userID" class="form-control"
							placeholder="Enter your user ID" required> <!-- Input for user ID -->
					</div>
					<div class="mb-3">
						<label for="userPassword" class="form-label">Password</label>
						<input type="password" name="userPassword" id="userPassword"
							class="form-control" placeholder="Enter your password" required> <!-- Input for password -->
					</div>
					<div class="mb-3">
						<label for="userEmail" class="form-label">Email</label>
						<input type="email" name="userEmail" id="userEmail" class="form-control"
							placeholder="Enter your email" required> <!-- Input for email -->
					</div>
					<div class="d-grid">
						<button type="submit" class="btn btn-primary">Sign Up</button> <!-- Sign-up button -->
					</div>
				</form>
			</div>
			<div class="card-footer text-center text-muted">
				Already have an account? 
				<a href="userLogin.jsp" class="text-primary">Login here</a> <!-- Link to login page -->
			</div>
		</div>
	</section>

	<!-- Footer Section -->
	<footer class="bg-dark text-light py-4 mt-5">
		<div class="container text-center">
			<p class="mb-1">&copy; 2025 Hyejung Choi All Rights Reserved.</p> <!-- Copyright notice -->
			<p class="mb-0">
				<a href="#" class="text-light text-decoration-none mx-2">Privacy Policy</a> | 
				<a href="#" class="text-light text-decoration-none mx-2">Terms of Service</a> | 
				<a href="#" class="text-light text-decoration-none mx-2">Contact Us</a>
			</p>
		</div>
	</footer>
	<!-- Include Bootstrap JavaScript -->
	<script src="./js/bootstrap.bundle.min.js"></script>
</body>
</html>