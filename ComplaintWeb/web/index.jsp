<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TUT Complaint & Feedback Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Professional navigation (shared) -->
    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <!-- Hero Section -->
    <section class="hero">
        <div>
            <!-- TUT Logo (image) -->
            <img src="images/logo.jfif" 
                 alt="TUT Logo" 
                 width="200" 
                 height="200"
                 style="margin-bottom: 1.5rem; max-width: 100%; height: auto;">

            <h1>Student Complaint & Feedback Tracker</h1>
            <p>
                A dedicated platform for TUT students to voice concerns, submit feedback,
                and track the progress of their complaints — from submission to resolution.
            </p>

            <div class="hero-actions">
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <c:if test="${sessionScope.role == 'STUDENT'}">
                            <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn-hero-primary">Go to My Dashboard</a>
                        </c:if>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/AdminDashboardServlet" class="btn-hero-primary">Go to Admin Dashboard</a>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-hero-primary">Register Now</a>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-hero-outline">Login</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Features Section (no emojis, clean cards) -->
    <section style="background: #f5f7fc; padding-bottom: 3rem;">
        <div class="features-grid">
            <div class="feature-card">
                <h3>Submit Complaints</h3>
                <p>Easily submit complaints or feedback about any campus service — academic, accommodation, financial aid, IT, and more.</p>
            </div>
            <div class="feature-card">
                <h3>Track Progress</h3>
                <p>Every complaint gets a unique reference number. Track its status from OPEN through IN PROGRESS to RESOLVED in real time.</p>
            </div>
            <div class="feature-card">
                <h3>Admin Responses</h3>
                <p>Receive direct responses from administrators. No more wondering — you will always know the status of your complaint.</p>
            </div>
            <div class="feature-card">
                <h3>Secure & Private</h3>
                <p>Your account requires admin approval before you can log in. You can also choose to submit complaints anonymously.</p>
            </div>
        </div>
    </section>

    <!-- How It Works (numbered steps) -->
    <section style="background: white; padding: 3rem 1.5rem; text-align: center;">
        <h2 style="margin-bottom: 0.5rem;">How It Works</h2>
        <p style="color: var(--text-muted); margin-bottom: 2.5rem;">Three simple steps to get your complaint heard</p>
        <div style="display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap; max-width: 900px; margin: 0 auto;">
            <div style="flex: 1; min-width: 200px; padding: 1.5rem;">
                <div style="width: 50px; height: 50px; background: var(--tut-blue); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-weight: 700; font-size: 1.2rem;">1</div>
                <h3>Register</h3>
                <p style="color: var(--text-muted); font-size: 0.9rem;">Create your TUT student account. An admin will review and approve your registration.</p>
            </div>
            <div style="flex: 1; min-width: 200px; padding: 1.5rem;">
                <div style="width: 50px; height: 50px; background: var(--tut-blue); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-weight: 700; font-size: 1.2rem;">2</div>
                <h3>Submit</h3>
                <p style="color: var(--text-muted); font-size: 0.9rem;">Log in and submit your complaint or feedback with a category, priority, and full description.</p>
            </div>
            <div style="flex: 1; min-width: 200px; padding: 1.5rem;">
                <div style="width: 50px; height: 50px; background: var(--tut-blue); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-weight: 700; font-size: 1.2rem;">3</div>
                <h3>Track</h3>
                <p style="color: var(--text-muted); font-size: 0.9rem;">Follow updates as admins respond and move your complaint towards resolution.</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Tshwane University of Technology — Student Complaint & Feedback Tracker</p>
        <p style="margin-top: 4px;">Built for TUT Internet Programming | <a href="${pageContext.request.contextPath}/login.jsp">Staff Login</a></p>
    </footer>

    <script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>