<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .auth-page {
    min-height: 100vh;
    display: flex;
    align-items: center;
    padding: 80px 0;
    position: relative;
  }

  .auth-bg {
    position: absolute;
    inset: 0;
    background:
      radial-gradient(ellipse at 80% 50%, rgba(255,69,0,0.1) 0%, transparent 50%),
      radial-gradient(ellipse at 20% 80%, rgba(255,140,0,0.06) 0%, transparent 40%);
  }

  .auth-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 28px;
    padding: 48px 40px;
    backdrop-filter: blur(20px);
    position: relative;
    z-index: 1;
    max-width: 460px;
    margin: 0 auto;
    box-shadow: 0 30px 80px rgba(0,0,0,0.5);
  }

  .auth-card::before {
    content: '';
    position: absolute;
    top: 0; left: 20%; right: 20%;
    height: 2px;
    background: linear-gradient(to right, transparent, #ff4500, #ffd700, transparent);
    border-radius: 2px;
  }

  .auth-logo {
    width: 60px;
    height: 60px;
    border-radius: 18px;
    background: linear-gradient(135deg, #ff4500, #ff8c00);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.6rem;
    margin: 0 auto 20px;
    box-shadow: 0 8px 25px rgba(255,69,0,0.4);
  }

  .social-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 12px;
    color: white;
    font-size: 0.9rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
    width: 100%;
  }

  .social-btn:hover {
    background: rgba(255,255,255,0.08);
    border-color: rgba(255,255,255,0.2);
    color: white;
    transform: translateY(-2px);
  }

  .divider-or {
    display: flex;
    align-items: center;
    gap: 16px;
    margin: 24px 0;
    color: rgba(255,255,255,0.3);
    font-size: 0.8rem;
  }
  .divider-or::before, .divider-or::after {
    content: '';
    flex: 1;
    height: 1px;
    background: rgba(255,255,255,0.08);
  }

  .input-group-premium {
    position: relative;
    margin-bottom: 20px;
  }

  .input-icon {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(255,255,255,0.35);
    font-size: 0.9rem;
    z-index: 2;
  }

  .form-premium-icon {
    padding-left: 44px !important;
  }

  .toggle-password {
    position: absolute;
    right: 14px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: rgba(255,255,255,0.35);
    cursor: pointer;
    font-size: 0.9rem;
    z-index: 2;
    transition: color 0.3s;
  }

  .toggle-password:hover { color: #ff4500; }

  .remember-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
  }

  .custom-checkbox {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    color: rgba(255,255,255,0.55);
    font-size: 0.85rem;
  }

  .custom-checkbox input { accent-color: #ff4500; }

  .forgot-link {
    color: #ff4500;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 500;
  }

  .forgot-link:hover {
    color: #ff8c00;
    text-decoration: underline;
  }

  .auth-promo {
    display: none;
  }

  @media (min-width: 992px) {
    .auth-promo {
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding-left: 60px;
    }
  }
</style>

<div class="auth-page">
  <div class="auth-bg"></div>
  <div class="container" style="position:relative; z-index:1;">
    <div class="row align-items-center">

      <!-- Left: Promo -->
      <div class="col-lg-6 auth-promo animate__animated animate__fadeInLeft">
        <div class="mb-4">
          <span style="background:rgba(255,69,0,0.12);border:1px solid rgba(255,69,0,0.3);border-radius:20px;padding:6px 18px;font-size:0.8rem;font-weight:600;color:#ff8c00;">
            🍕 Welcome Back!
          </span>
        </div>
        <h2 style="font-size:3rem;font-weight:900;line-height:1.2;margin-bottom:20px;">
          Your Favourite<br>
          <span class="text-gradient">Food Awaits</span><br>
          You!
        </h2>
        <p style="color:rgba(255,255,255,0.55);font-size:1rem;line-height:1.8;max-width:420px;margin-bottom:32px;">
          Sign in to your FoodieHub account and continue enjoying the best food delivery experience in town.
        </p>
        <div class="d-flex gap-4">
          <div>
            <div style="font-size:1.6rem;font-weight:800;color:#ff4500;">10K+</div>
            <div style="font-size:0.8rem;color:rgba(255,255,255,0.4);">Happy Users</div>
          </div>
          <div>
            <div style="font-size:1.6rem;font-weight:800;color:#ff8c00;">500+</div>
            <div style="font-size:0.8rem;color:rgba(255,255,255,0.4);">Menu Items</div>
          </div>
          <div>
            <div style="font-size:1.6rem;font-weight:800;color:#ffd700;">4.9⭐</div>
            <div style="font-size:0.8rem;color:rgba(255,255,255,0.4);">Rating</div>
          </div>
        </div>
      </div>

      <!-- Right: Login Form -->
      <div class="col-lg-6 animate__animated animate__fadeInRight">
        <div class="auth-card">

          <div class="auth-logo">🍕</div>

          <h3 style="font-weight:800;font-size:1.6rem;text-align:center;margin-bottom:6px;">Welcome Back</h3>
          <p style="color:rgba(255,255,255,0.45);text-align:center;font-size:0.88rem;margin-bottom:28px;">Sign in to your FoodieHub account</p>

          <!-- Error Alert -->
          <c:if test="${not empty msg}">
            <div class="alert-premium mb-24" style="margin-bottom:20px;display:flex;align-items:center;gap:10px;">
              <i class="fas fa-exclamation-circle" style="color:#ff4500;"></i>
              ${msg}
            </div>
          </c:if>

          <!-- Social Login (Demo) -->
          <div class="row g-2 mb-4">
            <div class="col-6">
              <a href="#" class="social-btn">
                <img src="https://www.google.com/favicon.ico" width="18" alt="Google">
                Google
              </a>
            </div>
            <div class="col-6">
              <a href="#" class="social-btn">
                <i class="fab fa-facebook" style="color:#1877f2;font-size:1.1rem;"></i>
                Facebook
              </a>
            </div>
          </div>

          <div class="divider-or">or continue with email</div>

          <!-- Login Form -->
          <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="input-group-premium">
              <i class="fas fa-envelope input-icon"></i>
              <input type="email" name="email" class="form-premium form-premium-icon w-100" placeholder="Enter your email" required>
            </div>

            <div class="input-group-premium">
              <i class="fas fa-lock input-icon"></i>
              <input type="password" name="password" id="loginPass" class="form-premium form-premium-icon w-100" placeholder="Enter your password" required>
              <button type="button" class="toggle-password" onclick="togglePass('loginPass', this)">
                <i class="fas fa-eye"></i>
              </button>
            </div>

            <div class="remember-row">
              <label class="custom-checkbox">
                <input type="checkbox"> Remember me
              </label>
              <a href="#" class="forgot-link">Forgot password?</a>
            </div>

            <button type="submit" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;">
              <i class="fas fa-sign-in-alt"></i> Sign In
            </button>

          </form>

          <p style="text-align:center;color:rgba(255,255,255,0.4);font-size:0.85rem;margin-top:24px;">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register" style="color:#ff4500;font-weight:600;text-decoration:none;">Create Account</a>
          </p>

        </div>
      </div>

    </div>
  </div>
</div>

<script>
function togglePass(fieldId, btn) {
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
</script>

<%@ include file="../common/footer.jsp"%>
