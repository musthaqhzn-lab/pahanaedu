<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, com.icbt.model.Bill" %>
<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    int count = (bills != null) ? bills.size() : 0;
    DecimalFormat money = new DecimalFormat("#,##0.00");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>All Bills | Pahana Edu</title>
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
        <div class="ms-auto d-flex gap-2">
            <a class="btn btn-primary" href="BillServlet?action=new">
                <i class="bi bi-plus-lg me-1"></i> Create New Bill
            </a>
        </div>
    </div>
</nav>

<main class="container py-4 flex-grow-1">
    <header class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
        <div>
            <h1 class="h4 fw-bold mb-1">Bill List</h1>
            <div class="text-body-secondary">Manage all generated bills</div>
        </div>
        <span class="badge text-bg-secondary align-self-start">Total: <%= count %></span>
    </header>

    <!-- Filters -->
    <div class="card border-0 shadow-sm rounded-4 mb-3">
        <div class="card-body">
            <div class="row g-2 align-items-center">
                <div class="col-12 col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input id="tableSearch" type="text" class="form-control" placeholder="Search by Bill ID, Account Number...">
                    </div>
                </div>
                <div class="col-12 col-md-6 text-md-end">
                    <a href="main-menu.jsp" class="btn btn-outline-secondary">
                        ← Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Table / Empty state -->
    <div class="card border-0 shadow-sm rounded-4">
        <div class="card-body p-0">
            <% if (bills != null && !bills.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle mb-0" id="billsTable">
                    <thead class="table-light">
                    <tr>
                        <th>Bill ID</th>
                        <th>Account Number</th>
                        <th class="text-end">Total Amount (Rs.)</th>
                        <th>Bill Date</th>
                        <th class="text-center" style="width: 220px;">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Bill bill : bills) {
                        String dateStr = (bill.getBillDate() != null) ? sdf.format(bill.getBillDate()) : "-";
                    %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= bill.getAccountNumber() %></td>
                        <td class="text-end"><%= money.format(bill.getTotalAmount()) %></td>
                        <td><%= dateStr %></td>
                        <td class="text-center">
                            <div class="btn-group" role="group" aria-label="Actions">
                                <a class="btn btn-sm btn-outline-primary"
                                   href="BillServlet?action=edit&id=<%= bill.getBillId() %>&accountNumber=<%= bill.getAccountNumber() %>&totalAmount=<%= bill.getTotalAmount() %>&billDate=<%= bill.getBillDate() %>">
                                    <i class="bi bi-pencil-square me-1"></i>Edit
                                </a>
                                <a class="btn btn-sm btn-outline-danger"
                                   href="BillServlet?action=delete&id=<%= bill.getBillId() %>"
                                   onclick="return confirm('Are you sure you want to delete this bill?');">
                                    <i class="bi bi-trash me-1"></i>Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="p-4 p-md-5 text-center">
                <i class="bi bi-receipt fs-1 d-block mb-2"></i>
                <h2 class="h5 fw-semibold mb-1">No bills available</h2>
                <p class="text-body-secondary mb-3">Create your first bill to see it listed here.</p>
                <a class="btn btn-primary" href="BillServlet?action=new">
                    <i class="bi bi-plus-lg me-1"></i> Create New Bill
                </a>
            </div>
            <% } %>
        </div>
    </div>
</main>

<footer class="container py-4">
    <p class="text-center text-body-secondary small mb-0">
        &copy; 2025 Pahana Edu Bookshop System
    </p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Lightweight client-side search -->
<script>
    const searchInput = document.getElementById('tableSearch');
    const table = document.getElementById('billsTable');
    if (searchInput && table) {
        const rows = () => table.querySelectorAll('tbody tr');
        searchInput.addEventListener('input', () => {
            const q = searchInput.value.trim().toLowerCase();
            rows().forEach(tr => {
                const text = tr.innerText.toLowerCase();
                tr.style.display = text.includes(q) ? '' : 'none';
            });
        });
    }
</script>
</body>
</html>
