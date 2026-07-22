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
        <div class="profile-img-wrap" style="cursor:pointer;" onclick="document.getElementById('profileImageInput').click();">
          <c:choose>
            <c:when test="${not empty user.profileImage}">
              <img id="profilePreview" src="${pageContext.request.contextPath}/images/${user.profileImage}" class="profile-img" alt="Profile">
            </c:when>
            <c:otherwise>
              <img id="profilePreview" src="https://ui-avatars.com/api/?name=${user.name}&background=ff4500&color=fff&size=200" class="profile-img" alt="Profile">
            </c:otherwise>
          </c:choose>
          <div style="position:absolute;bottom:-10px;right:-10px;background:#ff4500;width:36px;height:36px;border-radius:50%;display:flex;align-items:center;justify-content:center;color:white;border:3px solid #12121a;transition:all 0.3s;">
            <i class="fas fa-camera"></i>
          </div>
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
          <!-- Hidden file input triggered by image click -->
          <input type="file" id="profileImageInput" accept="image/*" style="display:none;" onchange="openCropper(event)">
          <!-- Hidden file input to submit the cropped image -->
          <input type="file" name="imageFile" id="croppedImageInput" style="display:none;">
          
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
              <label class="form-label-premium">Gender</label>
              <select name="gender" class="form-premium w-100" style="padding:10px 16px;">
                <option value="" ${empty user.gender ? 'selected' : ''}>Select Gender</option>
                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
              </select>
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

<!-- Cropper Modal -->
<div class="modal fade" id="cropperModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background:#12121a;border:1px solid rgba(255,69,0,0.3);border-radius:16px;">
      <div class="modal-header" style="border-bottom:1px solid rgba(255,255,255,0.1);">
        <h5 class="modal-title" style="color:white;font-weight:700;">Crop Image</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="padding:0;max-height:60vh;overflow:hidden;">
        <img id="cropperImage" src="" style="max-width:100%;">
      </div>
      <div class="modal-footer" style="border-top:1px solid rgba(255,255,255,0.1);">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="border-radius:8px;">Cancel</button>
        <button type="button" class="btn btn-primary" onclick="cropAndSave()" style="background:#ff4500;border:none;border-radius:8px;">Crop & Save</button>
      </div>
    </div>
  </div>
</div>

<!-- Include Cropper.js -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.js"></script>

<script>
let cropper;

function openCropper(event) {
  const file = event.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('cropperImage').src = e.target.result;
      const cropperModal = new bootstrap.Modal(document.getElementById('cropperModal'));
      cropperModal.show();
      
      document.getElementById('cropperModal').addEventListener('shown.bs.modal', function () {
        if(cropper) { cropper.destroy(); }
        cropper = new Cropper(document.getElementById('cropperImage'), {
          aspectRatio: 1,
          viewMode: 1,
          autoCropArea: 1
        });
      }, {once:true});
    };
    reader.readAsDataURL(file);
  }
}

function cropAndSave() {
  if (cropper) {
    cropper.getCroppedCanvas({
      width: 400,
      height: 400
    }).toBlob(function(blob) {
      // Create a file from blob
      const file = new File([blob], "profile_cropped.jpg", { type: "image/jpeg", lastModified: new Date().getTime() });
      
      // Assign the cropped file to the hidden input using DataTransfer
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(file);
      document.getElementById('croppedImageInput').files = dataTransfer.files;
      
      // Update preview
      document.getElementById('profilePreview').src = URL.createObjectURL(blob);
      
      bootstrap.Modal.getInstance(document.getElementById('cropperModal')).hide();
    }, 'image/jpeg');
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
