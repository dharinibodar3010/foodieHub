<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<%@ include file="../common/header.jsp"%>

<div style="padding:60px 0 100px;">
  <div class="container">

    <!-- Page Header -->
    <div style="margin-bottom:40px;">
      <nav style="display:flex;gap:8px;align-items:center;font-size:0.8rem;color:rgba(255,255,255,1.0);margin-bottom:12px;">
        <a href="${pageContext.request.contextPath}/" style="color:#ff4500;text-decoration:none;">Home</a>
        <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
        <span>My Orders</span>
      </nav>
      <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
        <h1 class="section-title">My <span>Orders</span></h1>
        <div style="display:flex;gap:8px;flex-wrap:wrap;">
          <button onclick="filterOrders('all')" id="filter-all" style="background:rgba(255,69,0,0.15);border:1px solid rgba(255,69,0,0.4);border-radius:20px;padding:6px 18px;color:#ff4500;font-size:0.82rem;font-weight:600;cursor:pointer;">All</button>
          <button onclick="filterOrders('active')" id="filter-active" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:20px;padding:6px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;">Active</button>
          <button onclick="filterOrders('completed')" id="filter-completed" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:20px;padding:6px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;">Completed</button>
        </div>
      </div>
    </div>

    <!-- Orders List -->
    <c:choose>
      <c:when test="${not empty orders}">
        <div style="display:flex;flex-direction:column;gap:16px;" id="ordersContainer">
          <c:forEach var="o" items="${orders}">
            <div class="order-card-main" data-status="${o.status}" style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;transition:all 0.3s;">

              <!-- Order Header -->
              <div style="background:rgba(255,255,255,0.025);padding:18px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;border-bottom:1px solid rgba(255,255,255,0.05);">
                <div style="display:flex;align-items:center;gap:16px;flex-wrap:wrap;">
                  <div>
                    <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Order ID</div>
                    <div style="font-weight:800;color:#ff4500;font-size:1rem;">#FH-${o.id}</div>
                  </div>
                  <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                  <div>
                    <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Date</div>
                    <div style="font-weight:600;font-size:0.88rem;">${o.orderDate}</div>
                  </div>
                  <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                  <div>
                    <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Payment</div>
                    <div style="font-weight:600;font-size:0.88rem;">${o.paymentMode}</div>
                  </div>
                </div>

                <div style="display:flex;align-items:center;gap:12px;">
                  <span style="padding:6px 14px;border-radius:20px;font-size:0.78rem;font-weight:700;
                    background:${o.status == 'Delivered' ? 'rgba(40,167,69,0.15)' : o.status == 'Order Placed' ? 'rgba(255,193,7,0.15)' : 'rgba(255,69,0,0.15)'};
                    border:1px solid ${o.status == 'Delivered' ? 'rgba(40,167,69,0.4)' : o.status == 'Order Placed' ? 'rgba(255,193,7,0.4)' : 'rgba(255,69,0,0.4)'};
                    color:${o.status == 'Delivered' ? '#28a745' : o.status == 'Order Placed' ? '#ffc107' : '#ff4500'};">
                    ${o.status == 'Delivered' ? '✅' : o.status == 'Order Placed' ? '🕒' : '🚀'} ${o.status}
                  </span>
                  <span style="font-size:1.2rem;font-weight:900;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹${o.totalAmount}</span>
                </div>
              </div>

              <!-- Order Actions -->
              <div style="padding:16px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
                <p style="margin:0;color:rgba(255,255,255,1.0);font-size:0.85rem;">
                  <i class="fas fa-map-marker-alt me-2" style="color:#ff4500;"></i>
                  Delivery to Rajkot, Gujarat
                </p>
                <div style="display:flex;gap:10px;">
                  <button onclick="window.location.href='${pageContext.request.contextPath}/products'" style="background:rgba(255,69,0,0.1);border:1px solid rgba(255,69,0,0.3);border-radius:10px;padding:8px 18px;color:#ff4500;font-size:0.82rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,69,0,0.2)'" onmouseout="this.style.background='rgba(255,69,0,0.1)'">
                    <i class="fas fa-redo-alt me-1"></i> Reorder
                  </button>
                  <c:set var="invoiceRows" value="" />
                  <c:choose>
                    <c:when test="${not empty o.items}">
                      <c:forEach var="item" items="${o.items}">
                        <c:set var="rowHtml">
                          <tr>
                            <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #333;">🍽️ ${item.product.name}</td>
                            <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #555; text-align: center;">₹${item.price}</td>
                            <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #555; text-align: center;">${item.quantity}</td>
                            <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #333; font-weight: bold; text-align: right;">₹${item.price * item.quantity}</td>
                          </tr>
                        </c:set>
                        <c:set var="invoiceRows" value="${invoiceRows}${rowHtml}" />
                      </c:forEach>
                    </c:when>
                    <c:otherwise>
                      <c:set var="invoiceRows">
                        <tr>
                          <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #333;">🍽️ Food Order #FH-${o.id}</td>
                          <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #555; text-align: center;">₹${o.totalAmount}</td>
                          <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #555; text-align: center;">1</td>
                          <td style="padding: 16px 15px; border-bottom: 1px solid #eee; font-size: 15px; color: #333; font-weight: bold; text-align: right;">₹${o.totalAmount}</td>
                        </tr>
                      </c:set>
                    </c:otherwise>
                  </c:choose>
                  <button data-rows="${fn:escapeXml(invoiceRows)}" onclick="generateInvoice(this, '${o.id}', '${o.orderDate}', '${o.paymentMode}', '${o.totalAmount}', '${not empty o.user ? fn:escapeXml(o.user.name) : 'Customer'}', '${not empty o.user ? fn:escapeXml(o.user.mobile) : ''}')" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:8px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.08)'" onmouseout="this.style.background='rgba(255,255,255,0.05)'">
                    <i class="fas fa-file-invoice me-1"></i> Invoice
                  </button>
                  <button onclick="openTrackModal('${o.id}', '${o.status}')" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:8px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.08)'" onmouseout="this.style.background='rgba(255,255,255,0.05)'">
                    <i class="fas fa-map-marker-alt me-1" style="color:#ff4500;"></i> Track
                  </button>
                </div>
              </div>

            </div>
          </c:forEach>
        </div>
      </c:when>

      <c:otherwise>
        <!-- Demo Orders when no data -->
        <div style="display:flex;flex-direction:column;gap:16px;" id="ordersContainer">

          <!-- Demo Order 1 -->
          <div class="order-card-main" data-status="active" style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;transition:all 0.3s;" onmouseover="this.style.borderColor='rgba(255,69,0,0.3)'" onmouseout="this.style.borderColor='rgba(255,255,255,0.07)'">
            <div style="background:rgba(255,255,255,0.025);padding:18px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;border-bottom:1px solid rgba(255,255,255,0.05);">
              <div style="display:flex;align-items:center;gap:16px;flex-wrap:wrap;">
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Order ID</div>
                  <div style="font-weight:800;color:#ff4500;font-size:1rem;">#FH-1001</div>
                </div>
                <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Date</div>
                  <div style="font-weight:600;font-size:0.88rem;">19 Jul 2026</div>
                </div>
                <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Payment</div>
                  <div style="font-weight:600;font-size:0.88rem;">Razorpay</div>
                </div>
              </div>
              <div style="display:flex;align-items:center;gap:12px;">
                <span style="padding:6px 14px;border-radius:20px;font-size:0.78rem;font-weight:700;background:rgba(255,193,7,0.15);border:1px solid rgba(255,193,7,0.4);color:#ffc107;">🕒 On The Way</span>
                <span style="font-size:1.2rem;font-weight:900;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹1,256</span>
              </div>
            </div>
            <div style="padding:16px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
              <div style="display:flex;align-items:center;gap:10px;">
                <img src="https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=50&q=80" style="width:40px;height:40px;border-radius:8px;object-fit:cover;" alt="">
                <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=50&q=80" style="width:40px;height:40px;border-radius:8px;object-fit:cover;" alt="">
                <img src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=50&q=80" style="width:40px;height:40px;border-radius:8px;object-fit:cover;" alt="">
                <span style="font-size:0.8rem;color:rgba(255,255,255,1.0);">+2 items</span>
              </div>
              <div style="display:flex;gap:10px;">
                <button style="background:rgba(255,69,0,0.1);border:1px solid rgba(255,69,0,0.3);border-radius:10px;padding:8px 18px;color:#ff4500;font-size:0.82rem;font-weight:600;cursor:pointer;" onclick="showToastNotif('Order requeued!')">
                  <i class="fas fa-redo-alt me-1"></i> Reorder
                </button>
                <a href="${pageContext.request.contextPath}/order-success" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:8px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;text-decoration:none;">
                  <i class="fas fa-map-marker-alt me-1" style="color:#ff4500;"></i> Track
                </a>
              </div>
            </div>
          </div>

          <!-- Demo Order 2 -->
          <div class="order-card-main" data-status="completed" style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;overflow:hidden;transition:all 0.3s;" onmouseover="this.style.borderColor='rgba(255,69,0,0.3)'" onmouseout="this.style.borderColor='rgba(255,255,255,0.07)'">
            <div style="background:rgba(255,255,255,0.025);padding:18px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;border-bottom:1px solid rgba(255,255,255,0.05);">
              <div style="display:flex;align-items:center;gap:16px;flex-wrap:wrap;">
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Order ID</div>
                  <div style="font-weight:800;color:#ff4500;font-size:1rem;">#FH-1002</div>
                </div>
                <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Date</div>
                  <div style="font-weight:600;font-size:0.88rem;">15 Jul 2026</div>
                </div>
                <div style="width:1px;height:36px;background:rgba(255,255,255,0.07);"></div>
                <div>
                  <div style="font-size:0.72rem;color:rgba(255,255,255,0.35);font-weight:600;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;">Payment</div>
                  <div style="font-weight:600;font-size:0.88rem;">Cash on Delivery</div>
                </div>
              </div>
              <div style="display:flex;align-items:center;gap:12px;">
                <span style="padding:6px 14px;border-radius:20px;font-size:0.78rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">✅ Delivered</span>
                <span style="font-size:1.2rem;font-weight:900;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹599</span>
              </div>
            </div>
            <div style="padding:16px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px;">
              <p style="margin:0;color:rgba(255,255,255,1.0);font-size:0.85rem;">
                <i class="fas fa-check-circle me-2" style="color:#28a745;"></i>
                Delivered successfully on 15 Jul 2026 at 7:45 PM
              </p>
              <div style="display:flex;gap:10px;">
                <button style="background:rgba(255,69,0,0.1);border:1px solid rgba(255,69,0,0.3);border-radius:10px;padding:8px 18px;color:#ff4500;font-size:0.82rem;font-weight:600;cursor:pointer;" onclick="showToastNotif('Order added to cart!')">
                  <i class="fas fa-redo-alt me-1"></i> Reorder
                </button>
                <button style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:8px 18px;color:rgba(255,255,255,1.0);font-size:0.82rem;font-weight:600;cursor:pointer;">
                  <i class="fas fa-star me-1" style="color:#ffd700;"></i> Rate
                </button>
              </div>
            </div>
          </div>

        </div>
      </c:otherwise>
    </c:choose>

  </div>
