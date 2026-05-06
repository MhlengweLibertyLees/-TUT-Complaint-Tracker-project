package com.tut.complaint.servlet;

import com.tut.complaint.facade.ComplaintFacadeLocal;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Loads all data needed for the admin dashboard:
 * - Complaint counts by status (for the stat cards)
 * - All complaints (for the main table)
 * - Pending user count (for the notification badge)
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboardServlet"})
public class AdminDashboardServlet extends HttpServlet {

    @EJB private ComplaintFacadeLocal complaintFacade;
    @EJB private UsersFacadeLocal     usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Stat card counts
        request.setAttribute("totalComplaints",    complaintFacade.countAll());
        request.setAttribute("openCount",          complaintFacade.countByStatus("OPEN"));
        request.setAttribute("inProgressCount",    complaintFacade.countByStatus("IN_PROGRESS"));
        request.setAttribute("resolvedCount",      complaintFacade.countByStatus("RESOLVED"));
        request.setAttribute("closedCount",        complaintFacade.countByStatus("CLOSED"));

        // Pending user approvals badge
        request.setAttribute("pendingUsers",       usersFacade.countByStatus("PENDING"));

        // All complaints for the table — filtered by optional status param
        String filter = request.getParameter("filter");
        if (filter != null && !filter.isEmpty() && !"ALL".equals(filter)) {
            request.setAttribute("complaints", complaintFacade.findByStatus(filter));
            request.setAttribute("activeFilter", filter);
        } else {
            request.setAttribute("complaints", complaintFacade.findAll());
            request.setAttribute("activeFilter", "ALL");
        }

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
