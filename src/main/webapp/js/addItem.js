// JavaScript for Add Item Page
document.addEventListener('DOMContentLoaded', function() {

    // Get form elements
    const form = document.getElementById('itemForm');
    const inputs = form.querySelectorAll('input[type="text"], input[type="number"]');
    const submitBtn = form.querySelector('button[type="submit"]');
    const successAnimation = document.getElementById('successAnimation');

 
    const nameInput = document.getElementById('name');
    if (nameInput) {
        nameInput.focus();
    }

    // Input validation and formatting
    inputs.forEach(input => {
        // Real-time validation
        input.addEventListener('input', function() {
            validateField(this);
            updateSubmitButton();
        });

        input.addEventListener('blur', function() {
            validateField(this);
            formatField(this);
        });

        // Clear validation on focus
        input.addEventListener('focus', function() {
            clearFieldValidation(this);
        });
    });

    // Field validation function
    function validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let errorMessage = '';

        // Required field validation
        if (field.required && !value) {
            isValid = false;
            errorMessage = 'This field is required';
        }

        // Specific field validations
        switch (field.type) {
            case 'number':
                if (value && (isNaN(value) || parseFloat(value) < 0)) {
                    isValid = false;
                    errorMessage = 'Please enter a valid positive number';
                }
                break;

            case 'text':
                if (field.id === 'name' && value.length > 100) {
                    isValid = false;
                    errorMessage = 'Name cannot exceed 100 characters';
                }
                if (field.id === 'description' && value.length > 500) {
                    isValid = false;
                    errorMessage = 'Description cannot exceed 500 characters';
                }
                break;
        }

        // Update field appearance
        const formGroup = field.closest('.form-group');
        const existingError = formGroup.querySelector('.error-message');

        if (!isValid) {
            formGroup.classList.add('error');
            formGroup.classList.remove('success');

            if (!existingError) {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                errorDiv.textContent = errorMessage;
                field.parentNode.appendChild(errorDiv);
            } else {
                existingError.textContent = errorMessage;
            }
        } else {
            formGroup.classList.remove('error');
            if (value) {
                formGroup.classList.add('success');
            }

            if (existingError) {
                existingError.remove();
            }
        }

        return isValid;
    }

    // Clear field validation
    function clearFieldValidation(field) {
        const formGroup = field.closest('.form-group');
        formGroup.classList.remove('error', 'success');

        const errorMessage = formGroup.querySelector('.error-message');
        if (errorMessage) {
            errorMessage.remove();
        }
    }

    // Format field values
    function formatField(field) {
        if (field.type === 'number' && field.value) {
            const value = parseFloat(field.value);
            if (!isNaN(value)) {
                if (field.id === 'price') {
                    field.value = value.toFixed(2);
                } else if (field.id === 'quantityInStock') {
                    field.value = Math.floor(value);
                }
            }
        }

        // Trim text fields
        if (field.type === 'text') {
            field.value = field.value.trim();
        }
    }

    // Update submit button state
    function updateSubmitButton() {
        const requiredFields = form.querySelectorAll('input[required]');
        let allValid = true;

        requiredFields.forEach(field => {
            if (!field.value.trim() || field.closest('.form-group').classList.contains('error')) {
                allValid = false;
            }
        });

        if (allValid) {
            submitBtn.classList.add('ready');
        } else {
            submitBtn.classList.remove('ready');
        }
    }

    // Form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        // Validate all fields
        let allValid = true;
        inputs.forEach(field => {
            if (!validateField(field)) {
                allValid = false;
            }
        });

        if (!allValid) {
            showNotification('Please fix the errors before submitting', 'error');
            // Focus first invalid field
            const firstError = form.querySelector('.form-group.error input');
            if (firstError) {
                firstError.focus();
            }
            return;
        }

        // Show loading state
        submitBtn.classList.add('loading');
        submitBtn.disabled = true;

        // Simulate form processing (replace with actual submission)
        setTimeout(() => {
            // Show success animation
            showSuccessAnimation();

            // Submit the actual form after animation
            setTimeout(() => {
                // Remove the event listener to allow normal submission
                form.removeEventListener('submit', arguments.callee);
                form.submit();
            }, 1500);
        }, 500);
    });

    // Success animation
    function showSuccessAnimation() {
        successAnimation.classList.add('show');
        showNotification('Item added successfully!', 'success');

        // Remove animation class after completion
        setTimeout(() => {
            successAnimation.classList.remove('show');
        }, 1500);
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+Enter to submit
        if (e.ctrlKey && e.key === 'Enter') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }

        // Escape to clear form
        if (e.key === 'Escape') {
            const hasContent = Array.from(inputs).some(input => input.value.trim());
            if (hasContent) {
                const confirmClear = confirm('Clear all fields?');
                if (confirmClear) {
                    clearForm();
                }
            }
        }
    });

    // Clear form function
    function clearForm() {
        inputs.forEach(input => {
            input.value = '';
            clearFieldValidation(input);
        });
        nameInput.focus();
        updateSubmitButton();
        showNotification('Form cleared', 'info');
    }

    // Auto-save to localStorage (optional feature)
    let autoSaveEnabled = true;
    const STORAGE_KEY = 'addItem_formData';

    if (autoSaveEnabled) {
        // Load saved data
        loadFormData();

        // Save on input
        inputs.forEach(input => {
            input.addEventListener('input', debounce(saveFormData, 1000));
        });
    }

    function saveFormData() {
        const formData = {};
        inputs.forEach(input => {
            formData[input.name] = input.value;
        });
        try {

        } catch (e) {

        }
    }

    function loadFormData() {
        try {

            const savedData = localStorage.getItem(STORAGE_KEY);
            if (savedData) {
                const formData = JSON.parse(savedData);
                inputs.forEach(input => {
                    if (formData[input.name]) {
                        input.value = formData[input.name];
                        validateField(input);
                    }
                });
                updateSubmitButton();
            }
        } catch (e) {

        }
    }

    function clearSavedData() {
        try {
            localStorage.removeItem(STORAGE_KEY);
        } catch (e) {

        }
    }

    // Clear saved data on successful submission
    form.addEventListener('submit', function() {
        if (autoSaveEnabled) {
            setTimeout(clearSavedData, 2000);
        }
    });


    // Initial validation check
    setTimeout(updateSubmitButton, 100);
});

