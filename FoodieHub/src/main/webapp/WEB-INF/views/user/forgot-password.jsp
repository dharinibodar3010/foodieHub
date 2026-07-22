<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
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
</style>

<div class="auth-page">
  <div class="auth-bg"></div>
  <div class="container" style="position:relative; z-index:1;">
    <div class="row justify-content-center">

      <div class="col-lg-6 animate__animated animate__fadeInUp">
        <div class="auth-card">
          <div class="auth-logo">🔒</div>
          <h3 style="font-weight:800;font-size:1.6rem;text-align:center;margin-bottom:6px;">Reset Password</h3>
          <p style="color:rgba(255,255,255,0.45);text-align:center;font-size:0.88rem;margin-bottom:28px;">Don't worry, we'll help you get back in</p>

          <!-- Step 1: Request OTP -->
          <div id="step1">
            <div id="msg1" class="alert-premium mb-3" style="display:none; font-size:0.85rem;"></div>
            
            <form id="otpForm" onsubmit="sendOtp(event)">
              <div class="input-group-premium">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" id="email" class="form-premium form-premium-icon w-100" placeholder="Enter your registered email" required>
              </div>
              <button type="submit" id="btnOtp" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;">
                <i class="fas fa-paper-plane"></i> Send Reset Link
              </button>
            </form>
          </div>

          <!-- Step 2: Reset Password -->
          <div id="step2" style="display:none;">
            <div id="msg2" class="alert-premium mb-3" style="display:none; font-size:0.85rem;"></div>
            
            <form id="resetForm" onsubmit="resetPassword(event)">
              <div class="input-group-premium">
                <i class="fas fa-key input-icon"></i>
                <input type="text" id="token" class="form-premium form-premium-icon w-100" placeholder="Enter the reset token from email" required>
              </div>
              
              <div class="input-group-premium">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="newPassword" class="form-premium form-premium-icon w-100" placeholder="Enter new password" required>
              </div>

              <button type="submit" id="btnReset" class="btn-primary-premium w-100 justify-content-center" style="padding:14px;">
                <i class="fas fa-check-circle"></i> Update Password
              </button>
            </form>
          </div>

          <p style="text-align:center;color:rgba(255,255,255,0.4);font-size:0.85rem;margin-top:24px;">
            Remember your password?
            <a href="${pageContext.request.contextPath}/login" style="color:#ff4500;font-weight:600;text-decoration:none;">Sign In</a>
          </p>

        </div>
      </div>

    </div>
  </div>
</div>

<script>
  function sendOtp(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const btn = document.getElementById('btnOtp');
    const msg = document.getElementById('msg1');
    
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
    btn.disabled = true;

    // Use FormData for application/x-www-form-urlencoded
    const formData = new URLSearchParams();
    formData.append('email', email);

    fetch('${pageContext.request.contextPath}/api/forgot-password/send-otp', {
      method: 'POST',
      body: formData
    })
    .then(async (response) => {
      const text = await response.text();
      msg.style.display = 'block';
      
      if (response.ok) {
        msg.className = 'alert-success-premium mb-3';
        msg.innerHTML = '<i class="fas fa-check-circle"></i> ' + text;
        
        // Show step 2 after a short delay
        setTimeout(() => {
          document.getElementById('step1').style.display = 'none';
          document.getElementById('step2').style.display = 'block';
        }, 1500);
      } else {
        msg.className = 'alert-premium mb-3';
        msg.innerHTML = '<i class="fas fa-exclamation-circle" style="color:#ff4500;"></i> ' + text;
      }
    })
    .catch(error => {
      msg.style.display = 'block';
      msg.className = 'alert-premium mb-3';
      msg.innerHTML = 'An error occurred. Please try again.';
    })
    .finally(() => {
      btn.innerHTML = '<i class="fas fa-paper-plane"></i> Send Reset Link';
      btn.disabled = false;
    });
  }

  function resetPassword(e) {
    e.preventDefault();
    const token = document.getElementById('token').value;
    const newPassword = document.getElementById('newPassword').value;
    const btn = document.getElementById('btnReset');
    const msg = document.getElementById('msg2');
    
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
    btn.disabled = true;

    const formData = new URLSearchParams();
    formData.append('token', token);
    formData.append('newPassword', newPassword);

    fetch('${pageContext.request.contextPath}/api/forgot-password/reset', {
      method: 'POST',
      body: formData
    })
    .then(async (response) => {
      const text = await response.text();
      msg.style.display = 'block';
      
      if (response.ok) {
        msg.className = 'alert-success-premium mb-3';
        msg.innerHTML = '<i class="fas fa-check-circle"></i> ' + text + ' <br><a href="${pageContext.request.contextPath}/login" style="color:white;text-decoration:underline;">Click here to Login</a>';
        btn.style.display = 'none';
      } else {
        msg.className = 'alert-premium mb-3';
        msg.innerHTML = '<i class="fas fa-exclamation-circle" style="color:#ff4500;"></i> ' + text;
      }
    })
    .catch(error => {
      msg.style.display = 'block';
      msg.className = 'alert-premium mb-3';
      msg.innerHTML = 'An error occurred. Please try again.';
    })
    .finally(() => {
      if(btn.style.display !== 'none') {
        btn.innerHTML = '<i class="fas fa-check-circle"></i> Update Password';
        btn.disabled = false;
      }
    });
  }
</script>

<%@ include file="../common/footer.jsp"%>
