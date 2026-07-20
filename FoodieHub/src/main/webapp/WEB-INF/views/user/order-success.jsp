<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .success-page {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 80px 0;
    position: relative;
  }

  .success-bg {
    position: absolute;
    inset: 0;
    background:
      radial-gradient(ellipse at 50% 30%, rgba(40,167,69,0.12) 0%, transparent 60%),
      radial-gradient(ellipse at 20% 80%, rgba(255,69,0,0.06) 0%, transparent 40%);
  }

  @keyframes successPop {
    0% { transform: scale(0) rotate(-180deg); opacity: 0; }
    60% { transform: scale(1.15) rotate(10deg); }
    80% { transform: scale(0.95); }
    100% { transform: scale(1) rotate(0deg); opacity: 1; }
  }

  @keyframes confetti-fall {
    0% { transform: translateY(-10px) rotate(0deg); opacity: 1; }
    100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
  }

  .success-icon {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: linear-gradient(135deg, #28a745, #20c997);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    margin: 0 auto 24px;
    animation: successPop 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
    box-shadow: 0 20px 50px rgba(40,167,69,0.4);
  }

  .success-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(40,167,69,0.2);
    border-radius: 28px;
    padding: 50px 40px;
    text-align: center;
    max-width: 580px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
    box-shadow: 0 30px 80px rgba(0,0,0,0.4);
  }

  .success-card::before {
    content: '';
    position: absolute;
    top: 0; left: 20%; right: 20%;
    height: 2px;
    background: linear-gradient(to right, transparent, #28a745, #20c997, transparent);
    border-radius: 2px;
  }

  .order-detail-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin: 28px 0;
    text-align: left;
  }

  .order-detail-item {
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 14px;
    padding: 16px;
  }

  .detail-label {
    font-size: 0.72rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: rgba(255,255,255,0.35);
    margin-bottom: 6px;
  }

  .detail-value {
    font-size: 0.95rem;
    font-weight: 700;
    color: white;
  }

  .tracking-steps {
    display: flex;
    justify-content: space-between;
    position: relative;
    margin: 28px 0;
    padding: 0 10px;
  }

  .tracking-steps::before {
    content: '';
    position: absolute;
    top: 20px;
    left: 10%;
    right: 10%;
    height: 2px;
    background: rgba(255,255,255,0.07);
  }

  .tracking-steps::after {
    content: '';
    position: absolute;
    top: 20px;
    left: 10%;
    width: 30%;
    height: 2px;
    background: linear-gradient(to right, #28a745, #ff4500);
  }

  .track-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    position: relative;
    z-index: 1;
  }

  .track-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    border: 2px solid rgba(255,255,255,0.1);
    background: rgba(10,10,15,1);
    transition: all 0.5s ease;
  }

  .track-circle.done {
    border-color: #28a745;
    background: rgba(40,167,69,0.15);
  }

  .track-circle.active {
    border-color: #ff4500;
    background: rgba(255,69,0,0.15);
    animation: pulse-glow 2s infinite;
  }

  .track-label {
    font-size: 0.72rem;
    color: rgba(255,255,255,0.5);
    font-weight: 600;
    text-align: center;
    max-width: 70px;
  }

  .confetti-piece {
    position: fixed;
    width: 10px;
    height: 10px;
    border-radius: 2px;
    animation: confetti-fall linear forwards;
    pointer-events: none;
    z-index: 9999;
  }
</style>

