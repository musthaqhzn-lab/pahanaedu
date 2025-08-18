package com.icbt.servlet;

import com.icbt.model.User;
import com.icbt.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    // GET: if already logged in, go to main menu; else show login page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/main-menu.jsp");
            return;
        }

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    // POST: authenticate
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String password = trim(req.getParameter("password"));

        if (isBlank(username) || isBlank(password)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=true");
            return;
        }

        User user = userService.login(username, password);

        if (user != null) {
            // (Optional) session fixation protection: renew session id
            HttpSession old = req.getSession(false);
            if (old != null) old.invalidate();
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);

            // Forward to main menu
            req.getRequestDispatcher("/main-menu.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=true");
        }
    }

    // ----- helpers -----
    private static String trim(String s) { return s == null ? null : s.trim(); }
    private static boolean isBlank(String s) { return s == null || s.trim().isEmpty(); }
}
