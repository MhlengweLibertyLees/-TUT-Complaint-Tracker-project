package com.tut.complaint.entity;

import com.tut.complaint.entity.AdminResponse;
import com.tut.complaint.entity.Users;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-04T14:59:40")
@StaticMetamodel(Complaint.class)
public class Complaint_ { 

    public static volatile SingularAttribute<Complaint, Date> lastUpdated;
    public static volatile SingularAttribute<Complaint, Integer> complaintId;
    public static volatile SingularAttribute<Complaint, String> referenceNumber;
    public static volatile SingularAttribute<Complaint, String> description;
    public static volatile SingularAttribute<Complaint, Boolean> anonymous;
    public static volatile ListAttribute<Complaint, AdminResponse> responses;
    public static volatile SingularAttribute<Complaint, String> title;
    public static volatile SingularAttribute<Complaint, String> priority;
    public static volatile SingularAttribute<Complaint, Date> submittedDate;
    public static volatile SingularAttribute<Complaint, String> category;
    public static volatile SingularAttribute<Complaint, Users> user;
    public static volatile SingularAttribute<Complaint, String> status;

}