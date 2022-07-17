package com.TechBlog.Helper;

import java.sql.*;

public class ConnectionProvider {
	private static Connection con;
	private static String url = "jdbc:mysql://localhost:3306/techblog";
	private static String uname = "root";
	private static String pwd = "Debrana@95";

	public static Connection GetConnection() {
		try {
			if (con == null) {
				// Class.forName("com.mysql.jdbc.Driver");
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, uname, pwd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
