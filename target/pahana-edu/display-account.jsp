<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.icbt.model.Customer" %>
<%@ page import="com.icbt.dao.CustomerDAO" %>
<%
    String accountNumberStr = request.getParameter("accountNumber");
    Customer customer = null;
    if (accountNumberStr != null && !accountNumberStr.trim().isEmpty()) {
        try {
            int accountNumber = Integer.parseInt(accountNumberStr.trim());
            CustomerDAO dao = new CustomerDAO();
            customer = dao.getCustomerById(accountNumber);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid account number format.");
        }
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Display Account Details | Pahana Edu</title>
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
        <a class="navbar-brand d-flex align-items-center gap-2" href="main-menu.jsp">
            <i class="bi bi-journal-check"></i>
            <span class="fw-semibold">Pahana Edu Billing</span>
        </a>
    </div>
</nav>

<main class="container py-5 flex-grow-1">
    <header class="text-center mb-4">
        <h1 class="h4 fw-bold mb-1">Search Customer by Account Number</h1>
        <p class="text-body-secondary mb-0">Enter an account number to view customer details</p>
    </header>

    <!-- Search form -->
    <div class="card border-0 shadow-lg rounded-4 mb-4">
        <div class="card-body p-4 p-md-5">
            <% if (error != null) { %>
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>
                <div><%= error %></div>
            </div>
            <% } %>

            <form method="get" action="display-account.jsp">
                <label for="accountNumber" class="form-label fw-semibold">
                    <i class="bi bi-hash me-1"></i> Account Number
                </label>
                <div class="input-group mb-3">
                    <span class="input-group-text">ACC</span>
                    <input
                            type="text"
                            class="form-control"
                            name="accountNumber"
                            id="accountNumber"
                            placeholder="e.g., 12345"
                            value="<%= (accountNumberStr != null ? accountNumberStr : "") %>"
                            required>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="main-menu.jsp" class="btn btn-outline-secondary">← Back to Home</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search me-1"></i> Search
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Results -->
    <% if (customer != null) { %>
    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-4">
            <h2 class="h5 fw-bold mb-3">Customer Details</h2>
            <div class="row g-3">
                <div class="col-12 col-md-6">
                    <div class="border rounded-3 p-3 h-100">
                        <div class="text-body-secondary small mb-1">Account Number</div>
                        <div class="fw-semibold"><%= customer.getAccountNumber() %></div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="border rounded-3 p-3 h-100">
                        <div class="text-body-secondary small mb-1">Name</div>
                        <div class="fw-semibold"><%= customer.getName() %></div>
                    </div>
                </div>
                <div class="col-12 col-md-8">
                    <div class="border rounded-3 p-3 h-100">
                        <div class="text-body-secondary small mb-1">Address</div>
                        <div class="fw-semibold"><%= customer.getAddress() %></div>
                    </div>
                </div>
                <div class="col-12 col-md-4">
                    <div class="border rounded-3 p-3 h-100">
                        <div class="text-body-secondary small mb-1">Telephone</div>
                        <div class="fw-semibold"><%= customer.getTelephone() %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else if (accountNumberStr != null && error == null) { %>
    <div class="alert alert-warning d-flex align-items-center" role="alert">
        <i class="bi bi-info-circle me-2"></i>
        <div>No customer found with the given account number.</div>
    </div>
    <% } %>
</main>

<footer class="container py-4">
    <p class="text-center text-body-secondary small mb-0">
        &copy; 2025 Pahana Edu Bookshop System
    </p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
