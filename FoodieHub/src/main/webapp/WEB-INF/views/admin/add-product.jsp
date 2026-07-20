<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <!-- Page Header -->
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <div style="font-size:0.72rem;color:rgba(255,255,255,1.0);font-weight:700;text-transform:uppercase;letter-spacing:1.5px;margin-bottom:8px;">Admin Panel</div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Add New <span class="text-gradient">Product</span></h2>
      </div>
      <a href="${pageContext.request.contextPath}/viewProducts" class="btn-outline-premium">
        <i class="fas fa-arrow-left"></i> Back to Products
      </a>
    </div>

    <!-- Form Card -->
    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:36px;max-width:780px;">

      <form action="${pageContext.request.contextPath}/saveProduct" method="post" enctype="multipart/form-data">

        <div class="row g-4">

          <!-- Product Name -->
          <div class="col-md-6">
            <label class="form-label-premium">Product Name *</label>
            <div style="position:relative;">
              <i class="fas fa-hamburger" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
              <input type="text" name="name" class="form-premium w-100" style="padding-left:40px !important;" placeholder="e.g. Margherita Pizza" required>
            </div>
          </div>

          <!-- Price -->
          <div class="col-md-6">
            <label class="form-label-premium">Price (₹) *</label>
            <div style="position:relative;">
              <span style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,69,0,0.8);font-weight:700;font-size:0.95rem;">₹</span>
              <input type="number" name="price" class="form-premium w-100" style="padding-left:32px !important;" placeholder="299" min="1" step="0.01" required>
            </div>
          </div>

          <!-- Category -->
          <div class="col-md-6">
            <label class="form-label-premium">Category *</label>
            <select name="category.id" class="form-premium w-100" required>
              <option value="">-- Select Category --</option>
              <c:if test="${not empty categories}">
                <c:forEach var="cat" items="${categories}">
                  <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
              </c:if>
              <c:if test="${empty categories}">
                <option value="1">Pizza</option>
                <option value="2">Burger</option>
                <option value="3">Biryani</option>
                <option value="4">Desserts</option>
                <option value="5">Drinks</option>
              </c:if>
            </select>
          </div>

          <!-- Availability -->
          <div class="col-md-6">
            <label class="form-label-premium">Availability *</label>
            <select name="available" class="form-premium w-100" required>
              <option value="true">✅ Available</option>
              <option value="false">❌ Unavailable</option>
            </select>
          </div>

          <!-- Description -->
          <div class="col-12">
            <label class="form-label-premium">Description *</label>
            <textarea name="description" class="form-premium w-100" style="resize:none;height:100px;" placeholder="Describe the product..." required></textarea>
          </div>

          <!-- Image -->
          <div class="col-12">
            <label class="form-label-premium">Product Image</label>
            <div style="border:2px dashed rgba(255,69,0,0.25);border-radius:14px;padding:30px;text-align:center;cursor:pointer;transition:all 0.3s;position:relative;" onmouseover="this.style.borderColor='rgba(255,69,0,0.5)';this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.borderColor='rgba(255,69,0,0.25)';this.style.background='transparent'" onclick="document.getElementById('imageInput').click()">
              <div id="previewArea">
                <i class="fas fa-cloud-upload-alt" style="font-size:2.5rem;color:rgba(255,69,0,0.4);margin-bottom:12px;display:block;"></i>
                <div style="font-weight:600;color:rgba(255,255,255,1.0);margin-bottom:6px;">Click to upload image</div>
                <div style="font-size:0.78rem;color:rgba(255,255,255,1.0);">PNG, JPG, WEBP up to 5MB</div>
              </div>
              <img id="imagePreview" style="display:none;max-height:180px;border-radius:10px;max-width:100%;" alt="Preview">
              <input type="file" id="imageInput" name="imageFile" accept="image/*" style="display:none;" onchange="previewImage(this)">
            </div>
            <div style="margin-top:10px;">
              <label class="form-label-premium" style="margin-bottom:6px;">Or enter image URL/filename</label>
              <input type="text" name="image" class="form-premium w-100" placeholder="pizza.jpg or https://example.com/img.jpg">
            </div>
          </div>

          <!-- Submit Buttons -->
          <div class="col-12">
            <div style="display:flex;gap:12px;flex-wrap:wrap;">
              <button type="submit" class="btn-primary-premium" style="padding:13px 32px;">
                <i class="fas fa-save"></i> Save Product
              </button>
              <a href="${pageContext.request.contextPath}/viewProducts" class="btn-outline-premium" style="padding:12px 24px;">
                <i class="fas fa-times"></i> Cancel
              </a>
            </div>
          </div>

        </div>
      </form>
    </div>

  </div>
</div>

<script>
function previewImage(input) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = function(e) {
      const preview = document.getElementById('imagePreview');
      const area = document.getElementById('previewArea');
      preview.src = e.target.result;
      preview.style.display = 'block';
      area.style.display = 'none';
    };
    reader.readAsDataURL(input.files[0]);
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
