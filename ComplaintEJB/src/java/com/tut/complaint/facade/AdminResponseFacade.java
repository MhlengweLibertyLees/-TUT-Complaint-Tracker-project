package com.tut.complaint.facade;

import com.tut.complaint.entity.AdminResponse;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * Stateless EJB for AdminResponse database operations.
 */
@Stateless
public class AdminResponseFacade extends AbstractFacade<AdminResponse> implements AdminResponseFacadeLocal {

    @PersistenceContext(unitName = "ComplaintPU")
    private EntityManager em;

    public AdminResponseFacade() {
        super(AdminResponse.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    public List<AdminResponse> findByComplaint(Integer complaintId) {
        return em.createNamedQuery("AdminResponse.findByComplaint")
                 .setParameter("complaintId", complaintId)
                 .getResultList();
    }
}
