package com.tut.complaint.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

/**
 * Represents an admin's response to a student complaint.
 * Each response can also update the complaint's status.
 */
@Entity
@Table(name = "ADMIN_RESPONSES")
@NamedQueries({
    @NamedQuery(name = "AdminResponse.findByComplaint",
                query = "SELECT r FROM AdminResponse r WHERE r.complaint.complaintId = :complaintId ORDER BY r.responseDate ASC"),
    @NamedQuery(name = "AdminResponse.findAll",
                query = "SELECT r FROM AdminResponse r ORDER BY r.responseDate DESC")
})
public class AdminResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RESPONSE_ID")
    private Integer responseId;

    // The complaint this response belongs to
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "COMPLAINT_ID", nullable = false)
    private Complaint complaint;

    // The admin who wrote this response
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ADMIN_ID", nullable = false)
    private Users admin;

    @Lob
    @Column(name = "RESPONSE_TEXT", nullable = false)
    private String responseText;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "RESPONSE_DATE")
    private Date responseDate;

    // The status the admin set when writing this response
    @Column(name = "NEW_STATUS", length = 20)
    private String newStatus;

    // Internal notes are only visible to admins, not the student
    @Column(name = "IS_INTERNAL_NOTE")
    private boolean internalNote;

    public AdminResponse() {
        this.responseDate = new Date();
        this.internalNote = false;
    }

    // ── Getters and Setters ──────────────────────────────────────────────

    public Integer getResponseId() { return responseId; }
    public void setResponseId(Integer responseId) { this.responseId = responseId; }

    public Complaint getComplaint() { return complaint; }
    public void setComplaint(Complaint complaint) { this.complaint = complaint; }

    public Users getAdmin() { return admin; }
    public void setAdmin(Users admin) { this.admin = admin; }

    public String getResponseText() { return responseText; }
    public void setResponseText(String responseText) { this.responseText = responseText; }

    public Date getResponseDate() { return responseDate; }
    public void setResponseDate(Date responseDate) { this.responseDate = responseDate; }

    public String getNewStatus() { return newStatus; }
    public void setNewStatus(String newStatus) { this.newStatus = newStatus; }

    public boolean isInternalNote() { return internalNote; }
    public void setInternalNote(boolean internalNote) { this.internalNote = internalNote; }

    @Override
    public String toString() {
        return "AdminResponse[id=" + responseId + ", complaint=" + 
               (complaint != null ? complaint.getComplaintId() : "null") + "]";
    }
}
