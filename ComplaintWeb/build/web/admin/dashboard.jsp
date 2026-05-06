<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">

        <div class="page-header">
            <h2>Admin Dashboard</h2>
            <p>Overview of all student complaints and account approvals.</p>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <!-- Stat Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number" data-value="${totalComplaints}">${totalComplaints}</div>
                <div class="stat-label">Total Complaints</div>
            </div>
            <div class="stat-card open">
                <div class="stat-number" data-value="${openCount}">${openCount}</div>
                <div class="stat-label">Open</div>
            </div>
            <div class="stat-card in-progress">
                <div class="stat-number" data-value="${inProgressCount}">${inProgressCount}</div>
                <div class="stat-label">In Progress</div>
            </div>
            <div class="stat-card resolved">
                <div class="stat-number" data-value="${resolvedCount}">${resolvedCount}</div>
                <div class="stat-label">Resolved</div>
            </div>
            <div class="stat-card pending">
                <div class="stat-number" data-value="${pendingUsers}">${pendingUsers}</div>
                <div class="stat-label">Pending Approvals</div>
            </div>
        </div>

        <!-- Quick action -->
        <div class="d-flex gap-1" style="margin-bottom: 1.5rem; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/ManageUsers" class="btn btn-primary">
                Manage User Approvals
                <c:if test="${pendingUsers > 0}">
                    <span class="badge-pill">${pendingUsers}</span>
                </c:if>
            </a>
        </div>

        <!-- Filter tabs -->
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet"
               class="filter-tab ${activeFilter == 'ALL' ? 'active' : ''}">All (${totalComplaints})</a>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet?filter=OPEN"
               class="filter-tab ${activeFilter == 'OPEN' ? 'active' : ''}">Open (${openCount})</a>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet?filter=IN_PROGRESS"
               class="filter-tab ${activeFilter == 'IN_PROGRESS' ? 'active' : ''}">In Progress (${inProgressCount})</a>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet?filter=RESOLVED"
               class="filter-tab ${activeFilter == 'RESOLVED' ? 'active' : ''}">Resolved (${resolvedCount})</a>
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet?filter=CLOSED"
               class="filter-tab ${activeFilter == 'CLOSED' ? 'active' : ''}">Closed (${closedCount})</a>
        </div>

        <!-- Complaints Table -->
        <div class="card">
            <div class="card-header">Complaint Cases</div>
            <div class="card-body" style="padding: 0;">
                <c:choose>
                    <c:when test="${empty complaints}">
                        <div class="empty-state">
                            <p>No complaints in this category.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Reference</th>
                                        <th>Student</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Priority</th>
                                        <th>Status</th>
                                        <th>Submitted</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="complaint" items="${complaints}">
                                        <tr>
                                            <td>
                                                <code style="font-size:0.8rem; background:#f4f6fb; padding:2px 6px; border-radius:4px;">
                                                    ${complaint.referenceNumber}
                                                </code>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${complaint.anonymous}">
                                                        <span class="text-muted" style="font-style:italic;">Anonymous</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${complaint.user.fullName}<br>
                                                        <small class="text-muted">${complaint.user.studentNumber}</small>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                                ${complaint.title}
                                            </td>
                                            <td>${complaint.category}</td>
                                            <td><span class="badge badge-${complaint.priority.toLowerCase()}">${complaint.priority}</span></td>
                                            <td><span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">${complaint.status.replace('_',' ')}</span></td>
                                            <td style="white-space:nowrap;"><fmt:formatDate value="${complaint.submittedDate}" pattern="dd MMM yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/RespondServlet?id=${complaint.complaintId}" class="btn btn-sm btn-primary">Respond</a>
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

    </main>

    <footer class="footer">
        <p>&copy; 2025 Tshwane University of Technology – Complaint & Feedback Tracker</p>
    </footer>

    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>