
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editForm');
    const changesIndicator = document.getElementById('changesIndicator');
    const saveBtn = document.getElementById('saveBtn');
    let hasChanges = false;
    let originalValues = {};

    // Initialize original values
    function initializeOriginalValues() {
        const inputs = form.querySelectorAll('input[data-original]');
        inputs.forEach(input => {
            originalValues[input.name] = input.dataset.original;
        });
    }

    // Check for changes in form fields
    function checkForChanges() {
        const inputs = form.querySelectorAll('input[data-original]');
        hasChanges = false;

        inputs.forEach(input => {
            const currentValue = input.value.toString();
            const originalValue = originalValues[input.name] || '';

            if (currentValue !== originalValue) {
                input.classList.add('changed');
                hasChanges = true;
            } else {
                input.classList.remove('changed');
            }
        });

        // Show/hide changes indicator
        if (hasChanges) {
            changesIndicator.classList.add('show');
            saveBtn.style.background = '#e67e22';
            saveBtn.innerHTML = '💾 Save Changes *';
        } else {
            changesIndicator.classList.remove('show');
            saveBtn.style.background = '#27ae60';
            saveBtn.innerHTML = '💾 Save Changes';
        }
    }

    // Validate form inputs
    function validateForm() {
        let isValid = true;
        const nameInput = document.getElementById('name');
        const priceInput = document.getElementById('price');
        const quantityInput = document.getElementById('quantityInStock');

        // Clear previous error states
        [nameInput, priceInput, quantityInput].forEach(input => {
            input.classList.remove('error');
        });

        // Validate name
        if (!nameInput.value.trim()) {
            nameInput.classList.add('error');
            showTooltip(nameInput, 'Item name is required');
            isValid = false;
        }

        // Validate price
        if (!priceInput.value || parseFloat(priceInput.value) < 0) {
            priceInput.classList.add('error');
            showTooltip(priceInput, 'Price must be 0 or greater');
            isValid = false;
        }

        // Validate quantity
        if (!quantityInput.value || parseInt(quantityInput.value) < 0) {
            quantityInput.classList.add('error');
            showTooltip(quantityInput, 'Quantity must be 0 or greater');
            isValid = false;
        }

        return isValid;
    }

    // Show tooltip for validation errors
    function showTooltip(element, message) {
        // Remove existing tooltip
        const existingTooltip = element.parentNode.querySelector('.tooltip');
        if (existingTooltip) {
            existingTooltip.remove();
        }

        // Create new tooltip
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.textContent = message;
        tooltip.style.cssText = `
            position: absolute;
            background: #e74c3c;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            top: 100%;
            left: 0;
            z-index: 1000;
            white-space: nowrap;
            animation: slideDown 0.3s ease-out;
        `;

        element.parentNode.style.position = 'relative';
        element.parentNode.appendChild(tooltip);

        // Remove tooltip after 3 seconds
        setTimeout(() => {
            if (tooltip.parentNode) {
                tooltip.remove();
            }
        }, 3000);
    }

    // Handle form submission
    function handleFormSubmit(e) {
        if (!validateForm()) {
            e.preventDefault();
            showNotification('Please fix the errors before saving.', 'error');
            return;
        }

        // Add loading state
        saveBtn.classList.add('loading');
        saveBtn.disabled = true;

        // Show loading notification
        showNotification('Saving changes...', 'info');
    }

    // Show notifications
    function showNotification(message, type = 'success') {
        // Remove existing notifications
        const existingNotifications = document.querySelectorAll('.notification');
        existingNotifications.forEach(notification => notification.remove());

        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <span class="notification-icon">${getNotificationIcon(type)}</span>
                <span class="notification-message">${message}</span>
            </div>
        `;

        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: ${getNotificationColor(type)};
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 10000;
            animation: slideInRight 0.3s ease-out;
            max-width: 400px;
        `;

        document.body.appendChild(notification);

        // Auto-remove notification
        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 300);
        }, 4000);
    }

    // Get notification icon based on type
    function getNotificationIcon(type) {
        switch (type) {
            case 'success': return '✅';
            case 'error': return '❌';
            case 'warning': return '⚠️';
            case 'info': return 'ℹ️';
            default: return '📝';
        }
    }

    // Get notification color based on type
    function getNotificationColor(type) {
        switch (type) {
            case 'success': return '#27ae60';
            case 'error': return '#e74c3c';
            case 'warning': return '#f39c12';
            case 'info': return '#3498db';
            default: return '#34495e';
        }
    }

    // Handle input changes with debouncing
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

    // Auto-save functionality (optional)
    function autoSave() {
        if (hasChanges) {
            // Store in session storage for recovery
            const formData = new FormData(form);
            const data = {};
            for (let [key, value] of formData.entries()) {
                data[key] = value;
            }
            // Note: localStorage not available in Claude artifacts
            // sessionStorage.setItem('editItem_' + data.itemId, JSON.stringify(data));
            console.log('Auto-save triggered:', data);
        }
    }

    // Keyboard shortcuts
    function handleKeyboardShortcuts(e) {
        // Ctrl+S to save
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            if (hasChanges) {
                form.submit();
            }
        }

        // Escape to cancel
        if (e.key === 'Escape') {
            if (hasChanges && confirm('You have unsaved changes. Are you sure you want to leave?')) {
                window.location.href = 'items?action=list';
            }
        }
    }

    // Initialize the page
    function init() {
        initializeOriginalValues();

        // Add event listeners for form inputs
        const inputs = form.querySelectorAll('input[data-original]');
        const debouncedCheck = debounce(checkForChanges, 300);

        inputs.forEach(input => {
            input.addEventListener('input', debouncedCheck);
            input.addEventListener('blur', checkForChanges);
        });

        // Form submission handler
        form.addEventListener('submit', handleFormSubmit);

        // Keyboard shortcuts
        document.addEventListener('keydown', handleKeyboardShortcuts);

        // Auto-save every 30 seconds
        setInterval(autoSave, 30000);

        // Warn before leaving page with unsaved changes
        window.addEventListener('beforeunload', function(e) {
            if (hasChanges) {
                const message = 'You have unsaved changes. Are you sure you want to leave?';
                e.returnValue = message;
                return message;
            }
        });

        // Focus on first input
        const firstInput = form.querySelector('input[type="text"]:not([readonly])');
        if (firstInput) {
            firstInput.focus();
        }

        console.log('Edit Item form initialized successfully');
    }

    // Start the application
    init();
});

