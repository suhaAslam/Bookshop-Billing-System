
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addItem.css">

</head>
<body>
<div class="container">
    <div class="header">
        <h1>Add New Item</h1>
        <p>Enter item details to add to inventory</p>
    </div>

    <form action="items" method="post" id="itemForm">
        <div class="form-group">
            <label for="name">Item Name <span class="required">*</span></label>
            <input type="text" id="name" name="name" required
                   placeholder="Enter item name">
            <small>Name of the product or service</small>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <input type="text" id="description" name="description"
                   placeholder="Enter item description">
            <small>Brief description of the item</small>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="price">Price <span class="required">*</span></label>
                <input type="number" id="price" name="price" required
                       placeholder="0.00" min="0" step="0.01">
                <small>Price in Rupees LRK</small>
            </div>

            <div class="form-group">
                <label for="quantityInStock">Quantity in Stock <span class="required">*</span></label>
                <input type="number" id="quantityInStock" name="quantityInStock" required
                       placeholder="0" min="0" step="1">
                <small>Number of items available</small>
            </div>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn btn-primary">
                ✨ Add Item
            </button>
            <a href="items?action=list" class="btn btn-secondary">
                ← Back to List
            </a>
        </div>
    </form>

    <div class="success-animation" id="successAnimation">
        ✅
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/addItem.js"></script>
</body>
</html>
