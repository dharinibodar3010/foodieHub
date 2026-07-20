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
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">All <span class="text-gradient">Products</span></h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:6px 0 0;">Manage your entire product catalogue</p>
      </div>
      <div style="display:flex;gap:10px;flex-wrap:wrap;">
        <div style="position:relative;">
          <i class="fas fa-search" style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
          <input type="text" id="searchProduct" placeholder="Search products..." oninput="filterTable()" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:10px 16px 10px 36px;color:white;font-size:0.85rem;font-family:'Poppins',sans-serif;outline:none;width:220px;" onfocus="this.style.borderColor='rgba(255,69,0,0.4)'" onblur="this.style.borderColor='rgba(255,255,255,0.1)'">
        </div>
        <a href="${pageContext.request.contextPath}/addProduct" class="btn-primary-premium" style="padding:10px 20px;font-size:0.85rem;">
          <i class="fas fa-plus"></i> Add Product
        </a>
      </div>
    </div>

    <!-- Products Table -->
    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;overflow:hidden;">
      <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;" id="productTable">
          <thead>
            <tr style="background:rgba(255,69,0,0.06);border-bottom:1px solid rgba(255,69,0,0.1);">
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">#</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Image</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Product Name</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Category</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Price</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Status</th>
              <th style="padding:14px 16px;text-align:center;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${products}" varStatus="st">
              <tr class="product-row" style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;color:rgba(255,255,255,1.0);font-size:0.85rem;">${st.count}</td>
                <td style="padding:14px 16px;">
                  <img src="${p.image.startsWith('http') ? p.image : pageContext.request.contextPath.concat('/images/').concat(p.image)}"
                       alt="${p.name}" style="width:50px;height:50px;border-radius:10px;object-fit:cover;">
                </td>
                <td style="padding:14px 16px;font-weight:700;font-size:0.92rem;">${p.name}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,1.0);">
                  <c:choose>
                    <c:when test="${p.category != null}">${p.category.name}</c:when>
                    <c:otherwise>—</c:otherwise>
                  </c:choose>
                </td>
                <td style="padding:14px 16px;font-weight:800;background:linear-gradient(135deg,#ff4500,#ff8c00);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;font-size:0.95rem;">₹${p.price}</td>
                <td style="padding:14px 16px;">
                  <c:choose>
                    <c:when test="${p.available}">
                      <span style="background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);border-radius:20px;padding:4px 12px;font-size:0.72rem;font-weight:700;color:#28a745;">✅ Available</span>
                    </c:when>
                    <c:otherwise>
                      <span style="background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.4);border-radius:20px;padding:4px 12px;font-size:0.72rem;font-weight:700;color:#dc3545;">❌ Unavailable</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td style="padding:14px 16px;text-align:center;">
                  <div style="display:flex;gap:8px;justify-content:center;">
                    <a href="${pageContext.request.contextPath}/editProduct/${p.id}" style="width:34px;height:34px;background:rgba(255,193,7,0.15);border:1px solid rgba(255,193,7,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ffc107;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,193,7,0.3)'" onmouseout="this.style.background='rgba(255,193,7,0.15)'" title="Edit">
                      <i class="fas fa-edit" style="font-size:0.8rem;"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/deleteProduct/${p.id}"
                       onclick="return confirmDelete('${p.name}')"
                       style="width:34px;height:34px;background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#dc3545;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(220,53,69,0.3)'" onmouseout="this.style.background='rgba(220,53,69,0.15)'" title="Delete">
                      <i class="fas fa-trash" style="font-size:0.8rem;"></i>
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>

            <!-- Demo row if empty -->
            <c:if test="${empty products}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" class="product-row">
                <td style="padding:14px 16px;color:rgba(255,255,255,1.0);">1</td>
                <td style="padding:14px 16px;"><img src="https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=80&q=70" style="width:50px;height:50px;border-radius:10px;object-fit:cover;" alt=""></td>
                <td style="padding:14px 16px;font-weight:700;">Margherita Pizza</td>
                <td style="padding:14px 16px;color:rgba(255,255,255,1.0);">Pizza</td>
                <td style="padding:14px 16px;font-weight:800;background:linear-gradient(135deg,#ff4500,#ff8c00);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹299</td>
                <td style="padding:14px 16px;"><span style="background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);border-radius:20px;padding:4px 12px;font-size:0.72rem;font-weight:700;color:#28a745;">✅ Available</span></td>
                <td style="padding:14px 16px;text-align:center;">
                  <div style="display:flex;gap:8px;justify-content:center;">
                    <a href="#" style="width:34px;height:34px;background:rgba(255,193,7,0.15);border:1px solid rgba(255,193,7,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ffc107;text-decoration:none;"><i class="fas fa-edit" style="font-size:0.8rem;"></i></a>
                    <a href="#" style="width:34px;height:34px;background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#dc3545;text-decoration:none;"><i class="fas fa-trash" style="font-size:0.8rem;"></i></a>
                  </div>
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <!-- Table Footer -->
      <div style="padding:14px 16px;border-top:1px solid rgba(255,255,255,0.05);display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;">
        <span style="font-size:0.82rem;color:rgba(255,255,255,1.0);">
          Showing <span id="visibleCount" style="color:#ff4500;font-weight:700;"></span> product(s)
        </span>
        <a href="${pageContext.request.contextPath}/addProduct" class="btn-primary-premium" style="padding:8px 20px;font-size:0.82rem;">
          <i class="fas fa-plus"></i> Add New
        </a>
      </div>
    </div>

  </div>
</div>

<script>
function filterTable() {
  const search = document.getElementById('searchProduct').value.toLowerCase().trim();
  const rows = document.querySelectorAll('.product-row');
  let visible = 0;
  rows.forEach(row => {
    const text = row.textContent.toLowerCase();
    if (text.includes(search)) { row.style.display = ''; visible++; }
    else row.style.display = 'none';
  });
  document.getElementById('visibleCount').textContent = visible;
}

function confirmDelete(name) {
  return confirm('Are you sure you want to delete "' + name + '"?\nThis action cannot be undone.');
}

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('visibleCount').textContent = document.querySelectorAll('.product-row').length;
});
</script>

<%@ include file="../common/footer.jsp"%>
