<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<div style="min-height:100vh;display:flex;align-items:center;padding:80px 0;position:relative;">
  <div style="position:absolute;inset:0;background:radial-gradient(ellipse at 20% 50%,rgba(255,69,0,0.1) 0%,transparent 50%),radial-gradient(ellipse at 80% 80%,rgba(255,140,0,0.06) 0%,transparent 40%);"></div>

  <div class="container" style="position:relative;z-index:1;">
    <div class="row justify-content-center">
      <div class="col-lg-7">

        <div style="background:rgba(255,255,255,0.03);border:1px solid rgba(255,255,255,0.08);border-radius:28px;padding:48px 40px;backdrop-filter:blur(20px);box-shadow:0 30px 80px rgba(0,0,0,0.5);position:relative;">
          <!-- Top gradient line -->
          <div style="position:absolute;top:0;left:20%;right:20%;height:2px;background:linear-gradient(to right,transparent,#ff4500,#ffd700,transparent);border-radius:2px;"></div>

          <div style="text-align:center;margin-bottom:32px;">
            <div style="width:60px;height:60px;border-radius:18px;background:linear-gradient(135deg,#ff4500,#ff8c00);display:flex;align-items:center;justify-content:center;font-size:1.6rem;margin:0 auto 16px;box-shadow:0 8px 25px rgba(255,69,0,0.4);">
              👤
            </div>
            <h3 style="font-weight:800;font-size:1.7rem;margin-bottom:6px;">Create Account</h3>
            <p style="color:rgba(255,255,255,0.45);font-size:0.88rem;">Join FoodieHub and start ordering delicious food!</p>
          </div>

          <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="row g-3">

              <div class="col-md-6">
                <label class="form-label-premium">Full Name</label>
                <div style="position:relative;">
                  <i class="fas fa-user" style="position:absolute;left:16px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <input type="text" name="name" class="form-premium w-100" style="padding-left:44px !important;" placeholder="Your full name" required>
                </div>
              </div>

              <div class="col-md-6">
                <label class="form-label-premium">Mobile Number</label>
                <div style="position:relative;">
                  <i class="fas fa-phone" style="position:absolute;left:16px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <input type="tel" name="mobile" class="form-premium w-100" style="padding-left:44px !important;" placeholder="+91 XXXXX XXXXX" required>
                </div>
              </div>

              <div class="col-12">
                <label class="form-label-premium">Email Address</label>
                <div style="position:relative;">
                  <i class="fas fa-envelope" style="position:absolute;left:16px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <input type="email" name="email" class="form-premium w-100" style="padding-left:44px !important;" placeholder="your@email.com" required>
                </div>
              </div>

              <div class="col-12">
                <label class="form-label-premium">Delivery Address</label>
                <div style="position:relative;">
                  <i class="fas fa-map-marker-alt" style="position:absolute;left:16px;top:16px;color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <textarea name="address" class="form-premium w-100" style="padding-left:44px !important;resize:none;height:90px;" placeholder="Street, City, State, PIN Code" required></textarea>
                </div>
              </div>

              <div class="col-md-6">
                <label class="form-label-premium">Password</label>
                <div style="position:relative;">
                  <i class="fas fa-lock" style="position:absolute;left:16px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <input type="password" name="password" id="regPass" class="form-premium w-100" style="padding-left:44px !important;" placeholder="Min 8 characters" required>
                  <button type="button" onclick="togglePass2('regPass', this)" style="position:absolute;right:14px;top:50%;transform:translateY(-50%);background:none;border:none;color:rgba(255,255,255,0.35);cursor:pointer;font-size:0.9rem;z-index:2;">
                    <i class="fas fa-eye"></i>
                  </button>
                </div>
              </div>

              <div class="col-md-6">
                <label class="form-label-premium">Confirm Password</label>
                <div style="position:relative;">
                  <i class="fas fa-lock" style="position:absolute;left:16px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.35);font-size:0.9rem;z-index:2;"></i>
                  <input type="password" id="confirmPass" class="form-premium w-100" style="padding-left:44px !important;" placeholder="Repeat password" required>
                  <button type="button" onclick="togglePass2('confirmPass', this)" style="position:absolute;right:14px;top:50%;transform:translateY(-50%);background:none;border:none;color:rgba(255,255,255,0.35);cursor:pointer;font-size:0.9rem;z-index:2;">
                    <i class="fas fa-eye"></i>
                  </button>
                </div>
              </div>

              <div class="col-12">
                <label style="display:flex;align-items:flex-start;gap:10px;cursor:pointer;color:rgba(255,255,255,0.55);font-size:0.85rem;">
                  <input type="checkbox" required style="accent-color:#ff4500;margin-top:3px;">
                  I agree to FoodieHub's <a href="#" style="color:#ff4500;text-decoration:none;">Terms of Service</a> and <a href="#" style="color:#ff4500;text-decoration:none;">Privacy Policy</a>
                </label>
              </div>

              <div class="col-12">
                <!-- Password strength indicator -->
                <div id="strengthIndicator" style="display:none;margin-bottom:8px;">
                  <div style="display:flex;gap:4px;margin-bottom:4px;">
                    <div id="s1" style="height:4px;flex:1;border-radius:2px;background:rgba(255,255,255,0.1);transition:background 0.3s;"></div>
                    <div id="s2" style="height:4px;flex:1;border-radius:2px;background:rgba(255,255,255,0.1);transition:background 0.3s;"></div>
                    <div id="s3" style="height:4px;flex:1;border-radius:2px;background:rgba(255,255,255,0.1);transition:background 0.3s;"></div>
                    <div id="s4" style="height:4px;flex:1;border-radius:2px;background:rgba(255,255,255,0.1);transition:background 0.3s;"></div>
                  </div>
                  <div id="strengthText" style="font-size:0.75rem;color:rgba(255,255,255,0.4);"></div>
                </div>

                <button type="submit" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;font-size:1rem;">
                  <i class="fas fa-user-plus"></i> Create My Account
                </button>
              </div>

            </div>
          </form>

          <p style="text-align:center;color:rgba(255,255,255,0.4);font-size:0.85rem;margin-top:24px;">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login" style="color:#ff4500;font-weight:600;text-decoration:none;">Sign In</a>
          </p>

        </div>
      </div>
    </div>
  </div>