</div>

<!-- Track Order Modal -->
<div class="modal fade" id="trackOrderModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="background:rgba(20,20,30,0.95);border:1px solid rgba(255,255,255,0.1);border-radius:24px;backdrop-filter:blur(20px);">
      <div class="modal-header" style="border-bottom:1px solid rgba(255,255,255,0.05);padding:24px;">
        <h5 class="modal-title" style="color:white;font-weight:800;font-size:1.2rem;">
          Track Order <span id="trackModalOrderId" style="color:#ff4500;"></span>
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="padding:40px 24px;">
        
        <div style="position:relative;display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
          
          <!-- Connecting Line -->
          <div style="position:absolute;top:20px;left:30px;right:30px;height:4px;background:rgba(255,255,255,0.1);z-index:1;border-radius:2px;">
            <div id="trackProgressBar" style="height:100%;width:0%;background:linear-gradient(90deg,#ff4500,#ff8c00);transition:width 0.5s ease;border-radius:2px;"></div>
          </div>

          <!-- Step 1: Placed -->
          <div class="track-step" id="step-placed" style="position:relative;z-index:2;display:flex;flex-direction:column;align-items:center;gap:10px;width:60px;">
            <div class="track-icon" style="width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:white;font-size:1.1rem;transition:all 0.4s;">
              <i class="fas fa-clipboard-list"></i>
            </div>
            <div style="font-size:0.75rem;font-weight:600;color:rgba(255,255,255,0.5);text-align:center;">Placed</div>
          </div>

          <!-- Step 2: Preparing -->
          <div class="track-step" id="step-preparing" style="position:relative;z-index:2;display:flex;flex-direction:column;align-items:center;gap:10px;width:60px;">
            <div class="track-icon" style="width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:white;font-size:1.1rem;transition:all 0.4s;">
              <i class="fas fa-fire-burner"></i>
            </div>
            <div style="font-size:0.75rem;font-weight:600;color:rgba(255,255,255,0.5);text-align:center;">Preparing</div>
          </div>

          <!-- Step 3: On The Way -->
          <div class="track-step" id="step-ontheway" style="position:relative;z-index:2;display:flex;flex-direction:column;align-items:center;gap:10px;width:60px;">
            <div class="track-icon" style="width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:white;font-size:1.1rem;transition:all 0.4s;">
              <i class="fas fa-motorcycle"></i>
            </div>
            <div style="font-size:0.75rem;font-weight:600;color:rgba(255,255,255,0.5);text-align:center;">On The Way</div>
          </div>

          <!-- Step 4: Delivered -->
          <div class="track-step" id="step-delivered" style="position:relative;z-index:2;display:flex;flex-direction:column;align-items:center;gap:10px;width:60px;">
            <div class="track-icon" style="width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:white;font-size:1.1rem;transition:all 0.4s;">
              <i class="fas fa-home"></i>
            </div>
            <div style="font-size:0.75rem;font-weight:600;color:rgba(255,255,255,0.5);text-align:center;">Delivered</div>
          </div>

        </div>

        <div id="trackStatusMessage" style="text-align:center;margin-top:30px;color:rgba(255,255,255,0.8);font-size:0.95rem;font-weight:500;">
          Your order has been placed successfully!
        </div>

      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script>
