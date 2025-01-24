<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
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
	// Handle request parameters and ensure UTF-8 encoding
	request.setCharacterEncoding("UTF-8");

	// Retrieve and handle 'lectureDivide' parameter; default to "ALL" if not provided
	String lectureDivide = request.getParameter("lectureDivide") != null ? request.getParameter("lectureDivide") : "ALL";

	// Retrieve and handle 'search' parameter; default to an empty string if not provided
	String search = request.getParameter("search") != null ? request.getParameter("search") : "";

	// Initialize pageNumber to 1, and parse it from the request parameter if provided
	int pageNumber = 1;
	try {
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	} catch (NumberFormatException e) {
		System.out.println("Invalid pageNumber: " + e.getMessage()); // Log invalid pageNumber format
	}

	// Retrieve userID from session; if not found, redirect to the login page
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Login');");
		script.println("</script>");
		script.println("<script>");
		script.println("location.href = 'userLogin.jsp';"); // Redirect to login page
		script.println("</script>");
		script.close();
		return;
	}
	%>
	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Class Dashboard</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbar" aria-controls="navbar" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav me-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="dropdownMenuButton"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">Member
						Management</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<%
						// Display Login and Sign Up options if user is not logged in
						if (userID == null) {
						%>
						<li><a class="dropdown-item" href="userLogin.jsp">Login</a></li>
						<li><a class="dropdown-item" href="userJoin.jsp">Sign Up</a></li>
						<%
						} else { // Display Logout option if user is logged in
						%>
						<li><a class="dropdown-item" href="userLogout.jsp">Logout</a></li>
					</ul> <%
 }
 %></li>
			</ul>
			<!-- Search Form -->
			<form action="./index.jsp" method="get" class="d-flex">
				<input type="text" name="search" class="form-control me-2"
					type="search" placeholder="Enter keywords." aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</nav>

	<!-- Main Section -->
	<section class="container mt-5">
		<form method="get" action="./index.jsp" class="row g-3">
			<div class="col-auto">
				<!-- Dropdown for Lecture Division -->
				<select name="LectureDivide" class="form-control">
					<option value="ALL"
						<%="ALL".equals(request.getParameter("LectureDivide")) ? "selected" : ""%>>All</option>
					<option value="Grammar"
						<%="Grammar".equals(request.getParameter("LectureDivide")) ? "selected" : ""%>>Grammar</option>
					<option value="Speaking"
						<%="Speaking".equals(request.getParameter("LectureDivide")) ? "selected" : ""%>>Speaking</option>
					<option value="Writing"
						<%="Writing".equals(request.getParameter("LectureDivide")) ? "selected" : ""%>>Writing</option>
				</select>
			</div>
			<div class="col-auto">
				<!-- Search Input -->
				<input type="text" name="search" class="form-control"
					placeholder="Please enter words">
			</div>
			<div class="col-auto">
				<button type="submit" class="btn btn-primary">Search</button>
			</div>
			<div class="col-auto">
				<a class="btn btn-primary" data-bs-toggle="modal"
					href="#registerModal">Register</a>
			</div>
		</form>

		<%
		// Fetch a list of evaluations based on search and pagination
		ArrayList<EvaluationDTO> evaluationsList = new EvaluationDAO().getList(search, pageNumber);

		if (evaluationsList == null || evaluationsList.isEmpty()) {
		%>
		<!-- Message when no evaluations are available -->
		<p class="text-center mt-4">No evaluations available.</p>
		<%
		} else {
		for (EvaluationDTO evaluation : evaluationsList) {
		%>
		<!-- Display each evaluation -->
		<div class="card shadow-sm mt-4">
			<div
				class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
				<div class="d-flex flex-column">
					<h6 class="mb-0"><%=evaluation.getLectureName() != null ? evaluation.getLectureName() : "Unknown Lecture"%></h6>
					<small><%=evaluation.getUserID() != null ? evaluation.getUserID() : "Unknown User"%></small>
				</div>
				<div>
					<span class="text-white ms-2"><%=evaluation.getLectureYear()%></span>
				</div>
			</div>
			<div class="card-body position-relative">
				<h5 class="card-title"><%=evaluation.getEvaluationTitle() != null ? evaluation.getEvaluationTitle() : "No Title"%></h5>
				<p class="card-text text-secondary"><%=evaluation.getEvaluationContent() != null ? evaluation.getEvaluationContent() : "No Content"%></p>
				<!-- Delete Button -->
				<a onclick="return confirm('Are you sure you want to delete?');"
					href="deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>"
					class="btn btn-danger btn-sm position-absolute"
					style="bottom: 10px; right: 10px;">Delete</a>
			</div>
		</div>
		<%
		}
		}
		%>
	</section>

	<%
	// Calculate total pages for pagination based on total records
	int totalRecords = new EvaluationDAO().getTotalRecords(search);
	int totalPages = (int) Math.ceil((double) totalRecords / 10); // Show 10 records per page
	%>
	<!-- Pagination -->
	<ul class="pagination justify-content-center mt-3">
		<!-- Previous Button -->
		<li class="page-item <%=pageNumber <= 1 ? "disabled" : ""%>"><a
			class="page-link"
			href="?pageNumber=<%=pageNumber - 1%>&search=<%=search%>">Previous</a>
		</li>

		<%
		int startPage = Math.max(1, pageNumber - 2);
		int endPage = Math.min(totalPages, pageNumber + 2);

		for (int i = startPage; i <= endPage; i++) {
		%>
		<li class="page-item <%=i == pageNumber ? "active" : ""%>"><a
			class="page-link" href="?pageNumber=<%=i%>&search=<%=search%>"><%=i%></a>
		</li>
		<%
		}
		%>

		<!-- Next Button -->
		<li class="page-item <%=pageNumber >= totalPages ? "disabled" : ""%>">
			<a class="page-link"
			href="?pageNumber=<%=pageNumber + 1%>&search=<%=search%>">Next</a>
		</li>
	</ul>

	<!-- Modal for Lecture Registration -->
	<div class="modal fade" id="registerModal" tabindex="-1"
		aria-labelledby="registerModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">Lecture
						Register</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="evaluationRegisterAction.jsp" method="post">
						<div class="mb-3">
							<label for="LectureName" class="form-label">Lecture Name</label>
							<input type="text" name="lectureName" id="LectureName"
								class="form-control" maxlength="20">
						</div>
						<div class="mb-3">
							<label for="professorName" class="form-label">Professor
								Name</label> <input type="text" name="professorName" id="professorName"
								class="form-control" maxlength="20">
						</div>
						<div class="mb-3">
							<label for="lectureYear" class="form-label">Lecture Year</label>
							<input type="number" name="lectureYear" id="lectureYear"
								class="form-control" required>
						</div>
						<div class="mb-3">
							<label>Title</label> <input type="text" name="evaluationTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="mb-3">
							<label>Content</label>
							<textarea name="evaluationContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

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