package com.tut.complaint.facade;

import com.tut.complaint.entity.Users;
import java.util.List;
import javax.ejb.Local;

/**
 * Local interface for the UsersFacade.
 * The web application injects this interface via @EJB — it never touches the facade directly.
 */
@Local
public interface UsersFacadeLocal {

    void create(Users user);
    void edit(Users user);
    void remove(Users user);
    Users find(Object id);
    List<Users> findAll();

    // Find a user by their username (used for login)
    Users findByUsername(String username);

    // Find a user by email (used during registration to prevent duplicates)
    Users findByEmail(String email);

    // Get all users with a given status: PENDING, ACTIVE, REJECTED
    List<Users> findByStatus(String status);

    // Get all users with a given role: ADMIN or STUDENT
    List<Users> findByRole(String role);

    // Count users with a given status — used for the admin dashboard stats
    long countByStatus(String status);
    
    //find users by status role
    List<Users> findByStatusAndRole(String status, String role);
    
}
