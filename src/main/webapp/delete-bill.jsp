<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int billId = Integer.parseInt(request.getParameter("billId"));
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Delete Bill | Pahana Edu</title>
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

<main class="container flex-grow-1 d-flex align-items-center py-5">
    <div class="row justify-content-center w-100">
        <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
            <div class="card border-0 shadow-lg rounded-4">
                <div class="card-body p-4 p-md-5 text-center">
                    <div class="mb-3">
                        <i class="bi bi-exclamation-octagon text-danger" style="font-size: 2.5rem;"></i>
                    </div>
                    <h1 class="h4 fw-bold mb-2">Confirm Delete Bill</h1>
                    <p class="text-body-secondary mb-4">
                        Are you sure you want to permanently delete
                        <span class="fw-semibold">Bill ID</span>
                        <span class="badge text-bg-danger align-middle">#<%= billId %></span>?
                        This action cannot be undone.
                    </p>

                    <form action="BillDeleteServlet" method="post" class="d-grid gap-2">
                        <input type="hidden" name="billId" value="<%= billId %>" />
                        <button type="submit" class="btn btn-danger d-flex justify-content-center align-items-center gap-2">
                            <i class="bi bi-trash"></i>
                            Delete Bill
                        </button>
                        <button type="button" class="btn btn-outline-secondary d-flex justify-content-center align-items-center gap-2"
                                onclick="window.location.href='billing.jsp'">
                            <i class="bi bi-arrow-left"></i>
                            Cancel
                        </button>
                    </form>
                </div>
            </div>

            <p class="text-center text-body-secondary small mt-4 mb-0">
                &copy; 2025 Pahana Edu Bookshop System
            </p>
        </div>
    </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
