function validateForm() {
    var customerId = document.getElementById("customer_id").value;
    var itemId = document.getElementById("item_id").value;
    var quantity = document.getElementById("quantity").value;

    console.log("Form validation - Customer ID: " + customerId);
    console.log("Form validation - Item ID: " + itemId);
    console.log("Form validation - Quantity: " + quantity);

    if (!customerId) {
        alert("Please select a customer!");
        return false;
    }
    if (!itemId) {
        alert("Please select an item!");
        return false;
    }
    if (!quantity || quantity <= 0) {
        alert("Please enter a valid quantity!");
        return false;
    }
    return true;
}
    function validateForm() {
    var customerId = document.getElementById("customer_id").value;
    var itemId = document.getElementById("item_id").value;
    var quantity = document.getElementById("quantity").value;

    console.log("Form validation - Customer ID: " + customerId);
    console.log("Form validation - Item ID: " + itemId);
    console.log("Form validation - Quantity: " + quantity);

    if (!customerId) {
    alert("Please select a customer!");
    return false;
}
    if (!itemId) {
    alert("Please select an item!");
    return false;
}
    if (!quantity || quantity <= 0) {
    alert("Please enter a valid quantity!");
    return false;
}

    // Add loading state
    document.querySelector('.form-card').classList.add('loading');
    document.querySelector('.submit-btn').innerHTML = 'Creating Bill...';

    return true;
}