<div class="success-page">
  <div class="success-bg"></div>
  <div class="container" style="position:relative;z-index:1;">

    <div class="success-card animate__animated animate__fadeInUp">

      <div class="success-icon">✅</div>

      <h2 style="font-weight:900;font-size:2rem;margin-bottom:8px;">Order Placed! 🎉</h2>
      <p style="color:rgba(255,255,255,0.55);font-size:1rem;margin-bottom:0;">
        Woohoo! Your delicious food is on its way. Sit back and relax!
      </p>

      <!-- Order Details Grid -->
      <div class="order-detail-grid">

        <div class="order-detail-item">
          <div class="detail-label">Order ID</div>
          <div class="detail-value" style="color:#ff4500;">#FH-<c:out value="${param.orderId}" default="2024001"/></div>
        </div>

        <div class="order-detail-item">
          <div class="detail-label">Payment Mode</div>
          <div class="detail-value">
            <c:choose>
              <c:when test="${not empty paymentMode}">${paymentMode}</c:when>
              <c:otherwise>Razorpay</c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="order-detail-item">
          <div class="detail-label">Total Amount</div>
          <div class="detail-value" style="background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;font-size:1.1rem;">
            ₹<c:choose>
              <c:when test="${amount > 0}">${amount}</c:when>
              <c:otherwise>1,256</c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="order-detail-item">
          <div class="detail-label">Status</div>
          <div class="detail-value">
            <span style="background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);border-radius:8px;padding:3px 12px;font-size:0.82rem;color:#28a745;">
              ✅ Confirmed
            </span>
          </div>
        </div>

        <div class="order-detail-item" style="grid-column:1/-1;">
          <div class="detail-label">Estimated Delivery</div>
          <div class="detail-value" style="display:flex;align-items:center;gap:8px;">
            <i class="fas fa-clock" style="color:#ff4500;"></i>
            <span>30 - 45 minutes</span>
          </div>
        </div>

      </div>

      <!-- Order Tracking -->
      <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:16px;padding:20px;margin-bottom:28px;">
        <div style="font-size:0.8rem;font-weight:700;text-transform:uppercase;letter-spacing:1px;color:rgba(255,255,255,0.35);margin-bottom:20px;">Live Order Tracking</div>
        <div class="tracking-steps">
          <div class="track-step">
            <div class="track-circle done">✅</div>
            <div class="track-label">Order Placed</div>
          </div>
          <div class="track-step">
            <div class="track-circle done">👨‍🍳</div>
            <div class="track-label">Preparing</div>
          </div>
          <div class="track-step">
            <div class="track-circle active">🛵</div>
            <div class="track-label">On The Way</div>
          </div>
          <div class="track-step">
            <div class="track-circle">🏠</div>
            <div class="track-label">Delivered</div>
          </div>
        </div>
      </div>

      <!-- Success Message -->
      <c:if test="${not empty message}">
        <div style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.3);border-radius:12px;padding:14px;margin-bottom:24px;color:#28a745;font-weight:600;font-size:0.9rem;">
          <i class="fas fa-check-circle me-2"></i>${message}
        </div>
      </c:if>

      <!-- Action Buttons -->
      <div class="d-flex gap-3 justify-content-center flex-wrap">
        <a href="${pageContext.request.contextPath}/orders" class="btn-primary-premium" style="padding:12px 28px;">
          <i class="fas fa-box"></i> Track Orders
        </a>
        <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium" style="padding:11px 24px;">
          <i class="fas fa-utensils"></i> Order More
        </a>
      </div>

      <!-- Rating request -->
      <div style="margin-top:28px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);">
        <div style="font-size:0.85rem;color:rgba(255,255,255,0.4);margin-bottom:12px;">Enjoying FoodieHub? Leave a rating!</div>
        <div style="display:flex;gap:8px;justify-content:center;font-size:1.8rem;" id="starRating">
          <span onclick="rate(1)" style="cursor:pointer;transition:transform 0.2s;" onmouseover="hoverStars(1)" onmouseout="resetStars()">⭐</span>
          <span onclick="rate(2)" style="cursor:pointer;transition:transform 0.2s;" onmouseover="hoverStars(2)" onmouseout="resetStars()">⭐</span>
          <span onclick="rate(3)" style="cursor:pointer;transition:transform 0.2s;" onmouseover="hoverStars(3)" onmouseout="resetStars()">⭐</span>
          <span onclick="rate(4)" style="cursor:pointer;transition:transform 0.2s;" onmouseover="hoverStars(4)" onmouseout="resetStars()">⭐</span>
          <span onclick="rate(5)" style="cursor:pointer;transition:transform 0.2s;" onmouseover="hoverStars(5)" onmouseout="resetStars()">⭐</span>
        </div>
      </div>

    </div>
  </div>
</div>

<script>
// Confetti effect on load
function createConfetti() {
  const colors = ['#ff4500','#ff8c00','#ffd700','#28a745','#17a2b8','#e83e8c'];
  for (let i = 0; i < 80; i++) {
    const piece = document.createElement('div');
    piece.className = 'confetti-piece';
    piece.style.left = Math.random() * 100 + 'vw';
    piece.style.top = '-10px';
    piece.style.background = colors[Math.floor(Math.random() * colors.length)];
    piece.style.width = (Math.random() * 10 + 6) + 'px';
    piece.style.height = (Math.random() * 10 + 6) + 'px';
    piece.style.borderRadius = Math.random() > 0.5 ? '50%' : '2px';
    piece.style.animationDuration = (Math.random() * 3 + 2) + 's';
    piece.style.animationDelay = (Math.random() * 2) + 's';
    document.body.appendChild(piece);
    setTimeout(() => piece.remove(), 5000);
  }
}

window.addEventListener('load', createConfetti);

function rate(n) {
  const stars = document.querySelectorAll('#starRating span');
  stars.forEach((s, i) => {
    s.style.transform = i < n ? 'scale(1.2)' : 'scale(1)';
    s.style.filter = i < n ? 'saturate(2)' : 'grayscale(0.6)';
  });
  setTimeout(() => {
    alert('Thank you for rating us ' + n + '/5! 🙏');
  }, 200);
}

function hoverStars(n) {
  const stars = document.querySelectorAll('#starRating span');
  stars.forEach((s, i) => {
    s.style.transform = i < n ? 'scale(1.2)' : 'scale(1)';
  });
}

function resetStars() {
  const stars = document.querySelectorAll('#starRating span');
  stars.forEach(s => { s.style.transform = 'scale(1)'; s.style.filter = ''; });
}
</script>

<%@ include file="../common/footer.jsp"%>
