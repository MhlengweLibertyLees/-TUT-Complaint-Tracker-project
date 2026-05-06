package com.tut.complaint.servlet;

import com.tut.complaint.entity.Complaint;
import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.ComplaintFacadeLocal;
import com.tut.complaint.facade.AdminResponseFacadeLocal;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Handles complaint submission and viewing for students.
 * 
 * GET  /ComplaintServlet?action=list   → student's own complaints
 * GET  /ComplaintServlet?action=view&id=X → single complaint detail with responses
 * POST /ComplaintServlet               → submit a new complaint
 */
@WebServlet(name = "ComplaintServlet", urlPatterns = {"/ComplaintServlet"})
public class ComplaintServlet extends HttpServlet {

    @EJB private ComplaintFacadeLocal complaintFacade;
    @EJB private AdminResponseFacadeLocal  responseFacade;
    @EJB private UsersFacadeLocal     usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        if ("view".equals(action)) {
            // Show a single complaint and its admin responses
            String idParam = request.getParameter("id");
            if (idParam == null) {
                response.sendRedirect(request.getContextPath() + "/ComplaintServlet?action=list");
                return;
            }
            Complaint complaint = complaintFacade.find(Integer.parseInt(idParam));
            if (complaint == null || !complaint.getUser().getUserId().equals(userId)) {
                request.setAttribute("errorMessage", "Complaint not found.");
                request.getRequestDispatcher("/student/myComplaints.jsp").forward(request, response);
                return;
            }
            request.setAttribute("complaint", complaint);
            request.setAttribute("responses", responseFacade.findByComplaint(complaint.getComplaintId()));
            request.getRequestDispatcher("/student/complaintDetail.jsp").forward(request, response);

        } else {
            // Default: list all complaints for this student
            List<Complaint> complaints = complaintFacade.findByStudent(userId);
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("/student/myComplaints.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        String title       = request.getParameter("title");
        String description = request.getParameter("description");
        String category    = request.getParameter("category");
        String priority    = request.getParameter("priority");
        String anonParam   = request.getParameter("anonymous");

        if (isBlank(title) || isBlank(description) || isBlank(category)) {
            request.setAttribute("errorMessage", "Please fill in the title, description, and category.");
            request.getRequestDispatcher("/student/submitComplaint.jsp").forward(request, response);
            return;
        }

        Users student = usersFacade.find(userId);

        Complaint complaint = new Complaint();
        complaint.setUser(student);
        complaint.setTitle(title.trim());
        complaint.setDescription(description.trim());
        complaint.setCategory(category);
        complaint.setPriority(priority != null ? priority : "MEDIUM");
        complaint.setAnonymous("on".equals(anonParam));
        complaint.setReferenceNumber(generateReference());

        complaintFacade.create(complaint);

        response.sendRedirect(request.getContextPath() +
            "/ComplaintServlet?action=list&success=Your+complaint+has+been+submitted+successfully.+" +
            "Reference:+" + complaint.getReferenceNumber());
    }

    /**
     * Generates a unique reference number like TUT-2024-00042.
     * The timestamp-based counter ensures uniqueness without a separate sequence table.
     */
    private String generateReference() {
        String year = new SimpleDateFormat("yyyy").format(new Date());
        long count = complaintFacade.countAll() + 1;
        return String.format("TUT-%s-%05d", year, count);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
