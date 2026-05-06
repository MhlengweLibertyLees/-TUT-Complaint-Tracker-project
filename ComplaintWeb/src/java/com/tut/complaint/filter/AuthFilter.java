package com.tut.complaint.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * AuthFilter — runs on every request.
 * If the user hasn't logged in yet, they get redirected to the login page.
 * Public pages (login, register, home, CSS/JS) are excluded from this check.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    // Pages that anyone can visit without logging in
    private static final String[] PUBLIC_PATHS = {
        "/index.jsp", "/login.jsp", "/register.jsp",
        "/LoginServlet", "/RegisterServlet",
        "/css/", "/js/", "/images/"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Let public pages through without checking
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if the user has a valid session
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        if (!loggedIn) {
            // Save where they were trying to go so we can redirect after login
            res.sendRedirect(req.getContextPath() + "/login.jsp?message=Please+log+in+to+continue");
        } else {
            chain.doFilter(request, response);
        }
    }

    private boolean isPublicPath(String path) {
        for (String pub : PUBLIC_PATHS) {
            if (path.startsWith(pub) || path.equals(pub)) {
                return true;
            }
        }
        // Also allow the root context path itself
        return path.equals("/") || path.isEmpty();
    }

    @Override public void init(FilterConfig fc) throws ServletException {}
    @Override public void destroy() {}
}
