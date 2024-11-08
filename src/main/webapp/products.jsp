<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="p1.dbconnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .products {
            text-align: center;
            margin-top: 200px; /* Adjust the margin-top value to move products further down */
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .product {
            width: calc(33.33% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .product img {
            max-width: 100%;
            height: auto;
        }

        .product h3 {
            margin-top: 10px;
            font-size: 18px;
        }

        .product p {
            margin-top: 5px;
            font-size: 14px;
        }

        .product form {
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .product {
                width: calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .product {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="products">
            <h2>Our Products </h2>
            <form action="cart.jsp"><button type="submit">View Cart</button></form>
            <div class="product-list">
                <% 
                    try {
                        dbconnect.connect(); // Connect to the database
                        String sql = "SELECT * FROM Products";
                        ResultSet resultSet = dbconnect.st.executeQuery(sql);
                        while (resultSet.next()) {
                            int productId = resultSet.getInt("ProductID");
                            String productName = resultSet.getString("Name");
                            String description = resultSet.getString("Description");
                            double price = resultSet.getDouble("Price");
                           
                %>
                            <div class="product">
                                
                                <h3><%= productName %></h3>
                                <p><%= description %></p>
                                <p>Price: $<%= price %></p>
                                <form action="addtocart.jsp" method="post">
                                    <input type="hidden" name="productId" value="<%= productId %>">
                                    <input type="submit" value="Add to Cart">
                                </form>
                            </div>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
    </div>
</body>
</html>
