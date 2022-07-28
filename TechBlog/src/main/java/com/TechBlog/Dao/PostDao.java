package com.TechBlog.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.TechBlog.Entities.Categories;
import com.TechBlog.Entities.Posts;
import com.TechBlog.Helper.ConnectionProvider;
import com.mysql.cj.xdevapi.Statement;

public class PostDao {
	Connection connection;

	public PostDao(Connection connection) {
		super();
		this.connection = connection;
	}

	public ArrayList<Categories> getCategories() {
		ArrayList<Categories> list = new ArrayList<Categories>();
		try {
			String query = "select * from categories";
			// Statement statement=(Statement) this.connection.createStatement();
			PreparedStatement preparedStatement = connection.prepareStatement(query);
			ResultSet resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				int cid = resultSet.getInt("cid");
				String name = resultSet.getString("name");
				String description = resultSet.getString("description");
				Categories categories = new Categories(cid, name, description);
				list.add(categories);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean savePost(Posts posts) {
		boolean stats=false;
		try {
			String query="INSERT INTO posts(pTitle,pCOntent,pCode,pPic,catId,UserID) values (?,?,?,?,?,?);";
			PreparedStatement preparedStatement=this.connection.prepareStatement(query);
			preparedStatement.setString(1,posts.getpTitle());
			preparedStatement.setString(2, posts.getpContent());
			preparedStatement.setString(3, posts.getpCode());
			preparedStatement.setString(4, posts.getpPic());
			preparedStatement.setInt(5, posts.getCatId());
			preparedStatement.setInt(6, posts.getUserId());
			
			preparedStatement.executeUpdate();
			stats=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stats;
	}
	
	public List<Posts> getAllPosts(){
		List<Posts> list=new ArrayList();
		try {
			String query="select * from posts order by pid desc;;";
			PreparedStatement preparedStatement=this.connection.prepareStatement(query);
			ResultSet resultSet=preparedStatement.executeQuery();
			while(resultSet.next()) {
				int pid=resultSet.getInt("pid");
				String pTitle=resultSet.getString("pTitle");
				String pContent=resultSet.getString("PCOntent");
				String pCode=resultSet.getString("pCode");
				String pPic=resultSet.getString("pPic");
				Timestamp timestamp=resultSet.getTimestamp("PDate");
				int catId=resultSet.getInt("catId");
				int userId=resultSet.getInt("UserID");
				
				Posts posts=new Posts(pid,pTitle, pContent, pCode, pPic, timestamp,catId,userId);
				list.add(posts);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
 	public List<Posts> getPostByCatID(int catId){
 		List<Posts> list=new ArrayList();
 		try {
 			String query="select * from posts where catId=?";
 			PreparedStatement preparedStatement=this.connection.prepareStatement(query);
 			preparedStatement.setInt(1, catId);
 			ResultSet resultSet=preparedStatement.executeQuery();
 			while(resultSet.next()){
 				int pid=resultSet.getInt("pid");
				String pTitle=resultSet.getString("pTitle");
				String pContent=resultSet.getString("PCOntent");
				String pCode=resultSet.getString("pCode");
				String pPic=resultSet.getString("pPic");
				Timestamp timestamp=resultSet.getTimestamp("PDate");
				int userId=resultSet.getInt("UserID");
				
				Posts posts=new Posts(pid,pTitle, pContent, pCode, pPic, timestamp,catId,userId);
				list.add(posts);
 			}
 		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
 	}
 	
 	public Posts getPostByPostId(int post_id) {
 		Posts posts = null;
 		try {
 			String query="select * from posts where pid=?";
			PreparedStatement preparedStatement=this.connection.prepareStatement(query);
			preparedStatement.setInt(1, post_id);
			ResultSet resultSet=preparedStatement.executeQuery();
			if(resultSet.next()) {
				int pid=resultSet.getInt("pid");
				String pTitle=resultSet.getString("pTitle");
				String pContent=resultSet.getString("PCOntent");
				String pCode=resultSet.getString("pCode");
				String pPic=resultSet.getString("pPic");
				Timestamp timestamp=resultSet.getTimestamp("PDate");
				int userId=resultSet.getInt("UserID");
				int catId=resultSet.getInt("catId");
				
				posts=new Posts(pid,pTitle, pContent, pCode, pPic, timestamp,catId,userId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
 		return posts;
 	}
}
