<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, p1.dbconnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Billing</title>
    <!-- Add your CSS links here -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Billing Information</h2>
    
    <div>
        <h3>Cart Items</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                double totalPrice = 0; // Initialize totalPrice variable outside try-catch block
                
                try {
                    // Get the user ID from the session
                    int userId = (int) session.getAttribute("userId");
                    
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
                        
                        double total = productPrice * 1;
                        totalPrice += total; // Add to the total price
                        
                        // Display the cart item
                %>
                        <tr>
                            <td><%= productName %></td>
                            <td>$<%= productPrice %></td>
                            <td>x<%= 1%></td>
                            <td>$<%= total %></td>
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
        
        <p>Total Price: $<%= totalPrice %></p> <!-- Display the total price -->
    </div>
    
    <div>
        <h3>Billing Information</h3>
        <!-- Add form fields for billing information -->
        <form action="processpayment.jsp" method="post">
            <!-- Example fields: name, email, address, payment method, etc. -->
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required><br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br>
            
            <!-- Add more fields as needed -->
            
            <button type="submit">Proceed to Payment</button>
        </form>
    </div>
</body>
</html>
