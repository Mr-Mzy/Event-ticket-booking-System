//ticket from models
package com.example.leavecrud.models;
import java.util.Date;
import java.util.UUID;

public class Ticket {
    private String id;
    private String eventName;
    private int numberOfTickets;
    private double totalPayment;
    private Date createdDate;
    private Date eventDate;
    private String status; // e.g., "PENDING", "CONFIRMED", "CANCELLED"

    // Constructors
    public Ticket() {
        this.id = UUID.randomUUID().toString();
        this.createdDate = new Date();
        this.status = "PENDING";
    }

    public Ticket(String eventName, int numberOfTickets, double totalPayment, Date eventDate) {
        this();
        this.eventName = eventName;
        this.numberOfTickets = numberOfTickets;
        this.totalPayment = totalPayment;
        this.eventDate = eventDate;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    public int getNumberOfTickets() { return numberOfTickets; }
    public void setNumberOfTickets(int numberOfTickets) { this.numberOfTickets = numberOfTickets; }
    public double getTotalPayment() { return totalPayment; }
    public void setTotalPayment(double totalPayment) { this.totalPayment = totalPayment; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    public Date getEventDate() { return eventDate; }
    public void setEventDate(Date eventDate) { this.eventDate = eventDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}