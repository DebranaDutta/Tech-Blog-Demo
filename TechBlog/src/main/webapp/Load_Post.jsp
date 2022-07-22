<%@page import="com.TechBlog.Entities.Posts"%>
<%@page import="java.util.List"%>
<%@page import="com.TechBlog.Helper.ConnectionProvider"%>
<%@page import="com.TechBlog.Dao.PostDao"%>
<div class="row">
<%
	Thread.sleep(1000);
	PostDao postDao=new PostDao(ConnectionProvider.GetConnection());
	List<Posts> list;
	int cid=Integer.parseInt(request.getParameter("cid"));
	if(cid!=0){
		list=postDao.getPostByCatID(cid);
	}else{
		list=postDao.getAllPosts();
	}
	if(list.size()==0){
		out.println("<h3 class='display-3 text-center'>No post in this catagory</h3>");
		return;
	}
	for(Posts post:list){
%>
	<div class="col-md-6 mt-2">
		<div class="card">
			<img alt="Card image cap" src="img/<%=post.getpPic()%>" class="card-img-top">
			<div class="card-body">
				<b><%=post.getpTitle()%></b>
				<p><%=post.getpContent()%></p>
				<pre><%=post.getpCode()%></pre>
			</div>
		</div>
	</div>
	
<%
	}
%>
</div>