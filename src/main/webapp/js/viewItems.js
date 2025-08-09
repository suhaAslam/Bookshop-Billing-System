
document.addEventListener('DOMContentLoaded', function() {

    // Get DOM elements
    const searchInput = document.getElementById('searchInput');
    const itemTable = document.getElementById('itemTable');
    const itemRows = document.querySelectorAll('.item-row');

    // Search functionality
    if (searchInput && itemRows.length > 0) {
        searchInput.addEventListener('input', debounce(handleSearch, 300));
        searchInput.addEventListener('keydown', handleSearchKeydown);
    }

    // Search function
    function handleSearch() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        let visibleCount = 0;

        itemRows.forEach(row => {
            const itemName = row.children[1].textContent.toLowerCase();
            const itemDescription = row.children[2].textContent.toLowerCase();
            const itemId = row.children[0].textContent.toLowerCase();

            const isMatch = itemName.includes(searchTerm) ||
                itemDescription.includes(searchTerm) ||
                itemId.includes(searchTerm);

            if (isMatch) {
                row.classList.remove('hidden');
                row.style.display = '';
                visibleCount++;
            } else {
                row.classList.add('hidden');
                row.style.display = 'none';
            }
        });

        // Show/hide no results message
        updateNoResultsMessage(visibleCount, searchTerm);
        updateStats(visibleCount);
    }

    // Search keyboard shortcuts
    function handleSearchKeydown(e) {
        if (e.key === 'Escape') {
            searchInput.value = '';
            handleSearch();
            searchInput.blur();
        }

        if (e.key === 'Enter') {
            e.preventDefault();
            // Focus first visible row's edit button
            const firstVisibleRow = document.querySelector('.item-row:not(.hidden)');
            if (firstVisibleRow) {
                const editBtn = firstVisibleRow.querySelector('.btn-edit');
                if (editBtn) editBtn.focus();
            }
        }
    }

    // Update no results message
    function updateNoResultsMessage(visibleCount, searchTerm) {
        let noResultsMsg = document.getElementById('noResultsMessage');

        if (visibleCount === 0 && searchTerm) {
            if (!noResultsMsg) {
                noResultsMsg = document.createElement('div');
                noResultsMsg.id = 'noResultsMessage';
                noResultsMsg.className = 'no-results';
                noResultsMsg.innerHTML = `
                    <div style="text-align: center; padding: 40px; color: #6c757d;">
                        <h3>No items found</h3>
                        <p>No items match your search for "<strong>${searchTerm}</strong>"</p>
                        <button onclick="document.getElementById('searchInput').value=''; handleSearch();" 
                                class="btn btn-secondary" style="margin-top: 15px;">
                            Clear Search
                        </button>
                    </div>
                `;

                if (itemTable) {
                    itemTable.parentNode.appendChild(noResultsMsg);
                }
            } else {
                noResultsMsg.querySelector('strong').textContent = searchTerm;
            }

            noResultsMsg.style.display = 'block';
            if (itemTable) itemTable.style.display = 'none';
        } else {
            if (noResultsMsg) {
                noResultsMsg.style.display = 'none';
            }
            if (itemTable) itemTable.style.display = 'table';
        }
    }

    // Update statistics based on visible items
    function updateStats(visibleCount = null) {
        if (visibleCount === null) {
            visibleCount = itemRows.length - document.querySelectorAll('.item-row.hidden').length;
        }

        // Update item count in header or stats
        const itemCountElements = document.querySelectorAll('.total-items, .stat-number');
        if (itemCountElements.length > 0 && searchInput.value.trim()) {
            itemCountElements[0].textContent = `${visibleCount} / ${itemRows.length}`;
        } else if (itemCountElements.length > 0) {
            itemCountElements[0].textContent = itemRows.length;
        }
    }

    // Sort functionality
    if (itemTable) {
        const headers = itemTable.querySelectorAll('th');
        headers.forEach((header, index) => {
            if (index < headers.length - 1) { // Exclude actions column
                header.style.cursor = 'pointer';
                header.addEventListener('click', () => sortTable(index));

                // Add sort indicator
                const sortIcon = document.createElement('span');
                sortIcon.className = 'sort-icon';
                sortIcon.innerHTML = ' ↕';
                sortIcon.style.opacity = '0.5';
                header.appendChild(sortIcon);
            }
        });
    }

    let currentSortColumn = -1;
    let currentSortDirection = 'asc';

    function sortTable(columnIndex) {
        const tbody = itemTable.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('.item-row'));

        // Update sort direction
        if (currentSortColumn === columnIndex) {
            currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
        } else {
            currentSortDirection = 'asc';
            currentSortColumn = columnIndex;
        }

        // Update sort icons
        const headers = itemTable.querySelectorAll('th');
        headers.forEach((header, index) => {
            const icon = header.querySelector('.sort-icon');
            if (icon) {
                if (index === columnIndex) {
                    icon.innerHTML = currentSortDirection === 'asc' ? ' ↑' : ' ↓';
                    icon.style.opacity = '1';
                } else {
                    icon.innerHTML = ' ↕';
                    icon.style.opacity = '0.5';
                }
            }
        });

        // Sort rows
        rows.sort((a, b) => {
            let aValue = a.children[columnIndex].textContent.trim();
            let bValue = b.children[columnIndex].textContent.trim();

            // Handle numeric columns
            if (columnIndex === 0) { // ID column
                aValue = parseInt(aValue.replace('#', ''));
                bValue = parseInt(bValue.replace('#', ''));
            } else if (columnIndex === 3) { // Price column
                aValue = parseFloat(aValue.replace('$', ''));
                bValue = parseFloat(bValue.replace('$', ''));
            } else if (columnIndex === 4) { // Quantity column
                aValue = parseInt(aValue);}