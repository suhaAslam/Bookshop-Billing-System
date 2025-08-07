
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>

<html>
<head>
    <title>Customer List</title>
</head>
<body>
<h2>Customer List</h2>
<a href="addCustomer.jsp">Add New Customer</a>
<table border="1">
  <tr>
    <th>Account No</th><th>Name</th><th>Address</th><th>Phone</th><th>Units</th><th>Actions</th>
  </tr>
  <%
    List<Customer> list = (List<Customer>) request.getAttribute("customerList");
    if (list != null) {
      for (Customer c : list) {
  %>
  <tr>
    <td><%= c.getAccountNumber() %></td>
    <td><%= c.getName() %></td>
    <td><%= c.getAddress() %></td>
    <td><%= c.getPhoneNumber() %></td>
    <td><%= c.getUnitsConsumed() %></td>
    <td>
      <a href="customer?action=edit&id=<%= c.getAccountNumber() %>">Edit</a> |
      <a href="customer?action=delete&id=<%= c.getAccountNumber() %>"
         onclick="return confirm('Are you sure?');">Delete</a>
    </td>
  </tr>
  <%
      }
    }
  %>
</table>
</body>
</html>
