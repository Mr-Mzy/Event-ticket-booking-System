package com.example.leavecrud.servlets;

import com.example.leavecrud.models.Ticket;
import com.example.leavecrud.services.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

//Servlet for handling ticket editing
@WebServlet(name = "TicketEditServlet")
public class TicketEditServlet extends HttpServlet {
    private TicketService ticketService;


    @Override
    public void init() throws ServletException {
        super.init();
        ticketService = new TicketService();
    }

    //Handle get requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get ticket ID from request
            String ticketIdStr = request.getParameter("id");

            if (ticketIdStr == null || ticketIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Ticket ID is required");
            }

            String ticketId = ticketIdStr;

            // Get ticket from service
            Ticket ticket = ticketService.getTicketById(ticketId);

            if (ticket == null) {
                throw new IllegalArgumentException("Ticket not found with ID: " + ticketId);
            }

            // Set ticket in request and forward to edit JSP
            request.setAttribute("ticket", ticket);
            request.getRequestDispatcher("edit-ticket.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle errors
            request.setAttribute("error", "Error loading ticket: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/tickets");
        }
    }

    // Handles POST requests to update an existing ticket
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract parameters from request
            String id = request.getParameter("id");
            String eventName = request.getParameter("eventName");
            int numberOfTickets = Integer.parseInt(request.getParameter("numberOfTickets"));
            double totalPayment = Double.parseDouble(request.getParameter("totalPayment"));

            String eventDateStr = request.getParameter("eventDate");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            Date eventDate = formatter.parse(eventDateStr);

            // Create ticket object
            Ticket ticket = new Ticket();
            ticket.setId(id);
            ticket.setEventName(eventName);
            ticket.setNumberOfTickets(numberOfTickets);
            ticket.setTotalPayment(totalPayment);
            ticket.setEventDate(eventDate);

            // Update ticket
            ticketService.updateTicket(id, ticket);

            // Redirect to ticket list
            response.sendRedirect(request.getContextPath() + "/tickets");

        } catch (Exception e) {
            // Handle errors
            request.setAttribute("error", "Error updating ticket: " + e.getMessage());

            // Try to reload the ticket for the form
            try {
                String id = request.getParameter("id");
                Ticket ticket = ticketService.getTicketById(id);
                request.setAttribute("ticket", ticket);
            } catch (Exception ex) {
                // Ignore if we can't reload the ticket
            }

            request.getRequestDispatcher("/edit-ticket.jsp").forward(request, response);
        }
    }
}