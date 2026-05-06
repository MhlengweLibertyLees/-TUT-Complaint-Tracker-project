<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">
        <div class="page-header">
            <h2>Manage Student Accounts</h2>
            <p>Review pending registrations and view active student accounts.</p>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <!-- Pending Approvals -->
        <div class="card">
            <div class="card-header">
                Pending Approvals
                <c:if test="${not empty pendingUsers}">
                    <span class="badge-pill">${pendingUsers.size()}</span>
                </c:if>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty pendingUsers}">
                        <div class="empty-state"><p>No pending approvals.</p></div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr><th>Full Name</th><th>Username</th><th>Email</th><th>Student Number</th><th>Department</th><th>Registered</th><th>Actions</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${pendingUsers}">
                                        <tr>
                                            <td>${user.fullName}</td><td>${user.username}</td><td>${user.email}</td>
                                            <td>${user.studentNumber}</td><td>${user.department}</td>
                                            <td><fmt:formatDate value="${user.registeredDate}" pattern="dd MMM yyyy"/></td>
                                            <td>
                                                <div class="d-flex gap-1">
                                                    <form action="${pageContext.request.contextPath}/ApproveUserServlet" method="post">
                                                        <input type="hidden" name="id" value="${user.userId}">
                                                        <input type="hidden" name="action" value="approve">
                                                        <button type="submit" class="btn btn-sm btn-success">Approve</button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/ApproveUserServlet" method="post">
                                                        <input type="hidden" name="id" value="${user.userId}">
                                                        <input type="hidden" name="action" value="reject">
                                                        <button type="submit" class="btn btn-sm btn-danger" data-confirm="Reject ${user.fullName}?">Reject</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Active Students -->
        <div class="card">
            <div class="card-header">Active Students (${activeUsers.size()})</div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty activeUsers}">
                        <div class="empty-state"><p>No active students found.</p></div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr><th>Full Name</th><th>Username</th><th>Email</th><th>Student Number</th><th>Department</th><th>Status</th><th>Approved On</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${activeUsers}">
                                        <tr>
                                            <td>${user.fullName}</td><td>${user.username}</td><td>${user.email}</td>
                                            <td>${user.studentNumber}</td><td>${user.department}</td>
                                            <td><span class="badge badge-active">Active</span></td>
                                            <td><fmt:formatDate value="${user.approvedDate}" pattern="dd MMM yyyy"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Rejected Students -->
        <c:if test="${not empty rejectedUsers}">
            <div class="card">
                <div class="card-header">Rejected Registrations (${rejectedUsers.size()})</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr><th>Full Name</th><th>Username</th><th>Email</th><th>Student Number</th><th>Status</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${rejectedUsers}">
                                    <tr>
                                        <td>${user.fullName}</td><td>${user.username}</td><td>${user.email}</td>
                                        <td>${user.studentNumber}</td><td><span class="badge badge-rejected">Rejected</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>

    </main>

    <footer class="footer">
        <p>&copy; 2025 Tshwane University of Technology – Complaint & Feedback Tracker</p>
    </footer>
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>