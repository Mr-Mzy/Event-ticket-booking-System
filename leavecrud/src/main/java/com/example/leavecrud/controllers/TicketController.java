package com.example.leavecrud.controllers;

import com.example.leavecrud.dto.TicketRequestDTO;
import com.example.leavecrud.dto.TicketResponseDTO;
import com.example.leavecrud.models.Ticket;
import com.example.leavecrud.services.TicketService;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

// Servlet annotation to map this controller to "/tickets/*" URL pattern
@WebServlet("/tickets/*")
public class TicketController extends HttpServlet {
    private final TicketService ticketService = new TicketService(); //service layer for ticket operations
    private final ObjectMapper objectMapper = new ObjectMapper(); //objectmapper for json

    //handles get requests for ticket operations
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); //get the path info from url

        //handle different get requests based on path
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all tickets (sorted by event date using MergeSort)
            List<Ticket> tickets = ticketService.sortTicketsByEventDate(ticketService.getAllTickets());
            sendJsonResponse(resp, tickets);
        }

        else if (pathInfo.matches("/[\\w-]+/confirm")) {
            // Handle ticket confirmation
            handleTicketConfirmation(pathInfo, req, resp);
        }

        else if (pathInfo.matches("/[\\w-]+/cancel")) {
            // Handle ticket cancellation
            handleTicketCancellation(pathInfo, req, resp);
        }

        else if (pathInfo.startsWith("/event")) {
            // Retrieve tickets by event name
            handleEventRequest(req, resp);
        }

        else if (pathInfo.startsWith("/status")) {
            //Retrieve tickets by status
            handleStatusRequest(req, resp);
        }

        else if (pathInfo.startsWith("/queue")) {
            // Demonstrate FIFO queue usage
            handleProcessingQueueRequest(resp);
        }

        else if (pathInfo.startsWith("/sorted/payment")) {
            // Demonstrate MergeSort by total payment
            List<Ticket> tickets = ticketService.sortTicketsByTotalPayment(ticketService.getAllTickets());
            sendJsonResponse(resp, tickets);
        }

        else {
            //retrieve a single ticket by id
            handleSingleTicketRequest(pathInfo, resp);
        }
    }

    //confirm a ticket
    private void handleTicketConfirmation(String pathInfo, HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Extract ticket ID from path
            String[] parts = pathInfo.split("/");
            if (parts.length >= 3) {
              String ticketId =parts[1];

                // Process the confirmation
                Ticket success = ticketService.confirmTicket(ticketId);

                if (success!=null) {
                    // Redirect back to ticket list or detail page
                    resp.sendRedirect(req.getContextPath() + "/tickets.jsp");
                } else {
                    // Handle error case
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Could not confirm ticket");
                }
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ticket ID");
            }
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ticket ID format");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    //cancel a ticket
    private void handleTicketCancellation(String pathInfo, HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Extract ticket ID from path
            String[] parts = pathInfo.split("/");
            if (parts.length >= 3) {


                // Process the cancellation
                String ticketId =parts[1];

                // Process the confirmation
                Ticket success = ticketService.cancelTicket(ticketId);

                if (success!=null) {
                    // Redirect back to ticket list or detail page
                    resp.sendRedirect(req.getContextPath() + "/tickets.jsp");
                } else {
                    // Handle error case
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Could not cancel ticket");
                }
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ticket ID");
            }
        }
        //handle invalid ticket id format
        catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ticket ID format");
        }
        //handle unexpected errors
        catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    //Retrieves tickets for a specific event
    private void handleEventRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Get event name from query parameter
        String eventName = req.getParameter("name");

        // Fetch tickets by event name from service
        List<Ticket> tickets = ticketService.getTicketsByEventName(eventName);

        // Send JSON response with tickets
        sendJsonResponse(resp, tickets);
    }

    //Retrieves ticket by status
    private void handleStatusRequest(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String status = req.getParameter("status");
        List<Ticket> tickets = ticketService.getTicketsByStatus(status);
        sendJsonResponse(resp, tickets);
    }

    // Process one item from queue (FIFO)
    private void handleProcessingQueueRequest(HttpServletResponse resp) throws IOException {
        Ticket nextTicket = ticketService.processNextTicket();
        if (nextTicket != null) {
            sendJsonResponse(resp, nextTicket);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "No tickets in processing queue");
        }
    }

    //Retrieves a single ticket by its ID
    private void handleSingleTicketRequest(String pathInfo, HttpServletResponse resp) throws IOException {
        String id = pathInfo.substring(1);
        Ticket ticket = ticketService.getTicketById(id);
        if (ticket != null) {
            sendJsonResponse(resp, ticket);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // Handles POST requests for creating tickets or deleting via method
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String methodOverride = req.getParameter("_method");

        // Handle DELETE request via POST
        if ("DELETE".equals(methodOverride)) {
            String pathInfo = req.getPathInfo();
            if (pathInfo != null && pathInfo.length() > 1) {
                String id = pathInfo.substring(1);
                ticketService.deleteTicket(id);
                resp.sendRedirect(req.getContextPath()+"/tickets.jsp");
            } else {
                resp.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE,
                        "ID is missing");
            }
            return;
        }

        // Verify content type is JSON
        if (!req.getContentType().startsWith("application/json")) {
            resp.sendError(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE,
                    "Expected JSON content");
            return;
        }

        try {
            // Parse JSON request body into TicketRequestDTO
            TicketRequestDTO ticketDTO = objectMapper.readValue(req.getReader(), TicketRequestDTO.class);
            //Convert dto to ticket entity
            Ticket ticket = convertToEntity(ticketDTO);
            ticket.setCreatedDate(new Date());

            ticket = ticketService.createTicket(ticket);

            resp.setStatus(HttpServletResponse.SC_CREATED);
            sendJsonResponse(resp, ticket);

        } catch (JsonParseException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid JSON format: " + e.getMessage());
        }
    }

    //Handles PUT requests for updating tickets
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ticket ID");
            return;
        }

        //Extract TicketID
        String id = pathInfo.substring(1);
        TicketRequestDTO ticketDTO = objectMapper.readValue(req.getReader(), TicketRequestDTO.class);
        Ticket updatedTicket = convertToEntity(ticketDTO);
        updatedTicket.setId(id);

        //Update ticket via service
        ticketService.updateTicket(id, updatedTicket);
        sendJsonResponse(resp, updatedTicket);//send updated ticket as JSON
    }

    //Handle delete requests for deleting tickets
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ticket ID");
            return;
        }

        //Extract ticket ID
        String id = pathInfo.substring(1);
        ticketService.deleteTicket(id);//delete
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    //Converts TicketRequestDTO to ticket entity
    private Ticket convertToEntity(TicketRequestDTO ticketDTO) {
        Ticket ticket = new Ticket(
                ticketDTO.getEventName(),
                ticketDTO.getNumberOfTickets(),
                ticketDTO.getTotalPayment(),
                ticketDTO.getEventDate()
        );
        return ticket;
    }

    //Sends a JSON response
    private void sendJsonResponse(HttpServletResponse resp, Object data) throws IOException {
        resp.setContentType("application/json");
        objectMapper.writeValue(resp.getWriter(), data);

    }



}