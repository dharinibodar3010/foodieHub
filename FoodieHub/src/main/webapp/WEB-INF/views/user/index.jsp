<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  /* ===== HERO SECTION ===== */
  .hero-section {
    min-height: 100vh;
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
    padding: 40px 0;
  }

  .hero-bg {
    position: absolute;
    inset: 0;
    background:
      radial-gradient(ellipse at 60% 40%, rgba(255,69,0,0.15) 0%, transparent 60%),
      radial-gradient(ellipse at 10% 70%, rgba(255,140,0,0.08) 0%, transparent 50%);
  }

  .hero-circles {
    position: absolute;
    inset: 0;
    overflow: hidden;
    pointer-events: none;
  }

  .hero-circle {
    position: absolute;
    border-radius: 50%;
    border: 1px solid rgba(255,69,0,0.1);
    animation: rotateCircle 20s linear infinite;
  }

  @keyframes rotateCircle {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
  }

  .hero-circle-1 { width: 500px; height: 500px; top: -100px; right: -100px; }
  .hero-circle-2 { width: 350px; height: 350px; top: 50px; right: 50px; animation-duration: 15s; animation-direction: reverse; }

  .hero-title {
    font-size: clamp(2.8rem, 6vw, 5rem);
    font-weight: 900;
    line-height: 1.1;
    margin-bottom: 24px;
  }

  .hero-title .line2 {
    background: linear-gradient(135deg, #ff4500, #ff8c00, #ffd700);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: block;
  }

  .hero-desc {
    color: rgba(255,255,255,1.0);
    font-size: 1.1rem;
    line-height: 1.8;
    max-width: 500px;
    margin-bottom: 36px;
  }

  .hero-stats {
    display: flex;
    gap: 32px;
    margin-top: 40px;
    flex-wrap: wrap;
  }

  .hero-stat-item { text-align: center; }
  .hero-stat-num {
    font-size: 1.8rem;
    font-weight: 800;
    background: linear-gradient(135deg, #ff4500, #ffd700);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .hero-stat-label { font-size: 0.8rem; color: rgba(255,255,255,1.0); font-weight: 500; }

  .hero-food-card {
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 24px;
    padding: 12px;
    backdrop-filter: blur(20px);
    position: relative;
  }

  .hero-food-img {
    width: 100%;
    height: 380px;
    object-fit: contain;
    background: rgba(0,0,0,0.3);
    border-radius: 18px;
    transition: transform 0.5s ease;
  }

  .hero-floating-badge {
    position: absolute;
    background: rgba(10,10,15,0.95);
    border: 1px solid rgba(255,69,0,0.3);
    border-radius: 16px;
    padding: 12px 16px;
    backdrop-filter: blur(20px);
    display: flex;
    align-items: center;
    gap: 10px;
    animation: float 3s ease-in-out infinite;
  }

  .hero-floating-badge.badge-1 { top: 30px; left: -20px; }
  .hero-floating-badge.badge-2 { bottom: 60px; right: -20px; animation-delay: 1.5s; }

  /* ===== FEATURES SECTION ===== */
  .features-section { padding: 40px 0; }

  .feature-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 20px;
    padding: 32px 24px;
    transition: all 0.4s ease;
    height: 100%;
  }

  .feature-card:hover {
    background: rgba(255,69,0,0.06);
    border-color: rgba(255,69,0,0.25);
    transform: translateY(-8px);
  }

  .feature-icon {
    width: 64px;
    height: 64px;
    border-radius: 18px;
    background: rgba(255,69,0,0.12);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.8rem;
    margin-bottom: 20px;
    transition: all 0.3s ease;
  }

  .feature-card:hover .feature-icon {
    background: rgba(255,69,0,0.2);
    transform: scale(1.1);
  }

  /* ===== FOOD CATEGORIES ===== */
  .categories-section { padding: 40px 0; }

  .category-pill {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 50px;
    padding: 10px 24px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 500;
    font-size: 0.9rem;
    color: rgba(255,255,255,1.0);
    text-decoration: none;
  }

  .category-pill:hover,
  .category-pill.active {
    background: rgba(255,69,0,0.15);
    border-color: rgba(255,69,0,0.4);
    color: white;
  }

  /* ===== PROMO BANNER ===== */
  .promo-banner {
    background: linear-gradient(135deg, rgba(255,69,0,0.2) 0%, rgba(255,140,0,0.15) 50%, rgba(10,10,15,0) 100%);
    border: 1px solid rgba(255,69,0,0.25);
    border-radius: 24px;
    padding: 40px 30px;
    margin: 30px 0 10px 0;
    position: relative;
    overflow: hidden;
  }

  .promo-banner::after {
    content: '🍔';
    position: absolute;
    right: 40px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 8rem;
    opacity: 0.12;
  }
</style>

<!-- ===== HERO SECTION ===== -->
<section class="hero-section">
  <div class="hero-bg"></div>
  <div class="hero-circles">
    <div class="hero-circle hero-circle-1"></div>
    <div class="hero-circle hero-circle-2"></div>
  </div>

  <div class="container" style="position:relative; z-index:1;">
    <div class="row align-items-center g-5">

      <div class="col-lg-6 animate__animated animate__fadeInLeft">
        <div class="badge-premium d-inline-flex align-items-center gap-2 mb-4" style="background:rgba(255,69,0,0.12);border:1px solid rgba(255,69,0,0.3);border-radius:30px;padding:8px 18px;font-size:0.8rem;font-weight:600;color:#ff8c00;">
          <i class="fas fa-fire"></i> #1 Food Delivery App in Gujarat
        </div>

        <h1 class="hero-title">
          Hungry? We
          <span class="line2">Deliver Magic</span>
          to Your Door!
        </h1>

        <p class="hero-desc">
          Order your favourite meals from the best restaurants near you. Fresh, fast, and always delicious — FoodieHub delivers happiness in every bite.
        </p>

        <div class="d-flex gap-3 flex-wrap">
          <a href="${pageContext.request.contextPath}/products" class="btn-primary-premium" style="font-size:1rem; padding:14px 36px;">
            <i class="fas fa-utensils"></i> Order Now
          </a>
          <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium" style="font-size:1rem; padding:13px 30px;">
            <i class="fas fa-play-circle"></i> Explore Menu
          </a>
        </div>

        <div class="hero-stats">
          <div class="hero-stat-item">
            <div class="hero-stat-num">500+</div>
            <div class="hero-stat-label">Dishes</div>
          </div>
          <div class="hero-stat-item">
            <div class="hero-stat-num">10K+</div>
            <div class="hero-stat-label">Happy Customers</div>
          </div>
          <div class="hero-stat-item">
            <div class="hero-stat-num">4.9⭐</div>
            <div class="hero-stat-label">Rating</div>
          </div>
          <div class="hero-stat-item">
            <div class="hero-stat-num">30min</div>
            <div class="hero-stat-label">Avg. Delivery</div>
          </div>
        </div>
      </div>

      <div class="col-lg-6 d-none d-lg-block animate__animated animate__fadeInRight">
        <div class="hero-food-card" style="position:relative;">
          <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=80" alt="Delicious Food" class="hero-food-img">

          <div class="hero-floating-badge badge-1">
            <div style="width:36px;height:36px;background:linear-gradient(135deg,#ff4500,#ff8c00);border-radius:10px;display:flex;align-items:center;justify-content:center;">
              🚀
            </div>
            <div>
              <div style="font-weight:700;font-size:0.85rem;color:white;">Fast Delivery</div>
              <div style="font-size:0.72rem;color:rgba(255,255,255,1.0);">Avg. 30 minutes</div>
            </div>
          </div>

          <div class="hero-floating-badge badge-2">
            <div style="width:36px;height:36px;background:linear-gradient(135deg,#28a745,#20c997);border-radius:10px;display:flex;align-items:center;justify-content:center;">
              ✅
            </div>
            <div>
              <div style="font-weight:700;font-size:0.85rem;color:white;">Fresh & Healthy</div>
              <div style="font-size:0.72rem;color:rgba(255,255,255,1.0);">100% Natural</div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- ===== FEATURES SECTION ===== -->
<section id="features" class="features-section">
  <div class="container">
    <div class="text-center mb-60" style="margin-bottom:30px;">
      <h2 class="section-title">Why Choose <span>FoodieHub?</span></h2>
      <p class="section-subtitle mt-3">We make every meal experience special</p>
    </div>

    <div class="row g-4">
      <div class="col-lg-3 col-md-6">
        <div class="feature-card text-center">
          <div class="feature-icon mx-auto">⚡</div>
          <h5 style="font-weight:700; margin-bottom:12px;">Lightning Fast</h5>
          <p style="color:rgba(255,255,255,1.0); font-size:0.88rem; line-height:1.7;">
            Delivery in under 30 minutes. We value your time as much as we value great food.
          </p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="feature-card text-center">
          <div class="feature-icon mx-auto">🌿</div>
          <h5 style="font-weight:700; margin-bottom:12px;">Fresh Ingredients</h5>
          <p style="color:rgba(255,255,255,1.0); font-size:0.88rem; line-height:1.7;">
            Only the freshest ingredients from trusted local suppliers. Quality guaranteed.
          </p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="feature-card text-center">
          <div class="feature-icon mx-auto">🔒</div>
          <h5 style="font-weight:700; margin-bottom:12px;">Secure Payments</h5>
          <p style="color:rgba(255,255,255,1.0); font-size:0.88rem; line-height:1.7;">
            Pay safely with Razorpay, UPI, Cards or Cash on Delivery. 100% secure.
          </p>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <div class="feature-card text-center">
          <div class="feature-icon mx-auto">🎯</div>
          <h5 style="font-weight:700; margin-bottom:12px;">Live Tracking</h5>
          <p style="color:rgba(255,255,255,1.0); font-size:0.88rem; line-height:1.7;">
            Track your order in real time from kitchen to your doorstep.
          </p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ===== CATEGORIES SECTION ===== -->
<section class="categories-section">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center mb-5 flex-wrap gap-3">
      <h2 class="section-title">Browse by <span>Category</span></h2>
      <a href="${pageContext.request.contextPath}/products" class="btn-outline-premium">
        View All <i class="fas fa-arrow-right ms-1"></i>
      </a>
    </div>

    <div class="d-flex gap-3 flex-wrap mb-5">
      <c:choose>
        <c:when test="${not empty categories}">
          <c:forEach var="c" items="${categories}">
            <a href="${pageContext.request.contextPath}/products?category=${c.name}" class="category-pill">
              <c:choose>
                <c:when test="${c.name.toLowerCase().contains('pizza')}">&#127829;</c:when>
                <c:when test="${c.name.toLowerCase().contains('burger')}">&#127828;</c:when>
                <c:when test="${c.name.toLowerCase().contains('biryani')}">&#127835;</c:when>
                <c:when test="${c.name.toLowerCase().contains('salad')}">&#129367;</c:when>
                <c:when test="${c.name.toLowerCase().contains('dessert')}">&#127846;</c:when>
                <c:when test="${c.name.toLowerCase().contains('drink')}">&#129380;</c:when>
                <c:when test="${c.name.toLowerCase().contains('wrap')}">&#127790;</c:when>
                <c:when test="${c.name.toLowerCase().contains('sandwich')}">&#129386;</c:when>
                <c:otherwise>&#127869;</c:otherwise>
              </c:choose>
              ${c.name}
            </a>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/products" class="category-pill">View All</a>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- Popular Items Grid -->
    <div class="row g-4">
      <c:choose>
        <c:when test="${not empty featuredProducts}">
          <c:forEach var="p" items="${featuredProducts}">
            <div class="col-lg-4 col-md-6">
              <div class="card-premium">
                <div class="product-img-wrapper">
                  <img src="${p.image.startsWith('http') ? p.image : pageContext.request.contextPath.concat('/images/').concat(p.image)}" alt="${p.name}" class="product-card-img">
                  <div class="img-overlay"></div>
                </div>
                <div style="padding:20px;">
                  <h6 style="font-weight:700; margin-bottom:8px;">${p.name}</h6>
                  <p style="color:rgba(255,255,255,1.0);font-size:0.82rem;margin-bottom:14px;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;">${p.description}</p>
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="price-tag">₹${p.price}</span>
                    <form action="${pageContext.request.contextPath}/addToCart" method="post" style="margin:0;">
                      <input type="hidden" name="productId" value="${p.id}">
                      <input type="hidden" name="quantity" value="1">
                      <button type="submit" class="btn-primary-premium" style="padding:8px 20px; font-size:0.82rem; border:none; border-radius:12px; cursor:pointer;">
                        <i class="fas fa-plus"></i> Add
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="col-12 text-center text-white-50">No products available.</div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</section>

<!-- ===== PROMO BANNER ===== -->
<section style="padding:0 0 10px;">
  <div class="container">
    <div class="promo-banner">
      <div class="row align-items-center">
        <div class="col-lg-8">
          <span style="background:rgba(255,69,0,0.2);border:1px solid rgba(255,69,0,0.4);border-radius:20px;padding:5px 16px;font-size:0.8rem;font-weight:600;color:#ff8c00;display:inline-block;margin-bottom:16px;">
            🎉 Special Offer — Limited Time
          </span>
          <h2 style="font-size:2.2rem;font-weight:800;margin-bottom:12px;">
            Get <span class="text-gradient">50% OFF</span> on Your First Order!
          </h2>
          <p style="color:rgba(255,255,255,1.0);font-size:1rem;margin-bottom:24px;">
            Use code <strong style="color:#ffd700;background:rgba(255,215,0,0.1);padding:2px 10px;border-radius:6px;">FOODIE50</strong> at checkout. Valid for new users only.
          </p>
          <a href="${pageContext.request.contextPath}/products" class="btn-primary-premium">
            <i class="fas fa-tag"></i> Claim Offer
          </a>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="../common/footer.jsp"%>
