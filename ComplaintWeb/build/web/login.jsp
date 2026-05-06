<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <!-- TUT Logo Image -->
            <img src="${pageContext.request.contextPath}/images/logo.jfif" 
                 alt="TUT Logo" 
                 style="width: 80px; height: auto; margin-bottom: 1rem;">
            <h1>Welcome Back</h1>
            <p>Sign in to the TUT Complaint Tracker</p>
        </div>

        <!-- Success message (e.g., after registration) -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <!-- Info message (e.g., session expired) -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-info">${param.message}</div>
        </c:if>

        <!-- Error message from servlet -->
        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert alert-danger">${requestScope.errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post" data-validate="true">
            <div class="form-group">
                <label for="username">Username <span class="required">*</span></label>
                <input type="text" id="username" name="username" required
                       placeholder="Enter your username"
                       value="${not empty param.username ? param.username : ''}">
            </div>
            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <input type="password" id="password" name="password" required
                       placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; padding: 11px;">
                Sign In
            </button>
        </form>

        <div style="text-align: center; margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
            <p style="color: var(--text-muted); margin-bottom: 0.5rem;">
                Don't have an account yet?
            </p>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline" style="width: 100%; justify-content: center;">
                Register as a TUT Student
            </a>
        </div>

        <div style="text-align: center; margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/index.jsp" style="font-size: 0.85rem; color: var(--text-muted);">
                ← Back to Home
            </a>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>