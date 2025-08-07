
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Customer</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addCustomer.css">

</head>
<body>
<div class="container">
  <div class="header">
    <h1>Add New Customer</h1>
    <p>Enter customer details to create a new account</p>
  </div>

  <form action="customer" method="post" id="customerForm">
    <div class="form-group">
      <label for="accountNumber">Account Number <span class="required">*</span></label>
      <input type="number" id="accountNumber" name="accountNumber" required
             placeholder="Enter unique account number" min="1">
      <small>Must be a unique positive number</small>
    </div>

    <div class="form-group">
      <label for="name">Customer Name <span class="required">*</span></label>
      <input type="text" id="name" name="name" required
             placeholder="Enter full name" pattern="[A-Za-z\s]+">
      <small>Only letters and spaces allowed</small>
    </div>

    <div class="form-group">
      <label for="address">Address <span class="required">*</span></label>
      <input type="text" id="address" name="address" required
             placeholder="Enter complete address">
      <small>Street, city, postal code</small>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="phoneNumber">Phone Number <span class="required">*</span></label>
        <input type="tel" id="phoneNumber" name="phoneNumber" required
               placeholder="1234567890" pattern="[0-9]{10}" maxlength="10">
        <small>10 digits only</small>
      </div>

      <div class="form-group">
        <label for="unitsConsumed">Units Consumed <span class="required">*</span></label>
        <input type="number" id="unitsConsumed" name="unitsConsumed" required
               placeholder="0" min="0" step="1">
        <small>Electricity units (kWh)</small>
      </div>
    </div>

    <div class="btn-container">
      <button type="submit" class="btn btn-primary">
        ✨ Add Customer
      </button>
      <a href="customer?action=view" class="btn btn-secondary">
        ← Back to List
      </a>
    </div>
  </form>

  <div class="success-animation" id="successAnimation">
    ✅
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/addCustomer.js"></script>
</body>
</html>
