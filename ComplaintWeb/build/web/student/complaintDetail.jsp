<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Details – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Responsive two‑column layout */
        @media (max-width: 768px) {
            .detail-grid {
                grid-template-columns: 1fr !important;
                gap: 1rem !important;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">

        <div style="margin-bottom: 1rem;">
            <a href="${pageContext.request.contextPath}/ComplaintServlet?action=list" class="text-muted" style="font-size:0.9rem;">
                ← Back to My Complaints
            </a>
        </div>

        <div class="detail-grid" style="display: grid; grid-template-columns: 2fr 1fr; gap: 1.5rem; align-items: start;">

            <!-- Left column: complaint body and responses -->
            <div>
                <!-- Complaint info card -->
                <div class="card">
                    <div class="card-header" style="display: flex; justify-content: space-between; align-items: center;">
                        <span>${complaint.title}</span>
                        <span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">
                            ${complaint.status.replace('_',' ')}
                        </span>
                    </div>
                    <div class="card-body">
                        <p style="line-height: 1.6;">${complaint.description}</p>
                        <c:if test="${complaint.anonymous}">
                            <p class="text-muted" style="font-size: 0.85rem;">
                                This complaint was submitted anonymously.
                            </p>
                        </c:if>
                    </div>
                </div>

                <!-- Admin responses timeline (students see only non‑internal notes) -->
                <div class="card">
                    <div class="card-header">Admin Responses</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty responses}">
                                <div class="empty-state">
                                    <p>No responses yet.</p>
                                    <p style="margin-top: 0.5rem;">An administrator will respond to your complaint soon.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <ul class="timeline">
                                    <c:forEach var="resp" items="${responses}">
                                        <c:if test="${not resp.internalNote}">
                                            <li class="timeline-item">
                                                <div class="timeline-dot admin"></div>
                                                <div class="timeline-content">
                                                    <div class="timeline-meta">
                                                        <strong>${resp.admin.fullName}</strong> · 
                                                        <fmt:formatDate value="${resp.responseDate}" pattern="dd MMM yyyy HH:mm"/>
                                                        <c:if test="${not empty resp.newStatus}">
                                                            → Status: 
                                                            <span class="badge badge-${resp.newStatus.toLowerCase().replace('_','-')}">
                                                                ${resp.newStatus.replace('_',' ')}
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                    <p>${resp.responseText}</p>
                                                </div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Right column: metadata and status guide -->
            <div>
                <div class="card">
                    <div class="card-header">Complaint Details</div>
                    <div class="card-body" style="font-size: 0.9rem;">
                        <table style="width:100%; border:none;">
                            <tbody>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Reference</td>
                                    <td style="padding:6px 0;">
                                        <code style="background:var(--tut-blue-lt); padding:2px 8px; border-radius:4px;">
                                            ${complaint.referenceNumber}
                                        </code>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Status</td>
                                    <td style="padding:6px 0;">
                                        <span class="badge badge-${complaint.status.toLowerCase().replace('_','-')}">
                                            ${complaint.status.replace('_',' ')}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Category</td>
                                    <td style="padding:6px 0;">${complaint.category}</td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Priority</td>
                                    <td style="padding:6px 0;">
                                        <span class="badge badge-${complaint.priority.toLowerCase()}">${complaint.priority}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Submitted</td>
                                    <td style="padding:6px 0;">
                                        <fmt:formatDate value="${complaint.submittedDate}" pattern="dd MMM yyyy"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0; color:var(--text-muted);">Last Updated</td>
                                    <td style="padding:6px 0;">
                                        <fmt:formatDate value="${complaint.lastUpdated}" pattern="dd MMM yyyy"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card" style="border-left: 4px solid var(--tut-gold);">
                    <div class="card-body" style="font-size: 0.85rem;">
                        <strong>What do the statuses mean?</strong>
                        <ul style="margin-top: 8px; padding-left: 1.2rem; line-height: 2.2;">
                            <li><span class="badge badge-open">OPEN</span> – Received, not yet reviewed</li>
                            <li><span class="badge badge-in-progress">IN PROGRESS</span> – Being handled</li>
                            <li><span class="badge badge-resolved">RESOLVED</span> – Action taken</li>
                            <li><span class="badge badge-closed">CLOSED</span> – Case closed</li>
                        </ul>
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