<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="position:sticky; top:0; z-index:98; background:rgba(13,13,20,0.85); backdrop-filter:blur(25px); -webkit-backdrop-filter:blur(25px); padding:24px 32px 16px 32px; margin:-32px -32px 24px -32px; border-bottom:1px solid rgba(255,255,255,0.04); box-shadow: 0 10px 40px rgba(0,0,0,0.3);">
      <div class="admin-page-header" style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Customer <span class="text-gradient">Reviews</span></h2>
        <p style="color:rgba(255,255,255,0.4);font-size:0.85rem;margin:6px 0 0;">Manage food ratings and reviews</p>
      </div>
    </div>

    <c:if test="${not empty sessionScope.errorMsg}">
      <div id="errorAlert" style="background:rgba(220,53,69,0.1);border:1px solid rgba(220,53,69,0.3);color:#dc3545;padding:12px 16px;border-radius:12px;margin-bottom:20px;font-size:0.9rem;transition:opacity 0.5s ease;">
        <i class="fas fa-exclamation-circle" style="margin-right:8px;"></i> ${sessionScope.errorMsg}
      </div>
      <c:remove var="errorMsg" scope="session" />
    </c:if>
    <c:if test="${not empty sessionScope.successMsg}">
      <div id="successAlert" style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.3);color:#28a745;padding:12px 16px;border-radius:12px;margin-bottom:20px;font-size:0.9rem;transition:opacity 0.5s ease;">
        <i class="fas fa-check-circle" style="margin-right:8px;"></i> ${sessionScope.successMsg}
      </div>
      <c:remove var="successMsg" scope="session" />
    </c:if>

    <script>
      setTimeout(function() {
        var successAlert = document.getElementById('successAlert');
        if(successAlert) { successAlert.style.opacity = '0'; setTimeout(() => successAlert.style.display = 'none', 500); }
        var errorAlert = document.getElementById('errorAlert');
        if(errorAlert) { errorAlert.style.opacity = '0'; setTimeout(() => errorAlert.style.display = 'none', 500); }
      }, 3000);
    </script>

    <form id="bulkDeleteForm" action="${pageContext.request.contextPath}/admin/deleteBulkReviews" method="post" style="margin:0;" onsubmit="return submitBulkDelete(event)">
      <div style="display:flex;justify-content:flex-end;margin-bottom:16px;">
        <button type="submit" style="background:linear-gradient(135deg,#dc3545,#c82333);border:none;color:white;padding:10px 20px;border-radius:12px;font-weight:600;font-size:0.9rem;cursor:pointer;box-shadow:0 4px 15px rgba(220,53,69,0.4);transition:all 0.3s;display:flex;align-items:center;gap:8px;">
          <i class="fas fa-trash-alt"></i> Delete Selected
        </button>
      </div>
      <div style="background:rgba(18,18,26,0.7);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:28px;backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);box-shadow:0 15px 35px rgba(0,0,0,0.4);position:relative;overflow:hidden;">
        <div style="position:absolute;top:-50px;right:-50px;width:200px;height:200px;background:rgba(255,215,0,0.08);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>
        <div style="position:relative;z-index:2;">
        <div style="overflow-x:auto; overflow-y:auto; max-height:calc(100vh - 250px); padding-right:5px;">
        <table style="width:100%;border-collapse:collapse;">
          <thead style="box-shadow: 0 2px 5px rgba(0,0,0,0.5);">
            <tr style="background:rgba(255,215,0,0.08);border-bottom:1px solid rgba(255,215,0,0.15);">
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;width:50px;text-align:center;">
                <input type="checkbox" id="selectAllCheckbox" onchange="toggleSelectAll(this)" style="cursor:pointer;width:16px;height:16px;">
              </th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">User</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">Product</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">Rating</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">Comment</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">Date</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:right;font-size:0.72rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.5);">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="r" items="${list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,215,0,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;text-align:center;">
                  <input type="checkbox" class="review-checkbox" name="reviewIds" value="${r.id}" style="cursor:pointer;width:16px;height:16px;">
                </td>
                <td style="padding:14px 16px;font-weight:700;font-size:0.92rem;color:white;">${r.user != null ? r.user.name : 'Guest'}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.8);">${r.product != null ? r.product.name : 'Unknown Product'}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:#FFD700;">
                  <c:forEach begin="1" end="${r.rating}">
                    <i class="fas fa-star"></i>
                  </c:forEach>
                  <c:forEach begin="${r.rating + 1}" end="5">
                    <i class="far fa-star" style="color:rgba(255,255,255,0.2);"></i>
                  </c:forEach>
                </td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.6);max-width:200px;">${r.comment}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.4);">${r.createdAt}</td>
                <td style="padding:14px 16px;text-align:right;">
                  <a href="${pageContext.request.contextPath}/admin/deleteReview/${r.id}" onclick="return confirm('Are you sure you want to delete this review?')" style="display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:8px;background:rgba(220,53,69,0.1);color:#dc3545;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='#dc3545';this.style.color='white';" onmouseout="this.style.background='rgba(220,53,69,0.1)';this.style.color='#dc3545';">
                    <i class="fas fa-trash-alt"></i>
                  </a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                <td colspan="7" style="text-align:center;padding:30px;color:rgba(255,255,255,0.4);">No reviews found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
      </div>
      </div>
    </form>

  </div>
</div>

<script>
function submitBulkDelete(event) {
  const checkboxes = document.querySelectorAll('.review-checkbox:checked');
  if (checkboxes.length === 0) {
    alert("Please select at least one review to delete.");
    event.preventDefault();
    return false;
  }
  if (!confirm('Are you sure you want to delete all selected reviews?')) {
    event.preventDefault();
    return false;
  }
  return true;
}

function toggleSelectAll(masterCheckbox) {
  const checkboxes = document.querySelectorAll('.review-checkbox');
  checkboxes.forEach(cb => {
    cb.checked = masterCheckbox.checked;
  });
}
</script>

</body>
</html>
