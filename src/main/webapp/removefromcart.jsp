<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, p1.dbconnect" %>
<%
    // Get the product name from the form submission
    String productName = request.getParameter("productName");
    
    // Ensure productName is not null and not empty
    if (productName != null && !productName.isEmpty()) {
        // Connect to the database
        dbconnect.connect();
        
        // Delete the item from the cart based on the product name
        String removeFromCartQuery = "DELETE FROM Cart WHERE Name = ?";
        PreparedStatement removeFromCartStatement = dbconnect.con.prepareStatement(removeFromCartQuery);
        removeFromCartStatement.setString(1, productName);
        int rowsDeleted = removeFromCartStatement.executeUpdate();
        
        if (rowsDeleted > 0) {
            // Item removed from cart successfully
            response.sendRedirect("cart.jsp");
        } else {
            // Failed to remove item from cart
            out.println("Failed to remove item from cart.");
        }
    } else {
        // Invalid product name
        out.println("Invalid product name.");
    }
%>
