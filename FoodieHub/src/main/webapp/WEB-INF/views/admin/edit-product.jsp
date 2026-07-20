<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Edit <span class="text-gradient">Product</span></h2>
      <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium"><i class="fas fa-arrow-left"></i> Back</a>
    </div>

    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:36px;max-width:780px;">
      <form action="${pageContext.request.contextPath}/updateProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${product.id}">

        <div class="row g-4">
          <div class="col-md-6">
            <label class="form-label-premium">Product Name *</label>
            <input type="text" name="name" class="form-premium w-100" value="${product.name}" placeholder="Product Name" required>
          </div>
          <div class="col-md-6">
            <label class="form-label-premium">Price (₹) *</label>
            <div style="position:relative;">
              <span style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#ff4500;font-weight:700;">₹</span>
              <input type="number" name="price" class="form-premium w-100" style="padding-left:30px !important;" value="${product.price}" placeholder="Price" required>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label-premium">Category</label>
            <select name="category.id" class="form-premium w-100">
              <option value="">-- Select Category --</option>
              <c:if test="${not empty categories}">
                <c:forEach var="cat" items="${categories}">
                  <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
              </c:if>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label-premium">Availability</label>
            <select name="available" class="form-premium w-100">
              <option value="true" ${product.available ? 'selected' : ''}>✅ Available</option>
              <option value="false" ${!product.available ? 'selected' : ''}>❌ Unavailable</option>
            </select>
          </div>
          <div class="col-12">
            <label class="form-label-premium">Description</label>
            <textarea name="description" class="form-premium w-100" style="resize:none;height:100px;" placeholder="Description...">${product.description}</textarea>
          </div>
          <div class="col-12">
            <label class="form-label-premium">Product Image</label>
            <div style="border:2px dashed rgba(255,69,0,0.25);border-radius:14px;padding:30px;text-align:center;cursor:pointer;transition:all 0.3s;position:relative;" onmouseover="this.style.borderColor='rgba(255,69,0,0.5)';this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.borderColor='rgba(255,69,0,0.25)';this.style.background='transparent'" onclick="document.getElementById('imageInput').click()">
              <div id="previewArea" style="${not empty product.image ? 'display:none;' : ''}">
                <i class="fas fa-cloud-upload-alt" style="font-size:2.5rem;color:rgba(255,69,0,0.4);margin-bottom:12px;display:block;"></i>
                <div style="font-weight:600;color:rgba(255,255,255,1.0);margin-bottom:6px;">Click to update image</div>
                <div style="font-size:0.78rem;color:rgba(255,255,255,1.0);">PNG, JPG, WEBP up to 5MB</div>
              </div>
              <img id="imagePreview" src="${not empty product.image ? (product.image.startsWith('http') ? product.image : pageContext.request.contextPath.concat('/images/').concat(product.image)) : ''}" style="${not empty product.image ? 'display:block;' : 'display:none;'} max-height:180px;border-radius:10px;max-width:100%; margin:0 auto;" alt="Preview">
              <input type="file" id="imageInput" name="imageFile" accept="image/*" style="display:none;" onchange="previewImage(this)">
            </div>
            <div style="margin-top:10px;">
              <label class="form-label-premium" style="margin-bottom:6px;">Or enter image URL/filename</label>
              <input type="text" name="image" class="form-premium w-100" value="${product.image}" placeholder="pizza.jpg or https://example.com/img.jpg">
            </div>
          </div>
          <div class="col-12">
            <div style="display:flex;gap:12px;">
              <button type="submit" class="btn-primary-premium" style="padding:12px 30px;"><i class="fas fa-save"></i> Update Product</button>
              <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium" style="padding:11px 24px;"><i class="fas fa-times"></i> Cancel</a>
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
      if(area) area.style.display = 'none';
    };
    reader.readAsDataURL(input.files[0]);
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
