<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<nav class="navbar-premium navbar navbar-expand-lg">
  <div class="container">

    <!-- Brand -->
    <a class="navbar-brand-premium" href="${pageContext.request.contextPath}/">
      🍕 Foodie<span>Hub</span>
    </a>

    <!-- Desktop Nav Links (hidden on mobile) -->
    <div class="collapse navbar-collapse d-none d-lg-flex justify-content-end align-items-center gap-1" id="desktopNav">
      <ul class="navbar-nav align-items-center gap-1 mb-0">
        <li class="nav-item">
          <a class="nav-link-premium" href="${pageContext.request.contextPath}/">
            <i class="fas fa-home me-1"></i> Home
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link-premium" href="${pageContext.request.contextPath}/products">
            <i class="fas fa-utensils me-1"></i> Menu
          </a>
        </li>
        <c:if test="${not empty sessionScope.admin and empty sessionScope.user}">
          <li class="nav-item">
            <a class="nav-link-premium" href="${pageContext.request.contextPath}/dashboard" style="color:#ff4500;">
              <i class="fas fa-shield-alt me-1"></i> Dashboard
            </a>
          </li>
        </c:if>
        <c:if test="${empty sessionScope.admin or not empty sessionScope.user}">
          <li class="nav-item">
            <a class="nav-link-premium" href="${pageContext.request.contextPath}/cart">
              <span class="nav-cart-badge">
                <i class="fas fa-shopping-cart me-1"></i> Cart
                <span class="cart-count">0</span>
              </span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link-premium" href="${pageContext.request.contextPath}/orders">
              <i class="fas fa-box me-1"></i> My Orders
            </a>
          </li>
        </c:if>
        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <li class="nav-item ms-2 dropdown">
              <a class="nav-link-premium d-flex align-items-center gap-2" href="#" id="profileDropdown"
                 role="button" data-bs-toggle="dropdown" aria-expanded="false"
                 style="padding:4px 12px;border:1px solid rgba(255,255,255,0.1);border-radius:30px;">
                <c:choose>
                  <c:when test="${not empty sessionScope.user.profileImage}">
                    <img src="${pageContext.request.contextPath}/images/${sessionScope.user.profileImage}" alt="Profile"
                         style="width:28px;height:28px;border-radius:50%;object-fit:cover;">
                  </c:when>
                  <c:otherwise>
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ff4500&color=fff&size=100"
                         alt="Profile" style="width:28px;height:28px;border-radius:50%;">
                  </c:otherwise>
                </c:choose>
                <span style="font-size:0.85rem;font-weight:600;">${sessionScope.user.name}</span>
                <i class="fas fa-chevron-down ms-1" style="font-size:0.7rem;"></i>
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown"
                  style="background:rgba(18,18,26,0.95);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);border-radius:12px;padding:10px;min-width:180px;">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"
                       style="color:white;font-size:0.85rem;padding:8px 16px;border-radius:8px;">
                  <i class="fas fa-user-circle me-2" style="color:#ff4500;"></i> My Profile</a></li>
                <li><hr class="dropdown-divider" style="border-color:rgba(255,255,255,0.1);"></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"
                       style="color:white;font-size:0.85rem;padding:8px 16px;border-radius:8px;">
                  <i class="fas fa-sign-out-alt me-2" style="color:#dc3545;"></i> Logout</a></li>
              </ul>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item ms-2">
              <a class="btn-nav-login nav-link-premium" href="${pageContext.request.contextPath}/login">
                <i class="fas fa-sign-in-alt me-1"></i> Login
              </a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>

    <!-- Mobile Hamburger Button -->
    <button class="navbar-toggler d-lg-none" style="border-color:rgba(255,69,0,0.5);"
            type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileMenu" aria-controls="mobileMenu">
      <span style="color:#ff4500;"><i class="fas fa-bars"></i></span>
    </button>

  </div>
</nav>

