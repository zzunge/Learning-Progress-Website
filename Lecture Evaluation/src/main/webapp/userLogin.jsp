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
	String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID != null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('You are logged in.');");
	script.println("location.href = 'index.jsp';");
	script.println("</script>");
	script.close();
	return;
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
					<a class="nav-link" href="index.jsp">Home</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdownMenuButton" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						Member Management
					</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					
<%
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
					placeholder="Enter keywords." aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<!-- Login Page Section -->
	<section class="container mt-5" style="max-width: 400px;">
		<div class="card shadow-lg">
			<div class="card-header bg-primary text-white text-center">
				<h4 class="mb-0">Login</h4>
			</div>
			<div class="card-body">
				<form method="post" action="userLoginAction.jsp">
					<div class="mb-3">
						<label for="userID" class="form-label">User ID</label> <input
							type="text" name="userID" id="userID" class="form-control"
							placeholder="Enter your user ID" required>
					</div>
					<div class="mb-3">
						<label for="userPassword" class="form-label">Password</label> <input
							type="password" name="userPassword" id="userPassword"
							class="form-control" placeholder="Enter your password" required>
					</div>
					<div class="d-grid">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
			<div class="card-footer text-center text-muted">
				Do not have account yet? <a href="userJoin.jsp" class="text-primary">Click
					here</a>
			</div>
		</div>
	</section>


	<!-- Footer Section -->
	<footer class="bg-dark text-light py-4 mt-5">
		<div class="container text-center">
			<p class="mb-1">&copy; 2025 Hyejung Choi All Rights Reserved.</p>
			<p class="mb-0">
				<a href="#" class="text-light text-decoration-none mx-2">Privacy
					Policy</a> | <a href="#" class="text-light text-decoration-none mx-2">Terms
					of Service</a> | <a href="#"
					class="text-light text-decoration-none mx-2">Contact Us</a>
			</p>
		</div>
	</footer>
	<!-- Include Bootstrap JavaScript -->
	<script src="./js/bootstrap.bundle.min.js"></script>
</body>
</html>
