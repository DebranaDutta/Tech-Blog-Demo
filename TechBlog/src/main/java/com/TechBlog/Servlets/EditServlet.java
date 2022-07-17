package com.TechBlog.Servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.TechBlog.Dao.UserDao;
import com.TechBlog.Entities.Message;
import com.TechBlog.Entities.User;
import com.TechBlog.Helper.ConnectionProvider;
import com.TechBlog.Helper.Helper;

@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String user_name = request.getParameter("user_name");
		String user_password = request.getParameter("user_password");
		String user_email = request.getParameter("user_email");
		String user_about = request.getParameter("user_about");
		Part part = request.getPart("user_image");
		String user_image = part.getSubmittedFileName();

		// get the user from the session
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		user.setName(user_name);
		user.setPassword(user_password);
		user.setEmail(user_email);
		user.setAbout(user_about);
		String oldFile=user.getProfile();
		user.setProfile(user_image);

		// Create Use DAO Object
		UserDao userDao = new UserDao(ConnectionProvider.GetConnection());

		// Update Database
		boolean status = userDao.UpdateUser(user);
		if (status == true) {
			String path = request.getRealPath("/") + "Profile_pic" + File.separator + user.getProfile();
			System.out.print(path);
			
			String oldPath = request.getRealPath("/") + "Profile_pic" + File.separator + oldFile;
			if(!oldFile.equals("default.png")) {
				Helper.deleteFile(oldPath);
			}
			
			if (Helper.saveFile(part.getInputStream(), path)) {
				//out.println("Updated");
				Message message = new Message("Profile details Updated", "success", "alert-success");
				session.setAttribute("Message", message);
			}else {
				Message message = new Message("Something went wrong", "error", "alert-danger");
				session.setAttribute("Message", message);
			}
		} else {
			//out.println("Not Updated");
			Message message = new Message("Something went wrong", "error", "alert-danger");
			session.setAttribute("Message", message);
		}
		response.sendRedirect("Profile.jsp");
	}
}
