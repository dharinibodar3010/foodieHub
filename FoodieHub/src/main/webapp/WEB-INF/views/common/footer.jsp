<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer style="background: #0d0d14; border-top: 1px solid rgba(255,69,0,0.15); margin-top: 80px; padding-top: 60px; padding-bottom: 30px;">
  <div class="container">
    <div class="row g-5">

      <!-- Brand -->
      <div class="col-lg-4 col-md-6">
        <div class="mb-4">
          <h3 style="font-size:1.8rem; font-weight:800; background: linear-gradient(135deg,#ff4500,#ff8c00,#ffd700); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text;">
            🍕 FoodieHub
          </h3>
          <p style="color:rgba(255,255,255,0.95); font-size:0.9rem; line-height:1.8; margin-top:12px;">
            Order your favourite food anytime, anywhere. Fast delivery, best quality and amazing offers delivered right to your door.
          </p>
        </div>
        <div class="d-flex gap-3">
          <a href="#" style="width:40px;height:40px;background:rgba(255,69,0,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#ff4500;text-decoration:none;transition:all 0.3s ease;" onmouseover="this.style.background='#ff4500';this.style.color='white'" onmouseout="this.style.background='rgba(255,69,0,0.15)';this.style.color='#ff4500'">
            <i class="fab fa-facebook-f"></i>
          </a>
          <a href="#" style="width:40px;height:40px;background:rgba(255,69,0,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#ff4500;text-decoration:none;transition:all 0.3s ease;" onmouseover="this.style.background='#ff4500';this.style.color='white'" onmouseout="this.style.background='rgba(255,69,0,0.15)';this.style.color='#ff4500'">
            <i class="fab fa-instagram"></i>
          </a>
          <a href="#" style="width:40px;height:40px;background:rgba(255,69,0,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#ff4500;text-decoration:none;transition:all 0.3s ease;" onmouseover="this.style.background='#ff4500';this.style.color='white'" onmouseout="this.style.background='rgba(255,69,0,0.15)';this.style.color='#ff4500'">
            <i class="fab fa-twitter"></i>
          </a>
          <a href="#" style="width:40px;height:40px;background:rgba(255,69,0,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#ff4500;text-decoration:none;transition:all 0.3s ease;" onmouseover="this.style.background='#ff4500';this.style.color='white'" onmouseout="this.style.background='rgba(255,69,0,0.15)';this.style.color='#ff4500'">
            <i class="fab fa-youtube"></i>
          </a>
        </div>
      </div>

      <!-- Quick Links -->
      <div class="col-lg-2 col-md-6">
        <h6 style="color:white;font-weight:700;font-size:0.95rem;margin-bottom:20px;text-transform:uppercase;letter-spacing:1px;">Quick Links</h6>
        <ul class="list-unstyled">
          <li class="mb-3"><a href="${pageContext.request.contextPath}/" style="color:rgba(255,255,255,0.95);text-decoration:none;font-size:0.9rem;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.95)'"><i class="fas fa-chevron-right me-2" style="font-size:0.7rem;color:#ff4500;"></i>Home</a></li>
          <li class="mb-3"><a href="${pageContext.request.contextPath}/products" style="color:rgba(255,255,255,0.95);text-decoration:none;font-size:0.9rem;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.95)'"><i class="fas fa-chevron-right me-2" style="font-size:0.7rem;color:#ff4500;"></i>Menu</a></li>
          <li class="mb-3"><a href="${pageContext.request.contextPath}/cart" style="color:rgba(255,255,255,0.95);text-decoration:none;font-size:0.9rem;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.95)'"><i class="fas fa-chevron-right me-2" style="font-size:0.7rem;color:#ff4500;"></i>Cart</a></li>
          <li class="mb-3"><a href="${pageContext.request.contextPath}/orders" style="color:rgba(255,255,255,0.95);text-decoration:none;font-size:0.9rem;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.95)'"><i class="fas fa-chevron-right me-2" style="font-size:0.7rem;color:#ff4500;"></i>My Orders</a></li>
          <li class="mb-3"><a href="${pageContext.request.contextPath}/register" style="color:rgba(255,255,255,0.95);text-decoration:none;font-size:0.9rem;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.95)'"><i class="fas fa-chevron-right me-2" style="font-size:0.7rem;color:#ff4500;"></i>Register</a></li>
        </ul>
      </div>

      <!-- Contact -->
      <div class="col-lg-3 col-md-6">
        <h6 style="color:white;font-weight:700;font-size:0.95rem;margin-bottom:20px;text-transform:uppercase;letter-spacing:1px;">Contact Us</h6>
        <div class="d-flex flex-column gap-3">
          <div class="d-flex align-items-start gap-3">
            <div style="width:36px;height:36px;background:rgba(255,69,0,0.15);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ff4500;flex-shrink:0;">
              <i class="fas fa-map-marker-alt" style="font-size:0.85rem;"></i>
            </div>
            <span style="color:rgba(255,255,255,0.95);font-size:0.9rem;line-height:1.5;">Rajkot, Gujarat, India 360001</span>
          </div>
          <div class="d-flex align-items-center gap-3">
            <div style="width:36px;height:36px;background:rgba(255,69,0,0.15);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ff4500;flex-shrink:0;">
              <i class="fas fa-phone" style="font-size:0.85rem;"></i>
            </div>
            <span style="color:rgba(255,255,255,0.95);font-size:0.9rem;">+91 98765 43210</span>
          </div>
          <div class="d-flex align-items-center gap-3">
            <div style="width:36px;height:36px;background:rgba(255,69,0,0.15);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#ff4500;flex-shrink:0;">
              <i class="fas fa-envelope" style="font-size:0.85rem;"></i>
            </div>
            <span style="color:rgba(255,255,255,0.95);font-size:0.9rem;">hello@foodiehub.in</span>
          </div>
        </div>
      </div>

      <!-- Newsletter -->
      <div class="col-lg-3 col-md-6">
        <h6 style="color:white;font-weight:700;font-size:0.95rem;margin-bottom:20px;text-transform:uppercase;letter-spacing:1px;">Newsletter</h6>
        <p style="color:rgba(255,255,255,0.95);font-size:0.85rem;margin-bottom:16px;">Get exclusive offers and food news delivered to your inbox.</p>
        <div class="d-flex gap-2">
          <input type="email" placeholder="Your email..." style="flex:1;background:rgba(255,255,255,0.05);border:1px solid rgba(255,69,0,0.2);border-radius:10px;padding:10px 14px;color:white;font-size:0.85rem;outline:none;">
          <button style="background:linear-gradient(135deg,#ff4500,#ff8c00);border:none;border-radius:10px;padding:10px 16px;color:white;cursor:pointer;transition:all 0.3s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
            <i class="fas fa-paper-plane"></i>
          </button>
        </div>
        <div class="mt-4 d-flex gap-2 flex-wrap">
          <span style="background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:6px;padding:4px 10px;font-size:0.75rem;color:rgba(255,255,255,0.9);">
            🚀 Fast Delivery
          </span>
          <span style="background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:6px;padding:4px 10px;font-size:0.75rem;color:rgba(255,255,255,0.9);">
            🔒 Secure Pay
          </span>
          <span style="background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:6px;padding:4px 10px;font-size:0.75rem;color:rgba(255,255,255,0.9);">
            ⭐ Top Rated
          </span>
        </div>
      </div>

    </div>

    <div style="height:1px;background:linear-gradient(to right,transparent,rgba(255,69,0,0.4),transparent);margin:40px 0;"></div>

    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
      <p style="color:rgba(255,255,255,0.85);font-size:0.85rem;margin:0;">
        © 2026 <strong style="color:#ff4500;">FoodieHub</strong>. All Rights Reserved. Made with ❤️ in India.
      </p>
      <div class="d-flex gap-4">
        <a href="#" style="color:rgba(255,255,255,0.85);text-decoration:none;font-size:0.8rem;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Privacy Policy</a>
        <a href="#" style="color:rgba(255,255,255,0.85);text-decoration:none;font-size:0.8rem;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Terms of Service</a>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/js/script.js"></script>

</body>
</html>