// Utility functions
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Notification system
function showNotification(message, type = 'info') {
    // Remove existing notifications
    const existingNotification = document.querySelector('.notification');
    if (existingNotification) {
        existingNotification.remove();
    }

    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <span>${message}</span>
        <button onclick="this.parentElement.remove()">&times;</button>
    `;

    // Add notification styles
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 8px;
        color: white;
        font-weight: 500;
        z-index: 1000;
        display: flex;
        align-items: center;
        gap: 15px;
        min-width: 300px;
        animation: slideInRight 0.3s ease-out;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    `;

    // Set background color based on type
    const colors = {
        success: '#27ae60',
        error: '#e74c3c',
        warning: '#f39c12',
        info: '#3498db'
    };

    notification.style.backgroundColor = colors[type] || colors.info;

    // Style the close button
    const closeBtn = notification.querySelector('button');
    closeBtn.style.cssText = `
        background: none;
        border: none;
        color: white;
        font-size: 20px;
        cursor: pointer;
        padding: 0;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
    `;

    document.body.appendChild(notification);

    // Auto-remove after 4 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.style.animation = 'slideOutRight 0.3s ease-in';
            setTimeout(() => notification.remove(), 300);
        }
    }, 4000);
}

// Add CSS animations if not already present
if (!document.getElementById('add-item-styles')) {
    const style = document.createElement('style');
    style.id = 'add-item-styles';
    style.textContent = `
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
        
        .btn.ready {
            background: linear-gradient(135deg, #27ae60, #2ecc71) !important;
            animation: readyPulse 2s infinite;
        }
        
        @keyframes readyPulse {
            0%, 100% { 
                box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
            }
            50% { 
                box-shadow: 0 6px 20px rgba(39, 174, 96, 0.5);
                transform: translateY(-1px);
            }
        }
    `;
    document.head.appendChild(style);
}