<!-- Mobile Offcanvas Menu (separate from nav, only for mobile) -->
<div class="offcanvas offcanvas-start mobile-offcanvas" tabindex="-1" id="mobileMenu" aria-labelledby="mobileMenuLabel">
  <div class="offcanvas-header" style="border-bottom:1px solid rgba(255,255,255,0.1);padding:20px 24px;display:flex;justify-content:space-between;align-items:center;">
    <h5 id="mobileMenuLabel" style="font-weight:800;margin:0;font-size:1.4rem;">
      🍕 <span style="background:var(--gradient-main);-webkit-background-clip:text;-webkit-text-fill-color:transparent;text-shadow:0 2px 10px rgba(255,165,0,0.4);">Foodie</span><span style="color:white;">Hub</span>
    </h5>
    <button type="button" class="mobile-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);color:rgba(255,255,255,0.9);font-size:1.1rem;width:34px;height:34px;border-radius:50%;display:flex;align-items:center;justify-content:center;margin-left:auto;">
      <i class="fas fa-times"></i>
    </button>
  </div>
  <div class="offcanvas-body" style="padding:24px;overflow:hidden;">
    <ul class="list-unstyled mb-0" style="display:flex;flex-direction:column;gap:12px;">
      <li>
        <a href="${pageContext.request.contextPath}/" class="mobile-menu-link">
          <i class="fas fa-home"></i> Home
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/products" class="mobile-menu-link">
          <i class="fas fa-utensils"></i> Menu
        </a>
      </li>
      <c:if test="${not empty sessionScope.admin and empty sessionScope.user}">
        <li>
          <a href="${pageContext.request.contextPath}/dashboard" class="mobile-menu-link" style="color:#ff4500;">
            <i class="fas fa-shield-alt"></i> Dashboard
          </a>
        </li>
      </c:if>
      <c:if test="${empty sessionScope.admin or not empty sessionScope.user}">
        <li>
          <a href="${pageContext.request.contextPath}/cart" class="mobile-menu-link">
            <i class="fas fa-shopping-cart"></i> Cart
            <span class="cart-count" style="position:static !important; background:#ff4500;color:#fff;border-radius:50%;padding:2px 8px;font-size:0.75rem;margin-left:auto;">0</span>
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/orders" class="mobile-menu-link">
            <i class="fas fa-box"></i> My Orders
          </a>
        </li>
      </c:if>
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <li style="margin-top:8px;padding-top:12px;border-top:1px solid rgba(255,255,255,0.1);">
            <a href="${pageContext.request.contextPath}/profile" class="mobile-menu-link">
              <i class="fas fa-user-circle"></i> My Profile
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/logout" class="mobile-menu-link" style="color:#ff6b6b;">
              <i class="fas fa-sign-out-alt"></i> Logout
            </a>
          </li>
        </c:when>
        <c:otherwise>
          <li style="margin-top:8px;padding-top:12px;border-top:1px solid rgba(255,255,255,0.1);">
            <a href="${pageContext.request.contextPath}/login" class="mobile-menu-link" style="color:#ff4500;">
              <i class="fas fa-sign-in-alt"></i> Login
            </a>
          </li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</div>

<style>
.mobile-menu-link {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 13px 16px;
  color: rgba(255,255,255,0.9);
  text-decoration: none;
  font-size: 1rem;
  font-weight: 500;
  border-radius: 12px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.06);
  transition: all 0.2s ease;
}
.mobile-menu-link:hover {
  background: rgba(255,69,0,0.15);
  color: #ff6e30;
  border-color: rgba(255,69,0,0.3);
}
.mobile-menu-link i {
  width: 20px;
  text-align: center;
  color: #ff4500;
  font-size: 1rem;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
  fetch('${pageContext.request.contextPath}/api/cart/count')
    .then(response => response.text())
    .then(count => {
      const badges = document.querySelectorAll('.cart-count');
      badges.forEach(b => {
        b.textContent = count && parseInt(count) > 0 ? count : '0';
      });
    })
    .catch(err => console.error('Cart count error:', err));
});
</script>