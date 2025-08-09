document.addEventListener('DOMContentLoaded', function() {

    // Get DOM elements
    const searchInput = document.getElementById('searchInput');
    const itemTable = document.getElementById('itemTable');

    // Debounce function to limit rapid calls
    function debounce(func, delay) {
        let timer;
        return function (...args) {
            clearTimeout(timer);
            timer = setTimeout(() => func.apply(this, args), delay);
        };
    }

    // Search functionality
    if (searchInput) {
        searchInput.addEventListener('input', debounce(handleSearch, 100));
        searchInput.addEventListener('keydown', handleSearchKeydown);
    }

    // Search function
    function handleSearch() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        const itemRows = document.querySelectorAll('.item-row'); // Always get fresh list
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
            if (noResultsMsg) noResultsMsg.style.display = 'none';
            if (itemTable) itemTable.style.display = 'table';
        }
    }

    // Update statistics
    function updateStats(visibleCount = null) {
        const itemRows = document.querySelectorAll('.item-row');
        if (visibleCount === null) {
            visibleCount = itemRows.length - document.querySelectorAll('.item-row.hidden').length;
        }
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
            if (index < headers.length - 1) {
                header.style.cursor = 'pointer';
                header.addEventListener('click', () => sortTable(index));
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

        if (currentSortColumn === columnIndex) {
            currentSortDirection = currentSortDirection === 'asc' ? 'desc' : 'asc';
        } else {
            currentSortDirection = 'asc';
            currentSortColumn = columnIndex;
        }

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

        rows.sort((a, b) => {
            let aValue = a.children[columnIndex].textContent.trim();
            let bValue = b.children[columnIndex].textContent.trim();
            if (columnIndex === 0) {
                aValue = parseInt(aValue.replace('#', ''));
                bValue = parseInt(bValue.replace('#', ''));
            } else if (columnIndex === 3) {
                aValue = parseFloat(aValue.replace('$', ''));
                bValue = parseFloat(bValue.replace('$', ''));
            } else if (columnIndex === 4) {
                aValue = parseInt(aValue);
                bValue = parseInt(bValue);
            }
            if (aValue < bValue) return currentSortDirection === 'asc' ? -1 : 1;
            if (aValue > bValue) return currentSortDirection === 'asc' ? 1 : -1;
            return 0;
        });

        rows.forEach(row => tbody.appendChild(row));
    }
});
