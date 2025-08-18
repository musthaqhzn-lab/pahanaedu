package com.icbt.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Don't create if it doesn't exist
        if (session != null) {
            session.invalidate(); // Destroy the session
        }
        response.sendRedirect("login.jsp?message=logout"); // redirect to login page with message
    }
}
