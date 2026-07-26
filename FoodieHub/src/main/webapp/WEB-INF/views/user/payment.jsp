<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .payment-page { padding: 60px 0 100px; text-align: center; }
  .payment-card {
    background: rgba(18,18,26,0.7);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 24px;
    padding: 40px;
    max-width: 600px;
    margin: 0 auto;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    position: relative;
    overflow: hidden;
  }
  .payment-card::before {
    content: ''; position: absolute; top: -50px; right: -50px; width: 200px; height: 200px;
    background: rgba(255,94,0,0.15); border-radius: 50%; filter: blur(40px); pointer-events: none; z-index: 0;
  }
  .payment-card > * { position: relative; z-index: 2; }
  
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
    text-align: left;
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
    width: 20px; height: 20px; border-radius: 50%;
    border: 2px solid rgba(255,255,255,1.0);
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0; transition: all 0.3s;
  }
  .payment-method-card.selected .radio-custom {
    border-color: #ff4500; background: rgba(255,69,0,0.15);
  }
  .radio-dot {
    width: 8px; height: 8px; border-radius: 50%;
    background: #ff4500; display: none;
  }
  .payment-method-card.selected .radio-dot { display: block; }
  .payment-method-icon {
    width: 44px; height: 44px; border-radius: 12px;
    background: rgba(255,255,255,0.06); display: flex;
    align-items: center; justify-content: center;
    font-size: 1.3rem; flex-shrink: 0;
  }
  .payment-method-name { font-weight: 700; font-size: 0.95rem; color: white; }
  .payment-method-desc { font-size: 0.78rem; color: rgba(255,255,255,1.0); margin-top: 2px; }

  .test-mode-ribbon {
    position: absolute;
    top: 25px;
    right: -45px;
    background: #dc3545;
    color: white;
    padding: 8px 50px;
    transform: rotate(45deg);
    font-weight: 700;
    font-size: 0.9rem;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    z-index: 10;
    letter-spacing: 1px;
    pointer-events: none;
  }
</style>

<div class="payment-page">

  <div class="container">
    <form id="paymentForm" action="${pageContext.request.contextPath}/process-payment" method="post" style="display:none;">
      <input type="hidden" name="orderId" value="${order.id}">
      <input type="hidden" name="paymentMode" id="paymentModeInput" value="">
      <input type="hidden" name="transactionId" id="transactionIdInput" value="">
    </form>

    <form id="cancelForm" action="${pageContext.request.contextPath}/cancel-payment" method="post" style="display:none;">
      <input type="hidden" name="orderId" value="${order.id}">
    </form>

    <div class="payment-card" id="mainPaymentCard">
      <!-- Test Mode Ribbon -->
      <div class="test-mode-ribbon">Test Mode</div>
      <h2 style="font-weight:800;margin-bottom:10px;">Select Payment Method</h2>
      <p style="color:rgba(255,255,255,0.7);margin-bottom:30px;">Order ID: #FH-${order.id} &bull; Total: <strong style="color:white;">₹${order.totalAmount}</strong></p>

      <!-- Razorpay -->
      <div class="payment-method-card selected" id="pm-razorpay" onclick="selectPayment('razorpay')">
        <div class="radio-custom"><div class="radio-dot"></div></div>
        <div class="payment-method-icon">💳</div>
        <div>
          <div class="payment-method-name">Razorpay — UPI / Card / Netbanking</div>
          <div class="payment-method-desc">Pay securely via Razorpay gateway</div>
        </div>
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

      <!-- UPI Details Section (Hidden by default) -->
      <div id="upiSection" style="display:none;margin-top:20px;padding:20px;background:rgba(0,186,136,0.05);border:1px solid rgba(0,186,136,0.2);border-radius:14px;text-align:center;">
        <div style="margin-bottom:12px;display:flex;gap:15px;justify-content:center;">
          <img src="https://upload.wikimedia.org/wikipedia/commons/f/f2/Google_Pay_Logo.svg" height="24" alt="GPay" style="opacity:0.9;">
          <img src="https://upload.wikimedia.org/wikipedia/commons/7/71/PhonePe_Logo.svg" height="24" alt="PhonePe" style="opacity:0.9;">
          <img src="https://upload.wikimedia.org/wikipedia/commons/2/24/Paytm_Logo_%28standalone%29.svg" height="24" alt="Paytm" style="opacity:0.9;">
        </div>
        <img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg" width="100" style="border-radius:10px;border:2px solid #00ba88;padding:4px;background:white;margin:10px auto;" alt="UPI QR">
        <p style="color:rgba(255,255,255,0.8);font-size:0.85rem;margin:12px 0 0;">
          Scan QR to pay directly from your UPI app.<br>
          <span style="font-size:0.75rem;color:rgba(255,255,255,0.4);">Transactions are instant and secure.</span>
        </p>
      </div>

      <!-- COD Details Section (Hidden by default) -->
      <div id="codSection" style="display:none;margin-top:16px;padding:16px;background:rgba(40,167,69,0.08);border:1px solid rgba(40,167,69,0.2);border-radius:12px;">
        <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:0;">
          <i class="fas fa-info-circle" style="color:#28a745;margin-right:8px;"></i>
          Cash on Delivery incurs an extra ₹5 handling charge. Please keep exact change ready.
        </p>
      </div>

      <!-- Pay Button -->
      <button id="payBtn" onclick="executePayment()" class="btn-primary-premium w-100 justify-content-center" style="margin-top:24px;padding:16px;font-size:1.05rem;">
        <i class="fas fa-lock"></i> Pay Securely
      </button>

      <button onclick="cancelPayment()" style="background:none;border:none;color:rgba(255,255,255,0.45);font-size:0.85rem;margin-top:24px;cursor:pointer;text-decoration:underline;display:block;width:100%;transition:color 0.2s;" onmouseover="this.style.color='#dc3545'" onmouseout="this.style.color='rgba(255,255,255,0.45)'">
        <i class="fas fa-times-circle me-1"></i> Cancel Payment &amp; Go Back to Cart
      </button>
    </div>
  </div>
