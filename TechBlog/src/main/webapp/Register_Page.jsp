<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 89%, 65% 100%, 30% 90%, 0 100%, 0 0
		);
}
</style>
</head>
<body>
	<!-- NAVBAR -->
	<%@include file="Normal_Navbar.jsp"%>
	<!-- REGISTRATION FORM -->
	<main style="padding: 10px">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header primary-background text-white text-center">
							<h4>
								<span class="fa fa-user-circle"></span>Registration Form
							</h4>
						</div>
						<div class="card-body"></div>
						<form id="Registration_Form" action="RegisterServlet" method="post" style="padding: 5px">
							<div class="form-group">
								<label for="user_name">User Name</label> <input name="user_name"
									type="text" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter usern name">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									name="user_email" type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email">
							</div>
							<div class="form-group">
								<label for="gender">Select Gender</label><br> <input
									type="radio" id="gender-male" style="margin-right: 2px;"
									name="gender">Male <input type="radio"
									id="gender-female" style="margin-right: 2px;" name="gender">Female
							</div>
							<div class="form-group">
								<textarea name="user_about" class="form-control" rows="6"
									placeholder="Something about yourself"></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="user_password" type="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password">
							</div>
							<div class="form-check">
								<input name="user_check" type="checkbox" class="form-check-input"
									id="exampleCheck1"> <label class="form-check-label"
									for="exampleCheck1">Agree Terms & Conditions</label>
							</div>
							<button type="submit" class="btn primary-background text-white"
								style="margin-top: 10px">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://kit.fontawesome.com/a2eb5bebaa.js"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			console.log("loaded.....");
			$('#Registration_Form').on('submit',function(event){
				event.preventDefault();
				let form=new FormData(this);
				console.log(form);
				$.ajax({
					url:"RegisterServlet",
					type:'POST'
					data: 'form',
					success: function(data, textStatus, jqXHR){
						console.log(data)
					},
					error: function(jqXHR, textStatus, errorThrown){
						console.log(jqXHR)
					},
					processData: false,
					contentType: false
				});
			});
		});
	</script>
</body>
</html>