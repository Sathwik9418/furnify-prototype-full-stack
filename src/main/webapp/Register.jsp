<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>

<%@ page import="p1.dbconnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  

  <% 
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    if (username != null && password != null && confirmPassword != null) {
      if (password.equals(confirmPassword)) {
        try {
          dbconnect.connect();
          String sql = "INSERT INTO Users (Username, Password) VALUES (?, ?)";
          PreparedStatement statement = dbconnect.con.prepareStatement(sql);
          statement.setString(1, username);
          statement.setString(2, password);
          int rowsInserted = statement.executeUpdate();
          if (rowsInserted > 0) {
            response.sendRedirect("index.html"); 
        }
        } catch (SQLException e) {
          e.printStackTrace();
        }
      } else {
        out.println("Passwords do not match");
      }
    }
  %>
</body>
</html>
