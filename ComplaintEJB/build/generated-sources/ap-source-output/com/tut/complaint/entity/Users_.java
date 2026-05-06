package com.tut.complaint.entity;

import com.tut.complaint.entity.AdminResponse;
import com.tut.complaint.entity.Complaint;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-04T14:59:40")
@StaticMetamodel(Users.class)
public class Users_ { 

    public static volatile SingularAttribute<Users, String> role;
    public static volatile SingularAttribute<Users, Date> registeredDate;
    public static volatile SingularAttribute<Users, String> studentNumber;
    public static volatile SingularAttribute<Users, Integer> approvedBy;
    public static volatile ListAttribute<Users, Complaint> complaints;
    public static volatile SingularAttribute<Users, String> fullName;
    public static volatile SingularAttribute<Users, Integer> userId;
    public static volatile SingularAttribute<Users, String> passwordHash;
    public static volatile SingularAttribute<Users, Date> approvedDate;
    public static volatile ListAttribute<Users, AdminResponse> responses;
    public static volatile SingularAttribute<Users, String> department;
    public static volatile SingularAttribute<Users, String> email;
    public static volatile SingularAttribute<Users, String> username;
    public static volatile SingularAttribute<Users, String> status;

}