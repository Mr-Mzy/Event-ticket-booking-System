<%@ page import="java.util.List" %>
<%@ page import="com.example.leavecrud.models.Ticket" %>
<%@ page import="com.example.leavecrud.services.TicketService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Ticket Management</title>
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
    }
    .page-title {
      color: #2c3e50;
      font-weight: 600;
      margin-bottom: 25px;
      border-bottom: 2px solid #4a6572;
      padding-bottom: 10px;
    }
    .search-container {
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    #searchInput {
      width: 300px;
      padding: 8px 15px;
      border-radius: 5px;
      border: 1px solid #ced4da;
    }
    .table-container {
      overflow-x: auto;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th {
      background-color: #4a6572;
      color: white;
      position: sticky;
      top: 0;
    }
    .table-hover tbody tr:hover {
      background-color: rgba(74, 101, 114, 0.1);
    }
    .actions {
      white-space: nowrap;
    }
    .edit-btn {
      margin-right: 5px;
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
      background-color: #4a6572;
      border-color: #4a6572;
    }
    .btn-secondary:hover {
      background-color: #38505c;
      border-color: #38505c;
    }
    .btn-danger {
      background-color: #e74c3c;
      border-color: #e74c3c;
    }
    .btn-danger:hover {
      background-color: #c0392b;
      border-color: #c0392b;
    }
    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
    }
    .status-pending {
      background-color: #f39c12;
      color: white;
    }
    .status-confirmed {
      background-color: #27ae60;
      color: white;
    }
    .status-cancelled {
      background-color: #e74c3c;
      color: white;
    }
  </style>
</head>
<body>

<div class="container main-container">
  <h2 class="page-title">
    <i class="fas fa-ticket-alt me-2"></i>Ticket Management
  </h2>

  <div class="search-container">
    <div class="input-group">
      <span class="input-group-text"><i class="fas fa-search"></i></span>
      <input type="text" id="searchInput" class="form-control" placeholder="Search by event name...">
    </div>
    <div class="d-flex p-2">
      <button id="generatePdfBtn" class="btn btn-success me-2">
        <i class="fas fa-file-pdf me-1"></i> Generate PDF
      </button>
      <a href="${pageContext.request.contextPath}/ticket-add">
        <button id="addTicketBtn" class="btn btn-primary">
          <i class="fas fa-plus me-1"></i> Add New Ticket
        </button>
      </a>
    </div>
  </div>

  <div class="table-container">
    <table class="table table-hover table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Event Name</th>
        <th>Number of Tickets</th>
        <th>Total Payment</th>
        <th>Created Date</th>
        <th>Event Date</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        TicketService ticketService = new TicketService();
        List<Ticket> tickets = ticketService.getAllTickets();
      %>
      <c:forEach items="<%= tickets %>" var="ticket">
        <tr data-id="${ticket.id}">
          <td>${ticket.id}</td>
          <td>${ticket.eventName}</td>
          <td>${ticket.numberOfTickets}</td>
          <td>$${String.format("%.2f", ticket.totalPayment)}</td>
          <td>${ticket.createdDate}</td>
          <td>${ticket.eventDate}</td>
          <td>
            <span class="status-badge status-${ticket.status.toLowerCase()}">
                ${ticket.status}
            </span>
          </td>
          <td class="actions">
            <a href="${pageContext.request.contextPath}/ticket-edit?id=${ticket.id}" class="btn btn-secondary btn-sm edit-btn">
              <i class="fas fa-edit"></i> Edit
            </a>
            <form action="${pageContext.request.contextPath}/tickets/${ticket.id}" method="post" style="display:inline;">
              <input type="hidden" name="_method" value="DELETE">
              <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this ticket?')">
                <i class="fas fa-trash"></i> Delete
              </button>
            </form>
            <c:if test="${ticket.status == 'PENDING'}">
              <a href="${pageContext.request.contextPath}/tickets/${ticket.id}/confirm" class="btn btn-success btn-sm ms-1">
                <i class="fas fa-check"></i> Confirm
              </a>
              <a href="${pageContext.request.contextPath}/tickets/${ticket.id}/cancel" class="btn btn-warning btn-sm">
                <i class="fas fa-times"></i> Cancel
              </a>
            </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Add a simple footer -->
  <div class="mt-4 text-center text-muted">
    <small>Ticket Management System powered by <a href="https://www.oracle.com/java/technologies/" class="text-decoration-none">Minidu Sathsara</a></small>
  </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<!-- jsPDF Library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

<script>
  // Simple search functionality
  document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchValue = this.value.toLowerCase();
    const tableRows = document.querySelectorAll('tbody tr');

    tableRows.forEach(row => {
      const eventName = row.getElementsByTagName('td')[1].innerText.toLowerCase();
      if (eventName.includes(searchValue)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  });

  // PDF Generation functionality
  document.getElementById('generatePdfBtn').addEventListener('click', function() {
    // Initialize jsPDF
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    // Add title
    doc.setFontSize(18);
    doc.text('Ticket Management Report', 14, 22);
    doc.setFontSize(11);
    doc.text("Generated on:" + new Date().toLocaleString(), 14, 30);

    // Get visible rows (respecting the search filter)
    const tableRows = Array.from(document.querySelectorAll('tbody tr'))
            .filter(row => row.style.display !== 'none');

    // Extract data for the PDF
    const tableData = tableRows.map(row => {
      const cells = Array.from(row.getElementsByTagName('td'));
      return [
        cells[0].innerText, // ID
        cells[1].innerText, // Event Name
        cells[2].innerText, // Number of Tickets
        cells[3].innerText, // Total Payment
        cells[4].innerText, // Created Date
        cells[5].innerText, // Event Date
        cells[6].innerText.trim()  // Status
      ];
    });

    // Create the table in the PDF
    doc.autoTable({
      startY: 35,
      head: [['ID', 'Event Name', 'Tickets', 'Payment', 'Created', 'Event Date', 'Status']],
      body: tableData,
      theme: 'grid',
      headStyles: {
        fillColor: [74, 101, 114],
        textColor: [255, 255, 255],
        fontStyle: 'bold'
      },
      styles: {
        fontSize: 9,
        cellPadding: 3,
      },
      columnStyles: {
        0: {cellWidth: 15}, // ID column
        2: {cellWidth: 15}, // Tickets column
        3: {cellWidth: 20}, // Payment column
        6: {cellWidth: 20}  // Status column
      }
    });

    // Add footer
    const pageCount = doc.internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
      doc.setPage(i);
      doc.setFontSize(8);
      doc.text('Ticket Management System - Powered by Inuka', 14, doc.internal.pageSize.height - 10);
      doc.text(`Page ${i} of ${pageCount}`, doc.internal.pageSize.width - 30, doc.internal.pageSize.height - 10);
    }

    // Save the PDF
    doc.save('TicketManagementReport.pdf');
  });
</script>
</body>
</html>