
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<html>
<head>
    <title>Edit Customer</title>
</head>
<body>
<h2>Edit Customer</h2>
<%
  Customer c = (Customer) request.getAttribute("customer");
%>
<form action="customer" method="post">
  <input type="hidden" name="action" value="update">
  Account Number: <input type="text" name="accountNumber" value="<%= c.getAccountNumber() %>" readonly><br>
  Name: <input type="text" name="name" value="<%= c.getName() %>" required><br>
  Address: <input type="text" name="address" value="<%= c.getAddress() %>" required><br>
  Phone Number: <input type="text" name="phoneNumber" value="<%= c.getPhoneNumber() %>" required><br>
  Units Consumed: <input type="number" name="unitsConsumed" value="<%= c.getUnitsConsumed() %>" required><br>
  <input type="submit" value="Update Customer">
</form>
<a href="customer?action=view">Back to List</a>
</body>
</html>
