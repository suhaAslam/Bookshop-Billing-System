let hasChanges = false;

// Form validation and enhancement
document.getElementById('editForm').addEventListener('submit', function(e) {
    const phoneNumber = document.getElementById('phoneNumber').value;

    // Validate phone number
    if (!/^[0-9]{10}$/.test(phoneNumber)) {
        alert('Phone number must be exactly 10 digits');
        e.preventDefault();
        return;
    }

    // Show loading state
    const submitBtn = document.getElementById('saveBtn');
    submitBtn.innerHTML = '⏳ Saving Changes...';
    submitBtn.disabled = true;
});

// Track changes
function trackChanges() {
    const inputs = document.querySelectorAll('input:not([readonly]):not([type="hidden"])');
    const changesIndicator = document.getElementById('changesIndicator');

    inputs.forEach(input => {
        input.addEventListener('input', function() {
            const original = this.dataset.original;
            const current = this.value;
            const formGroup = this.closest('.form-group');

            if (original !== current) {
                formGroup.classList.add('changed');
                hasChanges = true;
            } else {
                formGroup.classList.remove('changed');
            }

            // Check if any field has changes
            const changedFields = document.querySelectorAll('.form-group.changed');
            if (changedFields.length > 0) {
                changesIndicator.style.display = 'block';
                hasChanges = true;
            } else {
                changesIndicator.style.display = 'none';
                hasChanges = false;
            }
        });
    });
}

// Warn about unsaved changes
window.addEventListener('beforeunload', function(e) {
    if (hasChanges) {
        e.preventDefault();
        e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
        return e.returnValue;
    }
});

// Real-time phone number formatting
document.getElementById('phoneNumber').addEventListener('input', function(e) {
    this.value = this.value.replace(/[^0-9]/g, '').substring(0, 10);
});

// Real-time name validation
document.getElementById('name').addEventListener('input', function(e) {
    this.value = this.value.replace(/[^A-Za-z\s]/g, '');
});

// Delete confirmation
function confirmDelete(name, accountNo) {
    return confirm(
        `⚠️ WARNING: Delete Customer\n\n` +
        `Are you sure you want to permanently delete:\n\n` +
        `Name: ${name}\n` +
        `Account: #${accountNo}\n\n` +
        `This action cannot be undone and will remove all customer data.`
    );
}

// Initialize change tracking
trackChanges();

// Auto-save draft (optional feature)
function autoSaveDraft() {
    if (hasChanges) {
        const formData = new FormData(document.getElementById('editForm'));
        const draftData = {};
        for (let [key, value] of formData.entries()) {
            draftData[key] = value;
        }
        localStorage.setItem('editCustomerDraft', JSON.stringify(draftData));
    }
}

// Auto-save every 30 seconds
setInterval(autoSaveDraft, 30000);

// Load draft on page load
function loadDraft() {
    const draft = localStorage.getItem('editCustomerDraft');
    if (draft) {
        try {
            const draftData = JSON.parse(draft);
            const accountNumber = document.getElementById('accountNumber').value;

            // Only load draft if it's for the same customer
            if (draftData.accountNumber === accountNumber) {
                Object.keys(draftData).forEach(key => {
                    const input = document.querySelector(`[name="${key}"]`);
                    if (input && !input.readOnly && key !== 'accountNumber') {
                        input.value = draftData[key];
                        input.dispatchEvent(new Event('input'));
                    }
                });

                if (hasChanges) {
                    const restore = confirm('Found unsaved changes from a previous session. Would you like to restore them?');
                    if (!restore) {
                        localStorage.removeItem('editCustomerDraft');
                        location.reload();
                    }
                }
            }
        } catch (e) {
            console.log('Error loading draft:', e);
        }
    }
}

// Clear draft on successful save
document.getElementById('editForm').addEventListener('submit', function() {
    localStorage.removeItem('editCustomerDraft');
});

// Load draft on page load
loadDraft();

// Keyboard shortcuts
document.addEventListener('keydown', function(e) {
    // Ctrl+S to save
    if (e.ctrlKey && e.key === 's') {
        e.preventDefault();
        document.getElementById('editForm').submit();
    }

    // Escape to cancel
    if (e.key === 'Escape') {
        if (hasChanges) {
            const leave = confirm('You have unsaved changes. Are you sure you want to leave?');
            if (leave) {
                window.location.href = 'customer?action=view';
            }
        } else {
            window.location.href = 'customer?action=view';
        }
    }
});

// Show keyboard shortcuts hint
console.log('💡 Keyboard shortcuts: Ctrl+S to save, Escape to cancel');
