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

    <!-- Page Header -->
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.6rem;margin-bottom:4px;">
          Welcome, <span style="background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Admin</span> 👋
        </h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.88rem;margin:0;">
          <i class="fas fa-calendar me-2" style="color:#ff4500;"></i>
          Saturday, 19 July 2026 — FoodieHub Dashboard
        </p>
      </div>
      <div style="display:flex;gap:10px;">
        <button onclick="window.location.reload()" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:10px 16px;color:rgba(255,255,255,1.0);cursor:pointer;font-size:0.82rem;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='#ff4500'" onmouseout="this.style.background='rgba(255,255,255,0.05)';this.style.color='rgba(255,255,255,1.0)'">
          <i class="fas fa-sync-alt me-1"></i> Refresh
        </button>
        <a href="${pageContext.request.contextPath}/products" class="btn-primary-premium" style="padding:10px 20px;font-size:0.85rem;">
          <i class="fas fa-eye"></i> View Store
        </a>
      </div>
    </div>

    <!-- Stats Grid -->
    <div class="row g-4 mb-4">

      <div class="col-xl-3 col-md-6">
        <div class="stat-card" style="background:rgba(255,69,0,0.06);border-color:rgba(255,69,0,0.15);">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(255,69,0,0.15);color:#ff4500;">
              <i class="fas fa-shopping-bag"></i>
            </div>
            <span style="background:rgba(255,69,0,0.1);border:1px solid rgba(255,69,0,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#ff4500;">+12% ↑</span>
          </div>
          <div class="stat-number">₹48.5K</div>
          <div class="stat-label">Total Revenue</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card" style="background:rgba(99,102,241,0.06);border-color:rgba(99,102,241,0.15);">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(99,102,241,0.15);color:#818cf8;">
              <i class="fas fa-clipboard-list"></i>
            </div>
            <span style="background:rgba(99,102,241,0.1);border:1px solid rgba(99,102,241,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#818cf8;">+8% ↑</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#6366f1,#8b5cf6);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">256</div>
          <div class="stat-label">Total Orders</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card" style="background:rgba(40,167,69,0.06);border-color:rgba(40,167,69,0.15);">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(40,167,69,0.15);color:#28a745;">
              <i class="fas fa-users"></i>
            </div>
            <span style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#28a745;">+25% ↑</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#28a745,#20c997);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">1,240</div>
          <div class="stat-label">Total Users</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card" style="background:rgba(255,193,7,0.06);border-color:rgba(255,193,7,0.15);">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(255,193,7,0.15);color:#ffc107;">
              <i class="fas fa-boxes"></i>
            </div>
            <span style="background:rgba(255,193,7,0.1);border:1px solid rgba(255,193,7,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#ffc107;">Active</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#ffc107,#fd7e14);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">89</div>
          <div class="stat-label">Total Products</div>
        </div>
      </div>

    </div>

    <div class="row g-4 mb-4">

      <!-- Recent Orders -->
      <div class="col-lg-8">
        <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;padding:24px;">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
            <h6 style="font-weight:800;font-size:1rem;margin:0;">Recent Orders</h6>
            <a href="${pageContext.request.contextPath}/adminOrders" style="color:#ff4500;text-decoration:none;font-size:0.82rem;font-weight:600;">View All <i class="fas fa-arrow-right ms-1"></i></a>
          </div>

          <div style="overflow-x:auto;">
            <table style="width:100%;border-collapse:collapse;">
              <thead>
                <tr>
                  <th style="padding:10px 14px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Order ID</th>
                  <th style="padding:10px 14px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Customer</th>
                  <th style="padding:10px 14px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Amount</th>
                  <th style="padding:10px 14px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Payment</th>
                  <th style="padding:10px 14px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Status</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="o" items="${recentOrders}">
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#ff4500;font-size:0.88rem;">#FH-${o.id}</td>
                    <td style="padding:12px 14px;font-size:0.88rem;color:#ffffff;">${o.user != null ? o.user.name : 'Guest'}</td>
                    <td style="padding:12px 14px;font-weight:700;font-size:0.88rem;color:white;">₹${o.totalAmount}</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">${o.paymentMode}</td>
                    <td style="padding:12px 14px;">
                      <span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;
                        background:${o.status == 'Delivered' ? 'rgba(40,167,69,0.15)' : 'rgba(255,193,7,0.15)'};
                        border:1px solid ${o.status == 'Delivered' ? 'rgba(40,167,69,0.4)' : 'rgba(255,193,7,0.4)'};
                        color:${o.status == 'Delivered' ? '#28a745' : '#ffc107'};">
                        ${o.status}
                      </span>
                    </td>
                  </tr>
                </c:forEach>

                <!-- Demo rows if no data -->
                <c:if test="${empty recentOrders}">
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#ff4500;">#FH-1001</td>
                    <td style="padding:12px 14px;font-size:0.88rem;color:#ffffff;">Ravi Patel</td>
                    <td style="padding:12px 14px;font-weight:700;">₹1,256</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">Razorpay</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(255,193,7,0.15);border:1px solid rgba(255,193,7,0.4);color:#ffc107;">On The Way</span></td>
                  </tr>
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#ff4500;">#FH-1002</td>
                    <td style="padding:12px 14px;font-size:0.88rem;color:#ffffff;">Priya Shah</td>
                    <td style="padding:12px 14px;font-weight:700;">₹599</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">COD</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">Delivered</span></td>
                  </tr>
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#ff4500;">#FH-1003</td>
                    <td style="padding:12px 14px;font-size:0.88rem;color:#ffffff;">Karan Mehta</td>
                    <td style="padding:12px 14px;font-weight:700;">₹849</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">UPI</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(255,193,7,0.15);border:1px solid rgba(255,193,7,0.4);color:#ffc107;">Preparing</span></td>
                  </tr>
                  <tr onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#ff4500;">#FH-1004</td>
                    <td style="padding:12px 14px;font-size:0.88rem;color:#ffffff;">Anita Joshi</td>
                    <td style="padding:12px 14px;font-weight:700;">₹1,450</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">Razorpay</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">Delivered</span></td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Quick Actions & Stats -->
      <div class="col-lg-4">

        <!-- Revenue Chart (Simple) -->
        <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;padding:24px;margin-bottom:20px;">
          <h6 style="font-weight:800;font-size:0.95rem;margin-bottom:16px;">Weekly Revenue</h6>
          <div style="display:flex;align-items:flex-end;gap:8px;height:80px;">
            <c:forEach var="day" items="${['Mon','Tue','Wed','Thu','Fri','Sat','Sun']}">
              <div style="flex:1;display:flex;flex-direction:column;align-items:center;gap:4px;">
                <div style="width:100%;background:linear-gradient(to top,#ff4500,#ffd700);border-radius:4px 4px 0 0;height:20px;transition:all 0.5s;" title="Revenue"></div>
                <span style="font-size:0.65rem;color:rgba(255,255,255,1.0);">${day}</span>
              </div>
            </c:forEach>
            <!-- Fallback static bars -->
            <script>
              (function() {
                var bars = document.querySelectorAll('[title="Revenue"]');
                var heights = [45, 65, 35, 80, 55, 90, 70];
                bars.forEach(function(b, i) { b.style.height = heights[i] + 'px'; });
              })();
            </script>
          </div>
        </div>

        <!-- Quick Actions -->
        <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;padding:24px;">
          <h6 style="font-weight:800;font-size:0.95rem;margin-bottom:16px;">Quick Actions</h6>
          <div style="display:flex;flex-direction:column;gap:10px;">
            <a href="${pageContext.request.contextPath}/addProduct" style="display:flex;align-items:center;gap:12px;background:rgba(255,69,0,0.08);border:1px solid rgba(255,69,0,0.2);border-radius:12px;padding:12px 16px;color:white;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,69,0,0.15)'" onmouseout="this.style.background='rgba(255,69,0,0.08)'">
              <i class="fas fa-plus-circle" style="color:#ff4500;width:20px;"></i>
              <span style="font-size:0.88rem;font-weight:600;">Add New Product</span>
              <i class="fas fa-chevron-right" style="margin-left:auto;font-size:0.7rem;color:rgba(255,255,255,1.0);"></i>
            </a>
            <a href="${pageContext.request.contextPath}/addCategory" style="display:flex;align-items:center;gap:12px;background:rgba(255,193,7,0.08);border:1px solid rgba(255,193,7,0.2);border-radius:12px;padding:12px 16px;color:white;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,193,7,0.15)'" onmouseout="this.style.background='rgba(255,193,7,0.08)'">
              <i class="fas fa-tags" style="color:#ffc107;width:20px;"></i>
              <span style="font-size:0.88rem;font-weight:600;">Add Category</span>
              <i class="fas fa-chevron-right" style="margin-left:auto;font-size:0.7rem;color:rgba(255,255,255,1.0);"></i>
            </a>
            <a href="${pageContext.request.contextPath}/users" style="display:flex;align-items:center;gap:12px;background:rgba(40,167,69,0.08);border:1px solid rgba(40,167,69,0.2);border-radius:12px;padding:12px 16px;color:white;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(40,167,69,0.15)'" onmouseout="this.style.background='rgba(40,167,69,0.08)'">
              <i class="fas fa-users" style="color:#28a745;width:20px;"></i>
              <span style="font-size:0.88rem;font-weight:600;">Manage Users</span>
              <i class="fas fa-chevron-right" style="margin-left:auto;font-size:0.7rem;color:rgba(255,255,255,1.0);"></i>
            </a>
            <a href="${pageContext.request.contextPath}/adminOrders" style="display:flex;align-items:center;gap:12px;background:rgba(99,102,241,0.08);border:1px solid rgba(99,102,241,0.2);border-radius:12px;padding:12px 16px;color:white;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(99,102,241,0.15)'" onmouseout="this.style.background='rgba(99,102,241,0.08)'">
              <i class="fas fa-receipt" style="color:#818cf8;width:20px;"></i>
              <span style="font-size:0.88rem;font-weight:600;">View All Orders</span>
              <i class="fas fa-chevron-right" style="margin-left:auto;font-size:0.7rem;color:rgba(255,255,255,1.0);"></i>
            </a>
          </div>
        </div>

      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
