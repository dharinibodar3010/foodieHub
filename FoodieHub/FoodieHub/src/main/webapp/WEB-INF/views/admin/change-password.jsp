<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">

  <!-- Sidebar -->
  <div style="width:260px;flex-shrink:0;">
    <%@ include file="../common/sidebar.jsp"%>
  </div>

  <!-- Main Content -->
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);overflow-x:hidden;">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.6rem;margin-bottom:4px;">
          Update <span style="background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Profile</span> 🔒
        </h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.88rem;margin:0;">
          Secure your admin account
        </p>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-6">
        <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;padding:30px;">
          
          <c:if test="${not empty msg}">
            <div class="alert alert-success" style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.3);color:#28a745;border-radius:12px;font-size:0.9rem;">
              ${msg}
            </div>
          </c:if>

          <c:if test="${not empty error}">
            <div class="alert alert-danger" style="background:rgba(220,53,69,0.1);border:1px solid rgba(220,53,69,0.3);color:#dc3545;border-radius:12px;font-size:0.9rem;">
              ${error}
            </div>
          </c:if>

          <form action="${pageContext.request.contextPath}/adminChangePassword" method="post">
            <div class="mb-3">
              <label class="form-label" style="color:white;font-weight:600;font-size:0.85rem;">Old Password (Required)</label>
              <input type="password" name="oldPassword" class="form-control" required style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:white;border-radius:10px;padding:12px;" placeholder="Enter current password to verify">
            </div>
            
            <hr style="border-color: rgba(255,255,255,0.1); margin: 24px 0;">

            <div class="mb-3">
              <label class="form-label" style="color:white;font-weight:600;font-size:0.85rem;">New Username</label>
              <input type="text" name="newUsername" value="${sessionScope.admin.username}" class="form-control" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:white;border-radius:10px;padding:12px;" placeholder="Leave unchanged if you don't want to change">
            </div>

            <div class="mb-4">
              <label class="form-label" style="color:white;font-weight:600;font-size:0.85rem;">New Password</label>
              <input type="password" name="newPassword" class="form-control" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);color:white;border-radius:10px;padding:12px;" placeholder="Leave empty if you don't want to change">
            </div>

            <button type="submit" class="btn-primary-premium" style="width:100%;padding:12px;font-size:0.9rem;border:none;border-radius:10px;cursor:pointer;">
              Update Profile
            </button>
          </form>
          
        </div>
      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
