// Form validation and enhancement
document.getElementById('customerForm').addEventListener('submit', function(e) {
    const phoneNumber = document.getElementById('phoneNumber').value;
    const accountNumber = document.getElementById('accountNumber').value;

    // Validate phone number
    if (!/^[0-9]{10}$/.test(phoneNumber)) {
        alert('Phone number must be exactly 10 digits');
        e.preventDefault();
        return;
    }

    // Validate account number
    if (accountNumber <= 0) {
        alert('Account number must be a positive number');
        e.preventDefault();
        return;
    }

    // Show loading state
    const submitBtn = e.target.querySelector('.btn-primary');
    submitBtn.innerHTML = '⏳ Adding Customer...';
    submitBtn.disabled = true;
});

// Real-time phone number formatting
document.getElementById('phoneNumber').addEventListener('input', function(e) {
    this.value = this.value.replace(/[^0-9]/g, '').substring(0, 10);
});

// Real-time name validation
document.getElementById('name').addEventListener('input', function(e) {
    this.value = this.value.replace(/[^A-Za-z\s]/g, '');
});

// Add floating labels effect
document.querySelectorAll('input').forEach(input => {
    input.addEventListener('focus', function() {
        this.parentElement.classList.add('focused');
    });

    input.addEventListener('blur', function() {
        if (this.value === '') {
            this.parentElement.classList.remove('focused');
        }
    });
});