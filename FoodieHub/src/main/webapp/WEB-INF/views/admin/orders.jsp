<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Manage <span class="text-gradient">Orders</span></h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:6px 0 0;">View and update order status</p>
      </div>
      <div style="position:relative;">
        <i class="fas fa-search" style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
        <input type="text" id="searchOrder" placeholder="Search orders..." oninput="filterOrders()" style="background:rgba(255,255,255,1.0);border:1px solid rgba(255,255,255,1.0);border-radius:10px;padding:10px 16px 10px 36px;color:white;font-size:0.85rem;font-family:'Poppins',sans-serif;outline:none;width:250px;">
      </div>
    </div>

    <div style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.06);border-radius:24px;overflow:hidden;">
      <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;" id="orderTable">
          <thead>
            <tr style="background:rgba(99,102,241,0.08);border-bottom:1px solid rgba(99,102,241,0.15);">
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Order ID</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Customer</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Date</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Amount</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Payment</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Status</th>
              <th style="padding:14px 16px;text-align:center;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Update Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="o" items="${orders}">
              <tr class="order-row" style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(99,102,241,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;font-weight:700;color:#818cf8;font-size:0.88rem;">#FH-${o.id}</td>
                <td style="padding:14px 16px;">
                  <div style="font-weight:600;font-size:0.88rem;color:white;">${o.user != null ? o.user.name : 'Guest'}</div>
                  <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">${o.user != null ? o.user.mobile : ''}</div>
                </td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,1.0);">${o.orderDate}</td>
                <td style="padding:14px 16px;font-weight:800;font-size:0.92rem;">₹${o.totalAmount}</td>
                <td style="padding:14px 16px;font-size:0.82rem;">${o.paymentMode}</td>
                <td style="padding:14px 16px;">
                  <span style="padding:4px 10px;border-radius:12px;font-size:0.72rem;font-weight:700;
                    background:${o.status == 'Delivered' || o.status == 'Completed' ? 'rgba(40,167,69,0.15)' : o.status == 'Order Placed' ? 'rgba(255,193,7,0.15)' : 'rgba(255,69,0,0.15)'};
                    border:1px solid ${o.status == 'Delivered' || o.status == 'Completed' ? 'rgba(40,167,69,0.4)' : o.status == 'Order Placed' ? 'rgba(255,193,7,0.4)' : 'rgba(255,69,0,0.4)'};
                    color:${o.status == 'Delivered' || o.status == 'Completed' ? '#28a745' : o.status == 'Order Placed' ? '#ffc107' : '#ff4500'};">
                    ${o.status}
                  </span>
                </td>
                <td style="padding:14px 16px;text-align:center;">
                  <form action="${pageContext.request.contextPath}/updateOrderStatus" method="post" style="display:flex;gap:8px;justify-content:center;">
                    <input type="hidden" name="id" value="${o.id}">
                    <select name="status" class="form-premium" style="padding:6px 10px !important;font-size:0.75rem !important;min-width:120px;">
                      <option value="Order Placed" ${o.status == 'Order Placed' ? 'selected' : ''}>Order Placed</option>
                      <option value="Preparing" ${o.status == 'Preparing' ? 'selected' : ''}>Preparing</option>
                      <option value="On The Way" ${o.status == 'On The Way' ? 'selected' : ''}>On The Way</option>
                      <option value="Delivered" ${o.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                      <option value="Completed" ${o.status == 'Completed' ? 'selected' : ''}>Completed</option>
                    </select>
                    <button type="submit" style="background:rgba(99,102,241,0.15);border:1px solid rgba(99,102,241,0.3);border-radius:8px;padding:6px 12px;color:#818cf8;font-size:0.75rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(99,102,241,0.3)'" onmouseout="this.style.background='rgba(99,102,241,0.15)'">
                      Update
                    </button>
                  </form>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty orders}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                <td colspan="7" style="text-align:center;padding:30px;color:rgba(255,255,255,1.0);">No orders found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<script>
function filterOrders() {
  const search = document.getElementById('searchOrder').value.toLowerCase();
  const rows = document.querySelectorAll('.order-row');
  rows.forEach(row => {
    const text = row.textContent.toLowerCase();
    row.style.display = text.includes(search) ? '' : 'none';
  });
}
</script>

<%@ include file="../common/footer.jsp"%>
