
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Item - Inventory System</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/editItem.css">

</head>
<body>
<div class="container">
  <div class="header">
    <h1>Edit Item</h1>
    <p>Update item information</p>
  </div>

    <%
    Item item = (Item) request.getAttribute("item");
    if (item != null) {
  %>

  <div class="item-info">
    <h3>Editing: <%= item.getName() %></h3>
    <p>Item ID #<%= item.getItemId() %> • Current Stock: <%= item.getQuantityInStock() %> • Price: $<%= String.format("%.2f", item.getPrice()) %></p>
  </div>

  <div class="changes-indicator" id="changesIndicator">
    📝 You have unsaved changes
  </div>

  <form action="items" method="post" id="editForm">
    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">

    <div class="form-group">
      <label for="itemId">Item ID</label>
      <input type="number" id="itemIdDisplay" name="itemIdDisplay"
             value="<%= item.getItemId() %>" readonly>
      <span class="readonly-badge">Read Only</span>
      <small>Item ID cannot be changed</small>
    </div>

    <div class="form-group">
      <label for="name">Item Name <span class="required">*</span></label>
      <input type="text" id="name" name="name" required
             value="<%= item.getName() %>"
             data-original="<%= item.getName() %>"
             placeholder="Enter item name">
      <div class="original-value">Original: <%= item.getName() %></div>
      <small>Name of the product or service</small>
    </div>

    <div class="form-group">
      <label for="description">Description</label>
      <input type="text" id="description" name="description"
             value="<%= item.getDescription() != null ? item.getDescription() : "" %>"
             data-original="<%= item.getDescription() != null ? item.getDescription() : "" %>"
             placeholder="Enter item description">
      <div class="original-value">Original: <%= item.getDescription() != null ? item.getDescription() : "N/A" %></div>
      <small>Brief description of the item</small>
    </div>

    <div class="form-row">
      <div class="form-group">
        <label for="price">Price <span class="required">*</span></label>
        <input type="number" id="price" name="price" required
               value="<%= item.getPrice() %>"
               data-original="<%= item.getPrice() %>"
               min="0" step="0.01" placeholder="0.00">
        <div class="original-value">Original: LRK<%= String.format(" %.2f", item.getPrice()) %></div>
        <small>Price in Rupees (LRK)</small>
      </div>

      <div class="form-group">
        <label for="quantityInStock">Quantity in Stock <span class="required">*</span></label>
        <input type="number" id="quantityInStock" name="quantityInStock" required
               value="<%= item.getQuantityInStock() %>"
               data-original="<%= item.getQuantityInStock() %>"
               min="0" step="1" placeholder="0">
        <div class="original-value">Original: <%= item.getQuantityInStock() %></div>
        <small>Number of items available</small>
      </div>
    </div>

    <div class="btn-container">
      <button type="submit" class="btn btn-success" id="saveBtn">
        💾 Save Changes
      </button>
      <a href="items?action=list" class="btn btn-secondary">
        ← Cancel
      </a>
      <a href="items?action=delete&itemId=<%= item.getItemId() %>"
         class="btn btn-danger"
         onclick="return confirmDelete('<%= item.getName() %>', '<%= item.getItemId() %>');">
        🗑️ Delete Item
      </a>
    </div>
  </form>

    <% } else { %>
  <div style="text-align: center; padding: 40px; color: #e74c3c;">
    <h3>Item Not Found</h3>
    <p>The item you're trying to edit doesn't exist.</p>
    <a href="items?action=list" class="btn btn-secondary" style="margin-top: 20px;">
      ← Back to Item List
    </a>
  </div>
    <% } %>
  <script src="${pageContext.request.contextPath}/js/editItem.js"></script>

</body>
</html>
