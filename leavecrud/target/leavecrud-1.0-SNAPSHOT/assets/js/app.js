document.addEventListener('DOMContentLoaded', function() {
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('tbody tr');

            rows.forEach(row => {
                const venueName = row.cells[1].textContent.toLowerCase();
                if (venueName.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    // Modal handling
    const modal = document.getElementById('venueModal');
    const btn = document.getElementById('addVenueBtn');
    const span = document.getElementsByClassName('close')[0];

    if (btn && modal && span) {
        btn.onclick = function() {
            modal.style.display = 'block';
            document.getElementById('modalTitle').textContent = 'Add New Venue';
            document.getElementById('venueForm').reset();
            document.getElementById('venueId').value = '';
        }

        span.onclick = function() {
            modal.style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    }

    // Edit buttons
    document.querySelectorAll('.edit-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const id = row.getAttribute('data-id');
            const name = row.cells[1].textContent;
            const location = row.cells[2].textContent;
            const capacity = row.cells[3].textContent;
            const facilities = row.cells[4].textContent;
            const available = row.cells[5].textContent === 'Yes';

            document.getElementById('modalTitle').textContent = 'Edit Venue';
            document.getElementById('venueId').value = id;
            document.getElementById('name').value = name;
            document.getElementById('location').value = location;
            document.getElementById('capacity').value = capacity;
            document.getElementById('facilities').value = facilities;
            document.getElementById('available').checked = available;

            modal.style.display = 'block';
        });
    });

    // Form validation
    const venueForm = document.getElementById('venueForm');
    if (venueForm) {
        venueForm.addEventListener('submit', function(e) {
            let isValid = true;

            // Validate name
            const name = document.getElementById('name');
            const nameError = document.getElementById('nameError');
            if (!name.value.trim()) {
                nameError.style.display = 'block';
                nameError.textContent = 'Venue name is required';
                isValid = false;
            } else {
                nameError.style.display = 'none';
            }

            // Validate location
            const location = document.getElementById('location');
            const locationError = document.getElementById('locationError');
            if (!location.value.trim()) {
                locationError.style.display = 'block';
                locationError.textContent = 'Location is required';
                isValid = false;
            } else {
                locationError.style.display = 'none';
            }

            // Validate capacity
            const capacity = document.getElementById('capacity');
            const capacityError = document.getElementById('capacityError');
            if (!capacity.value || isNaN(capacity.value)) {
                capacityError.style.display = 'block';
                capacityError.textContent = 'Valid capacity is required';
                isValid = false;
            } else {
                capacityError.style.display = 'none';
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    }
});