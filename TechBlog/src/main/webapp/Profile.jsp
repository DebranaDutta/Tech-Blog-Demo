<%@page import="com.TechBlog.Entities.User"%>
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
<title>Insert title here</title>
</head>
<body>
	<%=user.getId()%>
	<br>
	<%=user.getName()%>
	<br>
	<%=user.getEmail()%>
	<br>
	<%=user.getAbout()%>
</body>
</html>