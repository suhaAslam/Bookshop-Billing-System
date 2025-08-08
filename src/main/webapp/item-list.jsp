
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View items</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        a.button {
            padding: 5px 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }
        a.button.delete {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">Items List</h2>

<div style="width: 80%; margin: auto;">
    <a href="items?action=new" class="button">Add New Item</a>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price (LKR)</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${listItems}">
            <tr>
                <td>${item.itemId}</td>
                <td>${item.name}</td>
                <td>${item.description}</td>
                <td>${item.price}</td>
                <td>${item.quantityInStock}</td>
                <td>
                    <a href="items?action=edit&itemId=${item.itemId}" class="button">Edit</a>
                    <a href="items?action=delete&itemId=${item.itemId}" class="button delete"
                       onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
