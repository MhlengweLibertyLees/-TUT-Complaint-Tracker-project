<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="main-nav">
    <div class="nav-container">
        <a class="nav-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/logo.jfif" 
                 alt="TUT Logo" 
                 class="nav-logo">
            TUT Complaint Tracker
        </a>

        <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation">
            <span></span><span></span><span></span>
        </button>

        <ul class="nav-menu" id="navMenu">
            <c:choose>
                <c:when test="${sessionScope.role == 'ADMIN'}">
                    <!-- Admin menu -->
                    <li><a href="${pageContext.request.contextPath}/AdminDashboardServlet">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/ManageUsers">Manage Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/AdminDashboardServlet">All Complaints</a></li>
                </c:when>
                <c:when test="${sessionScope.role == 'STUDENT'}">
                    <!-- Student menu -->
                    <li><a href="${pageContext.request.contextPath}/student/dashboard">My Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/ComplaintServlet?action=list">My Complaints</a></li>
                    <li><a href="${pageContext.request.contextPath}/student/submitComplaint.jsp">New Complaint</a></li>
                </c:when>
                <c:otherwise>
                    <!-- Not logged in -->
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
                </c:otherwise>
            </c:choose>

            <!-- Common items: logout and user name -->
            <c:if test="${not empty sessionScope.user}">
                <li><a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Logout</a></li>
                <li><a href="#">${sessionScope.fullName}</a></li>
            </c:if>
        </ul>
    </div>
</nav>

<script>
    // Mobile nav toggle
    const toggle = document.getElementById('navToggle');
    const menu = document.getElementById('navMenu');
    if (toggle && menu) {
        toggle.addEventListener('click', function() {
            menu.classList.toggle('open');
        });
    }

    // Highlight active navigation link based on current URL
    (function highlightActiveLink() {
        const currentPath = window.location.pathname;
        const links = document.querySelectorAll('.nav-menu a');
        links.forEach(link => {
            const href = link.getAttribute('href');
            if (href && (currentPath === href || currentPath.endsWith(href))) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });
    })();
</script>