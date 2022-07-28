<%@page import="com.TechBlog.Entities.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.TechBlog.Helper.ConnectionProvider"%>
<%@page import="com.TechBlog.Dao.PostDao"%>
<%@page import="com.TechBlog.Entities.Posts"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.TechBlog.Entities.User"%>
<%@page errorPage="Error_Page.jsp"%>

<%
int post_id = Integer.parseInt(request.getParameter("post_id"));
PostDao postDao1 = new PostDao(ConnectionProvider.GetConnection());
Posts post = postDao1.getPostByPostId(post_id);
%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("Login_Page.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>

</style>
<meta charset="ISO-8859-1">
<title><%=post.getpTitle()%></title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 89%, 65% 100%, 30% 90%, 0 100%, 0 0
		);
}
</style>
</head>
<body>
	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><i class="fa-solid fa-align-justify"></i>Tech Blog </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><i class="fa-solid fa-house-user"></i>Home <span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#"><i class="fa-solid fa-file-contract"></i>Contacts</a></li>
				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> Catagories </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="" data-toggle="modal" data-target="#post_model"><i class="fas fa-icons"></i>Do post</a></li>

			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">
					<span class="fa fa-search"></span>
				</button>
			</form>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="" data-toggle="modal" data-target="#profile_model"><%=user.getName()%></a></li>
				<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out mr-2"></span>Logout</a></li>
			</ul>
		</div>
	</nav>
	<!-- END OF NAVBAR -->
	<!-- Modal -->
	<div class="modal fade" id="profile_model" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title container text-center" id="exampleModalLongTitle">
						Hello
						<%=user.getName()%></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img alt="" style="border-radius: 50%; max-width: 150px; max-height: 120px" src="Profile_pic/<%=user.getProfile()%>">

						<!-- USER DETAILS -->
						<div id="profile_details">
							<table class="table" style="margin-top: 15px">
								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">NAME:</th>
										<td><%=user.getName()%></td>
									</tr>
									<tr>
										<th scope="row">EMAIL</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">ABOUT</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On</th>
										<td><%=user.getDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- END OF USER DETAILS -->
					</div>
				</div>
				<div id="edit_footer" class="modal-footer">
					<button type="button" id="close_btn" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END OF PROFILE-MODAL -->

	<!-- POST MODAL -->
	<div class="modal fade" id="post_model" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<h5 class="modal-title" id="exampleModalLongTitle">Details</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="AddPostServlet" method="post" id="add-post-form">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected="selected" disabled="disabled">----Select Category----</option>
								<%
								PostDao postDao = new PostDao(ConnectionProvider.GetConnection());
								ArrayList<Categories> list = postDao.getCategories();
								for (Categories c : list) {
								%>
								<option><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="form-group">
							<input type="text" placeholder="Title" class="form-control" name="ptitle">
						</div>
						<div class="form-group">
							<textarea rows="6" placeholder="Content" class="form-control" name="pcontent"></textarea>
						</div>
						<div class="form-group">
							<textarea rows="6" placeholder="Code(If any)" class="form-control" name="pcode"></textarea>
						</div>
						<div class="form-group">
							<label>Image</label>
							<input type="file" class="form-control" name="pimage">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn primary-background text-white">POST</button>
						</div>
					</form>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="submit" class="btn primary-background text-white">POST</button>
				</div> -->
			</div>
		</div>
	</div>
	<!-- END OF POST MODAL -->
	

	<h1><%=post_id%></h1>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://kit.fontawesome.com/a2eb5bebaa.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

</body>
</html>