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
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 20px;
    padding: 28px;
    margin-bottom: 24px;
  }

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
            <div class="col-md-6">
              <label class="form-label-premium">Full Name</label>
              <div style="position:relative;">
                <i class="fas fa-user" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
                <input type="text" class="form-premium w-100" style="padding-left:40px !important;" placeholder="Your full name" value="">
              </div>
            </div>
            <div class="col-md-6">
              <label class="form-label-premium">Mobile Number</label>
              <div style="position:relative;">
                <i class="fas fa-phone" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
                <input type="tel" class="form-premium w-100" style="padding-left:40px !important;" placeholder="+91 XXXXX XXXXX">
              </div>
            </div>
            <div class="col-12">
              <label class="form-label-premium">Street Address</label>
              <div style="position:relative;">
                <i class="fas fa-home" style="position:absolute;left:14px;top:14px;color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
                <textarea class="form-premium w-100" style="padding-left:40px !important;resize:none;height:80px;" placeholder="House no., Street, Area..."></textarea>
              </div>
            </div>
            <div class="col-md-4">
              <label class="form-label-premium">City</label>
              <input type="text" class="form-premium w-100" placeholder="City" value="Rajkot">
            </div>
            <div class="col-md-4">
              <label class="form-label-premium">State</label>
              <input type="text" class="form-premium w-100" placeholder="State" value="Gujarat">
            </div>
            <div class="col-md-4">
              <label class="form-label-premium">PIN Code</label>
              <input type="text" class="form-premium w-100" placeholder="360001">
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
              <div onclick="selectDelivery(this)" style="background:rgba(255,69,0,0.1);border:1.5px solid rgba(255,69,0,0.4);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;">
                <div style="font-size:1.4rem;margin-bottom:6px;">⚡</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Express</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">20-30 min</div>
                <div style="font-size:0.8rem;font-weight:700;color:#28a745;margin-top:6px;">FREE</div>
              </div>
            </div>
            <div class="col-md-4">
              <div onclick="selectDelivery(this)" style="background:rgba(255,255,255,0.03);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;">
                <div style="font-size:1.4rem;margin-bottom:6px;">🛵</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Standard</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">45-60 min</div>
                <div style="font-size:0.8rem;font-weight:700;color:#28a745;margin-top:6px;">FREE</div>
              </div>
            </div>
            <div class="col-md-4">
              <div onclick="selectDelivery(this)" style="background:rgba(255,255,255,0.03);border:1.5px solid rgba(255,255,255,0.08);border-radius:12px;padding:16px;cursor:pointer;text-align:center;transition:all 0.3s;">
                <div style="font-size:1.4rem;margin-bottom:6px;">📅</div>
                <div style="font-weight:700;font-size:0.9rem;margin-bottom:4px;">Scheduled</div>
                <div style="font-size:0.75rem;color:rgba(255,255,255,1.0);">Choose time</div>
                <div style="font-size:0.8rem;font-weight:700;color:#28a745;margin-top:6px;">FREE</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Payment Methods -->
        <div class="checkout-card">
          <div class="checkout-section-title">
            <i class="fas fa-credit-card"></i> Payment Method
          </div>

          <!-- Razorpay -->
          <div class="payment-method-card selected" id="pm-razorpay" onclick="selectPayment('razorpay')">
            <div class="radio-custom"><div class="radio-dot"></div></div>
            <div class="payment-method-icon">💳</div>
            <div>
              <div class="payment-method-name">Razorpay — UPI / Card / Netbanking</div>
              <div class="payment-method-desc">Pay securely via Razorpay gateway</div>
            </div>
            <div class="razorpay-badge">Recommended</div>
          </div>

          <!-- UPI -->
          <div class="payment-method-card" id="pm-upi" onclick="selectPayment('upi')">
            <div class="radio-custom"><div class="radio-dot"></div></div>
            <div class="payment-method-icon">📱</div>
            <div>
              <div class="payment-method-name">UPI Direct (GPay / PhonePe / Paytm)</div>
              <div class="payment-method-desc">Instant bank transfer via UPI</div>
            </div>
          </div>

          <!-- COD -->
          <div class="payment-method-card" id="pm-cod" onclick="selectPayment('cod')">
            <div class="radio-custom"><div class="radio-dot"></div></div>
            <div class="payment-method-icon">💵</div>
            <div>
              <div class="payment-method-name">Cash on Delivery (COD)</div>
              <div class="payment-method-desc">Pay when your order arrives</div>
            </div>
          </div>

          <!-- Card Details (for Razorpay demo) -->
          <div id="razorpaySection" style="margin-top:20px;padding:20px;background:rgba(23,108,232,0.05);border:1px solid rgba(23,108,232,0.2);border-radius:14px;">
            <div style="display:flex;align-items:center;gap:10px;margin-bottom:16px;">
              <img src="https://razorpay.com/favicon.ico" width="20" alt="Razorpay" style="border-radius:4px;">
              <span style="font-weight:600;font-size:0.88rem;color:#4b9aff;">Powered by Razorpay</span>
              <span style="margin-left:auto;font-size:0.75rem;color:rgba(255,255,255,0.35);">🔒 256-bit SSL Secured</span>
            </div>
            <div style="display:flex;gap:10px;flex-wrap:wrap;">
              <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Visa.svg" height="22" alt="Visa" style="opacity:0.7;">
              <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/300px-MasterCard_Logo.svg.png" height="22" alt="Mastercard" style="opacity:0.7;">
              <span style="font-size:0.8rem;color:rgba(255,255,255,0.4);align-self:center;">+ UPI, Netbanking, Wallets</span>
            </div>
          </div>

          <!-- UPI Details Section -->
          <div id="upiSection" style="display:none;margin-top:20px;padding:20px;background:rgba(0,186,136,0.05);border:1px solid rgba(0,186,136,0.2);border-radius:14px;text-align:center;">
            <div style="margin-bottom:12px;display:flex;gap:15px;justify-content:center;">
              <img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/Google_Pay_Logo.svg" height="24" alt="GPay" style="opacity:0.9;">
              <img src="https://upload.wikimedia.org/wikipedia/commons/7/71/PhonePe_Logo.svg" height="24" alt="PhonePe" style="opacity:0.9;">
              <img src="https://upload.wikimedia.org/wikipedia/commons/2/24/Paytm_Logo_%28standalone%29.svg" height="24" alt="Paytm" style="opacity:0.9;">
            </div>
            <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg" width="100" style="border-radius:10px;border:2px solid #00ba88;padding:4px;background:white;" alt="UPI QR">
            <p style="color:rgba(255,255,255,0.8);font-size:0.85rem;margin:12px 0 0;">
              Scan QR or click "Place Order Securely" to pay via your UPI app.<br>
              <span style="font-size:0.75rem;color:rgba(255,255,255,0.4);">Transactions are processed securely by Razorpay.</span>
            </p>
          </div>

          <div id="codSection" style="display:none;margin-top:16px;padding:16px;background:rgba(40,167,69,0.08);border:1px solid rgba(40,167,69,0.2);border-radius:12px;">
            <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:0;">
              <i class="fas fa-info-circle" style="color:#28a745;margin-right:8px;"></i>
              Please keep exact change ready. Our delivery partner does not carry change.
            </p>
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
              <span>Delivery</span><span style="color:#28a745;font-weight:600;">FREE</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:0.88rem;color:rgba(255,255,255,1.0);">
              <span>GST (5%)</span><span style="color:white;font-weight:600;">₹${tax}</span>
            </div>
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

          <!-- Hidden form for COD -->
          <form id="codForm" action="${pageContext.request.contextPath}/payment" method="post" style="display:none;">
            <input type="hidden" name="paymentMode" id="paymentModeInput" value="COD">
            <input type="hidden" name="totalAmount" id="totalAmountInput" value="${totalAmount}">
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
let selectedPayment = 'razorpay';

