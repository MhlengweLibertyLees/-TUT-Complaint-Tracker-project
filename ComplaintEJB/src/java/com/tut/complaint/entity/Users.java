package com.tut.complaint.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;

/**
 * Represents a system user — either a student or an admin.
 * Students register themselves and wait for admin approval before they can log in.
 */
@Entity
@Table(name = "USERS")
@NamedQueries({
    @NamedQuery(name = "Users.findAll",
                query = "SELECT u FROM Users u ORDER BY u.registeredDate DESC"),
    @NamedQuery(name = "Users.findByUsername",
                query = "SELECT u FROM Users u WHERE u.username = :username"),
    @NamedQuery(name = "Users.findByEmail",
                query = "SELECT u FROM Users u WHERE u.email = :email"),
    @NamedQuery(name = "Users.findByStatus",
                query = "SELECT u FROM Users u WHERE u.status = :status ORDER BY u.registeredDate DESC"),
    @NamedQuery(name = "Users.findByRole",
                query = "SELECT u FROM Users u WHERE u.role = :role"),
    @NamedQuery(name = "Users.countByStatus",
                query = "SELECT COUNT(u) FROM Users u WHERE u.status = :status")
})
public class Users implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "USER_ID")
    private Integer userId;

    @Column(name = "USERNAME", nullable = false, unique = true, length = 50)
    private String username;

    @Column(name = "PASSWORD_HASH", nullable = false, length = 255)
    private String passwordHash;

    @Column(name = "FULL_NAME", nullable = false, length = 100)
    private String fullName;

    @Column(name = "EMAIL", nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "STUDENT_NUMBER", length = 20)
    private String studentNumber;

    // ADMIN or STUDENT
    @Column(name = "ROLE", nullable = false, length = 20)
    private String role;

    // PENDING → ACTIVE → REJECTED
    @Column(name = "STATUS", nullable = false, length = 20)
    private String status;

    @Column(name = "DEPARTMENT", length = 100)
    private String department;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "REGISTERED_DATE")
    private Date registeredDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "APPROVED_DATE")
    private Date approvedDate;

    // The admin who approved or rejected this account
    @Column(name = "APPROVED_BY")
    private Integer approvedBy;

    // A student submits many complaints
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Complaint> complaints;

    // An admin can respond to many complaints
    @OneToMany(mappedBy = "admin", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<AdminResponse> responses;

    public Users() {
        this.registeredDate = new Date();
        this.status = "PENDING";
        this.role = "STUDENT";
    }

    // ── Getters and Setters ──────────────────────────────────────────────

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getStudentNumber() { return studentNumber; }
    public void setStudentNumber(String studentNumber) { this.studentNumber = studentNumber; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public Date getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(Date registeredDate) { this.registeredDate = registeredDate; }

    public Date getApprovedDate() { return approvedDate; }
    public void setApprovedDate(Date approvedDate) { this.approvedDate = approvedDate; }

    public Integer getApprovedBy() { return approvedBy; }
    public void setApprovedBy(Integer approvedBy) { this.approvedBy = approvedBy; }

    public List<Complaint> getComplaints() { return complaints; }
    public void setComplaints(List<Complaint> complaints) { this.complaints = complaints; }

    public List<AdminResponse> getResponses() { return responses; }
    public void setResponses(List<AdminResponse> responses) { this.responses = responses; }

    @Override
    public String toString() {
        return "Users[userId=" + userId + ", username=" + username + "]";
    }
}
