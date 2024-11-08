<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, p1.dbconnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Processing</title>
    <!-- Add your CSS links here -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Payment Processing</h2>
    
    <%
        // Get the form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        // Add more form fields as needed
        
        // Perform payment processing logic here
        // For example, you can update the order status in the database, send confirmation emails, etc.
        
        // For demonstration purposes, let's just display the submitted data
    %>
    
    <div>
        <h3>Billing Information</h3>
        <p>Name: <%= name %></p>
        <p>Email: <%= email %></p>
        <!-- Display more form fields as needed -->
    </div>
    
    <div>
        <h3>Payment Status</h3>
        <p>Your payment has been processed successfully!</p>
        <!-- You can also display additional payment details or order summary here -->
    </div>
</body>
</html>
