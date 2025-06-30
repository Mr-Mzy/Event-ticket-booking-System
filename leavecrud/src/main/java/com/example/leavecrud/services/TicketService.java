//ticket service form services
package com.example.leavecrud.services;

import com.example.leavecrud.models.Ticket;
import com.example.leavecrud.datastructures.CustomQueue;
import com.example.leavecrud.datastructures.MergeSort;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class TicketService {
    private static final String FILE_PATH = "C:\\Users\\User\\Desktop\\ANC\\leavecrud\\tickets.json";
    private final CustomQueue<Ticket> ticketProcessingQueue = new CustomQueue<>();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // CRUD Operations
    public List<Ticket> getAllTickets() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return new ArrayList<>();
        }
        return objectMapper.readValue(file, new TypeReference<List<Ticket>>() {});
    }

    //Retrieve a ticket by its ID
    public Ticket getTicketById(String id) throws IOException {
        List<Ticket> tickets = getAllTickets();
        return tickets.stream()
                .filter(t -> t.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    //Create new ticket
    public Ticket createTicket(Ticket ticket) throws IOException {
        List<Ticket> tickets = getAllTickets();
        ticket.setId(UUID.randomUUID().toString());
        ticket.setCreatedDate(new Date());
        ticket.setStatus("PENDING");
        tickets.add(ticket);
        saveAllTickets(tickets);
        ticketProcessingQueue.enqueue(ticket); // Add to processing queue
        return ticket;
    }

    //Update ticket
    public Ticket updateTicket(String id, Ticket updatedTicket) throws IOException {
        List<Ticket> tickets = getAllTickets();
        for (int i = 0; i < tickets.size(); i++) {
            if (tickets.get(i).getId().equals(id)) {
                updatedTicket.setId(id);
                updatedTicket.setCreatedDate(tickets.get(i).getCreatedDate());
                tickets.set(i, updatedTicket);
                saveAllTickets(tickets);
                return updatedTicket;
            }
        }
        return null;
    }

    //delete ticket
    public void deleteTicket(String id) throws IOException {
        List<Ticket> tickets = getAllTickets();
        tickets.removeIf(t -> t.getId().equals(id));
        saveAllTickets(tickets);
    }

    // Queue Operations
    //Process and returns next ticket in the queue
    public Ticket processNextTicket() {
        return ticketProcessingQueue.isEmpty() ? null : ticketProcessingQueue.dequeue();
    }

    //retrieve all tickets currently in the processing queue
    public List<Ticket> getProcessingQueue() {
        List<Ticket> queueItems = new ArrayList<>();
        CustomQueue<Ticket> tempQueue = new CustomQueue<>();

        //move items to temp queue
        while (!ticketProcessingQueue.isEmpty()) {
            Ticket ticket = ticketProcessingQueue.dequeue();
            queueItems.add(ticket);
            tempQueue.enqueue(ticket);
        }

        // Restore the queue
        while (!tempQueue.isEmpty()) {
            ticketProcessingQueue.enqueue(tempQueue.dequeue());
        }

        return queueItems;
    }

    // Sorting Operations
    public List<Ticket> sortTicketsByEventDate(List<Ticket> tickets) {
        List<Ticket> sortedTickets = new ArrayList<>(tickets);
        MergeSort.sort(sortedTickets, Comparator.comparing(Ticket::getEventDate));
        return sortedTickets;
    }

    public List<Ticket> sortTicketsByTotalPayment(List<Ticket> tickets) {
        List<Ticket> sortedTickets = new ArrayList<>(tickets);
        MergeSort.sort(sortedTickets, Comparator.comparingDouble(Ticket::getTotalPayment));
        return sortedTickets;
    }

    // Helper method to save all tickets
    private void saveAllTickets(List<Ticket> tickets) throws IOException {
        objectMapper.writeValue(new File(FILE_PATH), tickets);
    }

    // Retrieve ticket by status
    public List<Ticket> getTicketsByStatus(String status) throws IOException {
        List<Ticket> allTickets = getAllTickets();
        List<Ticket> filteredTickets = new ArrayList<>();

        for (Ticket ticket : allTickets) {
            if (ticket.getStatus().equalsIgnoreCase(status)) {
                filteredTickets.add(ticket);
            }
        }
        return filteredTickets;
    }

    // Retrieve ticket by event name
    public List<Ticket> getTicketsByEventName(String eventName) throws IOException {
        List<Ticket> allTickets = getAllTickets();
        List<Ticket> filteredTickets = new ArrayList<>();

        for (Ticket ticket : allTickets) {
            if (ticket.getEventName().equalsIgnoreCase(eventName)) {
                filteredTickets.add(ticket);
            }
        }
        return filteredTickets;
    }

    //confirm
    public Ticket confirmTicket(String id) throws IOException {
        List<Ticket> tickets = getAllTickets();
        for (Ticket ticket : tickets) {
            if (ticket.getId().equals(id)) {
                ticket.setStatus("CONFIRMED");
                saveAllTickets(tickets);
                return ticket;
            }
        }
        return null;
    }

    //cancel
    public Ticket cancelTicket(String id) throws IOException {
        List<Ticket> tickets = getAllTickets();
        for (Ticket ticket : tickets) {
            if (ticket.getId().equals(id)) {
                ticket.setStatus("CANCELLED");
                saveAllTickets(tickets);
                return ticket;
            }
        }
        return null;
    }
}
