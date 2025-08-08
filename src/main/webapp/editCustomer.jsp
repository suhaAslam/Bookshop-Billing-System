
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Customer - Billing System</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/editCustomer.css">


</head>
<body>
<div class="container">
  <div class="header">
    <h1>Edit Customer</h1>
    <p>Update customer information</p>
  </div>

  <%
    Customer customer = (Customer) request.getAttribute("customer");
    if (customer != null) {
  %>

  <div class="customer-info">
    <h3>Editing: <%= customer.getName() %></h3>
    <p>Account #<%= customer.getAccountNumber() %> • Current Units: <%= customer.getUnitsConsumed() %> </p>
  </div>

  <div class="changes-indicator" id="changesIndicator">
    📝 You have unsaved changes
  </div>

  <form action="customer" method="post" id="editForm">
    <input type="hidden" name="action" value="update">

    <div class="form-group">
      <label for="accountNumber">Account Number</label>
      <input type="number" id="accountNumber" name="accountNumber"
             value="<%= customer.getAccountNumber() %>" readonly>
      <span class="readonly-badge">Read Only</span>
      <small>Account number cannot be changed</small>
    </div>

    <div class="form-group">
      <label for="name">Customer Name <span class="required">*</span></label>
      <input type="text" id="name" name="name" required
             value="<%= customer.getName() %>"
             data-original="<%= customer.getName() %>"
             pattern="[A-Za-z\s]+" placeholder="Enter full name">
      <div class="original-value">Original: <%= customer.getName() %></div>
      <small>Only letters and spaces allowed</small>
    </div>

    <div class="form-group">
      <label for="address">Address <span class="required">*</span></label>
      <input type="text" id="address" name="address" required
             value="<%= customer.getAddress() %>"
             data-original="<%= customer.getAddress() %>"
             placeholder="Enter complete address">
      <div class="original-value">Original: <%= customer.getAddress() %></div>
      <small>Street, city, postal code</small>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="phoneNumber">Phone Number <span class="required">*</span></label>
        <input type="tel" id="phoneNumber" name="phoneNumber" required
               value="<%= customer.getPhoneNumber() %>"
               data-original="<%= customer.getPhoneNumber() %>"
               pattern="[0-9]{10}" maxlength="10" placeholder="1234567890">
        <div class="original-value">Original: <%= customer.getPhoneNumber() %></div>
        <small>10 digits only</small>
      </div>

      <div class="form-group">
        <label for="unitsConsumed">Units bought <span class="required">*</span></label>
        <input type="number" id="unitsConsumed" name="unitsConsumed" required
               value="<%= customer.getUnitsConsumed() %>"
               data-original="<%= customer.getUnitsConsumed() %>"
               min="0" step="1" placeholder="0">
        <div class="original-value">Original: <%= customer.getUnitsConsumed() %></div>
        <small>number of items purchased </small>
      </div>
    </div>

    <div class="btn-container">
      <button type="submit" class="btn btn-success" id="saveBtn">
        💾 Save Changes
      </button>
      <a href="customer?action=view" class="btn btn-secondary">
        ← Cancel
      </a>
      <a href="customer?action=delete&id=<%= customer.getAccountNumber() %>"
         class="btn btn-danger"
         onclick="return confirmDelete('<%= customer.getName() %>', '<%= customer.getAccountNumber() %>');">
        🗑️ Delete Customer
      </a>
    </div>
  </form>

  <% } else { %>
  <div style="text-align: center; padding: 40px; color: #e74c3c;">
    <h3>Customer Not Found</h3>
    <p>The customer you're trying to edit doesn't exist.</p>
    <a href="customer?action=view" class="btn btn-secondary" style="margin-top: 20px;">
      ← Back to Customer List
    </a>
  </div>
  <% } %>
  <script src="${pageContext.request.contextPath}/js/editCustomer.js"></script>
</div>
</body>
</html>
