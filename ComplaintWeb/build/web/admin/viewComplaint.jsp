<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaint – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Responsive two‑column layout */
        @media (max-width: 768px) {
            .two-columns {
                grid-template-columns: 1fr !important;
                gap: 1rem !important;
            }
        }
        /* Timeline dot for internal notes (not yet in main CSS) */
        .timeline-dot.internal {
            background: var(--text-muted);
            box-shadow: 0 0 0 2px var(--text-muted);
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">

        <div style="margin-bottom: 1rem;">
            <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="text-muted" style="font-size:0.9rem;">← Back to Dashboard</a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <div class="two-columns" style="display: grid; grid-template-columns: 2fr 1fr; gap: 1.5rem; align-items: start;">

            <!-- Left column: complaint + responses + response form -->
            <div>
                <!-- Complaint details -->
                <div class="card">
                    <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                        <span>${complaint.title}</span>
                        <span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">${complaint.status.replace('_',' ')}</span>
                    </div>
                    <div class="card-body">
                        <p style="line-height: 1.6;">${complaint.description}</p>
                    </div>
                </div>

                <!-- Response history -->
                <div class="card">
                    <div class="card-header">Response History</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty responses}">
                                <div class="empty-state">
                                    <p>No responses yet. Use the form below to respond.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <ul class="timeline">
                                    <c:forEach var="resp" items="${responses}">
                                        <li class="timeline-item">
                                            <div class="timeline-dot ${resp.internalNote ? 'internal' : 'admin'}"></div>
                                            <div class="timeline-content">
                                                <div class="timeline-meta">
                                                    <strong>${resp.admin.fullName}</strong> · 
                                                    <fmt:formatDate value="${resp.responseDate}" pattern="dd MMM yyyy HH:mm"/>
                                                    <c:if test="${resp.internalNote}">
                                                        <span class="badge" style="background:#e9ecef; color:#6c757d;">Internal Note</span>
                                                    </c:if>
                                                    <c:if test="${not empty resp.newStatus}">
                                                        → Status: <span class="badge badge-${resp.newStatus.toLowerCase().replace('_','-')}">${resp.newStatus.replace('_',' ')}</span>
                                                    </c:if>
                                                </div>
                                                <p>${resp.responseText}</p>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Add response form -->
                <div class="card">
                    <div class="card-header">Add Response</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/RespondServlet" method="post" data-validate="true">
                            <input type="hidden" name="complaintId" value="${complaint.complaintId}">

                            <div class="form-group">
                                <label for="newStatus">Update Status</label>
                                <select id="newStatus" name="newStatus">
                                    <option value="">-- Keep current status (${complaint.status.replace('_',' ')}) --</option>
                                    <option value="OPEN">Open</option>
                                    <option value="IN_PROGRESS">In Progress</option>
                                    <option value="RESOLVED">Resolved</option>
                                    <option value="CLOSED">Closed</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="responseText">Response <span class="required">*</span></label>
                                <textarea id="responseText" name="responseText" required data-maxlength="2000" placeholder="Write your response..."></textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-check">
                                    <input type="checkbox" name="internalNote"> Mark as internal note (not visible to student)
                                </label>
                            </div>

                            <div class="d-flex gap-1">
                                <button type="submit" class="btn btn-primary">Send Response</button>
                                <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="btn btn-outline">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Right column: complaint metadata -->
            <div>
                <div class="card">
                    <div class="card-header">Complaint Information</div>
                    <div class="card-body" style="font-size:0.9rem;">
                        <table style="width:100%; border:none;">
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Reference</td>
                                <td><code style="background:#f4f6fb; padding:2px 6px; border-radius:4px;">${complaint.referenceNumber}</code></td>
                            </tr>
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Student</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${complaint.anonymous}"><em class="text-muted">Anonymous</em></c:when>
                                        <c:otherwise>${complaint.user.fullName}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <c:if test="${not complaint.anonymous}">
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Student No.</td>
                                    <td>${complaint.user.studentNumber}</td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Email</td>
                                    <td>${complaint.user.email}</td>
                                </tr>
                            </c:if>
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Category</td>
                                <td>${complaint.category}</td>
                            </tr>
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Priority</td>
                                <td><span class="badge badge-${complaint.priority.toLowerCase()}">${complaint.priority}</span></td>
                            </tr>
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Status</td>
                                <td><span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">${complaint.status.replace('_',' ')}</span></td>
                            </tr>
                            <tr>
                                <td style="padding:6px 0; color:var(--text-muted);">Submitted</td>
                                <td><fmt:formatDate value="${complaint.submittedDate}" pattern="dd MMM yyyy"/></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2025 Tshwane University of Technology – Complaint & Feedback Tracker</p>
    </footer>

    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>