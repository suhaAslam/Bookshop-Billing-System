
    // Search functionality
    document.getElementById('searchInput').addEventListener('keyup', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const rows = document.querySelectorAll('.customer-row');

    rows.forEach(row => {
    const text = row.textContent.toLowerCase();
    if (text.includes(searchTerm)) {
    row.style.display = '';
    row.style.animation = 'fadeIn 0.3s ease';
} else {
    row.style.display = 'none';
            }
        });
    });

    // Confirm delete with customer details
    function confirmDelete(name, accountNo) {
    return confirm(
    `Are you sure you want to delete this customer?\n\n` +
    `Name: ${name}\n` +
    `Account: #${accountNo}\n\n` +
    `This action cannot be undone.`
    );
}

    // Add loading animation to action buttons
    document.querySelectorAll('.btn-delete, .btn-edit').forEach(btn => {
    btn.addEventListener('click', function(e) {
        if (this.classList.contains('btn-delete')) {
            if (!confirmDelete('', '')) {
                e.preventDefault();
                return;
            }
        }

        const originalText = this.innerHTML;
        this.innerHTML = '⏳ Processing...';
        this.style.pointerEvents = 'none';

        // Reset after 3 seconds if page doesn't navigate
        setTimeout(() => {
            this.innerHTML = originalText;
            this.style.pointerEvents = 'auto';
        }, 3000);
    });
});

    // Add fade-in animation for rows
    const style = document.createElement('style');
    style.textContent = `
    @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}
    `;
    document.head.appendChild(style);

    // Auto-refresh every 30 seconds (optional)
    // setInterval(() => {
    //     window.location.reload();
    // }, 30000);
