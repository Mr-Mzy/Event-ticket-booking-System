<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>Event Ticket Management System</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap 5 CSS (Dark version) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <!-- AOS (Animate On Scroll) CSS -->
  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <!-- Custom CSS -->
  <style>
    body {
      background-color: #121212;
      color: #e0e0e0;
      font-family: 'Poppins', sans-serif;
      overflow-x: hidden;
    }
    .hero-section {
      height: 70vh;
      background: linear-gradient(135deg, #1a1a1a 0%, #0d0d0d 100%);
      position: relative;
    }
    .hero-content {
      position: relative;
      z-index: 2;
    }
    .feature-card {
      background-color: #1e1e1e;
      border-radius: 10px;
      border: 1px solid #333;
      transition: all 0.3s ease-in-out;
      overflow: hidden;
    }
    .feature-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.3);
      border-color: #6c63ff;
    }
    .card-icon {
      font-size: 2.5rem;
      margin-bottom: 15px;
      color: #6c63ff;
    }
    .btn-custom {
      background: linear-gradient(45deg, #6c63ff, #4c46e6);
      border: none;
      color: white;
      position: relative;
      z-index: 1;
      overflow: hidden;
      transition: all 0.3s ease;
    }
    .btn-custom:hover {
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 7px 15px rgba(108, 99, 255, 0.3);
    }
    .btn-custom::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 0%;
      height: 100%;
      background: rgba(255, 255, 255, 0.1);
      transition: all 0.3s ease;
      z-index: -1;
    }
    .btn-custom:hover::before {
      width: 100%;
    }
    .navbar {
      background-color: rgba(18, 18, 18, 0.95) !important;
      backdrop-filter: blur(10px);
    }
    .particle {
      position: absolute;
      border-radius: 50%;
    }
    @media (max-width: 768px) {
      .hero-section {
        height: auto;
        padding: 80px 0;
      }
    }
    .footer {
      background-color: #0d0d0d;
      padding: 30px 0;
    }
    .animate-character {
      background-image: linear-gradient(
              -225deg,
              #6c63ff 0%,
              #3c70ee 29%,
              #4c46e6 67%,
              #2980b9 100%
      );
      background-size: 200% auto;
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      animation: textclip 2s linear infinite;
    }
    @keyframes textclip {
      to {
        background-position: 200% center;
      }
    }
  </style>
  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">
      <i class="bi bi-ticket-perforated me-2"></i>EventTix
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/tickets.jsp">Tickets</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/venues.jsp">Venues</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#about">About</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero Section -->
<section class="hero-section d-flex align-items-center">
  <div class="container hero-content">
    <div class="row align-items-center">
      <div class="col-lg-6 mb-4 mb-lg-0" data-aos="fade-right" data-aos-duration="1000">
        <h1 class="display-4 fw-bold mb-4">Welcome to <span class="animate-character">EventTix</span> Management System</h1>
        <p class="lead mb-4">Streamline your event ticketing process with our powerful and intuitive platform.</p>
        <div class="d-flex gap-3">
          <a href="${pageContext.request.contextPath}/tickets.jsp" class="btn btn-custom btn-lg px-4">Explore Tickets</a>
          <a href="${pageContext.request.contextPath}/ticket-add" class="btn btn-outline-light btn-lg px-4">Create Ticket</a>
        </div>
      </div>
      <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000">
        <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" class="d-none" alt="Preload"/>
        <div id="lottie-container" class="w-100" style="height: 400px;"></div>
      </div>
    </div>
  </div>
</section>

<!-- Features Section -->
<section class="py-5 mt-4">
  <div class="container">
    <div class="row text-center mb-5">
      <div class="col-12" data-aos="fade-up">
        <h2 class="fw-bold">Key Features</h2>
        <p class="text-muted">Everything you need to manage your events efficiently</p>
      </div>
    </div>
    <div class="row">
      <!-- Feature 1 -->
      <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="100">
        <div class="feature-card h-100 p-4 text-center">
          <div class="card-icon">
            <i class="bi bi-ticket-perforated"></i>
          </div>
          <h5 class="fw-bold">Ticket Management</h5>
          <p class="text-muted mb-0">Create, edit, and manage tickets for all your events with ease.</p>
        </div>
      </div>
      <!-- Feature 2 -->
      <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
        <div class="feature-card h-100 p-4 text-center">
          <div class="card-icon">
            <i class="bi bi-geo-alt"></i>
          </div>
          <h5 class="fw-bold">Venue Organization</h5>
          <p class="text-muted mb-0">Manage all your venues and allocate tickets efficiently.</p>
        </div>
      </div>
      <!-- Feature 3 -->
      <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="300">
        <div class="feature-card h-100 p-4 text-center">
          <div class="card-icon">
            <i class="bi bi-graph-up"></i>
          </div>
          <h5 class="fw-bold">Detailed Analytics</h5>
          <p class="text-muted mb-0">Track sales, performance, and attendance with powerful insights.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Quick Actions Section -->
