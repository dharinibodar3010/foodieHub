<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<div style="padding:60px 0 100px;">
  <div class="container">

    <!-- Page Title -->
    <div style="margin-bottom:40px;">
      <nav style="display:flex;gap:8px;align-items:center;font-size:0.8rem;color:rgba(255,255,255,1.0);margin-bottom:12px;">
        <a href="${pageContext.request.contextPath}/" style="color:#ff4500;text-decoration:none;">Home</a>
        <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
        <a href="${pageContext.request.contextPath}/products" style="color:#ff4500;text-decoration:none;">Menu</a>
        <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
        <span>My Cart</span>
      </nav>
      <h1 class="section-title">My <span>Cart</span></h1>
    </div>

    <div class="row g-4">

      <!-- Cart Items -->
      <div class="col-lg-8">

        <!-- Dynamic Cart Items -->
        <div style="display:flex;flex-direction:column;gap:16px;" id="cartContainer">

          <c:if test="${empty cartItems}">
            <div style="text-align:center;padding:40px;color:rgba(255,255,255,1.0);">
              <i class="fas fa-shopping-cart" style="font-size:3rem;color:rgba(255,69,0,0.3);margin-bottom:20px;"></i>
              <h5>Your cart is empty!</h5>
              <p>Add some delicious food to your cart.</p>
              <a href="${pageContext.request.contextPath}/products" class="btn-primary-premium mt-3">Browse Menu</a>
            </div>
          </c:if>
          <c:forEach var="c" items="${cartItems}">
          <div class="cart-item-row" data-id="${c.id}" data-price="${c.product.price}" data-qty="${c.quantity}" style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:18px;padding:20px;display:flex;align-items:center;gap:16px;transition:all 0.3s;">
            <img src="${c.product.image.startsWith('http') ? c.product.image : pageContext.request.contextPath.concat('/images/').concat(c.product.image)}" alt="${c.product.name}"
                 style="width:80px;height:80px;border-radius:14px;object-fit:cover;flex-shrink:0;">
            <div style="flex:1;">
              <div style="font-weight:700;font-size:1rem;color:white;margin-bottom:4px;">${c.product.name}</div>
              <div style="font-size:0.8rem;color:rgba(255,255,255,1.0);margin-bottom:10px;">${c.product.category.name}</div>
              <div style="font-size:0.9rem;font-weight:700;background:linear-gradient(135deg,#ff4500,#ff8c00);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹${c.product.price} each</div>
            </div>
            <div style="display:flex;align-items:center;gap:0;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:12px;overflow:hidden;">
              <button onclick="changeQty(this,-1)" style="width:38px;height:38px;border:none;background:transparent;color:rgba(255,255,255,1.0);cursor:pointer;font-size:1rem;transition:all 0.2s;" onmouseover="this.style.background='rgba(255,69,0,0.2)';this.style.color='#ff4500'" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,1.0)'">−</button>
              <span class="qty-display" style="min-width:36px;text-align:center;font-weight:700;font-size:0.95rem;color:white;">${c.quantity}</span>
              <button onclick="changeQty(this,1)" style="width:38px;height:38px;border:none;background:transparent;color:rgba(255,255,255,1.0);cursor:pointer;font-size:1rem;transition:all 0.2s;" onmouseover="this.style.background='rgba(255,69,0,0.2)';this.style.color='#ff4500'" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,1.0)'">+</button>
            </div>
            <div style="min-width:80px;text-align:right;">
              <div class="item-total" style="font-size:1.1rem;font-weight:800;background:linear-gradient(135deg,#ff4500,#ff8c00);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹${c.product.price * c.quantity}</div>
            </div>
            <a href="${pageContext.request.contextPath}/removeCart/${c.id}" style="width:36px;height:36px;border-radius:10px;border:1px solid rgba(220,53,69,0.3);background:rgba(220,53,69,0.1);color:#dc3545;cursor:pointer;font-size:0.85rem;display:flex;align-items:center;justify-content:center;text-decoration:none;transition:all 0.3s;flex-shrink:0;" onmouseover="this.style.background='rgba(220,53,69,0.25)'" onmouseout="this.style.background='rgba(220,53,69,0.1)'">
              <i class="fas fa-trash"></i>
            </a>
          </div>
          </c:forEach>
        </div>

        <!-- Coupon -->
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:18px;padding:20px;margin-top:20px;display:flex;gap:12px;">
          <div style="position:relative;flex:1;">
            <i class="fas fa-tag" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;"></i>
            <input type="text" id="couponInput" placeholder="Enter promo code (FOODIE50)" style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:12px 16px 12px 40px;color:white;font-size:0.88rem;font-family:'Poppins',sans-serif;outline:none;" onfocus="this.style.borderColor='rgba(255,69,0,0.4)'" onblur="this.style.borderColor='rgba(255,255,255,0.1)'">
          </div>
          <button onclick="applyCoupon()" style="background:linear-gradient(135deg,#ff4500,#ff8c00);border:none;border-radius:10px;padding:12px 24px;color:white;font-weight:600;font-size:0.88rem;cursor:pointer;white-space:nowrap;transition:all 0.3s;" onmouseover="this.style.transform='scale(1.02)'" onmouseout="this.style.transform='scale(1)'">
            Apply
          </button>
        </div>

      </div>

      <!-- Order Summary -->
      <div class="col-lg-4">
        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.07);border-radius:20px;padding:28px;position:sticky;top:90px;">

          <h5 style="font-weight:800;font-size:1.1rem;margin-bottom:24px;padding-bottom:16px;border-bottom:1px solid rgba(255,255,255,0.07);">
            Order Summary
          </h5>

          <div style="display:flex;flex-direction:column;gap:14px;margin-bottom:20px;">
            <div style="display:flex;justify-content:space-between;font-size:0.9rem;color:rgba(255,255,255,1.0);">
              <span>Subtotal</span>
              <span id="subtotal" style="color:white;font-weight:600;">₹1,196</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:0.9rem;color:rgba(255,255,255,1.0);">
              <span>Delivery Fee</span>
              <span style="color:#28a745;font-weight:600;">FREE 🎉</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:0.9rem;color:rgba(255,255,255,1.0);">
              <span>Taxes (5% GST)</span>
              <span id="taxes" style="color:white;font-weight:600;">₹60</span>
            </div>
            <div id="discountRow" style="display:none;justify-content:space-between;font-size:0.9rem;">
              <span style="color:#28a745;font-weight:600;"><i class="fas fa-tag me-1"></i>Discount (50%)</span>
              <span id="discountAmt" style="color:#28a745;font-weight:700;"></span>
            </div>
          </div>

          <div style="height:1px;background:linear-gradient(to right,transparent,rgba(255,69,0,0.4),transparent);margin-bottom:20px;"></div>

          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
            <span style="font-size:1.1rem;font-weight:700;">Total</span>
            <span id="totalDisplay" style="font-size:1.5rem;font-weight:900;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">₹1,256</span>
          </div>

          <a href="${pageContext.request.contextPath}/checkout" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;font-size:1rem;text-align:center;">
            <i class="fas fa-lock me-2"></i>Proceed to Checkout
          </a>

          <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium w-100 justify-content-center mt-3" style="padding:12px;">
            <i class="fas fa-arrow-left me-2"></i>Continue Shopping
          </a>

          <!-- Trust badges -->
          <div style="display:flex;justify-content:center;gap:20px;margin-top:20px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.06);">
            <div style="text-align:center;">
              <div style="font-size:1.2rem;margin-bottom:4px;">🔒</div>
              <div style="font-size:0.68rem;color:rgba(255,255,255,0.35);">Secure</div>
            </div>
            <div style="text-align:center;">
              <div style="font-size:1.2rem;margin-bottom:4px;">🚀</div>
              <div style="font-size:0.68rem;color:rgba(255,255,255,0.35);">Fast</div>
            </div>
            <div style="text-align:center;">
              <div style="font-size:1.2rem;margin-bottom:4px;">🔄</div>
              <div style="font-size:0.68rem;color:rgba(255,255,255,0.35);">Easy Returns</div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<script>
