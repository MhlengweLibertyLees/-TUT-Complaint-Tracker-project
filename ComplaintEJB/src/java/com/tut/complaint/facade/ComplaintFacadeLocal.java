package com.tut.complaint.facade;

import com.tut.complaint.entity.Complaint;
import java.util.List;
import javax.ejb.Local;

/**
 * Local interface for ComplaintFacade.
 */
@Local
public interface ComplaintFacadeLocal {

    void create(Complaint complaint);
    void edit(Complaint complaint);
    void remove(Complaint complaint);
    Complaint find(Object id);
    List<Complaint> findAll();

    // All complaints submitted by a specific student
    List<Complaint> findByStudent(Integer userId);

    // All complaints with a given status (OPEN, IN_PROGRESS, RESOLVED, CLOSED)
    List<Complaint> findByStatus(String status);

    // Filter complaints by category
    List<Complaint> findByCategory(String category);

    // Look up a complaint by its reference number (e.g. TUT-2024-0001)
    Complaint findByReference(String referenceNumber);

    // Count complaints by status — used for the admin dashboard cards
    long countByStatus(String status);

    // Total number of complaints in the system
    long countAll();
}
