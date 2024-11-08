package p1;

import java.sql.*;


public class dbconnect {
	public static Connection con;
	public static Statement st;
	public static int userid;
	
	public static void connect()
	{
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost:3306/furniture","root","sathwik");
		st=con.createStatement();
		}
		catch(Exception e)
		{
			System.out.println("Error");
			e.printStackTrace();
		}
	}
	public static void close()
	
	{
		
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
