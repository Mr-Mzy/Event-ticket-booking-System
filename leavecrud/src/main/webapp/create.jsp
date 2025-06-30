<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add New Venue</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body {
      background: linear-gradient(135deg, #2c3e50, #4a6572);
      min-height: 100vh;
      padding: 20px 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .main-container {
      background-color: rgba(255, 255, 255, 0.95);
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
      padding: 25px;
      margin: 20px auto;
      max-width: 800px;
    }
    .page-title {
      color: #2c3e50;
      font-weight: 600;
      margin-bottom: 25px;
      border-bottom: 2px solid #4a6572;
      padding-bottom: 10px;
    }
    .form-group {
      margin-bottom: 20px;
    }
    .form-label {
      font-weight: 500;
      color: #2c3e50;
    }
    .form-control:focus {
      border-color: #4a6572;
      box-shadow: 0 0 0 0.25rem rgba(74, 101, 114, 0.25);
    }
    .error {
      color: #dc3545;
      font-size: 0.875rem;
      margin-top: 5px;
    }
    .form-text {
      color: #6c757d;
    }
    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-top: 30px;
    }
    .btn-primary {
      background-color: #2c3e50;
      border-color: #2c3e50;
    }
    .btn-primary:hover {
      background-color: #1a252f;
      border-color: #1a252f;
    }
    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #5a6268;
    }
  </style>
