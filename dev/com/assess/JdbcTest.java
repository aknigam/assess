package com.assess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import org.apache.commons.dbcp.BasicDataSource;

public class JdbcTest {

	
	public static void main(String[] args) throws Exception {
		run1();
	}
	public static void run2() throws Exception {
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/assess",
				"root",
				"root");

		System.out.println(con);
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT CustomerName FROM customer");

		while (rs.next()) {
			String s = rs.getString("CustomerName");
			System.out.println(s);
		}
		con.close();
		
	}
	
	public static void run1() throws Exception{
		BasicDataSource ds = new BasicDataSource();
		ds.setPassword("root");
		ds.setUsername("root");
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost:3306/assess");
		
		Connection con = ds.getConnection();
		
		System.out.println(con);
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT CustomerName FROM customer");

		while (rs.next()) {
			String s = rs.getString("CustomerName");
			System.out.println(s);
		}
		con.close();
		
	}
}