let trackModalInstance = null;

function openTrackModal(orderId, status) {
  document.getElementById('trackModalOrderId').textContent = '#FH-' + orderId;
  
  // Reset all steps
  const steps = ['placed', 'preparing', 'ontheway', 'delivered'];
  steps.forEach(step => {
    const el = document.getElementById('step-' + step);
    el.querySelector('.track-icon').style.background = 'rgba(255,255,255,0.1)';
    el.querySelector('.track-icon').style.color = 'white';
    el.querySelector('.track-icon').style.boxShadow = 'none';
    el.querySelector('div:last-child').style.color = 'rgba(255,255,255,0.5)';
  });

  let progress = 0;
  let message = "";
  const s = status.toLowerCase();

  const highlightStep = (step) => {
    const el = document.getElementById('step-' + step);
    el.querySelector('.track-icon').style.background = 'linear-gradient(135deg,#ff4500,#ff8c00)';
    el.querySelector('.track-icon').style.boxShadow = '0 0 15px rgba(255,69,0,0.5)';
    el.querySelector('div:last-child').style.color = '#ff4500';
  };

  if (s.includes('placed')) {
    progress = 0;
    message = "Your order has been received and is waiting for confirmation.";
    highlightStep('placed');
  } else if (s.includes('preparing')) {
    progress = 33;
    message = "The kitchen is currently preparing your delicious food!";
    highlightStep('placed');
    highlightStep('preparing');
  } else if (s.includes('way')) {
    progress = 66;
    message = "Your order is out for delivery! It will reach you soon.";
    highlightStep('placed');
    highlightStep('preparing');
    highlightStep('ontheway');
  } else if (s.includes('delivered') || s.includes('completed')) {
    progress = 100;
    message = "Yay! Your food has been delivered successfully. Enjoy your meal!";
    highlightStep('placed');
    highlightStep('preparing');
    highlightStep('ontheway');
    highlightStep('delivered');
  }

  document.getElementById('trackProgressBar').style.width = progress + '%';
  document.getElementById('trackStatusMessage').textContent = message;

  if(!trackModalInstance) {
    trackModalInstance = new bootstrap.Modal(document.getElementById('trackOrderModal'));
  }
  trackModalInstance.show();
}
function filterOrders(type) {
  const cards = document.querySelectorAll('.order-card-main');
  const filters = ['all','active','completed'];

  filters.forEach(f => {
    const btn = document.getElementById('filter-' + f);
    if (btn) {
      btn.style.background = f === type ? 'rgba(255,69,0,0.15)' : 'rgba(255,255,255,0.05)';
      btn.style.borderColor = f === type ? 'rgba(255,69,0,0.4)' : 'rgba(255,255,255,0.1)';
      btn.style.color = f === type ? '#ff4500' : 'rgba(255,255,255,1.0)';
    }
  });

  cards.forEach(card => {
    const rawStatus = card.getAttribute('data-status') || '';
    const status = rawStatus.toLowerCase();
    
    if (type === 'all') {
      card.style.display = '';
    } else if (type === 'active' && (status === 'active' || status === 'placed' || status === 'order placed' || status === 'on the way' || status === 'preparing')) {
      card.style.display = '';
    } else if (type === 'completed' && (status === 'completed' || status === 'delivered')) {
      card.style.display = '';
    } else {
      card.style.display = 'none';
    }
  });
}

