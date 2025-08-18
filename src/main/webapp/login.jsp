<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Login | Pahana Edu Billing System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex flex-column min-vh-100">

<%
    String error = request.getParameter("error");
    String message = request.getParameter("message");
%>

<!-- Minimal top brand -->
<nav class="navbar navbar-expand-lg bg-body shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="#">
            <i class="bi bi-journal-check"></i>
            <span class="fw-semibold">Pahana Edu Billing</span>
        </a>
    </div>
</nav>

<main class="container flex-grow-1 d-flex align-items-center">
    <div class="row justify-content-center w-100">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">

            <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="row g-0">
                    <!-- Left: form -->
                    <div class="col-12">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center mb-4">
                                <h1 class="h4 fw-bold mb-1">Welcome back</h1>
                                <p class="text-body-secondary mb-0">Sign in to continue</p>
                            </div>

                            <%-- Messages --%>
                            <%
                                if ("logout".equals(message)) {
                            %>
                            <div class="alert alert-success d-flex align-items-center" role="alert">
                                <i class="bi bi-check-circle me-2"></i><div>Logout successful!</div>
                            </div>
                            <%
                            } else if (error != null) {
                            %>
                            <div class="alert alert-danger d-flex align-items-center" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i><div>Invalid username or password.</div>
                            </div>
                            <%
                                }
                            %>

                            <form action="login" method="post" class="needs-validation" novalidate id="loginForm">
                                <!-- Username -->
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="username" name="username" placeholder="username" required>
                                    <label for="username"><i class="bi bi-person me-1"></i> Username</label>
                                    <div class="invalid-feedback">Please enter your username.</div>
                                </div>

                                <!-- Password with toggle -->
                                <div class="input-group mb-3">
                                    <div class="form-floating flex-grow-1">
                                        <input type="password" class="form-control" id="password" name="password" placeholder="password" required>
                                        <label for="password"><i class="bi bi-lock me-1"></i> Password</label>
                                        <div class="invalid-feedback">Please enter your password.</div>
                                    </div>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePwd" tabindex="-1" aria-label="Show password">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="remember">
                                        <label class="form-check-label" for="remember">Remember me</label>
                                    </div>
                                    <a href="help.jsp" class="link-primary text-decoration-none">Need help?</a>
                                </div>

                                <button id="submitBtn" type="submit" class="btn btn-primary w-100 d-flex justify-content-center align-items-center gap-2">
                                    <span class="btn-text">Login</span>
                                    <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                                </button>
                            </form>

                            <!-- Divider -->
                            <div class="d-flex align-items-center my-4">
                                <hr class="flex-grow-1">
                                <span class="mx-2 text-body-tertiary small">or</span>
                                <hr class="flex-grow-1">
                            </div>

                            <!-- Optional quick links -->
                            <div class="d-grid gap-2">
                                <a class="btn btn-outline-secondary" href="#">
                                    <i class="bi bi-shield-lock me-2"></i>
                                    Use single sign-on (SSO)
                                </a>
                            </div>

                        </div>
                    </div>
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

<!-- No custom CSS; small JS to enhance UX -->
<script>
    // Floating-label validation
    (() => {
        'use strict';
        const form = document.getElementById('loginForm');
        const submitBtn = document.getElementById('submitBtn');
        const spinner = submitBtn.querySelector('.spinner-border');
        const btnText = submitBtn.querySelector('.btn-text');

        form.addEventListener('submit', (e) => {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            } else {
                // Busy state
                submitBtn.disabled = true;
                spinner.classList.remove('d-none');
                btnText.textContent = 'Signing in...';
            }
            form.classList.add('was-validated');
        }, false);
    })();

    // Show/hide password
    const togglePwd = document.getElementById('togglePwd');
    const pwd = document.getElementById('password');
    togglePwd.addEventListener('click', () => {
        const isText = pwd.type === 'text';
        pwd.type = isText ? 'password' : 'text';
        togglePwd.innerHTML = isText ? '<i class="bi bi-eye"></i>' : '<i class="bi bi-eye-slash"></i>';
        togglePwd.setAttribute('aria-label', isText ? 'Show password' : 'Hide password');
    });
</script>
</body>
</html>
