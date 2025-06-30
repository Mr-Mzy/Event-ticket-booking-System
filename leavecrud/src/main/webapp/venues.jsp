<%@ page import="java.util.List" %>
<%@ page import="com.example.leavecrud.models.Venue" %>
<%@ page import="com.example.leavecrud.services.VenueService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Venue Management</title>
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
  </style>
</head>
<body>

<div class="container main-container">
  <h2 class="page-title">
    <i class="fas fa-map-marker-alt me-2"></i>Venue Management
  </h2>

  <div class="search-container">
    <div class="input-group">
      <span class="input-group-text"><i class="fas fa-search"></i></span>
      <input type="text" id="searchInput" class="form-control" placeholder="Search by venue name...">
    </div>
    <div class="d-flex p-2">
      <button id="generatePdfBtn" class="btn btn-success me-2">
        <i class="fas fa-file-pdf me-1"></i> Generate PDF
      </button>
      <a href="${pageContext.request.contextPath}/venue-add">
        <button id="addVenueBtn" class="btn btn-primary">
          <i class="fas fa-plus me-1"></i> Add New Venue
        </button>
      </a>
    </div>
  </div>

  <div class="table-container">
    <table class="table table-hover table-bordered">
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Location</th>
        <th>Capacity</th>
        <th>Facilities</th>
        <th>Available</th>
        <th>Available From</th>
        <th>Available To</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        VenueService venueService = new VenueService();
        List<Venue> venues = venueService.getAllVenues();
      %>
      <c:forEach items="<%= venues %>" var="venue">
        <tr data-id="${venue.id}">
          <td>${venue.id}</td>
          <td>${venue.name}</td>
          <td>${venue.location}</td>
          <td>${venue.capacity}</td>
          <td>${venue.facilities}</td>
          <td>
            <span class="badge ${venue.available ? 'bg-success' : 'bg-danger'}">
                ${venue.available ? 'Yes' : 'No'}
            </span>
          </td>
          <td>${venue.availableFrom}</td>
          <td>${venue.availableTo}</td>
          <td class="actions">
            <a href="${pageContext.request.contextPath}/venue-edit?id=${venue.id}" class="btn btn-secondary btn-sm edit-btn">
              <i class="fas fa-edit"></i> Edit
            </a>
            <form action="${pageContext.request.contextPath}/venues/${venue.id}" method="post" style="display:inline;">
              <input type="hidden" name="_method" value="DELETE">
              <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this venue?')">
                <i class="fas fa-trash"></i> Delete
              </button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Add a simple footer -->
  <div class="mt-4 text-center text-muted">
    <small>Venue Management System powered by <a href="https://www.oracle.com/java/technologies/" class="text-decoration-none">Inuka</a></small>
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
      const venueName = row.getElementsByTagName('td')[1].innerText.toLowerCase();
      if (venueName.includes(searchValue)) {
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
    doc.text('Venue Management Report', 14, 22);
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
        cells[1].innerText, // Name
        cells[2].innerText, // Location
        cells[3].innerText, // Capacity
        cells[4].innerText, // Facilities
        cells[5].innerText.trim(), // Available
        cells[6].innerText, // Available From
        cells[7].innerText  // Available To
      ];
    });

    // Create the table in the PDF
    doc.autoTable({
      startY: 35,
      head: [['ID', 'Name', 'Location', 'Capacity', 'Facilities', 'Available', 'From', 'To']],
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
        5: {cellWidth: 20}, // Available column
        6: {cellWidth: 25}, // Available From column
        7: {cellWidth: 25}  // Available To column
      }
    });

    // Add footer
    const pageCount = doc.internal.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
      doc.setPage(i);
      doc.setFontSize(8);
      doc.text('Venue Management System - Powered by Inuka', 14, doc.internal.pageSize.height - 10);
      doc.text(`Page ${i} of ${pageCount}`, doc.internal.pageSize.width - 30, doc.internal.pageSize.height - 10);
    }

    // Save the PDF
    doc.save('VenueManagementReport.pdf');
  });
</script>
<script>
  // Simple search functionality
  document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchValue = this.value.toLowerCase();
    const tableRows = document.querySelectorAll('tbody tr');

    tableRows.forEach(row => {
      const venueName = row.getElementsByTagName('td')[1].innerText.toLowerCase();
      if (venueName.includes(searchValue)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  });
</script>

</body>
</html>