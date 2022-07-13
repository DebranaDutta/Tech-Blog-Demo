package com.TechBlog.Servlets;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TechBlog.Dao.UserDao;
import com.TechBlog.Entities.User;
import com.TechBlog.Helper.ConnectionProvider;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String check = request.getParameter("user_check");

		if (check == null) {
			out.println("Please agree Terms & Conditions");
		} else {
			// Getting the variables from Web Page
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String gender = request.getParameter("gender");
			String user_about = request.getParameter("user_about");
			String user_password = request.getParameter("user_password");

			// Creating new user object
			User user = new User(user_name, user_email, user_password, gender, user_about);

			// Creating a object of User Dao
			UserDao userDao = new UserDao(ConnectionProvider.GetConnection());

			// Inserting data using user dao insert method
			if (userDao.saveUSer(user)) {
				out.println("User added");
			}else {
				out.println("Operation Failed");
			}

		}
	}

}