function selectPayment(method) {
  selectedPayment = method;

  // Reset all
  ['razorpay','upi','cod'].forEach(m => {
    const el = document.getElementById('pm-' + m);
    el.classList.remove('selected');
  });

  document.getElementById('pm-' + method).classList.add('selected');
  document.getElementById('razorpaySection').style.display = (method === 'razorpay') ? 'block' : 'none';
  document.getElementById('upiSection').style.display = (method === 'upi') ? 'block' : 'none';
  document.getElementById('codSection').style.display = (method === 'cod') ? 'block' : 'none';
}

function selectDelivery(el) {
  document.querySelectorAll('[onclick="selectDelivery(this)"]').forEach(d => {
    d.style.background = 'rgba(255,255,255,0.03)';
    d.style.borderColor = 'rgba(255,255,255,0.08)';
  });
  el.style.background = 'rgba(255,69,0,0.1)';
  el.style.borderColor = 'rgba(255,69,0,0.4)';
}

function placeOrder() {
  const btn = document.getElementById('placeOrderBtn');
  const totalAmount = ${totalAmount};

  if (selectedPayment === 'razorpay' || selectedPayment === 'upi') {
    // Razorpay Demo Integration
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
    btn.disabled = true;

    const options = {
      key: 'rzp_test_SYu5g0dpspSt6h', // ← Replace with your Razorpay Test Key
      amount: totalAmount * 100, // Amount in paise
      currency: 'INR',
      name: 'FoodieHub',
      description: 'Food Order Payment',
      image: 'https://via.placeholder.com/150x60?text=FoodieHub',
      handler: function(response) {
        // Payment successful
        console.log('Payment ID:', response.razorpay_payment_id);
        document.getElementById('paymentModeInput').value = 'Razorpay - ' + response.razorpay_payment_id;
        document.getElementById('totalAmountInput').value = totalAmount;
        document.getElementById('codForm').submit();
      },
      prefill: {
        name: 'FoodieHub Customer',
        email: 'customer@foodiehub.com',
        contact: '9876543210'
      },
      notes: {
        address: 'Rajkot, Gujarat'
      },
      theme: {
        color: '#ff4500'
      },
      modal: {
        ondismiss: function() {
          btn.innerHTML = '<i class="fas fa-lock"></i> Place Order Securely';
          btn.disabled = false;
        }
      }
    };

    try {
      const rzp = new Razorpay(options);
      rzp.on('payment.failed', function(response) {
        alert('Payment failed: ' + response.error.description);
        btn.innerHTML = '<i class="fas fa-lock"></i> Place Order Securely';
        btn.disabled = false;
      });
      rzp.open();
    } catch(e) {
      // Fallback if Razorpay script not loaded
      alert('Razorpay Demo:\n\nIn production, add your API key.\nFor now, redirecting as Razorpay payment...');
      document.getElementById('paymentModeInput').value = 'Razorpay';
      document.getElementById('totalAmountInput').value = totalAmount;
      document.getElementById('codForm').submit();
    }

  } else {
    // COD
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Placing Order...';
    btn.disabled = true;
    setTimeout(() => {
      document.getElementById('paymentModeInput').value = 'Cash on Delivery';
      document.getElementById('totalAmountInput').value = totalAmount;
      document.getElementById('codForm').submit();
    }, 1200);
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
