
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Management - Billing System</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewCustomers.css">

</head>
<body>
<div class="container">
  <div class="header">
    <h1>Customer Management</h1>
    <p>Manage your customers</p>
  </div>

  <div class="actions-bar">
    <div class="search-container">
      <input type="text" class="search-input" placeholder="Search customers..." id="searchInput">
      <span class="search-icon">🔍</span>
    </div>
    <a href="addCustomer.jsp" class="btn btn-primary">
      ➕ Add New Customer
    </a>
    <a href="index.jsp" class="btn btn-secondary" style="margin-left:10px;">
      ⬅ Back to Home
    </a>
  </div>

  <%
    List<Customer> customerlist = (List<Customer>) request.getAttribute("customerList");
    int totalCustomers = customerlist != null ? customerlist.size() : 0;
    int totalUnits = 0;

    if (customerlist != null) {
      for (Customer c : customerlist) {
        totalUnits += c.getUnitsConsumed();
      }
    }
  %>

  <div class="table-container">
    <% if (customerlist != null && !customerlist.isEmpty()) { %>
    <table class="table" id="customerTable">
      <thead>
      <tr>
        <th>Account No</th>
        <th>Customer Name</th>
        <th>Address</th>
        <th>Phone Number</th>
        <th>Units Bought</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (Customer c : customerlist) { %>
      <tr class="customer-row">
        <td class="account-number">#<%= c.getAccountNumber() %></td>
        <td><%= c.getName() %></td>
        <td><%= c.getAddress() %></td>
        <td><%= c.getPhoneNumber() %></td>
        <td><span class="units-badge"><%= c.getUnitsConsumed() %> </span></td>
        <td>
          <div class="actions-cell">
            <a href="customer?action=edit&id=<%= c.getAccountNumber() %>"
               class="btn btn-edit btn-small">
              ✏️ Edit
            </a>
            <a href="customer?action=delete&id=<%= c.getAccountNumber() %>"
               class="btn btn-delete btn-small"
               onclick="return confirmDelete('<%= c.getName() %>', '<%= c.getAccountNumber() %>');">
              🗑️ Delete
            </a>
          </div>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <% } else { %>
    <div class="empty-state">
      <h3>No Customers Found</h3>
      <p>Start by adding your first customer to the system.</p>
      <a href="addCustomer.jsp" class="btn btn-primary">
        ➕ Add First Customer
      </a>
    </div>
    <% } %>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/viewCustomers.js"></script>
</body>
</html>
