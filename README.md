# 🎟️ Event Ticket Booking System

This is a Java-based **Event Ticket Booking System** developed as a university group project for the **Object-Oriented Programming (OOP)** module. It allows users to book, update, cancel, and view event tickets, using file handling and queue-based ticket processing.

---

## 🚀 Features

- ✅ Book, update, cancel, and view tickets (CRUD operations)
- 🧮 FIFO ticket processing using a **CustomQueue**
- 📂 Data storage with **JSON files**
- 📊 Sort tickets by:
  - Event Date
  - Total Payment (using Merge Sort)
- 🔐 Admin and User login (basic)
- 📌 Feedback system (optional)
- 🏛️ Venue management (team member components)

---

## 🧰 Technologies Used

- **Java**
- **Servlets** (`jakarta.servlet`)
- **Object-Oriented Programming**
- **Jackson Library** (for JSON handling)
- **IntelliJ IDEA** (as IDE)

---

## 🗂️ Project Structure

com.example.leavecrud
├── controllers # Handles HTTP requests
├── datastructures # CustomQueue and MergeSort
├── dto # TicketRequestDTO, TicketResponseDTO
├── models # Ticket, User, Admin, Venue, Payment
├── services # Business logic (TicketService)
└── servlets # Optional JSP/Servlet UIs


## 📚 OOP Concepts Applied

- **Encapsulation** – All class fields are private with getters/setters
- **Abstraction** – Service layer hides implementation details
- **Polymorphism** – CustomQueue is generic (`<T>`) and reusable
- **Inheritance** – Project supports extensibility (e.g., Admin/User)

---

## 💡 How to Run

1. Open the project in **IntelliJ IDEA**
2. Make sure your **Servlet container (Tomcat)** is configured
3. Run the application and use Postman or browser to test endpoints
4. JSON data will be saved to a file (`tickets.json`)

---

## 📁 File Path Configuration

You may need to update this path in `TicketService.java`:
```java
private static final String FILE_PATH = "C:\\...\\tickets.json";
