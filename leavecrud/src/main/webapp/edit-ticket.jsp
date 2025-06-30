<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Ticket</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Flatpickr for date picker -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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
        .flatpickr-input {
            background-color: white;
        }
        .status-info {
            padding: 8px 12px;
            border-radius: 4px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container main-container">
    <h2 class="page-title">
        <i class="fas fa-ticket-alt me-2"></i>Edit Ticket
    </h2>

    <div class="status-info">
        <strong>Status:</strong>
        <span class="badge ${ticket.status == 'PENDING' ? 'bg-warning' :
                         ticket.status == 'CONFIRMED' ? 'bg-success' : 'bg-danger'}">
            ${ticket.status}
        </span>
        <br>
        <strong>Created Date:</strong>
        <fmt:formatDate value="${ticket.createdDate}" pattern="yyyy-MM-dd HH:mm" />
    </div>

    <form id="editTicketForm">
        <input type="hidden" id="ticketId" value="${ticket.id}">

        <div class="form-group">
            <label for="eventName" class="form-label">Event Name</label>
            <input type="text" class="form-control" id="eventName" name="eventName"
                   value="${ticket.eventName}" required pattern="^[A-Za-z0-9\s\-.,&()]{3,100}$">
            <div class="error" id="eventNameError"></div>
            <small class="form-text">Event name must be 3-100 characters</small>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="numberOfTickets" class="form-label">Number of Tickets</label>
                    <input type="number" class="form-control" id="numberOfTickets" name="numberOfTickets"
                           value="${ticket.numberOfTickets}" required min="1" max="1000">
                    <div class="error" id="numberOfTicketsError"></div>
                    <small class="form-text">Must be between 1-1000</small>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label for="totalPayment" class="form-label">Total Payment ($)</label>
                    <input type="number" class="form-control" id="totalPayment" name="totalPayment"
                           value="${ticket.totalPayment}" required min="0.01" step="0.01">
                    <div class="error" id="totalPaymentError"></div>
                    <small class="form-text">Must be greater than $0</small>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="eventDate" class="form-label">Event Date</label>
            <input type="text" class="form-control flatpickr-input" id="eventDate" name="eventDate"
                   value="<fmt:formatDate value="${ticket.eventDate}" pattern="yyyy-MM-dd" />"
                   placeholder="Select date..." required>
            <div class="error" id="eventDateError"></div>
            <small class="form-text">Select the event date</small>
        </div>

        <div class="form-actions">
            <button type="button" class="btn btn-secondary" onclick="window.history.back()">
                <i class="fas fa-times me-1"></i> Cancel
            </button>
            <button type="button" class="btn btn-primary" onclick="submitEditForm()">
                <i class="fas fa-save me-1"></i> Update Ticket
            </button>
        </div>
    </form>

    <!-- Add a simple footer -->
    <div class="mt-4 text-center text-muted">
        <small>Ticket Management System powered by <a href="https://www.oracle.com/java/technologies/" class="text-decoration-none">M_zy</a></small>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>
    // Initialize date picker
    flatpickr("#eventDate", {
        dateFormat: "Y-m-d",
        minDate: "today",
        allowInput: true,
        disableMobile: true
    });

    function submitEditForm() {
        // Clear previous error messages
        const errorElements = document.querySelectorAll('.error');
        errorElements.forEach(el => el.textContent = '');

        // Get form values
        const ticketId = document.getElementById('ticketId').value;
        const eventName = document.getElementById('eventName').value;
        const numberOfTickets = parseInt(document.getElementById('numberOfTickets').value);
        const totalPayment = parseFloat(document.getElementById('totalPayment').value);
        const eventDate = document.getElementById('eventDate').value;

        // Validate form
        let isValid = true;

        // Event Name validation
        const eventNameRegex = /^[A-Za-z0-9\s\-.,&()]{3,100}$/;
        if (!eventName || !eventNameRegex.test(eventName)) {
            document.getElementById('eventNameError').textContent = 'Valid event name is required (3-100 characters)';
            isValid = false;
        }

        // Number of Tickets validation
        if (!numberOfTickets || isNaN(numberOfTickets) || numberOfTickets < 1 || numberOfTickets > 1000) {
            document.getElementById('numberOfTicketsError').textContent = 'Must be between 1-1000';
            isValid = false;
        }

        // Total Payment validation
        if (!totalPayment || isNaN(totalPayment) || totalPayment <= 0) {
            document.getElementById('totalPaymentError').textContent = 'Must be greater than $0';
            isValid = false;
        }

        // Event Date validation
        if (!eventDate) {
            document.getElementById('eventDateError').textContent = 'Event date is required';
            isValid = false;
        } else {
            const selectedDate = new Date(eventDate);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if (selectedDate < today) {
                document.getElementById('eventDateError').textContent = 'Event date cannot be in the past';
                isValid = false;
            }
        }

        if (!isValid) {
            return;
        }

        // Create JSON payload
        const ticketData = {

            eventName: eventName,
            numberOfTickets: numberOfTickets,
            totalPayment: totalPayment,
            eventDate: eventDate
        };

        // Show loading state
        const updateButton = document.querySelector('.btn-primary');
        const originalText = updateButton.innerHTML;
        updateButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Updating...';
        updateButton.disabled = true;

        // Send request
        fetch('${pageContext.request.contextPath}/tickets/' + ticketId, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(ticketData)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to update ticket');
                }
                return response.json();
            })
            .then(data => {
                // Show success message
                if (typeof Swal !== 'undefined') {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Ticket updated successfully',
                        icon: 'success',
                        confirmButtonColor: '#2c3e50'
                    }).then(() => {
                        window.location.href = '${pageContext.request.contextPath}/tickets.jsp';
                    });
                } else {
                    alert('Ticket updated successfully!');
                    window.location.href = '${pageContext.request.contextPath}/tickets.jsp';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                // Reset button
                updateButton.innerHTML = originalText;
                updateButton.disabled = false;

                // Show error
                if (typeof Swal !== 'undefined') {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Failed to update ticket: ' + error.message,
                        icon: 'error',
                        confirmButtonColor: '#2c3e50'
                    });
                } else {
                    alert('Failed to update ticket: ' + error.message);
                }
            });
    }

    // Add visual feedback for form validation
    document.querySelectorAll('#editTicketForm input').forEach(input => {
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
</body>
</html>