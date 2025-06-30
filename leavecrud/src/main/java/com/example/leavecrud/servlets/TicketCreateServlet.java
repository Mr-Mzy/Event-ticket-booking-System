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

//handle ticket creation
@WebServlet(name = "TicketCreateServlet")
public class TicketCreateServlet extends HttpServlet {
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
        // Forward to the create-ticket JSP page
        request.getRequestDispatcher("create-ticket.jsp").forward(request, response);
    }

    //Handles post request
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract parameters from request
            String eventName = request.getParameter("eventName");
            int numberOfTickets = Integer.parseInt(request.getParameter("numberOfTickets"));
            double totalPayment = Double.parseDouble(request.getParameter("totalPayment"));

            String eventDateStr = request.getParameter("eventDate");
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
            Date eventDate = formatter.parse(eventDateStr);

            // Create new ticket
            Ticket ticket = new Ticket();
            ticket.setEventName(eventName);
            ticket.setNumberOfTickets(numberOfTickets);
            ticket.setTotalPayment(totalPayment);
            ticket.setEventDate(eventDate);

            // Save ticket
            ticketService.createTicket(ticket);

            // Redirect to ticket list
            response.sendRedirect(request.getContextPath() + "/tickets");

        } catch (Exception e) {
            // Handle errors
            request.setAttribute("error", "Error creating ticket: " + e.getMessage());
            request.getRequestDispatcher("/create-ticket.jsp").forward(request, response);
        }
    }
}