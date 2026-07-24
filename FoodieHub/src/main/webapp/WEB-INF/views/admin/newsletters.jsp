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
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Newsletter <span class="text-gradient">Subscriptions</span></h2>
        <p style="color:rgba(255,255,255,0.4);font-size:0.85rem;margin:6px 0 0;">Users subscribed to our newsletter</p>
      </div>
      <button type="button" onclick="openBulkModal()" style="background:linear-gradient(135deg,#FF5E00,#FFD700);border:none;color:white;padding:10px 20px;border-radius:12px;font-weight:600;font-size:0.9rem;cursor:pointer;box-shadow:0 4px 15px rgba(255,94,0,0.3);transition:all 0.3s;display:flex;align-items:center;gap:8px;">
        <i class="fas fa-paper-plane"></i> Send Offer to All
      </button>
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

    <div style="background:rgba(18,18,26,0.7);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:28px;backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);box-shadow:0 15px 35px rgba(0,0,0,0.4);position:relative;overflow:hidden;">
      <div style="position:absolute;top:-50px;right:-50px;width:200px;height:200px;background:rgba(255,94,0,0.08);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>
      <div style="position:relative;z-index:2;">
      <div style="overflow-x:auto; overflow-y:auto; max-height:calc(100vh - 250px); padding-right:5px;">
        <table style="width:100%;border-collapse:collapse;">
          <thead style="box-shadow: 0 2px 5px rgba(0,0,0,0.5);">
            <tr style="background:rgba(255,94,0,0.08);border-bottom:1px solid rgba(255,94,0,0.15);">
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">ID</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Email Address</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Subscription Date</th>
              <th style="position: sticky; top: 0; background: #151515; z-index: 10; padding:14px 16px;text-align:right;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="n" items="${list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;color:rgba(255,255,255,0.4);font-size:0.85rem;">${n.id}</td>
                <td style="padding:14px 16px;font-weight:700;font-size:0.92rem;color:white;">
                  <div style="display:flex;align-items:center;gap:10px;">
                    <div style="width:30px;height:30px;border-radius:50%;background:rgba(255,94,0,0.15);color:#FF5E00;display:flex;align-items:center;justify-content:center;font-size:0.8rem;font-weight:700;">
                      <i class="fas fa-envelope"></i>
                    </div>
                    ${n.email}
                  </div>
                </td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.6);">
                    ${n.subscribedAt}
                </td>
                <td style="padding:14px 16px;text-align:right;">
                  <button type="button" onclick="openSingleModal('${n.email}')" style="background:rgba(99,102,241,0.1);color:#6366f1;border:1px solid rgba(99,102,241,0.2);padding:6px 12px;border-radius:8px;cursor:pointer;transition:all 0.3s;display:inline-flex;align-items:center;gap:6px;font-size:0.85rem;font-weight:600;" onmouseover="this.style.background='rgba(99,102,241,0.2)'" onmouseout="this.style.background='rgba(99,102,241,0.1)'">
                    <i class="fas fa-paper-plane"></i> Send Mail
                  </button>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                <td colspan="4" style="text-align:center;padding:30px;color:rgba(255,255,255,0.4);">No subscribers found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  </div>
</div>

<!-- Bulk Mail Modal -->
<div id="bulkMailModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.7);backdrop-filter:blur(5px);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:var(--dark);border:1px solid rgba(255,255,255,0.1);border-radius:24px;width:90%;max-width:500px;padding:32px;box-shadow:0 20px 50px rgba(0,0,0,0.5);position:relative;">
    <button type="button" onclick="closeModals()" style="position:absolute;top:20px;right:20px;background:none;border:none;color:rgba(255,255,255,0.5);font-size:1.2rem;cursor:pointer;transition:color 0.3s;" onmouseover="this.style.color='white'" onmouseout="this.style.color='rgba(255,255,255,0.5)'"><i class="fas fa-times"></i></button>
    <h3 style="margin:0 0 24px 0;font-size:1.4rem;font-weight:700;"><i class="fas fa-mail-bulk text-gradient" style="margin-right:10px;"></i>Send Offer to All</h3>
    
    <form action="${pageContext.request.contextPath}/admin/sendBulkNewsletter" method="post" id="bulkMailForm">
      <div style="margin-bottom:20px;">
        <label style="display:block;color:rgba(255,255,255,0.7);font-size:0.85rem;margin-bottom:8px;font-weight:600;">Subject</label>
        <input type="text" name="subject" required style="width:100%;background:rgba(0,0,0,0.2);border:1px solid rgba(255,255,255,0.1);padding:12px 16px;border-radius:12px;color:white;font-size:0.95rem;outline:none;" placeholder="Special Offer Inside!">
      </div>
      <div style="margin-bottom:24px;">
        <label style="display:block;color:rgba(255,255,255,0.7);font-size:0.85rem;margin-bottom:8px;font-weight:600;">Message</label>
        <textarea name="message" required rows="5" style="width:100%;background:rgba(0,0,0,0.2);border:1px solid rgba(255,255,255,0.1);padding:12px 16px;border-radius:12px;color:white;font-size:0.95rem;outline:none;resize:vertical;" placeholder="Write your promotional message here..."></textarea>
      </div>
      <button type="submit" id="bulkSubmitBtn" style="width:100%;background:linear-gradient(135deg,#FF5E00,#FFD700);border:none;color:white;padding:14px;border-radius:12px;font-weight:700;font-size:1rem;cursor:pointer;box-shadow:0 4px 15px rgba(255,94,0,0.3);transition:all 0.3s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
        <i class="fas fa-paper-plane" style="margin-right:8px;"></i> Send Bulk Email
      </button>
    </form>
  </div>
