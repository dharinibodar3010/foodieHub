<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .profile-page { padding: 60px 0 100px; }
  .profile-header {
    background: linear-gradient(135deg, rgba(255,69,0,0.1), transparent);
    border: 1px solid rgba(255,69,0,0.2);
    border-radius: 24px;
    padding: 40px;
    display: flex;
    align-items: center;
    gap: 30px;
    margin-bottom: 30px;
  }
  .profile-img-wrap {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 4px solid rgba(255,69,0,0.5);
    padding: 4px;
    position: relative;
  }
  .profile-img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
  }
  .profile-info h2 { font-size: 1.8rem; font-weight: 800; margin-bottom: 5px; color: white; }
  .profile-info p { color: rgba(255,255,255,0.6); margin-bottom: 0; }
  
  .profile-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 24px;
    padding: 30px;
  }
  .profile-card-title {
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 24px;
    color: white;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .profile-card-title i { color: #ff4500; }
</style>

<div class="profile-page container">
  <div class="row justify-content-center">
    <div class="col-lg-8">
    
      <c:if test="${not empty msg}">
        <div class="alert alert-success" style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.3);color:#28a745;border-radius:12px;">
          <i class="fas fa-check-circle me-2"></i> ${msg}
        </div>
      </c:if>

      <div class="profile-header">
        <div class="profile-img-wrap">
          <c:choose>
            <c:when test="${not empty user.profileImage}">
              <img src="${pageContext.request.contextPath}/images/${user.profileImage}" class="profile-img" alt="Profile">
            </c:when>
            <c:otherwise>
              <img src="https://ui-avatars.com/api/?name=${user.name}&background=ff4500&color=fff&size=200" class="profile-img" alt="Profile">
            </c:otherwise>
          </c:choose>
        </div>
        <div class="profile-info">
          <h2>${user.name}</h2>
          <p><i class="fas fa-envelope me-2"></i>${user.email}</p>
          <p><i class="fas fa-phone me-2"></i>${user.mobile != null ? user.mobile : 'Not added'}</p>
        </div>
      </div>

      <div class="profile-card">
        <div class="profile-card-title">
          <i class="fas fa-user-edit"></i> Edit Profile Details
        </div>
        <form action="${pageContext.request.contextPath}/updateProfile" method="post" enctype="multipart/form-data">
          
          <div class="row g-4">
            <div class="col-md-6">
              <label class="form-label-premium">Full Name</label>
              <input type="text" name="name" class="form-premium w-100" value="${user.name}" required>
            </div>
            
            <div class="col-md-6">
              <label class="form-label-premium">Email Address</label>
              <input type="email" name="email" class="form-premium w-100" value="${user.email}" required readonly style="opacity:0.7;cursor:not-allowed;" title="Email cannot be changed">
            </div>

            <div class="col-md-6">
              <label class="form-label-premium">Mobile Number</label>
              <input type="tel" name="mobile" class="form-premium w-100" value="${user.mobile}" placeholder="Your contact number">
            </div>

            <div class="col-md-6">
              <label class="form-label-premium">Profile Photo (Optional)</label>
              <input type="file" name="imageFile" class="form-premium w-100" accept="image/*" style="padding:9px 16px;">
            </div>

            <div class="col-12">
              <label class="form-label-premium">Delivery Address</label>
              <textarea name="address" class="form-premium w-100" style="height:100px;resize:none;" placeholder="Enter your full delivery address...">${user.address}</textarea>
            </div>

            <div class="col-12">
              <label class="form-label-premium">Update Password (Optional)</label>
              <input type="password" name="password" class="form-premium w-100" placeholder="Leave blank to keep current password">
            </div>
            
            <div class="col-12 mt-4">
              <button type="submit" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;font-size:1rem;">
                <i class="fas fa-save me-2"></i> Save Changes
              </button>
            </div>
          </div>

        </form>
      </div>

    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp"%>
