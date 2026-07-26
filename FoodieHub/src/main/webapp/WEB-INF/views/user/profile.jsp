<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .profile-page { padding: 40px 0 40px; }
  .profile-header {
    background: rgba(18,18,26,0.7);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 24px;
    padding: 40px;
    display: flex;
    align-items: center;
    gap: 30px;
    margin-bottom: 30px;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    position: relative;
    overflow: hidden;
  }
  .profile-header::before {
    content: ''; position: absolute; top: -50px; right: -50px; width: 200px; height: 200px;
    background: rgba(255,69,0,0.15); border-radius: 50%; filter: blur(40px); pointer-events: none; z-index: 0;
  }
  .profile-header > * { position: relative; z-index: 2; }
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
    background: rgba(18,18,26,0.7);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 24px;
    padding: 30px;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    position: relative;
    overflow: hidden;
  }
  .profile-card::before {
    content: ''; position: absolute; bottom: -50px; left: -50px; width: 200px; height: 200px;
    background: rgba(99,102,241,0.08); border-radius: 50%; filter: blur(40px); pointer-events: none; z-index: 0;
  }
  .profile-card > * { position: relative; z-index: 2; }
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
        <div id="profileMsg" style="display:flex;align-items:center;gap:12px;background:rgba(40,167,69,0.12);border:1px solid rgba(40,167,69,0.35);color:#28a745;border-radius:14px;padding:14px 20px;margin-bottom:24px;font-weight:600;transition:opacity 0.5s ease;">
          <i class="fas fa-check-circle" style="font-size:1.2rem;"></i>
          <span>${msg}</span>
          <button onclick="document.getElementById('profileMsg').style.display='none'" style="margin-left:auto;background:none;border:none;color:#28a745;cursor:pointer;font-size:1.1rem;">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <script>
          // Auto dismiss after 3 seconds
          setTimeout(function() {
            var msg = document.getElementById('profileMsg');
            if (msg) {
              msg.style.opacity = '0';
              setTimeout(function() { msg.style.display = 'none'; }, 500);
            }
          }, 3000);
        </script>
      </c:if>

      <div class="profile-header">
        <div class="profile-img-wrap" style="position:relative;">
          <c:choose>
            <c:when test="${not empty user.profileImage}">
              <img id="profilePreview" src="${pageContext.request.contextPath}/images/${user.profileImage}" class="profile-img" alt="Profile">
            </c:when>
            <c:otherwise>
              <img id="profilePreview" src="https://ui-avatars.com/api/?name=${user.name}&background=ff4500&color=fff&size=200" class="profile-img" alt="Profile">
            </c:otherwise>
          </c:choose>

          <!-- Hover Overlay -->
          <div id="photoOverlay" style="position:absolute;inset:0;border-radius:50%;background:rgba(0,0,0,0.55);display:flex;flex-direction:column;align-items:center;justify-content:center;gap:6px;opacity:0;transition:opacity 0.25s;cursor:pointer;"
               onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0'">
            <div onclick="document.getElementById('profileImageInput').click()" style="color:white;font-size:0.72rem;font-weight:700;display:flex;flex-direction:column;align-items:center;gap:3px;">
              <i class="fas fa-camera" style="font-size:1.1rem;"></i> Change
            </div>
            <c:if test="${not empty user.profileImage}">
              <div onclick="deleteProfilePhoto()" style="color:#ff4500;font-size:0.72rem;font-weight:700;display:flex;flex-direction:column;align-items:center;gap:3px;">
                <i class="fas fa-trash" style="font-size:0.9rem;"></i> Delete
              </div>
            </c:if>
          </div>

          <!-- Camera Icon Badge -->
          <div onclick="document.getElementById('profileImageInput').click()" style="position:absolute;bottom:-8px;right:-8px;background:#ff4500;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;color:white;border:3px solid #12121a;cursor:pointer;transition:all 0.3s;z-index:2;" title="Change Photo">
            <i class="fas fa-camera" style="font-size:0.75rem;"></i>
          </div>
        </div>

        <div class="profile-info">
          <h2>${user.name}</h2>
          <p><i class="fas fa-envelope me-2"></i>${user.email}</p>
          <p><i class="fas fa-phone me-2"></i>${user.mobile != null ? user.mobile : 'Not added'}</p>
          <!-- Quick change photo buttons -->
          <div style="display:flex;gap:8px;margin-top:10px;flex-wrap:wrap;">
            <button type="button" onclick="document.getElementById('profileImageInput').click()" style="background:rgba(255,69,0,0.15);border:1px solid rgba(255,69,0,0.3);border-radius:8px;padding:6px 14px;color:#ff4500;font-size:0.8rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,69,0,0.25)'" onmouseout="this.style.background='rgba(255,69,0,0.15)'">
              <i class="fas fa-camera me-1"></i> Change Photo
            </button>
            <c:if test="${not empty user.profileImage}">
              <button type="button" onclick="deleteProfilePhoto()" style="background:rgba(220,53,69,0.12);border:1px solid rgba(220,53,69,0.3);border-radius:8px;padding:6px 14px;color:#dc3545;font-size:0.8rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(220,53,69,0.25)'" onmouseout="this.style.background='rgba(220,53,69,0.12)'">
                <i class="fas fa-trash me-1"></i> Delete Photo
              </button>
            </c:if>
          </div>
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
      const file = new File([blob], "profile_cropped.jpg", { type: "image/jpeg", lastModified: new Date().getTime() });
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(file);
      document.getElementById('croppedImageInput').files = dataTransfer.files;
      document.getElementById('profilePreview').src = URL.createObjectURL(blob);
      bootstrap.Modal.getInstance(document.getElementById('cropperModal')).hide();
    }, 'image/jpeg');
  }
}

function deleteProfilePhoto() {
  if (!confirm('Are you sure you want to delete your profile photo?')) return;
  
  fetch('${pageContext.request.contextPath}/deleteProfilePhoto', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
  })
  .then(res => res.text())
  .then(result => {
    if (result === 'success') {
      // Reset to avatar
      const name = '${user.name}';
      document.getElementById('profilePreview').src = 
        'https://ui-avatars.com/api/?name=' + encodeURIComponent(name) + '&background=ff4500&color=fff&size=200';
      // Show success msg
      const container = document.querySelector('.col-lg-8');
      const existing = document.getElementById('profileMsg');
      if (existing) existing.remove();
      const msg = document.createElement('div');
      msg.id = 'profileMsg';
      msg.style.cssText = 'display:flex;align-items:center;gap:12px;background:rgba(40,167,69,0.12);border:1px solid rgba(40,167,69,0.35);color:#28a745;border-radius:14px;padding:14px 20px;margin-bottom:24px;font-weight:600;transition:opacity 0.5s ease;';
      msg.innerHTML = '<i class="fas fa-check-circle" style="font-size:1.2rem;"></i><span>Profile photo deleted!</span>';
      container.insertBefore(msg, container.firstChild);
      // Hide delete button
      document.querySelectorAll('[onclick="deleteProfilePhoto()"]').forEach(b => b.style.display='none');
      // Auto dismiss
      setTimeout(() => {
        msg.style.opacity = '0';
        setTimeout(() => msg.remove(), 500);
      }, 3000);
    }
  })
  .catch(err => alert('Error deleting photo'));
}
</script>

<%@ include file="../common/footer.jsp"%>