let discountApplied = false;

function changeQty(btn, delta) {
  const row = btn.closest('.cart-item-row');
  const qtyEl = row.querySelector('.qty-display');
  const price = parseFloat(row.getAttribute('data-price'));
  const cartId = row.getAttribute('data-id');
  let qty = parseInt(qtyEl.textContent) + delta;
  if (qty < 1) qty = 1;
  if (qty > 20) qty = 20;
  
  // Call backend to update qty
  fetch('${pageContext.request.contextPath}/updateCartQty?cartId=' + cartId + '&quantity=' + qty, { method: 'POST' })
    .then(res => res.text())
    .then(data => {
      if(data === 'success') {
        qtyEl.textContent = qty;
        row.setAttribute('data-qty', qty);
        row.querySelector('.item-total').textContent = '₹' + (price * qty).toLocaleString('en-IN');
        updateSummary();
      }
    });
}

function removeItem(btn) {
  const row = btn.closest('.cart-item-row');
  row.style.opacity = '0';
  row.style.transform = 'translateX(20px)';
  row.style.transition = 'all 0.4s ease';
  setTimeout(() => { row.remove(); updateSummary(); }, 400);
}

function updateSummary() {
  let sub = 0;
  document.querySelectorAll('.cart-item-row').forEach(row => {
    const price = parseFloat(row.getAttribute('data-price'));
    const qty = parseInt(row.getAttribute('data-qty'));
    sub += price * qty;
  });

  const tax = Math.round(sub * 0.05);
  let total = sub + tax;

  let discount = 0;
  if (discountApplied) {
    discount = Math.round(sub * 0.5);
    total = sub + tax - discount;
    document.getElementById('discountRow').style.display = 'flex';
    document.getElementById('discountAmt').textContent = '-₹' + discount.toLocaleString('en-IN');
  }

  document.getElementById('subtotal').textContent = '₹' + sub.toLocaleString('en-IN');
  document.getElementById('taxes').textContent = '₹' + tax;
  document.getElementById('totalDisplay').textContent = '₹' + total.toLocaleString('en-IN');
}

function applyCoupon() {
  const code = document.getElementById('couponInput').value.trim().toUpperCase();
  if (code === 'FOODIE50') {
    if (!discountApplied) {
      discountApplied = true;
      updateSummary();
      document.getElementById('couponInput').style.borderColor = '#28a745';
      showCartToast('🎉 Coupon FOODIE50 applied! 50% discount!');
    } else {
      showCartToast('Coupon already applied!');
    }
  } else if (code === '') {
    showCartToast('Please enter a coupon code');
  } else {
    document.getElementById('couponInput').style.borderColor = '#dc3545';
    showCartToast('❌ Invalid coupon code');
  }
}

function showCartToast(msg) {
  let toast = document.querySelector('.toast-premium');
  if (!toast) {
    toast = document.createElement('div');
    toast.className = 'toast-premium';
    document.body.appendChild(toast);
  }
  toast.textContent = msg;
  toast.style.display = 'block';
  setTimeout(() => { toast.style.display = 'none'; }, 3000);
}
document.addEventListener('DOMContentLoaded', updateSummary);
</script>

<%@ include file="../common/footer.jsp"%>
