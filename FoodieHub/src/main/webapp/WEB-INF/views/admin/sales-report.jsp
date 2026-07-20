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
          Sales <span class="text-gradient">Report</span> 📊
        </h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.88rem;margin:0;">
          Detailed analytics and order history
        </p>
      </div>
      <div>
        <!-- Filter Tabs -->
        <div style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:12px;display:inline-flex;padding:4px;flex-wrap:wrap;gap:4px;">
          <a href="${pageContext.request.contextPath}/salesReport?filter=daily" 
             style="padding:8px 16px;border-radius:8px;font-size:0.85rem;font-weight:600;text-decoration:none;transition:all 0.3s;
                    ${currentFilter == 'daily' ? 'background:rgba(255,69,0,0.15);color:#ff4500;' : 'color:rgba(255,255,255,0.7);'}">
            Daily
          </a>
          <a href="${pageContext.request.contextPath}/salesReport?filter=weekly" 
             style="padding:8px 16px;border-radius:8px;font-size:0.85rem;font-weight:600;text-decoration:none;transition:all 0.3s;
                    ${currentFilter == 'weekly' ? 'background:rgba(255,69,0,0.15);color:#ff4500;' : 'color:rgba(255,255,255,0.7);'}">
            Weekly
          </a>
          <a href="${pageContext.request.contextPath}/salesReport?filter=monthly" 
             style="padding:8px 16px;border-radius:8px;font-size:0.85rem;font-weight:600;text-decoration:none;transition:all 0.3s;
                    ${currentFilter == 'monthly' ? 'background:rgba(255,69,0,0.15);color:#ff4500;' : 'color:rgba(255,255,255,0.7);'}">
            Monthly
          </a>
          <a href="${pageContext.request.contextPath}/salesReport?filter=yearly" 
             style="padding:8px 16px;border-radius:8px;font-size:0.85rem;font-weight:600;text-decoration:none;transition:all 0.3s;
                    ${currentFilter == 'yearly' ? 'background:rgba(255,69,0,0.15);color:#ff4500;' : 'color:rgba(255,255,255,0.7);'}">
            Yearly
          </a>
          <a href="javascript:void(0)" onclick="document.getElementById('customDateForm').style.display='flex'"
             style="padding:8px 16px;border-radius:8px;font-size:0.85rem;font-weight:600;text-decoration:none;transition:all 0.3s;
                    ${currentFilter == 'custom' ? 'background:rgba(255,69,0,0.15);color:#ff4500;' : 'color:rgba(255,255,255,0.7);'}">
            Custom
          </a>
        </div>
      </div>
    </div>

    <!-- Custom Date Filter Form -->
    <form id="customDateForm" action="${pageContext.request.contextPath}/salesReport" method="get" 
          style="display:${currentFilter == 'custom' ? 'flex' : 'none'};gap:16px;align-items:flex-end;margin-bottom:32px;background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.06);padding:20px;border-radius:16px;flex-wrap:wrap;">
      <input type="hidden" name="filter" value="custom">
      <div>
        <label style="display:block;font-size:0.75rem;color:rgba(255,255,255,0.6);margin-bottom:6px;font-weight:600;">Start Date</label>
        <input type="date" name="startDate" value="${startDate}" required class="form-premium" style="padding:10px 16px;color:white;width:180px;">
      </div>
      <div>
        <label style="display:block;font-size:0.75rem;color:rgba(255,255,255,0.6);margin-bottom:6px;font-weight:600;">End Date</label>
        <input type="date" name="endDate" value="${endDate}" required class="form-premium" style="padding:10px 16px;color:white;width:180px;">
      </div>
      <div>
        <button type="submit" class="btn-primary-premium" style="padding:10px 24px;height:46px;">
          <i class="fas fa-filter me-1"></i> Apply Filter
        </button>
      </div>
    </form>

    <!-- Summary Cards -->
    <div class="row g-4 mb-5">
      <div class="col-md-6">
        <div style="background:rgba(40,167,69,0.06);border:1px solid rgba(40,167,69,0.15);border-radius:20px;padding:24px;display:flex;align-items:center;gap:20px;">
          <div style="width:64px;height:64px;border-radius:16px;background:rgba(40,167,69,0.15);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:#28a745;">
            <i class="fas fa-wallet"></i>
          </div>
          <div>
            <div style="font-size:0.85rem;color:rgba(255,255,255,0.8);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px;">
              ${currentFilter} Revenue
            </div>
            <div style="font-size:2rem;font-weight:900;background:linear-gradient(135deg,#28a745,#20c997);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
              ₹${totalRevenue}
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div style="background:rgba(99,102,241,0.06);border:1px solid rgba(99,102,241,0.15);border-radius:20px;padding:24px;display:flex;align-items:center;gap:20px;">
          <div style="width:64px;height:64px;border-radius:16px;background:rgba(99,102,241,0.15);display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:#818cf8;">
            <i class="fas fa-shopping-cart"></i>
          </div>
          <div>
            <div style="font-size:0.85rem;color:rgba(255,255,255,0.8);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px;">
              ${currentFilter} Orders
            </div>
            <div style="font-size:2rem;font-weight:900;background:linear-gradient(135deg,#6366f1,#8b5cf6);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
              ${totalOrders}
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Orders Table for the Selected Period -->
    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:20px;padding:24px;">
      <h6 style="font-weight:800;font-size:1.1rem;margin-bottom:20px;">Orders (${currentFilter})</h6>

      <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;">
          <thead>
            <tr>
              <th style="padding:12px 16px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.9);border-bottom:1px solid rgba(255,255,255,0.1);">Order ID</th>
              <th style="padding:12px 16px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.9);border-bottom:1px solid rgba(255,255,255,0.1);">Customer</th>
              <th style="padding:12px 16px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.9);border-bottom:1px solid rgba(255,255,255,0.1);">Date</th>
              <th style="padding:12px 16px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.9);border-bottom:1px solid rgba(255,255,255,0.1);">Amount</th>
              <th style="padding:12px 16px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;color:rgba(255,255,255,0.9);border-bottom:1px solid rgba(255,255,255,0.1);">Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="o" items="${orders}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,69,0,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;font-weight:700;color:#ff4500;font-size:0.9rem;">#FH-${o.id}</td>
                <td style="padding:14px 16px;font-size:0.9rem;color:#ffffff;">${o.user != null ? o.user.name : 'Guest'}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.8);">${o.orderDate}</td>
                <td style="padding:14px 16px;font-weight:800;font-size:0.9rem;">₹${o.totalAmount}</td>
                <td style="padding:14px 16px;">
                  <span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;
                    background:${o.status == 'Delivered' ? 'rgba(40,167,69,0.15)' : 'rgba(255,193,7,0.15)'};
                    border:1px solid ${o.status == 'Delivered' ? 'rgba(40,167,69,0.4)' : 'rgba(255,193,7,0.4)'};
                    color:${o.status == 'Delivered' ? '#28a745' : '#ffc107'};">
                    ${o.status}
                  </span>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty orders}">
              <tr>
                <td colspan="5" style="text-align:center;padding:30px;color:rgba(255,255,255,0.6);">No orders found for the selected period.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
