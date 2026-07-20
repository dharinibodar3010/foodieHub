<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
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
      radial-gradient(ellipse at 30% 40%, rgba(255,69,0,0.15) 0%, transparent 60%),
      radial-gradient(ellipse at 70% 80%, rgba(255,69,0,0.12) 0%, transparent 50%);
  }

  /* Decorative abstract shapes */
  .shape-1 {
    position: absolute; top: 15%; left: 10%; width: 300px; height: 300px;
    background: linear-gradient(135deg, rgba(255,69,0,0.2), rgba(255,69,0,0.1));
    border-radius: 50%; filter: blur(60px); animation: float 6s ease-in-out infinite;
  }
  .shape-2 {
    position: absolute; bottom: 10%; right: 15%; width: 250px; height: 250px;
    background: linear-gradient(135deg, rgba(255,69,0,0.15), rgba(255,69,0,0.05));
    border-radius: 50%; filter: blur(50px); animation: float 8s ease-in-out infinite reverse;
  }

  .admin-login-card {
    background: rgba(30, 41, 59, 0.6);
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 32px;
    padding: 50px 44px;
    width: 100%;
    max-width: 460px;
    position: relative;
    z-index: 10;
    box-shadow: 0 30px 80px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.1);
  }

  .admin-login-card::before {
    content: '';
    position: absolute;
    top: 0; left: 15%; right: 15%;
    height: 2px;
    background: linear-gradient(to right, transparent, #ff4500, #ff6b6b, transparent);
    border-radius: 2px;
  }

  .admin-badge {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(255,69,0,0.1);
    border: 1px solid rgba(255,69,0,0.25);
    border-radius: 20px;
    padding: 6px 18px;
    font-size: 0.78rem;
    font-weight: 700;
    color: #ff4500;
    margin-bottom: 24px;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 0 15px rgba(255,69,0,0.2);
  }

  .security-dots {
    display: flex;
    gap: 8px;
    margin: 24px 0;
  }

  .security-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: rgba(255,255,255,0.2);
    animation: dotPulse 1.5s infinite;
  }

  .security-dot:nth-child(2) { animation-delay: 0.2s; background: rgba(255,69,0,0.5); }
  .security-dot:nth-child(3) { animation-delay: 0.4s; background: rgba(255,69,0,0.7); }

  @keyframes dotPulse {
    0%, 100% { transform: scale(1); opacity: 0.5; }
    50% { transform: scale(1.4); opacity: 1; box-shadow: 0 0 10px currentColor; }
  }

  .admin-input-group {
    margin-bottom: 24px;
  }

  .admin-input-icon {
    position:absolute;left:18px;top:50%;transform:translateY(-50%);
    color:rgba(255,69,0,0.7);font-size:1rem;z-index:2;
  }

  .admin-input-field {
    padding-left:50px !important;
    height: 54px !important;
    border-color: rgba(255,69,0,0.3) !important;
    border-radius: 16px !important;
    background: rgba(15,23,42,0.6) !important;
  }
  .admin-input-field:focus {
    border-color: #ff4500 !important;
    box-shadow: 0 0 0 4px rgba(255,69,0,0.15) !important;
    background: rgba(255,69,0,0.03) !important;
  }
</style>

