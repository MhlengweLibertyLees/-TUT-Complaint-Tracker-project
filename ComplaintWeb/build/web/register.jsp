<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card" style="max-width: 520px;">
        <div class="auth-header">
            <!-- TUT Logo Image (200x200, but scaled down) -->
            <img src="${pageContext.request.contextPath}/images/logo.jfif" 
                 alt="TUT Logo" 
                 style="width: 80px; height: auto; margin-bottom: 1rem;">
            <h1>Create Account</h1>
            <p>Register as a TUT student – an admin will approve your account</p>
        </div>

        <!-- Error message from servlet -->
        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert alert-danger">${requestScope.errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" data-validate="true">

            <div class="form-group">
                <label for="fullName">Full Name <span class="required">*</span></label>
                <input type="text" id="fullName" name="fullName" required
                       placeholder="e.g. Thabo Nkosi"
                       value="${not empty requestScope.fullName ? requestScope.fullName : ''}">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="username">Username <span class="required">*</span></label>
                    <input type="text" id="username" name="username" required
                           placeholder="Choose a username"
                           value="${not empty requestScope.username ? requestScope.username : ''}">
                </div>
                <div class="form-group">
                    <label for="studentNumber">Student Number <span class="required">*</span></label>
                    <input type="text" id="studentNumber" name="studentNumber" required
                           placeholder="e.g. 220012345"
                           value="${not empty requestScope.studentNumber ? requestScope.studentNumber : ''}">
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required
                       placeholder="your.name@tut4life.ac.za"
                       value="${not empty requestScope.email ? requestScope.email : ''}">
            </div>

            <div class="form-group">
                <label for="department">Department / Faculty</label>
                <select id="department" name="department">
                    <option value="">-- Select your department --</option>
                    <option value="Faculty of Arts and Design" ${requestScope.department == 'Faculty of Arts and Design' ? 'selected' : ''}>Faculty of Arts and Design</option>
                    <option value="Faculty of Economics and Finance" ${requestScope.department == 'Faculty of Economics and Finance' ? 'selected' : ''}>Faculty of Economics and Finance</option>
                    <option value="Faculty of Engineering and the Built Environment" ${requestScope.department == 'Faculty of Engineering and the Built Environment' ? 'selected' : ''}>Faculty of Engineering and the Built Environment</option>
                    <option value="Faculty of Humanities" ${requestScope.department == 'Faculty of Humanities' ? 'selected' : ''}>Faculty of Humanities</option>
                    <option value="Faculty of ICT" ${requestScope.department == 'Faculty of ICT' ? 'selected' : ''}>Faculty of ICT</option>
                    <option value="Faculty of Management Sciences" ${requestScope.department == 'Faculty of Management Sciences' ? 'selected' : ''}>Faculty of Management Sciences</option>
                    <option value="Faculty of Science" ${requestScope.department == 'Faculty of Science' ? 'selected' : ''}>Faculty of Science</option>
                </select>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password" required
                           placeholder="At least 6 characters">
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           placeholder="Repeat your password">
                </div>
            </div>

            <!-- Info box (no emoji) -->
            <div class="alert alert-info" style="margin-bottom: 1.25rem;">
                <strong>Note:</strong> After registering, your account will be pending admin approval.
                You will be able to log in once an administrator reviews your registration.
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; padding: 11px;">
                Submit Registration
            </button>
        </form>

        <div style="text-align: center; margin-top: 1.25rem; padding-top: 1.25rem; border-top: 1px solid var(--border);">
            <p style="color: var(--text-muted);">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login.jsp">Sign in here</a>
            </p>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>