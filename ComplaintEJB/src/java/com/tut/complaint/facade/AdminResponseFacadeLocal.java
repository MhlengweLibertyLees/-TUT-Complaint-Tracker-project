package com.tut.complaint.facade;

import com.tut.complaint.entity.AdminResponse;
import java.util.List;
import javax.ejb.Local;

/**
 * Local interface for AdminResponseFacade.
 */
@Local
public interface AdminResponseFacadeLocal {

    void create(AdminResponse response);
    void edit(AdminResponse response);
    void remove(AdminResponse response);
    AdminResponse find(Object id);
    List<AdminResponse> findAll();

    // All responses for a specific complaint, ordered oldest first (for thread view)
    List<AdminResponse> findByComplaint(Integer complaintId);
}
