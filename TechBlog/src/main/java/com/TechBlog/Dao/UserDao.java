package com.TechBlog.Dao;

import java.sql.*;

import com.TechBlog.Entities.User;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	// Method to insert the database
	public boolean saveUSer(User user) {
		boolean state = false;
		try {
			String query = "INSERT INTO user(name, email, password, gender, about) values(?,?,?,?,?)";
			PreparedStatement preparedStatement = this.con.prepareStatement(query);
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setString(4, user.getGender());
			preparedStatement.setString(5, user.getAbout());

			preparedStatement.executeUpdate();
			state = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return state;
	}

	// UserDao: User getUserByEmailandPassword(String email,String password)
	public User getUserByEmailandPassword(String email, String password) {
		User user = null;
		try {
			String query = "SELECT * FROM user WHERE email=? AND password=?";
			PreparedStatement preparedStatement = this.con.prepareStatement(query);
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, password);

			ResultSet resultSet=preparedStatement.executeQuery();
			if(resultSet.next()) {
				int id=Integer.parseInt(resultSet.getString("id"));
				String name=resultSet.getString("name");
				String gender=resultSet.getString("gender");
				String about=resultSet.getString("about");
				Timestamp timestamp=resultSet.getTimestamp("rdate");  
				String profile=resultSet.getString("profile");
				
				user=new User(id, name, email, password, gender, about, timestamp, profile);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public boolean UpdateUser(User user) {
		boolean status=false;
		try {
			String query="UPDATE user SET name=?,password=?,email=?,gender=?,about=?,profile=? WHERE id=?";
			PreparedStatement preparedStatement=this.con.prepareStatement(query);
			preparedStatement.setString(1,user.getName());
			preparedStatement.setString(2,user.getPassword());
			preparedStatement.setString(3,user.getEmail());
			preparedStatement.setString(4, user.getGender());
			preparedStatement.setString(5, user.getAbout());
			preparedStatement.setString(6,user.getProfile());
			preparedStatement.setInt(7, user.getId());
			
			preparedStatement.executeUpdate();
			status=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
}
