package com.tut.complaint.facade;

import com.tut.complaint.entity.Complaint;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 * Stateless EJB for all Complaint database operations.
 */
@Stateless
public class ComplaintFacade extends AbstractFacade<Complaint> implements ComplaintFacadeLocal {

    @PersistenceContext(unitName = "ComplaintPU")
    private EntityManager em;

    public ComplaintFacade() {
        super(Complaint.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    public List<Complaint> findByStudent(Integer userId) {
        return em.createNamedQuery("Complaint.findByStudent")
                 .setParameter("userId", userId)
                 .getResultList();
    }

    @Override
    public List<Complaint> findByStatus(String status) {
        return em.createNamedQuery("Complaint.findByStatus")
                 .setParameter("status", status)
                 .getResultList();
    }

    @Override
    public List<Complaint> findByCategory(String category) {
        return em.createNamedQuery("Complaint.findByCategory")
                 .setParameter("category", category)
                 .getResultList();
    }

    @Override
    public Complaint findByReference(String referenceNumber) {
        try {
            return (Complaint) em.createNamedQuery("Complaint.findByReference")
                                 .setParameter("ref", referenceNumber)
                                 .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public long countByStatus(String status) {
        return (Long) em.createNamedQuery("Complaint.countByStatus")
                        .setParameter("status", status)
                        .getSingleResult();
    }

    @Override
    public long countAll() {
        return (Long) em.createNamedQuery("Complaint.countAll")
                        .getSingleResult();
    }
}
