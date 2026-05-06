package com.tut.complaint.servlet;

import com.tut.complaint.entity.AdminResponse;
import com.tut.complaint.entity.Complaint;
import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.ComplaintFacadeLocal;
import com.tut.complaint.facade.AdminResponseFacadeLocal;
import com.tut.complaint.facade.UsersFacadeLocal;
import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "RespondServlet", urlPatterns = {"/RespondServlet"})
public class RespondServlet extends HttpServlet {

    @EJB private ComplaintFacadeLocal complaintFacade;
    @EJB private AdminResponseFacadeLocal  responseFacade;
    @EJB private UsersFacadeLocal     usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            // If no id, redirect to admin dashboard (which lists all complaints)
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
            return;
        }

        Complaint complaint = complaintFacade.find(Integer.parseInt(idParam));
        if (complaint == null) {
            request.setAttribute("errorMessage", "Complaint not found.");
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            return;
        }

        request.setAttribute("complaint", complaint);
        request.setAttribute("responses", responseFacade.findByComplaint(complaint.getComplaintId()));
        request.getRequestDispatcher("/admin/viewComplaint.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session    = request.getSession(false);
        Integer adminId        = (Integer) session.getAttribute("userId");
        String complaintIdParam = request.getParameter("complaintId");
        String responseText    = request.getParameter("responseText");
        String newStatus       = request.getParameter("newStatus");
        String internalParam   = request.getParameter("internalNote");

        if (complaintIdParam == null || responseText == null || responseText.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() +
                "/RespondServlet?id=" + complaintIdParam + "&error=Response+text+cannot+be+empty");
            return;
        }

        Complaint complaint = complaintFacade.find(Integer.parseInt(complaintIdParam));
        Users admin         = usersFacade.find(adminId);

        AdminResponse adminResponse = new AdminResponse();
        adminResponse.setComplaint(complaint);
        adminResponse.setAdmin(admin);
        adminResponse.setResponseText(responseText.trim());
        adminResponse.setResponseDate(new Date());
        adminResponse.setInternalNote("on".equals(internalParam));

        if (newStatus != null && !newStatus.isEmpty() && !newStatus.equals(complaint.getStatus())) {
            adminResponse.setNewStatus(newStatus);
            complaint.setStatus(newStatus);
            complaint.setLastUpdated(new Date());
            complaintFacade.edit(complaint);
        }

        responseFacade.create(adminResponse);

        response.sendRedirect(request.getContextPath() +
            "/RespondServlet?id=" + complaintIdParam + "&success=Response+saved+successfully");
    }
}