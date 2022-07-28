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

import com.TechBlog.Dao.PostDao;
import com.TechBlog.Entities.Posts;
import com.TechBlog.Entities.User;
import com.TechBlog.Helper.ConnectionProvider;
import com.TechBlog.Helper.Helper;

@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddPostServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int cid = Integer.parseInt(request.getParameter("cid"));
		System.out.println(cid);
		String ptitle = request.getParameter("ptitle");
		String pcontent = request.getParameter("pcontent");
		String pcode = request.getParameter("pcode");
		Part part = request.getPart("pimage");
		String user_image = part.getSubmittedFileName();
		// get the user from the session
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		int userId=user.getId();

		Posts posts = new Posts(userId, ptitle, pcontent, pcode, user_image, null, cid, userId);
		//out.println(posts);
		
		PostDao postDao=new PostDao(ConnectionProvider.GetConnection());
		if(postDao.savePost(posts)) {
			String path=request.getRealPath("/")+"Post_Pic"+File.separator+user_image;
			Helper.saveFile(part.getInputStream(), path);
			out.println("done");
		}else {
			out.print("error");
		}

	}
}
