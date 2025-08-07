
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Customer</title>
</head>
<body>
<h2>Add Customer</h2>
<form action="customer" method="post">
  Account Number: <input type="text" name="accountNumber" required><br>
  Name: <input type="text" name="name" required><br>
  Address: <input type="text" name="address" required><br>
  Phone Number: <input type="text" name="phoneNumber" required><br>
  Units Consumed: <input type="number" name="unitsConsumed" required><br>
  <input type="submit" value="Add Customer">
</form>
<a href="customer?action=view">View All Customers</a>
</body>
</html>