</head>
<body>
<div class="container main-container">
  <h2 class="page-title">
    <i class="fas fa-plus-circle me-2"></i>Add New Venue
  </h2>

  <form id="createVenueForm">
    <div class="form-group">
      <label for="name" class="form-label">Venue Name</label>
      <input type="text" class="form-control" id="name" name="name" required pattern="^[A-Za-z0-9\s\-.,&()]{3,100}$">
      <div class="error" id="nameError"></div>
      <small class="form-text">Venue name must be 3-100 characters</small>
    </div>

    <div class="form-group">
      <label for="location" class="form-label">Location</label>
      <input type="text" class="form-control" id="location" name="location" required pattern="^[A-Za-z0-9\s\-.,]{3,100}$">
      <div class="error" id="locationError"></div>
      <small class="form-text">Valid location name required</small>
    </div>

    <div class="form-group">
      <label for="capacity" class="form-label">Capacity</label>
      <input type="number" class="form-control" id="capacity" name="capacity" required min="1">
      <div class="error" id="capacityError"></div>
      <small class="form-text">Capacity must be greater than 0</small>
    </div>

    <div class="form-group">
      <label for="facilities" class="form-label">Facilities</label>
      <textarea class="form-control" id="facilities" name="facilities" rows="3" required minlength="50"></textarea>
      <div class="error" id="facilitiesError"></div>
      <small class="form-text">Minimum 50 characters required</small>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label for="availableFrom" class="form-label">Available From</label>
          <input type="date" class="form-control" id="availableFrom" name="availableFrom" required>
          <div class="error" id="availableFromError"></div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="availableTo" class="form-label">Available To</label>
          <input type="date" class="form-control" id="availableTo" name="availableTo" required>
          <div class="error" id="availableToError"></div>
        </div>
      </div>
    </div>

    <div class="form-group form-check">
      <input type="checkbox" class="form-check-input" id="available" name="available" value="true" checked>
      <label class="form-check-label" for="available">Available</label>
    </div>

    <div class="form-actions">
      <button type="button" class="btn btn-secondary" onclick="window.history.back()">
        <i class="fas fa-times me-1"></i> Cancel
      </button>
      <button type="button" class="btn btn-primary" onclick="submitForm()">
        <i class="fas fa-save me-1"></i> Save
      </button>
    </div>
  </form>

  <!-- Add a simple footer -->
  <div class="mt-4 text-center text-muted">
    <small>Venue Management System powered by <a href="https://www.oracle.com/java/technologies/" class="text-decoration-none">Inuka</a></small>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function submitForm() {
    // Clear previous error messages
    const errorElements = document.querySelectorAll('.error');
    errorElements.forEach(el => el.textContent = '');

    // Get form values
    const name = document.getElementById('name').value;
    const location = document.getElementById('location').value;
    const capacity = parseInt(document.getElementById('capacity').value);
    const facilities = document.getElementById('facilities').value;
    const availableFrom = document.getElementById('availableFrom').value;
    const availableTo = document.getElementById('availableTo').value;


    // Validate form
    let isValid = true;

    // Name validation
    const nameRegex = /^[A-Za-z0-9\s\-.,&()]{3,100}$/;
    if (!name || !nameRegex.test(name)) {
      document.getElementById('nameError').textContent = 'Valid venue name is required (3-100 characters)';
      isValid = false;
    }

    // Location validation
    const locationRegex = /^[A-Za-z0-9\s\-.,]{3,100}$/;
    if (!location || !locationRegex.test(location)) {
      document.getElementById('locationError').textContent = 'Valid location is required';
      isValid = false;
    }

    // Capacity validation
    if (!capacity || isNaN(capacity) || capacity <= 0) {
      document.getElementById('capacityError').textContent = 'Capacity must be greater than 0';
      isValid = false;
    }

    // Facilities validation
    if (!facilities || facilities.trim().length < 50) {
      document.getElementById('facilitiesError').textContent = 'Facilities must be at least 50 characters';
      isValid = false;
    }

    // Date validation
    if (!availableFrom) {
      document.getElementById('availableFromError').textContent = 'Available from date is required';
      isValid = false;
    }

    if (!availableTo) {
      document.getElementById('availableToError').textContent = 'Available to date is required';
      isValid = false;
    }

    // Check if to date is after from date
    if (availableFrom && availableTo) {
      const fromDate = new Date(availableFrom);
      const toDate = new Date(availableTo);

      if (toDate <= fromDate) {
        document.getElementById('availableToError').textContent = 'Available to date must be after available from date';
        isValid = false;
      }
    }

    if (!isValid) {
      return;
    }

    // Create JSON payload
    const venueData = {
      name: name,
      location: location,
      capacity: capacity,
      facilities: facilities,
      availableFrom: availableFrom,
      availableTo: availableTo,

    };

    // Show loading state
    const saveButton = document.querySelector('.btn-primary');
    const originalText = saveButton.innerHTML;
    saveButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Saving...';
    saveButton.disabled = true;

    // Send request
    fetch('${pageContext.request.contextPath}/venues', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(venueData)
    })
            .then(response => {
              if (!response.ok) {
                throw new Error('Failed to create venue');
              }
              return response.json();
            })
            .then(data => {
              // Show success message with SweetAlert if available, otherwise use regular alert
              if (typeof Swal !== 'undefined') {
                Swal.fire({
                  title: 'Success!',
                  text: 'Venue created successfully',
                  icon: 'success',
                  confirmButtonColor: '#2c3e50'
                }).then(() => {
                  window.location.href = '${pageContext.request.contextPath}/venues.jsp';
                });
              } else {
                alert('Venue created successfully!');
                window.location.href = '${pageContext.request.contextPath}/venues.jsp';
              }
            })
            .catch(error => {
              console.error('Error:', error);
              // Reset button
              saveButton.innerHTML = originalText;
              saveButton.disabled = false;

              // Show error
              if (typeof Swal !== 'undefined') {
                Swal.fire({
                  title: 'Error!',
                  text: 'Failed to create venue: ' + error.message,
                  icon: 'error',
                  confirmButtonColor: '#2c3e50'
                });
              } else {
                alert('Failed to create venue: ' + error.message);
              }
            });
  }

  // Add visual feedback for form validation
  document.querySelectorAll('#createVenueForm input, #createVenueForm textarea').forEach(input => {
    input.addEventListener('input', function() {
      if (this.checkValidity()) {
        this.classList.remove('is-invalid');
        this.classList.add('is-valid');
      } else {
        this.classList.remove('is-valid');
        this.classList.add('is-invalid');
      }
    });
  });
</script>

<script src="${pageContext.request.contextPath}/src/main/webapp/assets/js/app.js"></script>
</body>
</html>