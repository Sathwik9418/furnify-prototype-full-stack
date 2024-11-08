<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, p1.dbconnect" %>
<%
    // Get the user ID from the session
    int userId = (int) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <!-- Add your CSS links here -->
    <link rel="stylesheet" href="styles.css">
    
</head>
<body>
    <h2>Your Shopping Cart</h2> 
    <table border="1">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                
                <th>Total</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                // Connect to the database
                dbconnect.connect();
                
                // Query the user's cart items
                String getCartItemsQuery = "SELECT * FROM Cart WHERE UserID = ?";
                PreparedStatement getCartItemsStatement = dbconnect.con.prepareStatement(getCartItemsQuery);
                getCartItemsStatement.setInt(1, userId);
                ResultSet resultSet = getCartItemsStatement.executeQuery();
                
                // Loop through the cart items
                while (resultSet.next()) {
                    String productName = resultSet.getString("Name");
                    double productPrice = resultSet.getDouble("Price");
   
            %>
                <tr>
                    <td><%= productName %></td>
                    <td>$<%= productPrice %></td>
                    <td>$<%= productPrice %></td>
                    <td>
                        <!-- Add remove item button -->
                        <form action="removefromcart.jsp" method="post">
                            <input type="hidden" name="productName" value="<%= productName %>">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            <% 
                }
            } catch (SQLException e) {
                out.println("Error retrieving cart items: " + e.getMessage());
                e.printStackTrace();
            } finally {
                dbconnect.close(); // Close database connection
            }
            %>
        </tbody>
    </table>
    
<form action="products.jsp"><button type="submit">Go to Products</button></form>
    
<form action="billing.jsp">
	<input type="submit" value="Proceed to checkout">
</form>
   
</body>
</html>
