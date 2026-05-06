package com.tut.complaint.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * RoleFilter — enforces role-based access control.
 * 
 * - /admin/* pages require role = ADMIN
 * - /student/* pages require role = STUDENT
 * 
 * If a student tries to access /admin/* (or vice versa), they see a 403 page
 * with a clear "You are not authorised" message.
 */
@WebFilter(filterName = "RoleFilter", urlPatterns = {"/admin/*", "/student/*"})
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean accessGranted = false;

        if (path.startsWith("/admin/") || path.contains("/AdminDashboardServlet")
                || path.contains("/ApproveUserServlet") || path.contains("/RespondServlet")
                || path.contains("/UpdateStatusServlet")) {
            accessGranted = "ADMIN".equals(role);
        } else if (path.startsWith("/student/") || path.contains("/ComplaintServlet")) {
            accessGranted = "STUDENT".equals(role);
        } else {
            // Path doesn't match either pattern — just let it through
            accessGranted = true;
        }

        if (accessGranted) {
            chain.doFilter(request, response);
        } else {
            // Forward to the 403 error page instead of sending an HTTP 403
            // This gives us a nice styled page with navigation
            req.setAttribute("attemptedPath", path);
            req.setAttribute("userRole", role);
            req.getRequestDispatcher("/error/403.jsp").forward(req, res);
        }
    }

    @Override public void init(FilterConfig fc) throws ServletException {}
    @Override public void destroy() {}
}