function generateInvoice(btn, orderId, date, payment, amount, customerName, customerPhone) {
  showToastNotif('Generating PDF Invoice...');

  const name = customerName ? customerName : 'Customer';
  const phone = customerPhone ? customerPhone : '';

  // Format payment method cleanly
  let displayPayment = 'Online Payment';
  if (payment.toLowerCase().includes('cash') || payment.toLowerCase().includes('cod')) {
    displayPayment = 'Cash on Delivery';
  }

  const invoiceHTML = `
    <div style="font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; color: #333; width: 100%; padding: 40px; box-sizing: border-box; background: white;">
      
      <!-- Header -->
      <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 40px; border-bottom: 2px solid #ff4500; padding-bottom: 20px;">
        <div>
          <div style="font-size: 32px; font-weight: 800; color: #ff4500; letter-spacing: -1px; display: flex; align-items: center; gap: 8px;">
            <span style="font-size: 36px;">🍕</span> FoodieHub
          </div>
          <div style="font-size: 14px; color: #777; margin-top: 5px;">Delicious Food, Delivered Fast</div>
        </div>
        <div style="text-align: right;">
          <div style="font-size: 28px; font-weight: 800; color: #333; letter-spacing: 1px; margin-bottom: 4px;">INVOICE</div>
          <div style="font-size: 15px; color: #666; font-weight: bold;">#FH-`+orderId+`</div>
        </div>
      </div>

      <!-- Info Row -->
      <div style="display: flex; justify-content: space-between; margin-bottom: 40px; gap: 20px;">
        <div style="background: #fff8f5; padding: 20px; border-radius: 12px; flex: 1; border: 1px solid #ffe5d9; box-sizing: border-box;">
          <div style="font-size: 12px; color: #ff6a00; text-transform: uppercase; font-weight: bold; margin-bottom: 5px;">Billed To</div>
          <div style="font-size: 16px; font-weight: bold; color: #444; margin-bottom: 5px;">`+name+`</div>
          <div style="font-size: 13px; color: #666; margin-bottom: 15px;">`+phone+`</div>
          <div style="font-size: 12px; color: #ff6a00; text-transform: uppercase; font-weight: bold; margin-bottom: 5px;">Date</div>
          <div style="font-size: 15px; font-weight: bold; color: #444;">`+date+`</div>
        </div>
        <div style="background: #fff8f5; padding: 20px; border-radius: 12px; flex: 1; border: 1px solid #ffe5d9; box-sizing: border-box;">
          <div style="font-size: 12px; color: #ff6a00; text-transform: uppercase; font-weight: bold; margin-bottom: 5px;">Payment Method</div>
          <div style="font-size: 16px; font-weight: bold; color: #444; margin-bottom: 15px;">`+displayPayment+`</div>
          <div style="font-size: 12px; color: #ff6a00; text-transform: uppercase; font-weight: bold; margin-bottom: 5px;">Status</div>
          <div style="font-size: 15px; font-weight: bold; color: #28a745;">Paid / Confirmed</div>
        </div>
      </div>
      
      <!-- Table -->
      <table style="width: 100%; border-collapse: collapse; margin-bottom: 30px; border: 1px solid #eee; border-radius: 8px; overflow: hidden;">
        <tr style="background: #ff4500; text-align: left; color: white;">
          <th style="padding: 15px; font-size: 13px; text-transform: uppercase; letter-spacing: 1px;">Item Description</th>
          <th style="padding: 15px; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; text-align: center;">Price</th>
          <th style="padding: 15px; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; text-align: center;">Qty</th>
          <th style="padding: 15px; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; text-align: right;">Total</th>
        </tr>
        ` + (btn ? btn.getAttribute('data-rows') : '') + `
      </table>
      
      <!-- Bottom Section (Side by side to prevent cutoff) -->
      <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 20px;">
        
        <!-- Thank You Message (Left Side) -->
        <div style="flex: 1; padding-right: 20px; text-align: left; padding-bottom: 10px;">
          <p style="margin: 0 0 8px 0; font-size: 17px; font-weight: 800; color: #ff4500;">Thank you for choosing FoodieHub!</p>
          <p style="margin: 0 0 12px 0; font-style: italic; color: #555; font-size: 14px; line-height: 1.5;">Your taste buds are about to do a happy dance!<br>We hope you enjoy every single bite.</p>
          <p style="margin: 0; font-size: 12px; color: #888; border-top: 1px dashed #ddd; padding-top: 10px;">Need help? support@foodiehub.com</p>
        </div>

        <!-- Total Box (Right Side) -->
        <div style="width: 280px; padding: 20px; background: #fff8f5; border-radius: 12px; border: 1px solid #ffe5d9;">
          <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 15px; color: #666;">
            <span>Subtotal:</span>
            <span>₹`+amount+`</span>
          </div>
          <div style="display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 15px; color: #666;">
            <span>Tax & Fees:</span>
            <span>Included</span>
          </div>
          <div style="border-top: 2px dashed #ff4500; margin: 15px 0;"></div>
          <div style="display: flex; justify-content: space-between; font-size: 20px; font-weight: 900; color: #ff4500;">
            <span>Total:</span>
            <span>₹`+amount+`</span>
          </div>
        </div>
      </div>
      
    </div>
  `;

  const opt = {
    margin:       [0.2, 0.2, 0.2, 0.2], // Standard margins
    filename:     'Invoice_FH_' + orderId + '.pdf',
    image:        { type: 'jpeg', quality: 0.98 },
    html2canvas:  { scale: 2, scrollY: 0 }, 
    jsPDF:        { unit: 'in', format: 'a4', orientation: 'portrait' }
  };

  html2pdf().set(opt).from(invoiceHTML).save().then(() => {
    let toast = document.querySelector('.toast-premium');
    if (toast) toast.style.display = 'none';
  });
}

function showToastNotif(msg) {
  let toast = document.querySelector('.toast-premium');
  if (!toast) {
    toast = document.createElement('div');
    toast.className = 'toast-premium';
    document.body.appendChild(toast);
  }
  toast.textContent = msg;
  toast.style.display = 'block';
  setTimeout(() => { toast.style.display = 'none'; }, 2500);
}
</script>

<%@ include file="../common/footer.jsp"%>