<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar-premium navbar navbar-expand-lg">
  <div class="container">

    <a class="navbar-brand-premium" href="${pageContext.request.contextPath}/">
      🍕 Foodie<span>Hub</span>
    </a>

    <button class="navbar-toggler" style="border-color:rgba(255,69,0,0.5)" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span style="color:#ff4500"><i class="fas fa-bars"></i></span>
    </button>

    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-auto align-items-center gap-1">

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

        <c:choose>
          <c:when test="${not empty sessionScope.user}">
            <li class="nav-item ms-2 dropdown">
              <a class="nav-link-premium d-flex align-items-center gap-2" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="padding: 4px 12px; border: 1px solid rgba(255,255,255,0.1); border-radius: 30px;">
                <c:choose>
                  <c:when test="${not empty sessionScope.user.profileImage}">
                    <img src="${pageContext.request.contextPath}/images/${sessionScope.user.profileImage}" alt="Profile" style="width: 28px; height: 28px; border-radius: 50%; object-fit: cover;">
                  </c:when>
                  <c:otherwise>
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.user.name}&background=ff4500&color=fff&size=100" alt="Profile" style="width: 28px; height: 28px; border-radius: 50%;">
                  </c:otherwise>
                </c:choose>
                <span style="font-size: 0.85rem; font-weight: 600;">${sessionScope.user.name}</span>
                <i class="fas fa-chevron-down ms-1" style="font-size: 0.7rem;"></i>
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown" style="background: rgba(18,18,26,0.95); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; padding: 10px; min-width: 180px;">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile" style="color: white; font-size: 0.85rem; padding: 8px 16px; border-radius: 8px; transition: all 0.3s;"><i class="fas fa-user-circle me-2" style="color: #ff4500;"></i> My Profile</a></li>
                <li><hr class="dropdown-divider" style="border-color: rgba(255,255,255,0.1);"></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout" style="color: white; font-size: 0.85rem; padding: 8px 16px; border-radius: 8px; transition: all 0.3s;"><i class="fas fa-sign-out-alt me-2" style="color: #dc3545;"></i> Logout</a></li>
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
  </div>
</nav>

<script>
document.addEventListener('DOMContentLoaded', function() {
  fetch('${pageContext.request.contextPath}/api/cart/count')
    .then(response => response.text())
    .then(count => {
      const badges = document.querySelectorAll('.cart-count');
      badges.forEach(b => {
        if(parseInt(count) > 0) {
          b.textContent = count;
          b.style.display = 'inline-flex';
        } else {
          b.textContent = '0';
        }
      });
    })
    .catch(err => console.error('Cart count error:', err));
});
</script>