</div>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
let currentMethod = 'razorpay';

function selectPayment(method) {
  currentMethod = method;
  // Reset all selections
  ['razorpay','upi','cod'].forEach(m => {
    document.getElementById('pm-' + m).classList.remove('selected');
  });
  document.getElementById('pm-' + method).classList.add('selected');

  // Toggle sections
  document.getElementById('upiSection').style.display = (method === 'upi') ? 'block' : 'none';
  document.getElementById('codSection').style.display = (method === 'cod') ? 'block' : 'none';
  
  // Update button text
  const btn = document.getElementById('payBtn');
  if(method === 'cod') {
    btn.innerHTML = '<i class="fas fa-check-circle"></i> Confirm Order (COD)';
  } else if(method === 'upi') {
    btn.innerHTML = '<i class="fas fa-mobile-alt"></i> Complete UPI Payment';
  } else {
    btn.innerHTML = '<i class="fas fa-lock"></i> Pay Securely via Razorpay';
  }
}

function executePayment() {
  const btn = document.getElementById('payBtn');
  const originalBtnContent = btn.innerHTML;
  btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
  btn.disabled = true;

  if (currentMethod === 'razorpay') {
    openRazorpay(btn, originalBtnContent);
  } else if (currentMethod === 'upi') {
    // Simulate UPI Payment - direct submit without delay
    document.getElementById('paymentModeInput').value = 'UPI Direct';
    document.getElementById('transactionIdInput').value = 'upi_txn_' + Math.floor(Math.random()*1000000000);
    document.getElementById('paymentForm').submit();
  } else if (currentMethod === 'cod') {
    document.getElementById('paymentModeInput').value = 'Cash on Delivery';
    document.getElementById('transactionIdInput').value = 'COD';
    document.getElementById('paymentForm').submit();
  }
}

function openRazorpay(btn, originalBtnContent) {
  const razorpayKey = '${razorpayKey}';
  const totalAmount = ${order.totalAmount};

  if(!razorpayKey || razorpayKey === '' || razorpayKey.includes('invalid')) {
     // No real key - simulate payment directly
     document.getElementById('paymentModeInput').value = 'Razorpay (Test)';
     document.getElementById('transactionIdInput').value = 'test_rzp_' + Math.floor(Math.random()*1000000);
     document.getElementById('paymentForm').submit();
     return;
  }

  const options = {
    key: razorpayKey, 
    amount: totalAmount * 100, 
    currency: 'INR',
    name: 'FoodieHub',
    description: 'Order #' + ${order.id} + ' Payment',
    image: 'https://ui-avatars.com/api/?name=FH&background=ff4500&color=fff',
    handler: function(response) {
      document.getElementById('paymentModeInput').value = 'Razorpay';
      document.getElementById('transactionIdInput').value = response.razorpay_payment_id;
      document.getElementById('paymentForm').submit();
    },
    prefill: {
      name: '${sessionScope.user.name}',
      email: '${sessionScope.user.email}',
      contact: '${sessionScope.user.mobile}'
    },
    theme: { color: '#ff4500' },
    modal: {
      ondismiss: function() {
        btn.innerHTML = originalBtnContent;
        btn.disabled = false;
      }
    }
  };

  try {
    const rzp = new Razorpay(options);
    rzp.on('payment.failed', function(response) {
      alert('Payment Failed: ' + response.error.description + '\nFalling back to simulated payment.');
      document.getElementById('paymentModeInput').value = 'Razorpay (Simulated)';
      document.getElementById('transactionIdInput').value = 'sim_txn_' + Math.floor(Math.random()*1000000);
      document.getElementById('paymentForm').submit();
    });
    rzp.open();
  } catch(e) {
    document.getElementById('paymentModeInput').value = 'Razorpay';
    document.getElementById('transactionIdInput').value = 'demo_txn_' + Math.floor(Math.random()*10000);
    document.getElementById('paymentForm').submit();
  }
}

function cancelPayment() {
  if (confirm('Cancel payment? Your cart items will be kept safely.')) {
    document.getElementById('cancelForm').submit();
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
