package com.tut.complaint.facade;

import com.tut.complaint.entity.Users;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 * Stateless EJB that handles all database operations for the Users entity.
 */
@Stateless
public class UsersFacade extends AbstractFacade<Users> implements UsersFacadeLocal {

    @PersistenceContext(unitName = "ComplaintPU")
    private EntityManager em;

    public UsersFacade() {
        super(Users.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    @Override
    public Users findByUsername(String username) {
        try {
            return (Users) em.createNamedQuery("Users.findByUsername")
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Users findByEmail(String email) {
        try {
            return (Users) em.createNamedQuery("Users.findByEmail")
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Users> findByStatus(String status) {
        return em.createNamedQuery("Users.findByStatus")
                .setParameter("status", status)
                .getResultList();
    }

    @Override
    public List<Users> findByRole(String role) {
        return em.createNamedQuery("Users.findByRole")
                .setParameter("role", role)
                .getResultList();
    }

    @Override
    public long countByStatus(String status) {
        return (Long) em.createNamedQuery("Users.countByStatus")
                .setParameter("status", status)
                .getSingleResult();
    }

    @Override
    public List<Users> findByStatusAndRole(String status, String role) {
        return em.createQuery("SELECT u FROM Users u WHERE u.status = :status AND u.role = :role")
                .setParameter("status", status)
                .setParameter("role", role)
                .getResultList();
    }
    
}
