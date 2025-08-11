<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Bill" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Bills</title>
</head>
<body>
<h1>All Bills</h1>

<div style="margin-bottom: 20px;">
  <a href="bill?action=add" style="background-color: #4CAF50; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px;">Add New Bill</a>
</div>

<table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%;">
  <thead>
  <tr style="background-color: #f2f2f2;">
    <th>Bill ID</th>
    <th>Customer ID</th>
    <th>Item ID</th>
    <th>Quantity</th>
    <th>Total Price</th>
    <th>Bill Date</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<Bill> billList = (List<Bill>) request.getAttribute("billList");
    System.out.println("JSP: Bill list size: " + (billList != null ? billList.size() : "null"));

    if (billList != null && !billList.isEmpty()) {
      for (Bill bill : billList) {
  %>
  <tr>
    <td><%= bill.getBillId() %></td>
    <td><%= bill.getAccountNumber() %></td>
    <td><%= bill.getItemId() %></td>
    <td><%= bill.getQuantity() %></td>
    <td>Rs <%= bill.getTotalPrice() %></td>
    <td><%= bill.getBillDate() %></td>
    <td>
      <a href="bill?action=delete&id=<%= bill.getBillId() %>"
         onclick="return confirm('Are you sure you want to delete this bill?')"
         style="color: red; text-decoration: none;">Delete</a>
    </td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="7" style="text-align:center;">No bills found.</td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>

<br>
<a href="index.jsp">⬅ Back to Dashboard</a>
</body>
</html>