package com.TechBlog.Servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.TechBlog.Dao.UserDao;
import com.TechBlog.Entities.User;
import com.TechBlog.Helper.ConnectionProvider;
import com.mysql.cj.Session;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		// Getting the variables from Web Page
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// Creating new user object
		User user = null;

		// Creating a object of UserDao
		UserDao userDao = new UserDao(ConnectionProvider.GetConnection());
		
		// Inserting data using userDao insert method
		user = userDao.getUserByEmailandPassword(email, password);

		// Print user value
		if(user==null) {
			response.sendRedirect("Error_Page.jsp");
		}else {
			//Creating Object of a Session
			HttpSession session=request.getSession();
			session.setAttribute("currentUser", user);
			response.sendRedirect("Profile.jsp");
		}
	}
}