<section class="py-5 bg-dark">
  <div class="container">
    <div class="row text-center mb-5">
      <div class="col-12" data-aos="fade-up">
        <h2 class="fw-bold">Quick Actions</h2>
        <p class="text-muted">Get started with these common tasks</p>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-lg-10">
        <div class="row g-4">
          <!-- Action 1 -->
          <div class="col-md-6" data-aos="zoom-in" data-aos-delay="100">
            <a href="${pageContext.request.contextPath}/tickets.jsp" class="text-decoration-none">
              <div class="feature-card h-100 p-4 d-flex align-items-center">
                <i class="bi bi-list-ul card-icon me-3" style="font-size: 2rem;"></i>
                <div>
                  <h5 class="mb-1 text-white">View All Tickets</h5>
                  <p class="text-muted mb-0">Browse and manage existing tickets</p>
                </div>
              </div>
            </a>
          </div>
          <!-- Action 2 -->
          <div class="col-md-6" data-aos="zoom-in" data-aos-delay="200">
            <a href="${pageContext.request.contextPath}/ticket-add" class="text-decoration-none">
              <div class="feature-card h-100 p-4 d-flex align-items-center">
                <i class="bi bi-plus-circle card-icon me-3" style="font-size: 2rem;"></i>
                <div>
                  <h5 class="mb-1 text-white">Create New Ticket</h5>
                  <p class="text-muted mb-0">Add a new ticket to the system</p>
                </div>
              </div>
            </a>
          </div>
          <!-- Action 3 -->
          <div class="col-md-6" data-aos="zoom-in" data-aos-delay="300">
            <a href="${pageContext.request.contextPath}/venues.jsp" class="text-decoration-none">
              <div class="feature-card h-100 p-4 d-flex align-items-center">
                <i class="bi bi-building card-icon me-3" style="font-size: 2rem;"></i>
                <div>
                  <h5 class="mb-1 text-white">Manage Venues</h5>
                  <p class="text-muted mb-0">View and edit venue information</p>
                </div>
              </div>
            </a>
          </div>
          <!-- Action 4 -->
          <div class="col-md-6" data-aos="zoom-in" data-aos-delay="400">
            <a href="${pageContext.request.contextPath}/venue-add" class="text-decoration-none">
              <div class="feature-card h-100 p-4 d-flex align-items-center">
                <i class="bi bi-plus-square card-icon me-3" style="font-size: 2rem;"></i>
                <div>
                  <h5 class="mb-1 text-white">Add New Venue</h5>
                  <p class="text-muted mb-0">Register a new venue in the system</p>
                </div>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- About Section -->
<section id="about" class="py-5">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-6 mb-4 mb-lg-0" data-aos="fade-right">
        <h2 class="fw-bold mb-4">About Our System</h2>
        <p class="mb-4">The Event Ticket Management System is designed to streamline the process of creating, managing, and tracking tickets for various events. Our platform provides an intuitive interface for event organizers to efficiently handle all aspects of ticket management.</p>
        <p>With our system, you can easily create new tickets, edit existing ones, manage venues, and track important metrics. The platform is designed to be user-friendly while providing powerful features to meet all your event management needs.</p>
      </div>
      <div class="col-lg-6" data-aos="fade-left">
        <div class="feature-card p-4">
          <div class="ratio ratio-16x9">
            <div id="stats-animation" style="height: 300px;"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer mt-5">
  <div class="container">
    <div class="row">
      <div class="col-12 text-center">
        <p class="mb-0">&copy; 2025 Event Ticket Management System. All rights reserved.</p>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS (Animate On Scroll) JS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Lottie Animation JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.12.0/lottie.min.js"></script>

<script>
  // Initialize AOS (Animate On Scroll)
  document.addEventListener('DOMContentLoaded', function() {
    AOS.init({
      duration: 800,
      easing: 'ease-in-out',
      once: true
    });

    // Load Lottie animation
    const ticketAnimation = lottie.loadAnimation({
      container: document.getElementById('lottie-container'),
      renderer: 'svg',
      loop: true,
      autoplay: true,
      path: 'https://assets5.lottiefiles.com/packages/lf20_khzniaya.json' // Event/ticket related animation
    });

    // Stats animation
    const statsAnimation = lottie.loadAnimation({
      container: document.getElementById('stats-animation'),
      renderer: 'svg',
      loop: true,
      autoplay: true,
      path: 'https://assets1.lottiefiles.com/packages/lf20_l4ny0jhr.json' // Data/stats related animation
    });

    // Create particles
    createParticles();

    // Navbar color change on scroll
    window.addEventListener('scroll', function() {
      const navbar = document.querySelector('.navbar');
      if (window.scrollY > 50) {
        navbar.style.backgroundColor = 'rgba(13, 13, 13, 0.95)';
      } else {
        navbar.style.backgroundColor = 'rgba(18, 18, 18, 0.95)';
      }
    });
  });

  // Particle animation
  function createParticles() {
    const count = 30;
    const heroSection = document.querySelector('.hero-section');

    for (let i = 0; i < count; i++) {
      let particle = document.createElement('div');
      particle.className = 'particle';

      const size = Math.random() * 5 + 1;
      const posX = Math.random() * 100;
      const posY = Math.random() * 100;
      const opacity = Math.random() * 0.5 + 0.1;
      const duration = Math.random() * 20 + 10;
      const delay = Math.random() * 5;

      particle.style.width = `${size}px`;
      particle.style.height = `${size}px`;
      particle.style.left = `${posX}%`;
      particle.style.top = `${posY}%`;
      particle.style.opacity = opacity;
      particle.style.backgroundColor = '#6c63ff';
      particle.style.animation = `float ${duration}s ease-in infinite ${delay}s`;

      heroSection.appendChild(particle);
    }
  }

  // Add floating animation
  document.head.insertAdjacentHTML('beforeend', `
      <style>
        @keyframes float {
          0% {
            transform: translateY(0) rotate(0deg);
            opacity: 0.5;
          }
          50% {
            transform: translateY(-20px) rotate(180deg);
            opacity: 0.8;
          }
          100% {
            transform: translateY(0) rotate(360deg);
            opacity: 0.5;
          }
        }
      </style>
    `);
</script>
</body>
</html>