// Global function for delete confirmation
function confirmDelete(itemName, itemId) {
    const modal = document.createElement('div');
    modal.className = 'delete-modal';
    modal.innerHTML = `
        <div class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>🗑️ Confirm Delete</h3>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong>"${itemName}"</strong>?</p>
                    <p><small>Item ID: #${itemId}</small></p>
                    <p class="warning-text">⚠️ This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="proceedDelete('${itemId}')">Delete Item</button>
                </div>
            </div>
        </div>
    `;

    modal.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 10000;
    `;

    document.body.appendChild(modal);
    document.body.style.overflow = 'hidden';

    return false; // Prevent default link action
}

// Close delete modal
function closeDeleteModal() {
    const modal = document.querySelector('.delete-modal');
    if (modal) {
        modal.remove();
        document.body.style.overflow = '';
    }
}

// Proceed with delete
function proceedDelete(itemId) {
    closeDeleteModal();
    window.location.href = `items?action=delete&itemId=${itemId}`;
}

// Add CSS for modals and animations
const styles = `
    @keyframes slideInRight {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    
    @keyframes slideOutRight {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
    
    @keyframes slideDown {
        from { transform: translateY(-10px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }
    
    .delete-modal .modal-overlay {
        background: rgba(0, 0, 0, 0.5);
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        animation: fadeIn 0.3s ease-out;
    }
    
    .delete-modal .modal-content {
        background: white;
        border-radius: 8px;
        max-width: 400px;
        width: 90%;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        animation: scaleIn 0.3s ease-out;
    }
    
    .delete-modal .modal-header {
        padding: 20px 20px 10px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .delete-modal .modal-body {
        padding: 20px;
    }
    
    .delete-modal .modal-footer {
        padding: 10px 20px 20px;
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }
    
    .delete-modal .warning-text {
        color: #e74c3c;
        font-weight: 500;
        margin-top: 10px;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    @keyframes scaleIn {
        from { transform: scale(0.9); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
    
    input.error {
        border-color: #e74c3c !important;
        background: rgba(231, 76, 60, 0.05) !important;
    }
`;

const styleSheet = document.createElement('style');
styleSheet.textContent = styles;
document.head.appendChild(styleSheet);