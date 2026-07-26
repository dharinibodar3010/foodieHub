<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<c:set var="isLoginPage" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<style>
  .admin-login-page {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 0;
    position: relative;
    background: #0f172a;
    overflow: hidden;
  }

  .admin-login-bg {
    position: absolute;
    inset: 0;
    background:
      radial-gradient(ellipse at 30% 40%, rgba(255,215,0,0.15) 0%, transparent 60%),
      radial-gradient(ellipse at 70% 80%, rgba(255,140,0,0.12) 0%, transparent 50%);
  }

  /* Decorative abstract shapes */
  .shape-1 {
    position: absolute; top: 15%; left: 10%; width: 300px; height: 300px;
    background: linear-gradient(135deg, rgba(255,140,0,0.2), rgba(255,215,0,0.1));
    border-radius: 50%; filter: blur(60px); animation: float 6s ease-in-out infinite;
  }
  .shape-2 {
    position: absolute; bottom: 10%; right: 15%; width: 250px; height: 250px;
    background: linear-gradient(135deg, rgba(255,215,0,0.15), rgba(255,69,0,0.05));
    border-radius: 50%; filter: blur(50px); animation: float 8s ease-in-out infinite reverse;
  }

  .admin-login-wrapper {
    position: relative;
    z-index: 10;
    width: 100%;
    max-width: 420px;
    margin: 0 auto;
    padding-top: 60px; /* Space for mascot */
  }

  .admin-login-card {
    background: linear-gradient(135deg, rgba(211, 84, 0, 0.2), rgba(212, 172, 13, 0.15));
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    border: 1px solid rgba(212, 172, 13, 0.3);
    border-radius: 32px;
    padding: 40px 36px;
    box-shadow: 0 30px 80px rgba(0,0,0,0.6), 0 0 40px rgba(211, 84, 0, 0.15), inset 0 1px 0 rgba(255,255,255,0.1);
    position: relative;
    border-top: 2px solid #d35400;
  }

  /* --- MASCOT SVG STYLES --- */
  .mascot-wrapper {
    position: absolute;
    top: -65px;
    left: 50%;
    transform: translateX(-50%);
    width: 120px;
    height: 120px;
    z-index: 15;
  }

  .mascot-svg {
    width: 100%;
    height: 100%;
    overflow: visible;
  }

  .mascot-ear { fill: #ff8c00; }
  .mascot-face { fill: #fff3e0; }
  .mascot-eye-bg { fill: #ffffff; }
  .mascot-pupil { fill: #1e293b; transition: transform 0.2s ease-out; }
  .mascot-nose { fill: #1e293b; }
  .mascot-blush { fill: #ffb74d; opacity: 0.6; }
  
  .mascot-arm {
    fill: #ff8c00;
    transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    transform-origin: bottom center;
  }
  
  /* Initial hidden arms */
  .arm-left { transform: translateY(40px) translateX(-20px) rotate(-45deg); opacity: 0; }
  .arm-right { transform: translateY(40px) translateX(20px) rotate(45deg); opacity: 0; }

  /* Eyes closed state (Arms covering eyes) */
  .mascot-wrapper.eyes-closed .arm-left { transform: translateY(-30px) translateX(15px) rotate(20deg); opacity: 1; }
  .mascot-wrapper.eyes-closed .arm-right { transform: translateY(-30px) translateX(-15px) rotate(-20deg); opacity: 1; }
  .mascot-wrapper.eyes-closed .mascot-eye-bg { fill: #ffe0b2; } /* slightly close */
  /* ------------------------- */

  .admin-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: linear-gradient(135deg, rgba(255,140,0,0.15), rgba(255,215,0,0.1));
    border: 1px solid rgba(255,140,0,0.3);
    border-radius: 20px;
    padding: 6px 18px;
    font-size: 0.75rem;
    font-weight: 700;
    color: #ffd700;
    margin-bottom: 24px;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 0 15px rgba(255,140,0,0.1);
  }

  .admin-input-group { margin-bottom: 24px; }

  .admin-input-icon {
    position:absolute;left:18px;top:50%;transform:translateY(-50%);
    color:rgba(255,140,0,0.8);font-size:1rem;z-index:2;
  }

  .admin-input-field {
    padding-left:50px !important;
    height: 54px !important;
    border-color: rgba(255,140,0,0.2) !important;
    border-radius: 16px !important;
    background: rgba(15,23,42,0.6) !important;
    color: white !important;
  }
  .admin-input-field:focus {
    border-color: #ffd700 !important;
    box-shadow: 0 0 0 4px rgba(255,215,0,0.1) !important;
    background: rgba(255,140,0,0.05) !important;
  }

  .btn-glossy {
    width:100%; height:54px;
    background: linear-gradient(135deg, #d35400, #d4ac0d);
    border: none; border-radius: 16px;
    color: #ffffff; font-weight: 800; font-size: 1.05rem;
    cursor: pointer; transition: all 0.3s;
    box-shadow: 0 10px 25px rgba(211, 84, 0, 0.3), inset 0 2px 0 rgba(255,255,255,0.4);
    display: flex; align-items: center; justify-content: center; gap: 10px;
  }
  .btn-glossy:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 35px rgba(255,140,0,0.4), inset 0 2px 0 rgba(255,255,255,0.5);
  }

  @media (max-width: 576px) {
    .admin-login-page { padding: 40px 15px; }
    .admin-login-card { padding: 30px 24px; }
  }
</style>

<div class="admin-login-page">
  <div class="admin-login-bg"></div>
  <div class="shape-1"></div>
  <div class="shape-2"></div>

  <div class="container">
    <div class="admin-login-wrapper animate__animated animate__zoomIn" style="animation-duration: 0.6s;">
      
      <!-- MASCOT SVG -->
      <div class="mascot-wrapper" id="mascot">
        <svg class="mascot-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
          <!-- Ears -->
          <circle cx="50" cy="60" r="25" class="mascot-ear" />
          <circle cx="150" cy="60" r="25" class="mascot-ear" />
          <!-- Face Base -->
          <path d="M 40 100 C 40 30, 160 30, 160 100 C 160 160, 140 180, 100 180 C 60 180, 40 160, 40 100 Z" class="mascot-face" />
          <!-- Blush -->
          <ellipse cx="65" cy="130" rx="12" ry="6" class="mascot-blush" />
          <ellipse cx="135" cy="130" rx="12" ry="6" class="mascot-blush" />
          <!-- Eyes Background -->
          <circle cx="80" cy="100" r="14" class="mascot-eye-bg" />
          <circle cx="120" cy="100" r="14" class="mascot-eye-bg" />
          <!-- Pupils -->
          <circle cx="80" cy="100" r="6" class="mascot-pupil" id="pupilL" />
          <circle cx="120" cy="100" r="6" class="mascot-pupil" id="pupilR" />
          <!-- Nose / Mouth -->
          <path d="M 95 125 L 105 125 L 100 132 Z" class="mascot-nose" />
          <!-- Arms (Covering Eyes later) -->
          <g class="mascot-arm arm-left">
            <ellipse cx="75" cy="110" rx="20" ry="25" />
          </g>
          <g class="mascot-arm arm-right">
            <ellipse cx="125" cy="110" rx="20" ry="25" />
          </g>
        </svg>
      </div>

      <div class="admin-login-card">
        
        <div style="text-align:center;margin-bottom:28px;">
          <div class="admin-badge">
            <i class="fas fa-crown"></i> Admin Control
          </div>
          <h2 style="font-weight:900;font-size:1.8rem;margin-bottom:5px;letter-spacing:-0.5px;color:white;">Welcome Back!</h2>
          <p style="color:rgba(255,255,255,0.5);font-size:0.85rem;">Sign in to securely manage FoodieHub</p>
        </div>

        <!-- Error Alert from Spring -->
        <c:if test="${not empty error}">
          <div class="animate__animated animate__shakeX" style="background:rgba(220,53,69,0.1);border:1px solid rgba(220,53,69,0.3);border-radius:12px;padding:12px 16px;margin-bottom:20px;color:#ff6b6b;font-size:0.85rem;display:flex;align-items:center;gap:10px;font-weight:500;">
            <i class="fas fa-exclamation-circle"></i> ${error}
          </div>
        </c:if>

        <div id="resetMsg" class="alert-premium mb-3" style="display:none; font-size:0.85rem;"></div>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/adminLogin" method="post" id="adminForm">

          <div class="admin-input-group">
            <label class="form-label-premium">Username</label>
            <div style="position:relative;">
              <i class="fas fa-user-shield admin-input-icon"></i>
              <input type="text" name="username" id="username" class="form-premium w-100 admin-input-field" placeholder="admin" required autocomplete="off">
            </div>
          </div>

          <div class="admin-input-group">
            <label class="form-label-premium">Password</label>
            <div style="position:relative;">
              <i class="fas fa-lock admin-input-icon"></i>
              <input type="password" name="password" id="password" class="form-premium w-100 admin-input-field" placeholder="••••••••••" style="padding-right: 50px !important;" required>
              <i class="fas fa-eye" id="togglePassword" style="position:absolute;right:18px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,0.4);cursor:pointer;z-index:2;transition:color 0.3s;" onmouseover="this.style.color='#ffd700'" onmouseout="this.style.color='rgba(255,255,255,0.4)'" title="Show Password"></i>
            </div>
          </div>

          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;">
            <label style="display:flex;align-items:center;gap:8px;cursor:pointer;color:rgba(255,255,255,0.7);font-size:0.85rem;" for="rememberMe">
              <input type="checkbox" name="remember-me" id="rememberMe" style="width:16px;height:16px;accent-color:#d35400;cursor:pointer;">
              Remember me
            </label>
            <a href="javascript:void(0)" onclick="resetAdminAccess()" id="resetBtn" style="color:#d4ac0d;text-decoration:none;font-size:0.85rem;font-weight:600;transition:color 0.3s;">Reset Access?</a>
          </div>

          <button type="submit" class="btn-glossy">
            Secure Login <i class="fas fa-lock"></i>
          </button>

        </form>

        <div style="text-align:center;margin-top:28px;">
          <a href="${pageContext.request.contextPath}/" style="color:rgba(255,255,255,0.4);text-decoration:none;font-size:0.85rem;font-weight:500;transition:color 0.3s;" onmouseover="this.style.color='#ff8c00'" onmouseout="this.style.color='rgba(255,255,255,0.4)'">
            <i class="fas fa-arrow-left me-2"></i> Return to Website
          </a>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
  const mascot = document.getElementById('mascot');
  const userInp = document.getElementById('username');
  const passInp = document.getElementById('password');
  const pupilL = document.getElementById('pupilL');
  const pupilR = document.getElementById('pupilR');

  // Eye tracking logic for username
  userInp.addEventListener('focus', () => { mascot.classList.remove('eyes-closed'); });
  userInp.addEventListener('keyup', (e) => {
    let val = e.target.value.length;
    let maxLen = 20;
    let move = Math.min((val / maxLen) * 10 - 5, 5); // move from -5 to +5
    pupilL.style.transform = `translateX(${move}px)`;
    pupilR.style.transform = `translateX(${move}px)`;
  });

  // Eyes closed for password
  passInp.addEventListener('focus', () => { 
    if (passInp.getAttribute('type') === 'password') {
      mascot.classList.add('eyes-closed'); 
      pupilL.style.transform = `translateX(0px)`;
      pupilR.style.transform = `translateX(0px)`;
    }
  });
  
  passInp.addEventListener('blur', () => { mascot.classList.remove('eyes-closed'); });
  userInp.addEventListener('blur', () => { 
    pupilL.style.transform = `translateX(0px)`;
    pupilR.style.transform = `translateX(0px)`;
  });

  // Password visibility toggle
  const togglePassword = document.getElementById('togglePassword');
  togglePassword.addEventListener('click', function () {
    const type = passInp.getAttribute('type') === 'password' ? 'text' : 'password';
    passInp.setAttribute('type', type);
    this.classList.toggle('fa-eye');
    this.classList.toggle('fa-eye-slash');
    if (type === 'text') {
      this.setAttribute('title', 'Hide Password');
      mascot.classList.remove('eyes-closed');
    } else {
      this.setAttribute('title', 'Show Password');
      if (document.activeElement === passInp) {
        mascot.classList.add('eyes-closed');
      }
    }
  });

  // Reset Access Logic
  function resetAdminAccess() {
    const btn = document.getElementById('resetBtn');
    const msg = document.getElementById('resetMsg');
    
    if(!confirm("Are you sure you want to reset admin credentials? This will wipe the old admin and restore it from your environment variables.")) {
      return;
    }

    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Resetting...';
    btn.style.pointerEvents = 'none';

    fetch('${pageContext.request.contextPath}/admin/reset-access', {
      method: 'POST'
    })
    .then(async (response) => {
      const text = await response.text();
      msg.style.display = 'block';
      if (response.ok) {
        msg.className = 'alert-success-premium mb-3';
        msg.innerHTML = '<i class="fas fa-check-circle"></i> ' + text;
      } else {
        msg.className = 'alert-premium mb-3';
        msg.innerHTML = '<i class="fas fa-exclamation-circle" style="color:#ff4500;"></i> Failed to reset.';
      }
    })
    .catch(error => {
      msg.style.display = 'block';
      msg.className = 'alert-premium mb-3';
      msg.innerHTML = 'An error occurred while resetting.';
    })
    .finally(() => {
      btn.innerHTML = 'Reset Access?';
      btn.style.pointerEvents = 'auto';
    });
  }
</script>

<%@ include file="../common/footer.jsp"%>
