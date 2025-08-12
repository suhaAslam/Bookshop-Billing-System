<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help & User Guide</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #000000;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-top: 20px;
        }
        ul {
            line-height: 1.8;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Help & User Guide</h1>

    <h2>1. Login</h2>
    <ul>
        <li>Enter your Admin username and password to log in.</li>
        <li>After login, you will be redirected to the Admin Dashboard.</li>
    </ul>

    <h2>2. Manage Customers</h2>
    <ul>
        <li>Go to the <b>Customer Management</b> section from the dashboard.</li>
        <li>Add, update, or delete customer details as required.</li>
    </ul>

    <h2>3. Manage Items</h2>
    <ul>
        <li>Go to the <b>Item Management</b> section from the dashboard.</li>
        <li>Add new items, update existing items, or remove items from the inventory.</li>
    </ul>

    <h2>4. Bill Management</h2>
    <ul>
        <li>Create a new bill by selecting a customer and an item from the dropdown lists.</li>
        <li>Enter the quantity, and the system will calculate the total price automatically.</li>
        <li>View all bills in the <b>View Bills</b> section.</li>
    </ul>

    <h2>5. Logging Out</h2>
    <ul>
        <li>Use the <b>Logout</b> button in the dashboard to safely exit the system.</li>
    </ul>
    

    <a href="index.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>
</body>
</html>
