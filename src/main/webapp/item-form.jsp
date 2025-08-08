
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${item == null ? "Add New Item" : "Edit Item"}</title>
    <style>
        form {
            width: 400px;
            margin: 50px auto;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            font-family: Arial, sans-serif;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            margin-top: 15px;
            padding: 10px;
            background-color: #007BFF;
            border: none;
            color: white;
            cursor: pointer;
            width: 100%;
            border-radius: 3px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        a.button {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #007BFF;
        }
    </style>
</head>
<body>
<h2 style="text-align:center;">${item == null ? "Add New Item" : "Edit Item"}</h2>

<form action="items" method="post">
    <input type="hidden" name="itemId" value="${item != null ? item.itemId : ''}"/>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required value="${item != null ? item.name : ''}"/>

    <label for="description">Description:</label>
    <textarea id="description" name="description">${item != null ? item.description : ''}</textarea>

    <label for="price">Price (LKR):</label>
    <input type="number" step="0.01" id="price" name="price" required value="${item != null ? item.price : ''}"/>

    <label for="quantityInStock">Quantity In Stock:</label>
    <input type="number" id="quantityInStock" name="quantityInStock" required value="${item != null ? item.quantityInStock : ''}"/>

    <input type="submit" value="Save"/>
</form>

<div style="width: 400px; margin: auto;">
    <a href="items?action=list" class="button">Back to List</a>
</div>
</body>
</html>
