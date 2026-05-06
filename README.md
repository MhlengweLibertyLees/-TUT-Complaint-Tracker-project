# TUT Student Complaint Tracker

A web application for Tshwane University of Technology (TUT) students to submit complaints and for administrators to manage and resolve them efficiently.

## What This App Does

- **For Students**: Register, submit complaints (anonymously if preferred), track the status of each complaint, and view official responses.
- **For Administrators**: Approve student accounts, review all complaints, update their status, post public responses, and add private internal notes.
- **Core Workflow**: Complaint → Admin Review → Response → Status Update → Student is notified.

## Key Features

- Role-based access (Student / Admin)
- Complaint reference numbers for easy tracking
- Status lifecycle: OPEN → IN_PROGRESS → RESOLVED → CLOSED
- Responsive web design (works on mobile & desktop)
- Secure password hashing (SHA-256)

## Built With

- Java EE (Servlets, JSP, EJB, JPA)
- GlassFish Server 4.1.1
- Apache Derby Database
- HTML/CSS/JavaScript (custom, no frameworks)



# How to Run the TUT Complaint Tracker
Follow these steps to get the application running on your own computer.

### Prerequisites
Before you start, make sure you have installed:

Software	Version	Download Link
Java JDK	8 or 11	Oracle JDK or OpenJDK
GlassFish Server	4.1.1 or 5.0	GlassFish Downloads
NetBeans IDE	8.2 or 12+	NetBeans Downloads
Git (optional)	Latest	Git Downloads
💡 Tip: NetBeans can bundle GlassFish automatically. If you install NetBeans with GlassFish, you're ready to go.

### Step 1: Get the Code
Option A – Clone with Git (recommended):

bash
git clone https://github.com/MhlengweLibertyLees/TUT-Complaint-Tracker.git
Option B – Download as ZIP:

Go to https://github.com/MhlengweLibertyLees/TUT-Complaint-Tracker

Click the green Code button → Download ZIP

Extract the ZIP file to a folder (e.g., Documents/NetBeansProjects/)

After cloning/extracting, you should have two folders:

text
TUT-Complaint-Tracker/
├── ComplaintEJB/
└── ComplaintWeb/
### Step 2: Set Up the Database (Apache Derby)
Start GlassFish Server

In NetBeans: Go to Services tab → Servers → right‑click GlassFish → Start

Or run asadmin start-domain from the GlassFish bin folder

Open GlassFish Admin Console

Go to http://localhost:4848 in your browser

Username: admin (password is blank unless you set one)

Create a JDBC Connection Pool

Navigate to Resources → JDBC → Connection Pools

Click New

Pool Name: DerbyPool

Resource Type: javax.sql.DataSource

Datasource Classname: org.apache.derby.jdbc.ClientDataSource

Click Next

Add Connection Properties
In the Additional Properties section, add these:

Property	Value
DatabaseName	ComplaintDB
serverName	localhost
PortNumber	1527
User	APP
Password	APP
url	jdbc:derby://localhost:1527/ComplaintDB;create=true
Click Finish

Test the Connection

Select DerbyPool from the list → click Ping

You should see: Ping succeeded

Create a JDBC Resource

Go to Resources → JDBC → JDBC Resources

Click New

JNDI Name: jdbc/__default (or jdbc/ComplaintDB)

Pool Name: DerbyPool

Click OK

Note: The persistence.xml in ComplaintEJB is configured to use jdbc/__default. If you use a different JNDI name, update the file accordingly.

### Step 3: Open and Build the Projects in NetBeans
Open NetBeans

Open both projects:

Click File → Open Project

Navigate to TUT-Complaint-Tracker/ComplaintEJB → Open

Repeat for ComplaintWeb

Clean and Build

Right‑click ComplaintEJB → Clean and Build

Wait for BUILD SUCCESSFUL

Right‑click ComplaintWeb → Clean and Build

If you see errors, make sure your JDK is set correctly (Project Properties → Libraries → Java Platform = JDK 1.8).

### Step 4: Deploy and Run
Make sure GlassFish is running (Services tab → GlassFish → Start)

Right‑click ComplaintWeb → Run

NetBeans will:

Deploy ComplaintEJB.jar to GlassFish

Deploy ComplaintWeb.war

Open your browser at http://localhost:8080/ComplaintWeb

### Step 5: Create an Admin Account (First Time Only)
The database starts empty. You need to add an admin user manually.

Option A – Using GlassFish Admin Console (SQL):

Go to http://localhost:4848

Navigate to Resources → JDBC → JDBC Resources → click your resource

Click Ping → then Execute Command (if available) or use the Derby ij tool

Option B – Using Derby ij command line:

bash
cd C:\Program Files\glassfish-4.1.1\bin
./asadmin start-database
./asadmin create-jvm-options -Dderby.connection.requireAuthentication=false
./ij
Then run:

sql
CONNECT 'jdbc:derby://localhost:1527/ComplaintDB;create=true';
INSERT INTO USERS (USERNAME, PASSWORD_HASH, FULL_NAME, EMAIL, STUDENT_NUMBER, ROLE, STATUS, REGISTERED_DATE)
VALUES ('admin',
        '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
        'System Administrator',
        'admin@tut.ac.za',
        'ADMIN001',
        'ADMIN',
        'ACTIVE',
        CURRENT_TIMESTAMP);
Login credentials after insertion:

### Username: admin

### Password: admin123

Step 6: Test the Application
Open http://localhost:8080/ComplaintWeb

Click Login → use admin credentials

You should see the Admin Dashboard with statistics

To test as a student:

Log out → Register a new student account

Log out → Log in as admin → Approve the student

Log in as student → Submit a complaint

Common Issues & Fixes
Issue	Solution
Database not found	Make sure ;create=true is in the url property of the connection pool
Ping fails	Check that Derby is running: asadmin start-database
EJB not injected	Clean and build both projects; redeploy
JSP compilation errors	Ensure your project uses JDK 8 (not newer) in NetBeans settings
Login always fails	Verify the admin user exists in the USERS table (run the INSERT SQL again)
Alternative: Run Without NetBeans (using Maven/Ant)
Both projects use Ant build scripts. From the command line:

bash
cd ComplaintEJB
ant clean dist
cp dist/ComplaintEJB.jar ../ComplaintWeb/web/WEB-INF/lib/

cd ../ComplaintWeb
ant clean deploy
Then access http://localhost:8080/ComplaintWeb.

You're Done!
The TUT Complaint Tracker should now be running. Explore the admin dashboard, register a test student, and submit a complaint to see the full workflow.

If you get stuck, open an issue on GitHub or contact me at 
### libertyengetelo@gmail.com.
