

/**
 *
 * @author Liberty Chauke
 */
package com.tut.complaint.servlet;

import com.tut.complaint.entity.Users;
import com.tut.complaint.facade.ComplaintFacadeLocal;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
    @EJB private ComplaintFacadeLocal complaintFacade;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Users user = (session != null) ? (Users) session.getAttribute("user") : null;
        if (user == null || !"STUDENT".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        req.setAttribute("complaints", complaintFacade.findByStudent(user.getUserId()));
        req.getRequestDispatcher("/student/dashboard.jsp").forward(req, resp);
    }
}