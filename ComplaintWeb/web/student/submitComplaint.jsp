<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint – TUT Complaint Tracker</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/navbar.jsp"/>

    <main class="main-content">
        <div class="page-header">
            <h2>Submit a Complaint or Feedback</h2>
            <p>Fill in the form below. Your complaint will be assigned a unique reference number for tracking.</p>
        </div>

        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert alert-danger">${requestScope.errorMessage}</div>
        </c:if>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1.5rem; align-items: start;">

            <!-- Main Form -->
            <div class="card">
                <div class="card-header">Complaint Details</div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/ComplaintServlet"
                          method="post" data-validate="true">

                        <div class="form-group">
                            <label for="title">Complaint Title <span class="required">*</span></label>
                            <input type="text" id="title" name="title" required
                                   placeholder="Give your complaint a short, clear title"
                                   maxlength="200">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="category">Category <span class="required">*</span></label>
                                <select id="category" name="category" required>
                                    <option value="">-- Select a category --</option>
                                    <option value="Academic">Academic</option>
                                    <option value="Accommodation">Accommodation</option>
                                    <option value="Financial Aid">Financial Aid</option>
                                    <option value="Transport">Transport</option>
                                    <option value="IT Services">IT Services</option>
                                    <option value="Campus Safety">Campus Safety</option>
                                    <option value="Administrative">Administrative</option>
                                    <option value="Facilities">Facilities</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="priority">Priority Level</label>
                                <select id="priority" name="priority">
                                    <option value="LOW">Low – General feedback</option>
                                    <option value="MEDIUM" selected>Medium – Needs attention</option>
                                    <option value="HIGH">High – Urgent issue</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description <span class="required">*</span></label>
                            <textarea id="description" name="description" required
                                      data-maxlength="2000"
                                      placeholder="Describe your complaint in as much detail as possible. The more detail you provide, the faster it can be resolved."></textarea>
                        </div>

                        <div class="form-group">
                            <label class="form-check">
                                <input type="checkbox" name="anonymous" id="anonymous">
                                Submit this complaint anonymously
                            </label>
                            <small class="text-muted" style="display: block; margin-top: 4px;">
                                Your name will not be shown to the administrator when viewing this complaint.
                            </small>
                        </div>

                        <div class="d-flex gap-1" style="margin-top: 0.5rem;">
                            <button type="submit" class="btn btn-primary">Submit Complaint</button>
                            <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn btn-outline">Cancel</a>
                        </div>

                    </form>
                </div>
            </div>

            <!-- Tips Sidebar -->
            <div>
                <div class="card">
                    <div class="card-header">Tips for a Good Complaint</div>
                    <div class="card-body" style="font-size: 0.88rem; color: var(--text-main);">
                        <ul style="padding-left: 1.2rem; line-height: 2;">
                            <li>Be specific about what happened and when</li>
                            <li>Include any reference numbers or dates</li>
                            <li>Mention who was involved if relevant</li>
                            <li>State clearly what outcome you are hoping for</li>
                            <li>Keep the tone professional and factual</li>
                        </ul>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">What Happens Next?</div>
                    <div class="card-body" style="font-size: 0.88rem; color: var(--text-main); line-height: 1.8;">
                        <p><strong>1. Submitted</strong> – Your complaint is logged and gets a reference number.</p>
                        <p><strong>2. Review</strong> – An administrator reviews your complaint.</p>
                        <p><strong>3. Updates</strong> – You'll see status changes and admin responses in your dashboard.</p>
                        <p><strong>4. Resolved</strong> – Once handled, the status is updated to Resolved.</p>
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