<div class="admin-login-page">
  <div class="admin-login-bg"></div>
  <div class="shape-1"></div>
  <div class="shape-2"></div>

  <div class="container" style="position:relative;z-index:1;">
    <div class="row justify-content-center">
      <div class="col-auto">

        <div class="admin-login-card animate__animated animate__zoomIn" style="animation-duration: 0.6s;">

          <!-- Header -->
          <div style="text-align:center;margin-bottom:32px;">
            <div class="admin-badge">
              <i class="fas fa-fingerprint"></i> System Access
            </div>
            
            <h2 style="font-weight:900;font-size:2rem;margin-bottom:8px;letter-spacing:-0.5px;">Admin <span style="background:linear-gradient(135deg,#ff4500,#ff6b6b);-webkit-background-clip:text;-webkit-text-fill-color:transparent;">Portal</span></h2>
            <p style="color:rgba(255,255,255,0.5);font-size:0.9rem;">Authenticate to access FoodieHub</p>
            
            <div class="security-dots justify-content-center" style="justify-content:center;">
              <div class="security-dot"></div>
              <div class="security-dot"></div>
              <div class="security-dot"></div>
            </div>
          </div>

          <!-- Error Alert -->
          <c:if test="${not empty error}">
            <div class="animate__animated animate__shakeX" style="background:rgba(220,53,69,0.1);border:1px solid rgba(220,53,69,0.3);border-radius:14px;padding:16px 20px;margin-bottom:24px;color:#ff6b6b;font-size:0.9rem;display:flex;align-items:center;gap:12px; font-weight: 500;">
              <div style="width:30px;height:30px;border-radius:50%;background:rgba(220,53,69,0.2);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <i class="fas fa-exclamation"></i>
              </div>
              ${error}
            </div>
          </c:if>

          <!-- Login Form -->
          <form action="${pageContext.request.contextPath}/adminLogin" method="post">

            <div class="admin-input-group">
              <label class="form-label-premium">Username</label>
              <div style="position:relative;">
                <i class="fas fa-user-shield admin-input-icon"></i>
                <input type="text" name="username" class="form-premium w-100 admin-input-field" placeholder="admin@foodiehub.com" required>
              </div>
            </div>

            <div class="admin-input-group">
              <label class="form-label-premium">Password</label>
              <div style="position:relative;">
                <i class="fas fa-lock admin-input-icon"></i>
                <input type="password" name="password" id="adminPass" class="form-premium w-100 admin-input-field" placeholder="••••••••••" required>
                <button type="button" onclick="toggleAdminPass()" style="position:absolute;right:16px;top:50%;transform:translateY(-50%);background:none;border:none;color:rgba(255,255,255,0.3);cursor:pointer;font-size:1rem;z-index:2;transition:color 0.3s;padding:5px;">
                  <i class="fas fa-eye" id="adminPassIcon"></i>
                </button>
              </div>
            </div>

            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;">
              <label style="display:flex;align-items:center;gap:10px;cursor:pointer;color:rgba(255,255,255,0.6);font-size:0.85rem;user-select:none;">
                <div style="width:18px;height:18px;border-radius:4px;border:1px solid #ff4500;display:flex;align-items:center;justify-content:center;background:rgba(255,69,0,0.1);">
                  <i class="fas fa-check" style="font-size:0.6rem;color:#ff4500;opacity:1;"></i>
                </div>
                Remember me
              </label>
              <a href="#" style="color:#ff4500;text-decoration:none;font-size:0.85rem;font-weight:600;transition:color 0.3s;" onmouseover="this.style.color='#ff6b6b'" onmouseout="this.style.color='#ff4500'">Reset Access?</a>
            </div>

            <button type="submit" style="width:100%;height:56px;background:linear-gradient(135deg,#ff4500,#ff6b6b);border:none;border-radius:16px;color:white;font-weight:700;font-size:1.05rem;cursor:pointer;transition:all 0.4s cubic-bezier(0.4, 0, 0.2, 1);font-family:'Poppins',sans-serif;display:flex;align-items:center;justify-content:center;gap:12px;box-shadow:0 10px 30px rgba(255,69,0,0.4), inset 0 2px 0 rgba(255,255,255,0.2);" onmouseover="this.style.transform='translateY(-4px)';this.style.boxShadow='0 15px 35px rgba(255,69,0,0.6), inset 0 2px 0 rgba(255,255,255,0.2)'" onmouseout="this.style.transform='';this.style.boxShadow='0 10px 30px rgba(255,69,0,0.4), inset 0 2px 0 rgba(255,255,255,0.2)'">
              <span>Initialize Session</span>
              <i class="fas fa-arrow-right"></i>
            </button>

          </form>

          <!-- Security Note -->
          <div style="margin-top:32px;padding:16px 20px;background:rgba(255,69,0,0.05);border:1px solid rgba(255,69,0,0.15);border-radius:16px;display:flex;gap:14px;">
            <i class="fas fa-shield-check" style="color:#ff4500;font-size:1.2rem;margin-top:2px;"></i>
            <div>
              <div style="color:#e2e8f0;font-size:0.85rem;font-weight:600;margin-bottom:4px;">256-bit Secure Connection</div>
              <p style="margin:0;color:rgba(255,255,255,0.4);font-size:0.75rem;line-height:1.5;">
                Your IP address and access timestamp will be logged for security purposes.
              </p>
            </div>
          </div>

          <div style="text-align:center;margin-top:28px;">
            <a href="${pageContext.request.contextPath}/" style="color:rgba(255,255,255,0.4);text-decoration:none;font-size:0.85rem;font-weight:500;transition:color 0.3s;" onmouseover="this.style.color='#ff4500'" onmouseout="this.style.color='rgba(255,255,255,0.4)'">
              <i class="fas fa-arrow-left me-2"></i> Return to Website
            </a>
          </div>

        </div>

      </div>
    </div>
  </div>
</div>

<script>
function toggleAdminPass() {
  const field = document.getElementById('adminPass');
  const icon = document.getElementById('adminPassIcon');
  if (field.type === 'password') {
    field.type = 'text';
    icon.className = 'fas fa-eye-slash';
    icon.closest('button').style.color = '#818cf8';
  } else {
    field.type = 'password';
    icon.className = 'fas fa-eye';
    icon.closest('button').style.color = 'rgba(255,255,255,0.35)';
  }
}
</script>

<%@ include file="../common/footer.jsp"%>
