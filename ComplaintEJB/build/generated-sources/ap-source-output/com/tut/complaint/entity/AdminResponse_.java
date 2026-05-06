package com.tut.complaint.entity;

import com.tut.complaint.entity.Complaint;
import com.tut.complaint.entity.Users;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-04T14:59:40")
@StaticMetamodel(AdminResponse.class)
public class AdminResponse_ { 

    public static volatile SingularAttribute<AdminResponse, String> newStatus;
    public static volatile SingularAttribute<AdminResponse, Complaint> complaint;
    public static volatile SingularAttribute<AdminResponse, String> responseText;
    public static volatile SingularAttribute<AdminResponse, Boolean> internalNote;
    public static volatile SingularAttribute<AdminResponse, Users> admin;
    public static volatile SingularAttribute<AdminResponse, Date> responseDate;
    public static volatile SingularAttribute<AdminResponse, Integer> responseId;

}