</div>

<!-- Single Mail Modal -->
<div id="singleMailModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.7);backdrop-filter:blur(5px);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:var(--dark);border:1px solid rgba(255,255,255,0.1);border-radius:24px;width:90%;max-width:500px;padding:32px;box-shadow:0 20px 50px rgba(0,0,0,0.5);position:relative;">
    <button type="button" onclick="closeModals()" style="position:absolute;top:20px;right:20px;background:none;border:none;color:rgba(255,255,255,0.5);font-size:1.2rem;cursor:pointer;transition:color 0.3s;" onmouseover="this.style.color='white'" onmouseout="this.style.color='rgba(255,255,255,0.5)'"><i class="fas fa-times"></i></button>
    <h3 style="margin:0 0 24px 0;font-size:1.4rem;font-weight:700;"><i class="fas fa-envelope text-gradient" style="margin-right:10px;"></i>Message Subscriber</h3>
    
    <form action="${pageContext.request.contextPath}/admin/sendSingleNewsletter" method="post" id="singleMailForm">
      <input type="hidden" name="email" id="singleMailAddressHidden">
      
      <div style="margin-bottom:16px;">
        <label style="display:block;color:rgba(255,255,255,0.7);font-size:0.85rem;margin-bottom:8px;font-weight:600;">To</label>
        <div id="singleMailAddressDisplay" style="background:rgba(255,255,255,0.05);padding:12px 16px;border-radius:12px;color:#FFD700;font-weight:600;font-size:0.95rem;"></div>
      </div>
      <div style="margin-bottom:20px;">
        <label style="display:block;color:rgba(255,255,255,0.7);font-size:0.85rem;margin-bottom:8px;font-weight:600;">Subject</label>
        <input type="text" name="subject" required style="width:100%;background:rgba(0,0,0,0.2);border:1px solid rgba(255,255,255,0.1);padding:12px 16px;border-radius:12px;color:white;font-size:0.95rem;outline:none;" placeholder="Hello from FoodieHub!">
      </div>
      <div style="margin-bottom:24px;">
        <label style="display:block;color:rgba(255,255,255,0.7);font-size:0.85rem;margin-bottom:8px;font-weight:600;">Message</label>
        <textarea name="message" required rows="5" style="width:100%;background:rgba(0,0,0,0.2);border:1px solid rgba(255,255,255,0.1);padding:12px 16px;border-radius:12px;color:white;font-size:0.95rem;outline:none;resize:vertical;" placeholder="Write your message here..."></textarea>
      </div>
      <button type="submit" id="singleSubmitBtn" style="width:100%;background:linear-gradient(135deg,#6366f1,#4f46e5);border:none;color:white;padding:14px;border-radius:12px;font-weight:700;font-size:1rem;cursor:pointer;box-shadow:0 4px 15px rgba(99,102,241,0.3);transition:all 0.3s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
        <i class="fas fa-paper-plane" style="margin-right:8px;"></i> Send Message
      </button>
    </form>
  </div>
</div>

<script>
  function openBulkModal() {
    document.getElementById('bulkMailModal').style.display = 'flex';
  }
  function openSingleModal(email) {
    document.getElementById('singleMailAddressHidden').value = email;
    document.getElementById('singleMailAddressDisplay').innerText = email;
    document.getElementById('singleMailModal').style.display = 'flex';
  }
  function closeModals() {
    document.getElementById('bulkMailModal').style.display = 'none';
    document.getElementById('singleMailModal').style.display = 'none';
  }

  // Handle form submission loading states
  document.getElementById('bulkMailForm').addEventListener('submit', function() {
    var btn = document.getElementById('bulkSubmitBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:8px;"></i> Sending...';
    btn.style.opacity = '0.7';
    btn.style.pointerEvents = 'none';
  });
  
  document.getElementById('singleMailForm').addEventListener('submit', function() {
    var btn = document.getElementById('singleSubmitBtn');
    btn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:8px;"></i> Sending...';
    btn.style.opacity = '0.7';
    btn.style.pointerEvents = 'none';
  });

  // Auto-hide alerts
  setTimeout(function() {
    var successAlert = document.getElementById('successAlert');
    if(successAlert) { successAlert.style.opacity = '0'; setTimeout(() => successAlert.style.display = 'none', 500); }
    var errorAlert = document.getElementById('errorAlert');
    if(errorAlert) { errorAlert.style.opacity = '0'; setTimeout(() => errorAlert.style.display = 'none', 500); }
  }, 4000);
</script>

</body>
</html>
