<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="background: linear-gradient(135deg, var(--tut-blue) 0%, #001f4d 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem; margin: 0;">

    <div class="auth-card" style="max-width: 460px; text-align: center; padding: 2.5rem;">
        
        <!-- Simple lock icon as text (no emoji) -->
        <div style="font-size: 4rem; font-weight: 300; color: var(--tut-blue); margin-bottom: 1rem;">⨯</div>
        
        <h1 style="color: var(--danger); font-size: 1.8rem; margin-bottom: 0.5rem;">Access Denied</h1>
        <div style="font-size: 2.5rem; font-weight: 700; color: var(--border); margin-bottom: 1rem;">403</div>
        
        <p style="color: var(--text-main); margin-bottom: 0.5rem;">
            You are not authorised to view this page.
        </p>
        <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 1.5rem;">
            Your role: <strong style="color: var(--tut-blue);">${sessionScope.role}</strong> (insufficient permissions)
        </p>

        <div class="alert alert-info" style="text-align: left; margin-bottom: 1.5rem;">
            <strong>Note:</strong> If you believe you should have access, please contact the system administrator.
        </div>

        <c:choose>
            <c:when test="${sessionScope.role == 'STUDENT'}">
                <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn btn-primary" style="width: 100%; justify-content: center; margin-bottom: 0.75rem;">
                    Go to Student Dashboard
                </a>
            </c:when>
            <c:when test="${sessionScope.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="btn btn-primary" style="width: 100%; justify-content: center; margin-bottom: 0.75rem;">
                    Go to Admin Dashboard
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary" style="width: 100%; justify-content: center; margin-bottom: 0.75rem;">
                    Back to Login
                </a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/LogoutServlet" style="font-size: 0.85rem; color: var(--text-muted); display: inline-block; margin-top: 0.5rem;">
            Log out and switch account
        </a>
    </div>

    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>