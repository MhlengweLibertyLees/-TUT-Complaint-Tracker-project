package com.tut.complaint.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;

/**
 * Represents a complaint or feedback submission made by a student.
 * Tracks the full lifecycle: OPEN → IN_PROGRESS → RESOLVED → CLOSED.
 */
@Entity
@Table(name = "COMPLAINTS")
@NamedQueries({
    @NamedQuery(name = "Complaint.findAll",
                query = "SELECT c FROM Complaint c ORDER BY c.submittedDate DESC"),
    @NamedQuery(name = "Complaint.findByStudent",
                query = "SELECT c FROM Complaint c WHERE c.user.userId = :userId ORDER BY c.submittedDate DESC"),
    @NamedQuery(name = "Complaint.findByStatus",
                query = "SELECT c FROM Complaint c WHERE c.status = :status ORDER BY c.submittedDate DESC"),
    @NamedQuery(name = "Complaint.findByCategory",
                query = "SELECT c FROM Complaint c WHERE c.category = :category ORDER BY c.submittedDate DESC"),
    @NamedQuery(name = "Complaint.countByStatus",
                query = "SELECT COUNT(c) FROM Complaint c WHERE c.status = :status"),
    @NamedQuery(name = "Complaint.findByReference",
                query = "SELECT c FROM Complaint c WHERE c.referenceNumber = :ref"),
    @NamedQuery(name = "Complaint.countAll",
                query = "SELECT COUNT(c) FROM Complaint c")
})
public class Complaint implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "COMPLAINT_ID")
    private Integer complaintId;

    // The student who submitted this complaint
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", nullable = false)
    private Users user;

    @Column(name = "TITLE", nullable = false, length = 200)
    private String title;

    @Lob
    @Column(name = "DESCRIPTION", nullable = false)
    private String description;

    // e.g. Academic, Accommodation, Transport, Financial Aid, IT Services, Other
    @Column(name = "CATEGORY", length = 50)
    private String category;

    // LOW, MEDIUM, HIGH
    @Column(name = "PRIORITY", length = 20)
    private String priority;

    // OPEN, IN_PROGRESS, RESOLVED, CLOSED
    @Column(name = "STATUS", nullable = false, length = 20)
    private String status;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "SUBMITTED_DATE")
    private Date submittedDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "LAST_UPDATED")
    private Date lastUpdated;

    // Auto-generated reference like TUT-2024-0001
    @Column(name = "REFERENCE_NUMBER", unique = true, length = 20)
    private String referenceNumber;

    // Whether the student chose to submit anonymously
    @Column(name = "IS_ANONYMOUS")
    private boolean anonymous;

    // Responses from admin
    @OneToMany(mappedBy = "complaint", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<AdminResponse> responses;

    public Complaint() {
        this.submittedDate = new Date();
        this.lastUpdated = new Date();
        this.status = "OPEN";
        this.priority = "MEDIUM";
    }

    // ── Getters and Setters ──────────────────────────────────────────────

    public Integer getComplaintId() { return complaintId; }
    public void setComplaintId(Integer complaintId) { this.complaintId = complaintId; }

    public Users getUser() { return user; }
    public void setUser(Users user) { this.user = user; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getSubmittedDate() { return submittedDate; }
    public void setSubmittedDate(Date submittedDate) { this.submittedDate = submittedDate; }

    public Date getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(Date lastUpdated) { this.lastUpdated = lastUpdated; }

    public String getReferenceNumber() { return referenceNumber; }
    public void setReferenceNumber(String referenceNumber) { this.referenceNumber = referenceNumber; }

    public boolean isAnonymous() { return anonymous; }
    public void setAnonymous(boolean anonymous) { this.anonymous = anonymous; }

    public List<AdminResponse> getResponses() { return responses; }
    public void setResponses(List<AdminResponse> responses) { this.responses = responses; }

    @Override
    public String toString() {
        return "Complaint[id=" + complaintId + ", ref=" + referenceNumber + ", status=" + status + "]";
    }
}
