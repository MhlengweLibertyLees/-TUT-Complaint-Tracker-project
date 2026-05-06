<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dashboard – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">

        <div class="page-header">
            <h2>Welcome, ${sessionScope.user.fullName}</h2>
            <p>Here's a summary of your complaints and their current status.</p>
        </div>

        <!-- Flash messages -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <!-- Quick action card -->
        <div class="card mb-3" style="border-left: 4px solid var(--tut-blue);">
            <div class="card-body" style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 1rem;">
                <div>
                    <h3 style="margin-bottom: 4px;">Have a complaint or feedback?</h3>
                    <p style="margin: 0; color: var(--text-muted);">Submit it now and track its progress right here on your dashboard.</p>
                </div>
                <a href="${pageContext.request.contextPath}/student/submitComplaint.jsp" class="btn btn-primary">+ Submit a Complaint</a>
            </div>
        </div>

        <!-- Recent complaints table -->
        <div class="card">
            <div class="card-header">
                My Recent Complaints
                <a href="${pageContext.request.contextPath}/ComplaintServlet?action=list"
                   style="margin-left: auto; font-size: 0.85rem; font-weight: normal;">
                    View All →
                </a>
            </div>
            <div class="card-body" style="padding: 0;">
                <c:choose>
                    <c:when test="${empty complaints}">
                        <div class="empty-state">
                            <p>No complaints yet.</p>
                            <p style="margin-top: 0.5rem;">When you submit a complaint, it will appear here.</p>
                            <a href="${pageContext.request.contextPath}/student/submitComplaint.jsp" class="btn btn-primary mt-2">Submit Your First Complaint</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Reference</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Priority</th>
                                        <th>Status</th>
                                        <th>Submitted</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="complaint" items="${complaints}" end="9">
                                        <tr>
                                            <td>
                                                <code style="font-size: 0.8rem; background: var(--tut-blue-lt); padding: 2px 6px; border-radius: 4px;">
                                                    ${complaint.referenceNumber}
                                                </code>
                                            </td>
                                            <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                ${complaint.title}
                                            </td>
                                            <td>${complaint.category}</td>
                                            <td><span class="badge badge-${complaint.priority.toLowerCase()}">${complaint.priority}</span></td>
                                            <td><span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">${complaint.status.replace('_',' ')}</span></td>
                                            <td style="white-space: nowrap;"><fmt:formatDate value="${complaint.submittedDate}" pattern="dd MMM yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/ComplaintServlet?action=view&id=${complaint.complaintId}" class="btn btn-sm btn-outline">View</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <c:if test="${complaints.size() > 10}">
                            <div style="text-align: center; padding: 0.75rem;">
                                <a href="${pageContext.request.contextPath}/ComplaintServlet?action=list" class="btn btn-sm btn-outline">View all ${complaints.size()} complaints →</a>
                            </div>
                        </c:if>
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