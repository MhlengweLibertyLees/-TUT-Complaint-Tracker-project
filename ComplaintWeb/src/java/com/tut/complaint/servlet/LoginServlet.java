package com.tut.complaint.servlet;

import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @EJB
    private UsersFacadeLocal usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("role");
            redirectByRole(role, request, response);
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter both your username and password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        Users user = usersFacade.findByUsername(username.trim());

        if (user == null) {
            request.setAttribute("errorMessage", "No account found with that username. Please check and try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if ("PENDING".equals(user.getStatus())) {
            request.setAttribute("errorMessage",
                "Your account is still awaiting admin approval. You will be able to log in once approved.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if ("REJECTED".equals(user.getStatus())) {
            request.setAttribute("errorMessage",
                "Your account registration was not approved. Please contact the administrator.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        String hashedPassword = hashPassword(password);
        if (!hashedPassword.equals(user.getPasswordHash())) {
            request.setAttribute("errorMessage", "Incorrect password. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        // Store both individual attributes (for compatibility) and the full user object (for the navbar)
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("role", user.getRole());
        session.setAttribute("user", user);  // ← added for navbar
        session.setMaxInactiveInterval(30 * 60);

        redirectByRole(user.getRole(), request, response);
    }

    private void redirectByRole(String role, HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        if ("ADMIN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");
        } else {
            res.sendRedirect(req.getContextPath() + "/student/dashboard");
        }
    }

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("Could not hash password", e);
        }
    }
}