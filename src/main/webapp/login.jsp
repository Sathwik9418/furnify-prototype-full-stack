<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*" %>
<%@ page import=" p1.dbconnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

  <% 
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
      try {
        dbconnect.connect(); 
        String sql = "SELECT UserID FROM Users WHERE Username = ? AND Password = ?";
        
        PreparedStatement statement = dbconnect.con.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
          
          int userId = resultSet.getInt("UserID");
          
          
          HttpSession sessionObj = request.getSession();
          sessionObj.setAttribute("userId", userId);
          
          System.out.println(userId);
          
          
          response.sendRedirect("products.jsp");
        } else {
          out.println("<p style='color:red;'>Invalid username or password!</p>");
        }
      } catch (SQLException e) {
        out.println("<p style='color:red;'>Error occurred while processing login!</p>");
        e.printStackTrace();
      }
    }
  %>
</body>
</html>
