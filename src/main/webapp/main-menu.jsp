<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.icbt.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Pahana Edu – Main Menu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex flex-column min-vh-100">

<!-- Top bar -->
<nav class="navbar navbar-expand-lg bg-body shadow-sm">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center gap-2" href="#">
      <i class="bi bi-journal-check"></i>
      <span class="fw-semibold">Pahana Edu Billing</span>
    </a>
    <div class="ms-auto d-flex align-items-center gap-3">
      <span class="text-body-secondary small">
        Signed in as <strong><%= user.getUsername() %></strong>
      </span>
      <a class="btn btn-outline-danger"
         href="LogoutServlet"
         onclick="return confirm('Are you sure you want to logout?')">
        <i class="bi bi-box-arrow-right me-1"></i> Logout
      </a>
    </div>
  </div>
</nav>

<main class="container py-5 flex-grow-1">
  <header class="text-center mb-4">
    <h1 class="h4 fw-bold mb-1">Main Menu</h1>
    <p class="text-body-secondary mb-0">Choose an action to get started</p>
  </header>

  <!-- Menu grid -->
  <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-4">

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-person-plus display-6"></i>
          <h5 class="mt-3 mb-1">Add New Customer</h5>
          <p class="text-body-secondary small mb-0">Create a new customer profile.</p>
          <a href="add-new-customer.jsp" class="stretched-link" aria-label="Add New Customer"></a>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-pencil-square display-6"></i>
          <h5 class="mt-3 mb-1">Edit Customer</h5>
          <p class="text-body-secondary small mb-0">Search and update customer details.</p>
          <a href="CustomerServlet" class="stretched-link" aria-label="Edit Customer"></a>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-box-seam display-6"></i>
          <h5 class="mt-3 mb-1">Manage Items</h5>
          <p class="text-body-secondary small mb-0">Add, edit, or remove items.</p>
          <a href="ItemServlet" class="stretched-link" aria-label="Manage Items"></a>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-wallet2 display-6"></i>
          <h5 class="mt-3 mb-1">Display Account</h5>
          <p class="text-body-secondary small mb-0">View account balances and history.</p>
          <a href="display-account.jsp" class="stretched-link" aria-label="Display Account"></a>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-receipt display-6"></i>
          <h5 class="mt-3 mb-1">Print Bill</h5>
          <p class="text-body-secondary small mb-0">Generate and print customer bills.</p>
          <a href="BillServlet" class="stretched-link" aria-label="Print Bill"></a>
        </div>
      </div>
    </div>

    <div class="col">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-body text-center py-4">
          <i class="bi bi-life-preserver display-6"></i>
          <h5 class="mt-3 mb-1">Help</h5>
          <p class="text-body-secondary small mb-0">Documentation and support.</p>
          <a href="help.jsp" class="stretched-link" aria-label="Help"></a>
        </div>
      </div>
    </div>

  </div>
</main>

<footer class="container py-4">
  <p class="text-center text-body-secondary small mb-0">
    &copy; 2025 Pahana Edu Bookshop Billing System
  </p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
