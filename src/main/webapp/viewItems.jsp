
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Item" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Item Management - Inventory System</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewItems.css">

</head>
<body>
<div class="container">
  <div class="header">
    <h1>Item Management</h1>
    <p>Manage your inventory items</p>
  </div>

  <div class="actions-bar">
    <div class="search-container">
      <input type="text" class="search-input" placeholder="Search items..." id="searchInput">
      <span class="search-icon">🔍</span>
    </div>
    <a href="items?action=new" class="btn btn-primary">
      ➕ Add New Item
    </a>
  </div>

  <%
    List<Item> listItems = (List<Item>) request.getAttribute("listItems");
    int totalItems = listItems != null ? listItems.size() : 0;
    int totalQuantity = 0;
    double totalValue = 0;

    if (listItems != null) {
      for (Item item : listItems) {
        totalQuantity += item.getQuantityInStock();
        totalValue += item.getPrice() * item.getQuantityInStock();
      }
    }
  %>

  <div class="stats-container">
    <div class="stat-card">
      <div class="stat-number"><%= totalItems %></div>
      <div class="stat-label">Total Items</div>
    </div>
    <div class="stat-card">
      <div class="stat-number"><%= totalQuantity %></div>
      <div class="stat-label">Total Stock Quantity</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">$<%= String.format("%.2f", totalValue) %></div>
      <div class="stat-label">Total Inventory Value</div>
    </div>
  </div>

  <div class="table-container">
    <% if (listItems != null && !listItems.isEmpty()) { %>
    <table class="table" id="itemTable">
      <thead>
      <tr>
        <th>Item ID</th>
        <th>Item Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Stock Quantity</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (Item item : listItems) { %>
      <tr class="item-row">
        <td class="item-id">#<%= item.getItemId() %></td>
        <td><%= item.getName() %></td>
        <td><%= item.getDescription() != null ? item.getDescription() : "N/A" %></td>
        <td><span class="price-badge">$<%= String.format("%.2f", item.getPrice()) %></span></td>
        <td><span class="quantity-badge <%= item.getQuantityInStock() <= 5 ? "low-stock" : "" %>"><%= item.getQuantityInStock() %></span></td>
        <td>
          <div class="actions-cell">
            <a href="items?action=edit&itemId=<%= item.getItemId() %>"
               class="btn btn-edit btn-small">
              ✏️ Edit
            </a>
            <a href="items?action=delete&itemId=<%= item.getItemId() %>"
               class="btn btn-delete btn-small"
               onclick="return confirmDelete('<%= item.getName() %>', '<%= item.getItemId() %>');">
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
      <h3>No Items Found</h3>
      <p>Start by adding your first item to the inventory.</p>
      <a href="items?action=new" class="btn btn-primary">
        ➕ Add First Item
      </a>
    </div>
    <% } %>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/viewItems.js"></script>

</body>
</html>