</div>

<script>
function togglePass2(fieldId, btn) {
  const field = document.getElementById(fieldId);
  const icon = btn.querySelector('i');
  if (field.type === 'password') {
    field.type = 'text';
    icon.className = 'fas fa-eye-slash';
    btn.style.color = '#ff4500';
  } else {
    field.type = 'password';
    icon.className = 'fas fa-eye';
    btn.style.color = 'rgba(255,255,255,0.35)';
  }
}

// Password strength
document.getElementById('regPass').addEventListener('input', function() {
  const val = this.value;
  const indicator = document.getElementById('strengthIndicator');
  indicator.style.display = val.length > 0 ? 'block' : 'none';

  let strength = 0;
  if (val.length >= 8) strength++;
  if (/[A-Z]/.test(val)) strength++;
  if (/[0-9]/.test(val)) strength++;
  if (/[^A-Za-z0-9]/.test(val)) strength++;

  const colors = ['#dc3545','#fd7e14','#ffc107','#28a745'];
  const labels = ['Weak','Fair','Good','Strong'];

  for (let i = 1; i <= 4; i++) {
    document.getElementById('s' + i).style.background = i <= strength ? colors[strength - 1] : 'rgba(255,255,255,0.1)';
  }
  document.getElementById('strengthText').textContent = strength > 0 ? labels[strength-1] + ' password' : '';
  document.getElementById('strengthText').style.color = strength > 0 ? colors[strength-1] : 'rgba(255,255,255,0.4)';
});
</script>

<%@ include file="../common/footer.jsp"%>
