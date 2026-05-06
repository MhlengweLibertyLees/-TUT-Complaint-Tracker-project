package com.tut.complaint.servlet;

import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Handles admin approval and rejection of student registrations.
 * Also handles listing pending users.
 * 
 * GET  /ApproveUserServlet              → show all pending users
 * POST /ApproveUserServlet?action=approve&id=X → approve
 * POST /ApproveUserServlet?action=reject&id=X  → reject
 */
@WebServlet(name = "ApproveUserServlet", urlPatterns = {"/ApproveUserServlet"})
public class ApproveUserServlet extends HttpServlet {

    @EJB private UsersFacadeLocal usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pendingUsers",  usersFacade.findByStatus("PENDING"));
        request.setAttribute("activeUsers",   usersFacade.findByStatus("ACTIVE"));
        request.setAttribute("rejectedUsers", usersFacade.findByStatus("REJECTED"));
        request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action  = request.getParameter("action");
        String idParam = request.getParameter("id");
        HttpSession session = request.getSession(false);
        Integer adminId = (Integer) session.getAttribute("userId");

        if (idParam == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/ApproveUserServlet");
            return;
        }

        Users user = usersFacade.find(Integer.parseInt(idParam));
        if (user == null) {
            response.sendRedirect(request.getContextPath() +
                "/ApproveUserServlet?error=User+not+found");
            return;
        }

        if ("approve".equals(action)) {
            user.setStatus("ACTIVE");
            user.setApprovedBy(adminId);
            user.setApprovedDate(new Date());
            usersFacade.edit(user);
            response.sendRedirect(request.getContextPath() +
                "/ApproveUserServlet?success=" + user.getFullName() + "+has+been+approved.");
        } else if ("reject".equals(action)) {
            user.setStatus("REJECTED");
            user.setApprovedBy(adminId);
            user.setApprovedDate(new Date());
            usersFacade.edit(user);
            response.sendRedirect(request.getContextPath() +
                "/ApproveUserServlet?success=" + user.getFullName() + "+has+been+rejected.");
        } else {
            response.sendRedirect(request.getContextPath() + "/ApproveUserServlet");
        }
    }
}
