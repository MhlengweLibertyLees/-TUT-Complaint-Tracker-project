package com.tut.complaint.servlet;

import com.tut.complaint.facade.UsersFacadeLocal;
import com.tut.complaint.entity.Users;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ManageUsers")
public class ManageUsersServlet extends HttpServlet {

    @EJB
    private UsersFacadeLocal usersFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Users> pending = usersFacade.findByStatusAndRole("PENDING", "STUDENT");
        List<Users> active  = usersFacade.findByStatusAndRole("ACTIVE", "STUDENT");
        List<Users> rejected = usersFacade.findByStatusAndRole("REJECTED", "STUDENT");

        request.setAttribute("pendingUsers", pending);
        request.setAttribute("activeUsers", active);
        request.setAttribute("rejectedUsers", rejected);

        request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
    }
}