<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Help & User Guide | Pahana Edu</title>
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
    <div class="ms-auto">
      <a href="main-menu.jsp" class="btn btn-outline-secondary">← Back to Home</a>
    </div>
  </div>
</nav>

<main class="container py-5 flex-grow-1">
  <div class="row justify-content-center">
    <div class="col-12 col-lg-10">
      <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body p-4 p-md-5">

          <div class="text-center mb-4">
            <h1 class="h4 fw-bold mb-2">📘 Pahana Edu Billing System — User Help Guide</h1>
            <p class="text-body-secondary mb-0">
              Welcome! This guide will help you get started and make the most of the system.
            </p>
          </div>

          <!-- Tip -->
          <div class="alert alert-info d-flex align-items-start" role="alert">
            <i class="bi bi-lightbulb me-2 fs-5"></i>
            <div><strong>Tip:</strong> Always double-check item quantities and the selected customer before saving a bill.</div>
          </div>

          <!-- Accordion -->
          <div class="accordion" id="helpAccordion">

            <!-- Logging In -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingLogin">
                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLogin" aria-expanded="true" aria-controls="collapseLogin">
                  🔐 Logging In
                </button>
              </h2>
              <div id="collapseLogin" class="accordion-collapse collapse show" aria-labelledby="headingLogin" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">Enter your username and password on the login page.</li>
                    <li class="list-group-item">If successful, you will be redirected to the main dashboard.</li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- Main Dashboard -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingDashboard">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDashboard" aria-expanded="false" aria-controls="collapseDashboard">
                  🏠 Main Dashboard
                </button>
              </h2>
              <div id="collapseDashboard" class="accordion-collapse collapse" aria-labelledby="headingDashboard" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <p class="mb-2">From the dashboard you can quickly access:</p>
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">Customer management</li>
                    <li class="list-group-item">Items (add, edit, view)</li>
                    <li class="list-group-item">Billing (create, update, view bills)</li>
                    <li class="list-group-item">This Help page</li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- Customer Management -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingCustomers">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCustomers" aria-expanded="false" aria-controls="collapseCustomers">
                  👥 Customer Management
                </button>
              </h2>
              <div id="collapseCustomers" class="accordion-collapse collapse" aria-labelledby="headingCustomers" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">Add a new customer using the “Add Customer” form.</li>
                    <li class="list-group-item">Edit existing customer details when needed.</li>
                    <li class="list-group-item">View the list of all registered customers.</li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- Item Management -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingItems">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseItems" aria-expanded="false" aria-controls="collapseItems">
                  📚 Item Management
                </button>
              </h2>
              <div id="collapseItems" class="accordion-collapse collapse" aria-labelledby="headingItems" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">Add new books/items to your stock.</li>
                    <li class="list-group-item">Edit item information such as price or quantity.</li>
                    <li class="list-group-item">View all available items and current stock levels.</li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- Billing -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingBilling">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseBilling" aria-expanded="false" aria-controls="collapseBilling">
                  🧾 Billing
                </button>
              </h2>
              <div id="collapseBilling" class="accordion-collapse collapse" aria-labelledby="headingBilling" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item">Create a new bill by selecting a customer and items.</li>
                    <li class="list-group-item">Edit or update existing bills.</li>
                    <li class="list-group-item">Automatically calculate totals and view all bills.</li>
                  </ul>
                </div>
              </div>
            </div>

            <!-- More Help -->
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingSupport">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSupport" aria-expanded="false" aria-controls="collapseSupport">
                  ❓ Need More Help?
                </button>
              </h2>
              <div id="collapseSupport" class="accordion-collapse collapse" aria-labelledby="headingSupport" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                  <p class="mb-0">
                    If you encounter issues or need additional support, contact the system administrator
                    or refer to the technical documentation provided with the system.
                  </p>
                </div>
              </div>
            </div>

          </div>

          <!-- Quick Links -->
          <div class="row g-3 mt-4">
            <div class="col-12 col-md-6">
              <a class="btn btn-outline-primary w-100" href="display-account.jsp">
                <i class="bi bi-person-badge me-1"></i> Find Customer
              </a>
            </div>
            <div class="col-12 col-md-6">
              <a class="btn btn-outline-primary w-100" href="BillServlet">
                <i class="bi bi-receipt me-1"></i> Go to Billing
              </a>
            </div>
          </div>

          <p class="text-center text-body-secondary small mt-4 mb-0">
            &copy; 2025 Pahana Edu Bookshop System | Help Page
          </p>

        </div>
      </div>
    </div>
  </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
