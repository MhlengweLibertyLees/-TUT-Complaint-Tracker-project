package com.tut.complaint.servlet;

import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Handles student self-registration.
 * New accounts are saved with status=PENDING and role=STUDENT.
 * The student cannot log in until an admin approves their account.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @EJB
    private UsersFacadeLocal usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName      = request.getParameter("fullName");
        String username      = request.getParameter("username");
        String email         = request.getParameter("email");
        String studentNumber = request.getParameter("studentNumber");
        String department    = request.getParameter("department");
        String password      = request.getParameter("password");
        String confirmPwd    = request.getParameter("confirmPassword");

        // ── Validation ───────────────────────────────────────────────────
        if (isBlank(fullName) || isBlank(username) || isBlank(email) ||
            isBlank(password) || isBlank(studentNumber)) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPwd)) {
            request.setAttribute("errorMessage", "Passwords do not match. Please try again.");
            forwardWithValues(request, response, fullName, username, email, studentNumber, department);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
            forwardWithValues(request, response, fullName, username, email, studentNumber, department);
            return;
        }

        // Check for duplicate username
        if (usersFacade.findByUsername(username.trim()) != null) {
            request.setAttribute("errorMessage", "That username is already taken. Please choose a different one.");
            forwardWithValues(request, response, fullName, username, email, studentNumber, department);
            return;
        }

        // Check for duplicate email
        if (usersFacade.findByEmail(email.trim()) != null) {
            request.setAttribute("errorMessage", "An account with that email address already exists.");
            forwardWithValues(request, response, fullName, username, email, studentNumber, department);
            return;
        }

        // ── Create the new account ───────────────────────────────────────
        Users newUser = new Users();
        newUser.setFullName(fullName.trim());
        newUser.setUsername(username.trim());
        newUser.setEmail(email.trim());
        newUser.setStudentNumber(studentNumber.trim());
        newUser.setDepartment(department != null ? department.trim() : "");
        newUser.setPasswordHash(LoginServlet.hashPassword(password));
        newUser.setRole("STUDENT");
        newUser.setStatus("PENDING"); // Waits for admin approval

        usersFacade.create(newUser);

        // Send to login page with a success message
        response.sendRedirect(request.getContextPath() +
            "/login.jsp?success=Your+account+has+been+created.+Please+wait+for+admin+approval+before+logging+in.");
    }

    private void forwardWithValues(HttpServletRequest req, HttpServletResponse res,
            String fullName, String username, String email,
            String studentNumber, String department) throws ServletException, IOException {
        req.setAttribute("fullName", fullName);
        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("studentNumber", studentNumber);
        req.setAttribute("department", department);
        req.getRequestDispatcher("/register.jsp").forward(req, res);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
