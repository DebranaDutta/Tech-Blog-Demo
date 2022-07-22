<%@page import="com.TechBlog.Entities.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.TechBlog.Helper.ConnectionProvider"%>
<%@page import="com.TechBlog.Dao.PostDao"%>
<%@page import="com.TechBlog.Entities.User"%>
<%@page import="com.TechBlog.Entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page errorPage="Error_Page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("Login_Page.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=user.getName()%></title>
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
	<%
	Message message = (Message) session.getAttribute("Message");
	if (message != null) {
	%>
	<div class="alert <%=message.getCssClass()%>" role="alert"><%=message.getContent()%></div>
	<%
	session.removeAttribute("Message");
	}
	%>
	<!-- MAIN BODY OF THE PAGE -->
	<main>
		<div class="container">
			<div class="row mt-3">
			<!-- first col -->
				<div class="col-md-3">
					<div class="list-group text-center">
						<a href="#" onClick="getPost(0)" class="list-group-item list-group-item-action"> All POSTS </a> 
						<%
							PostDao postDao1=new PostDao(ConnectionProvider.GetConnection());
							ArrayList<Categories> list1=new ArrayList();
							list1=postDao1.getCategories();
							for(Categories categories:list1){
						%>
						<a href="#"  onclick="getPost(<%=categories.getCid()%>)" class="list-group-item list-group-item-action"><%=categories.getName()%></a> 
						<%}
						%>
					</div>
				</div>
				<!-- Second col -->	
				<div class="col-md-9">
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-3x fa-spin "></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid" id="post-container">
						
					</div>
					
				</div>
			</div>
		</div>
	</main>	
	<!-- END OF MAIN BODY OF THE PAGE -->
	<!-- PROFILE-MODAL -->

	<!-- Button trigger modal -->
	<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">Launch demo modal</button> -->
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

						<!-- USER DETAIL EDIT -->
						<div id="profile_edit" style="display: null;">
							<form action="EditServlet" method="post" enctype="multipart/form-data">
								<table class="table" style="margin-top: 15px; display: null">
									<tbody>
										<tr>
											<th scope="row">ID:</th>
											<td><%=user.getId()%></td>
										</tr>
										<tr>
											<th scope="row">NAME:</th>
											<td><input class="form-control text-center" type="text" name="user_name" value="<%=user.getName()%>"></td>
										</tr>
										<tr>
											<th scope="row">PASSWORD:</th>
											<td><input class="form-control text-center" type="password" name="user_password" id="user_pass" value="<%=user.getPassword()%>"></td>
											<td id="eye1"><span class="fa fa-eye-slash"></span></td>
											<td id="eye2"><span class="fa fa-eye"></span></td>
										</tr>
										<tr>
											<th scope="row">EMAIL:</th>
											<td><input class="form-control text-center" type="email" name="user_email" value="<%=user.getEmail()%>"></td>
										</tr>
										<tr>
											<th scope="row">GENDER:</th>
											<td><%=user.getGender().toUpperCase()%></td>
										</tr>
										<tr>
											<th scope="row">ABOUT</th>
											<td><textarea class="form-control" rows="4" name="user_about"><%=user.getAbout()%></textarea></td>
										</tr>
										<tr>
											<th scope="row">PROFILE PIC:</th>
											<td><input type="file" name="user_image" class="form-control"></td>
										</tr>
										<tr>
											<th scope="row">REGISTERED ON:</th>
											<td><%=user.getDateTime()%></td>
										</tr>
									</tbody>
								</table>
								<div class="modal-footer">
									<a type="submit" id="cancel_btn" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
									<button type="submit" class="btn primary-background text-white">Save</button>
								</div>
							</form>
						</div>
						<!-- END OF USER DETAILS -->
					</div>
				</div>
				<div id="edit_footer" class="modal-footer">
					<button type="button" id="close_btn" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" id="edit_btn" class="btn primary-background text-white">Edit</button>
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


	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://kit.fontawesome.com/a2eb5bebaa.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#profile_edit").hide();
			$("#eye2").hide();
			$("#eye1").click(function() {
				$("#eye2").show();
				$("#eye1").hide();
				var passInput = $("#user_pass");
				if (passInput.attr('type') === 'password') {
					passInput.attr('type', 'text');
				}
			});
			$("#eye2").click(function() {
				$("#eye1").show();
				$("#eye2").hide();
				var passInput = $("#user_pass");
				if (passInput.attr('type') === 'text') {
					passInput.attr('type', 'password');
				}
			});
			$("#edit_btn").click(function() {
				$("#profile_details").hide();
				$("#profile_edit").show();
				$("#edit_footer").hide();
				/* $(this).text("Save");
				$("#close_btn").text("Cancel"); */
			});
		});
	</script>

	<!-- ADD POST JS -->
	<script>
		$(document).ready(function() {
			$("#add-post-form").on("submit", function(event) {
				event.preventDefault();
				console.log("Ypu have clicked on Submit");
				let form = new FormData(this);

				$.ajax({
					url : "AddPostServlet",
					type : "POST",
					data : form,
					success : function(data, textStatus, jqXHR) {
						if(data.trim()==='done'){
						swal("Good job!", "saved successfully!", "success");
						}else{
							swal("Error!", "Something went wrong try again!", "error");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						swal("Error!", "Something went wrong try again!", "error");
					},
					processData : false,
					contentType : false
				});
			});
		});
	</script>
	
	<!-- Loading post using AJAX -->
	<!-- <script>
		function getPost(catId){
		
			$.ajax({
				url: "LoadPost.jsp",
				data:{cid:catId},
				success : function(data, textStatus, jqXHR){
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
				}
			});
		}
		$(document).ready(function(e){
			$("#loader").show();
			$("#post-container").hide();
			getPost()
		});
	</script> -->
	<script>
		function getPost(catId) {
			$("#loader").show();
			$("#post-container").hide();
			$.ajax({
				url:"Load_Post.jsp",
				data:{cid:catId},
				success : function(data, textStatus, jqXHR){
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
				}
			});
		}
		$(document).ready(function (e) {
			getPost(0);
		});
	</script>
</body>
</html>