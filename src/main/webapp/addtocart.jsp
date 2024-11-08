<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, p1.dbconnect" %>
<%
    // Get the product ID and user ID from the session
    int productId = Integer.parseInt(request.getParameter("productId"));
    int userId = (int) session.getAttribute("userId");
    
    // Ensure productId is valid
    if (productId > 0) {
        // Connect to the database
        dbconnect.connect();
        
        // Query the product details based on the product ID
        String getProductQuery = "SELECT * FROM Products WHERE ProductID = ?";
        PreparedStatement getProductStatement = dbconnect.con.prepareStatement(getProductQuery);
        getProductStatement.setInt(1, productId);
        ResultSet productResultSet = getProductStatement.executeQuery();
        
        // If product exists, add it to the user's cart
        if (productResultSet.next()) {
            String productName = productResultSet.getString("Name");
            double productPrice = productResultSet.getDouble("Price");
            
            // Insert the item into the user's cart
            String addToCartQuery = "INSERT INTO Cart (UserID, ProductID, Name, Price) VALUES (?, ?, ?, ?)";
            PreparedStatement addToCartStatement = dbconnect.con.prepareStatement(addToCartQuery);
            addToCartStatement.setInt(1, userId);
            addToCartStatement.setInt(2, productId);
            addToCartStatement.setString(3, productName);	
            addToCartStatement.setDouble(4, productPrice);
            int rowsInserted = addToCartStatement.executeUpdate();
            
            if (rowsInserted > 0) {
                // Item added to cart successfully
                response.sendRedirect("cart.jsp");
            } else {
                // Failed to add item to cart
                out.println("Failed to add item to cart.");
            }
        } else {
            // Product not found
            out.println("Product not found.");
        }
    } else {
        // Invalid product ID
        out.println("Invalid product ID.");
    }
%>
