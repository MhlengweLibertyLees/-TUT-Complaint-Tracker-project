<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">

        <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <div>
                <h2>My Complaints</h2>
                <p>All complaints you have submitted, with their current status and reference numbers.</p>
            </div>
            <a href="${pageContext.request.contextPath}/student/submitComplaint.jsp" class="btn btn-primary">+ New Complaint</a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <div class="card">
            <div class="card-header">
                Complaint History
                <span style="margin-left: auto; font-size: 0.85rem; font-weight: normal; color: var(--text-muted);">
                    ${complaints.size()} complaint(s) found
                </span>
            </div>
            <div class="card-body" style="padding: 0;">
                <c:choose>
                    <c:when test="${empty complaints}">
                        <div class="empty-state">
                            <p>No complaints submitted yet.</p>
                            <p style="margin-top: 0.5rem;">Once you submit a complaint it will appear here for tracking.</p>
                            <a href="${pageContext.request.contextPath}/student/submitComplaint.jsp" class="btn btn-primary mt-2">Submit Your First Complaint</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Reference</th>
                                        <th>Title</th>
                                        <th>Category</th>
                                        <th>Priority</th>
                                        <th>Status</th>
                                        <th>Submitted</th>
                                        <th>Last Updated</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="complaint" items="${complaints}" varStatus="loop">
                                        <tr>
                                            <td style="color: var(--text-muted);">${loop.count}</td>
                                            <td>
                                                <code style="font-size: 0.8rem; background: var(--tut-blue-lt); padding: 2px 6px; border-radius: 4px;">
                                                    ${complaint.referenceNumber}
                                                </code>
                                            </td>
                                            <td style="max-width: 220px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                ${complaint.title}
                                                <c:if test="${complaint.anonymous}">
                                                    <span title="Submitted anonymously" style="color: var(--text-muted); font-size: 0.75rem;">(anonymous)</span>
                                                </c:if>
                                            </td>
                                            <td>${complaint.category}</td>
                                            <td><span class="badge badge-${complaint.priority.toLowerCase()}">${complaint.priority}</span></td>
                                            <td><span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">${complaint.status.replace('_',' ')}</span></td>
                                            <td style="white-space: nowrap;"><fmt:formatDate value="${complaint.submittedDate}" pattern="dd MMM yyyy"/></td>
                                            <td style="white-space: nowrap; color: var(--text-muted); font-size: 0.85rem;"><fmt:formatDate value="${complaint.lastUpdated}" pattern="dd MMM yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/ComplaintServlet?action=view&id=${complaint.complaintId}" class="btn btn-sm btn-outline">View</a>
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