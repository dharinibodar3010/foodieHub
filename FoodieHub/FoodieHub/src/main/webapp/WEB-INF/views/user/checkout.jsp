<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .checkout-page { padding: 60px 0 100px; }

  .checkout-section-title {
    font-size: 0.8rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: #ff4500;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .checkout-section-title::after {
    content: '';
    flex: 1;
    height: 1px;
    background: rgba(255,69,0,0.2);
  }

  .checkout-card {
    background: rgba(18,18,26,0.7);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 24px;
    padding: 28px;
    margin-bottom: 24px;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    position: relative;
    overflow: hidden;
  }
  .checkout-card::before {
    content: ''; position: absolute; top: -50px; right: -50px; width: 150px; height: 150px;
    background: rgba(255,94,0,0.15); border-radius: 50%; filter: blur(40px); pointer-events: none; z-index: 0;
  }
  .checkout-card > * { position: relative; z-index: 2; }

  .payment-method-card {
    background: rgba(255,255,255,0.03);
    border: 1.5px solid rgba(255,255,255,0.08);
    border-radius: 14px;
    padding: 16px 20px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 14px;
    margin-bottom: 12px;
  }

  .payment-method-card:hover,
  .payment-method-card.selected {
    border-color: rgba(255,69,0,0.5);
    background: rgba(255,69,0,0.08);
  }

  .payment-method-card.selected {
    box-shadow: 0 0 0 2px rgba(255,69,0,0.2);
  }

  .radio-custom {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    border: 2px solid rgba(255,255,255,1.0);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    transition: all 0.3s;
  }

  .payment-method-card.selected .radio-custom {
    border-color: #ff4500;
    background: rgba(255,69,0,0.15);
  }

  .radio-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #ff4500;
    display: none;
  }

  .payment-method-card.selected .radio-dot { display: block; }

  .payment-method-icon {
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: rgba(255,255,255,0.06);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
    flex-shrink: 0;
  }

  .payment-method-name {
    font-weight: 700;
    font-size: 0.95rem;
    color: white;
  }

  .payment-method-desc {
    font-size: 0.78rem;
    color: rgba(255,255,255,1.0);
    margin-top: 2px;
  }

  .razorpay-badge {
    margin-left: auto;
    background: rgba(23, 108, 232, 0.15);
    border: 1px solid rgba(23,108,232,0.3);
    color: #4b9aff;
    font-size: 0.72rem;
    font-weight: 700;
    padding: 3px 10px;
    border-radius: 6px;
  }

  .order-item-mini {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 0;
    border-bottom: 1px solid rgba(255,255,255,0.05);
  }

  .order-item-mini:last-child { border-bottom: none; }

  .step-indicator {
    display: flex;
    gap: 8px;
    align-items: center;
    margin-bottom: 40px;
    flex-wrap: wrap;
  }

  .step-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.82rem;
    font-weight: 600;
  }

  .step-circle {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.75rem;
    font-weight: 700;
  }

  .step-item.done .step-circle { background: #28a745; color: white; }
  .step-item.active .step-circle { background: linear-gradient(135deg,#ff4500,#ff8c00); color: white; }
  .step-item.pending .step-circle { background: rgba(255,255,255,0.1); color: rgba(255,255,255,1.0); }
  .step-item.done, .step-item.active { color: white; }
  .step-item.pending { color: rgba(255,255,255,0.35); }

  .step-line { flex:1; height:2px; background: rgba(255,255,255,0.08); min-width:24px; }
  .step-line.done { background: linear-gradient(to right, #28a745, #ff4500); }

  /* ===== MOBILE RESPONSIVE ===== */
  @media (max-width: 768px) {
    .checkout-page { padding: 30px 0 80px; }
    .checkout-card { padding: 18px 16px; border-radius: 16px; }
    .step-indicator { gap: 4px; margin-bottom: 24px; }
    .step-item { font-size: 0.72rem; }
    .step-circle { width: 22px; height: 22px; font-size: 0.65rem; }
    .step-line { min-width: 12px; }
    /* Order summary - remove sticky on mobile */
    .col-lg-4 > div { position: static !important; top: auto !important; margin-top: 0; }
    /* Delivery options - stack on mobile */
    #del-express, #del-standard, #del-scheduled { margin-bottom: 10px; }
  }
</style>

<div class="checkout-page">
  <div class="container">

    <!-- Breadcrumb -->
    <nav style="display:flex;gap:8px;align-items:center;font-size:0.8rem;color:rgba(255,255,255,1.0);margin-bottom:16px;">
      <a href="${pageContext.request.contextPath}/" style="color:#ff4500;text-decoration:none;">Home</a>
      <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
      <a href="${pageContext.request.contextPath}/cart" style="color:#ff4500;text-decoration:none;">Cart</a>
      <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
      <span>Checkout</span>
    </nav>

    <h1 class="section-title mb-4">Secure <span>Checkout</span></h1>

    <!-- Steps -->
    <div class="step-indicator">
      <div class="step-item done">
        <div class="step-circle"><i class="fas fa-check" style="font-size:0.7rem;"></i></div>
        <span>Cart</span>
      </div>
      <div class="step-line done"></div>
      <div class="step-item active">
        <div class="step-circle">2</div>
        <span>Checkout</span>
      </div>
      <div class="step-line"></div>
      <div class="step-item pending">
        <div class="step-circle">3</div>
        <span>Payment</span>
      </div>
      <div class="step-line"></div>
      <div class="step-item pending">
        <div class="step-circle">4</div>
        <span>Confirmation</span>
      </div>
    </div>

    <div class="row g-4">

      <!-- Left: Checkout Form -->
      <div class="col-lg-8">

        <!-- Delivery Address -->
        <div class="checkout-card">
          <div class="checkout-section-title">
            <i class="fas fa-map-marker-alt"></i> Delivery Address
          </div>

          <div class="row g-3">
            <div class="col-12">
              <div id="addressDisplayMode" style="display:block;">
                <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.08);border-radius:12px;padding:16px;display:flex;justify-content:space-between;align-items:flex-start;">
                  <div style="flex:1;">
                    <div style="font-weight:700;margin-bottom:6px;"><i class="fas fa-home" style="color:#ff4500;margin-right:6px;"></i> Current Address</div>
                    <div id="addressTextDisplay" style="color:rgba(255,255,255,0.7);font-size:0.9rem;line-height:1.5;white-space:pre-wrap;">${sessionScope.user.address}</div>
                  </div>
                  <button type="button" onclick="editAddress()" style="background:rgba(255,69,0,0.1);border:1px solid rgba(255,69,0,0.3);color:#ff4500;font-size:0.8rem;font-weight:600;padding:6px 12px;border-radius:6px;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,69,0,0.2)'" onmouseout="this.style.background='rgba(255,69,0,0.1)'">
                    <i class="fas fa-edit"></i> Change
                  </button>
                </div>
              </div>

              <div id="addressEditMode" style="display:none;position:relative;">
                <label class="form-label-premium">Update Address</label>
                <textarea id="checkoutAddress" class="form-premium w-100" style="resize:none;height:100px;" placeholder="Enter your full delivery address...">${sessionScope.user.address}</textarea>
                <div style="text-align:right;margin-top:10px;">
                  <button type="button" onclick="saveAddress()" style="background:#ff4500;color:white;border:none;border-radius:8px;padding:8px 16px;font-weight:600;font-size:0.85rem;cursor:pointer;">
                    <i class="fas fa-check"></i> Done
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Delivery Options -->
        <div class="checkout-card">
          <div class="checkout-section-title">
            <i class="fas fa-truck"></i> Delivery Time
          </div>
          <div class="row g-3">
            <div class="col-md-4">
              <div onclick="selectDelivery(this, 'Express')" style="background:rgba(255,69,0,0.1);border:1.5px solid rgba(255,69,0,0.4);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;" id="del-express">
                <div style="font-size:1.4rem;margin-bottom:6px;">⚡</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Express</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">20-30 min</div>
                <div style="font-size:0.8rem;font-weight:700;color:#ff4500;margin-top:6px;">+₹40</div>
              </div>
            </div>
            <div class="col-md-4">
              <div onclick="selectDelivery(this, 'Standard')" style="background:rgba(255,255,255,0.03);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;" id="del-standard">
                <div style="font-size:1.4rem;margin-bottom:6px;">🛵</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Standard</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">45-60 min</div>
                <div style="font-size:0.8rem;font-weight:700;color:#28a745;margin-top:6px;">FREE</div>
              </div>
            </div>
            <div class="col-md-4">
              <div onclick="selectDelivery(this, 'Scheduled')" style="background:rgba(255,255,255,0.03);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;position:relative;" id="del-scheduled">
                <div style="font-size:1.4rem;margin-bottom:6px;">📅</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Scheduled</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">Choose time</div>
                <div style="font-size:0.8rem;font-weight:700;color:#28a745;margin-top:6px;">FREE</div>
                
                <!-- Scheduled Delivery Time Picker -->
                <div id="scheduledTimeContainer" style="display:none;margin-top:12px;text-align:left;" onclick="event.stopPropagation()">
                  <input type="time" id="scheduledTimeInput" class="form-premium w-100" style="padding:6px 12px !important;font-size:0.8rem;border-radius:8px;">
                </div>
              </div>
            </div>
          </div>
        </div>


      </div>

      <!-- Right: Order Summary -->
      <div class="col-lg-4">
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:28px;position:sticky;top:90px;">

          <h5 style="font-weight:800;font-size:1.05rem;margin-bottom:20px;">Your Order</h5>

          <!-- Mini Cart Items -->
          <div style="max-height:240px;overflow-y:auto;margin-bottom:20px;" class="custom-scroll">
            <c:forEach var="c" items="${cartItems}">
            <div class="order-item-mini">
              <img src="${c.product.image.startsWith('http') ? c.product.image : pageContext.request.contextPath.concat('/images/').concat(c.product.image)}" style="width:46px;height:46px;border-radius:10px;object-fit:cover;flex-shrink:0;" alt="${c.product.name}">
              <div style="flex:1;">
                <div style="font-weight:600;font-size:0.88rem;">${c.product.name}</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,0.4);">Qty: ${c.quantity}</div>
              </div>
              <div style="font-weight:700;font-size:0.9rem;color:#ff4500;">₹${c.product.price * c.quantity}</div>
            </div>
            </c:forEach>
          </div>

          <div style="height:1px;background:rgba(255,255,255,0.06);margin-bottom:16px;"></div>

          <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:16px;">
            <div style="display:flex;justify-content:space-between;font-size:0.88rem;color:rgba(255,255,255,1.0);">
              <span>Subtotal</span><span style="color:white;font-weight:600;">₹${subtotal}</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:0.88rem;color:rgba(255,255,255,1.0);">
              <span>Delivery</span><span id="deliveryChargeText" style="color:#28a745;font-weight:600;">FREE</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:0.88rem;color:rgba(255,255,255,1.0);">
              <span>GST (5%)</span><span style="color:white;font-weight:600;">₹${tax}</span>
            </div>
            <c:if test="${not empty discount and discount > 0}">
            <div style="display:flex;justify-content:space-between;font-size:0.88rem;color:rgba(255,255,255,1.0);">
              <span style="color:#28a745;font-weight:600;"><i class="fas fa-tag me-1"></i>Discount</span>
              <span style="color:#28a745;font-weight:700;">-₹${discount}</span>
            </div>
            </c:if>
          </div>

          <div style="height:1px;background:linear-gradient(to right,transparent,rgba(255,69,0,0.4),transparent);margin-bottom:16px;"></div>

          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
            <span style="font-size:1.05rem;font-weight:700;">Total Amount</span>
            <span id="checkoutTotal" style="font-size:1.5rem;font-weight:900;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹${totalAmount}</span>
          </div>

          <!-- Place Order Button -->
          <button id="placeOrderBtn" onclick="placeOrder()" class="btn-primary-premium w-100 justify-content-center" style="padding:16px;font-size:1rem;">
            <i class="fas fa-lock"></i> Place Order Securely
          </button>

          <!-- Hidden form for Order Creation -->
          <form id="codForm" action="${pageContext.request.contextPath}/place-order" method="post" style="display:none;">
            <input type="hidden" name="address" id="formAddress" value="Standard Address">
            <input type="hidden" name="deliveryTime" id="formDeliveryTime" value="30 mins">
            <input type="hidden" name="totalAmount" id="totalAmountInput" value="${totalAmount}">
            <c:if test="${not empty appliedCoupon}">
              <input type="hidden" name="appliedCoupon" value="${appliedCoupon}">
            </c:if>
          </form>

          <p style="text-align:center;font-size:0.75rem;color:rgba(255,255,255,0.3);margin-top:12px;">
            <i class="fas fa-shield-alt me-1"></i> 256-bit SSL Encrypted. Your data is safe.
          </p>

        </div>
      </div>

    </div>
  </div>
</div>

<script>
let selectedDeliveryType = 'Express'; // Default
const baseTotal = ${totalAmount};

function selectDelivery(el, type) {
  selectedDeliveryType = type;
  
  // Reset styles
  document.querySelectorAll('[id^="del-"]').forEach(d => {
    d.style.background = 'rgba(255,255,255,0.03)';
    d.style.borderColor = 'rgba(255,255,255,0.08)';
  });
  
  // Highlight selected
  el.style.background = 'rgba(255,69,0,0.1)';
  el.style.borderColor = 'rgba(255,69,0,0.4)';
  
  // Show/Hide time picker
  document.getElementById('scheduledTimeContainer').style.display = (type === 'Scheduled') ? 'block' : 'none';
  
  // Calculate total
  const deliveryFee = (type === 'Express') ? 40 : 0;
  const newTotal = baseTotal + deliveryFee;
  
  // Update Order Summary UI
  const deliveryChargeText = document.getElementById('deliveryChargeText');
  if(deliveryFee > 0) {
    deliveryChargeText.innerText = '+₹' + deliveryFee;
    deliveryChargeText.style.color = '#ff4500';
  } else {
    deliveryChargeText.innerText = 'FREE';
    deliveryChargeText.style.color = '#28a745';
  }
  
  // Update UI Total
  document.getElementById('checkoutTotal').innerText = '₹' + newTotal;
  document.getElementById('totalAmountInput').value = newTotal;
}

function placeOrder() {
  const btn = document.getElementById('placeOrderBtn');
  btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing Order...';
  btn.disabled = true;

  // Get address — even if edit mode is hidden, textarea still has value
  const addrEl = document.getElementById('checkoutAddress');
  let address = addrEl ? addrEl.value.trim() : '';

  // If address is empty, use display text or a default
  if (!address) {
    const displayAddr = document.getElementById('addressTextDisplay');
    address = displayAddr ? displayAddr.innerText.trim() : '';
  }
  if (!address) {
    address = 'Address not provided';
  }

  let deliveryTimeStr = selectedDeliveryType || 'Standard';
  if (selectedDeliveryType === 'Scheduled') {
    const timeVal = document.getElementById('scheduledTimeInput').value;
    if (!timeVal) {
      alert('Please choose a scheduled time.');
      btn.innerHTML = '<i class="fas fa-lock"></i> Place Order Securely';
      btn.disabled = false;
      return;
    }
    deliveryTimeStr += " (" + timeVal + ")";
  }

  document.getElementById('formAddress').value = address;
  document.getElementById('formDeliveryTime').value = deliveryTimeStr;
  document.getElementById('codForm').submit();
}

function editAddress() {
  document.getElementById('addressDisplayMode').style.display = 'none';
  document.getElementById('addressEditMode').style.display = 'block';
  document.getElementById('checkoutAddress').focus();
}

function saveAddress() {
  const newAddr = document.getElementById('checkoutAddress').value;
  if(newAddr && newAddr.trim() !== '') {
    document.getElementById('addressTextDisplay').innerText = newAddr;
  }
  document.getElementById('addressEditMode').style.display = 'none';
  document.getElementById('addressDisplayMode').style.display = 'block';
}

// Initial selection
document.addEventListener('DOMContentLoaded', () => {
  selectDelivery(document.getElementById('del-express'), 'Express');
});
</script>

<%@ include file="../common/footer.jsp"%>
