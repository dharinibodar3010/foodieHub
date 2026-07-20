<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .product-details-page { padding: 60px 0 100px; }
  
  .details-card {
    background: rgba(255,255,255,0.02);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 28px;
    padding: 36px;
  }
  
  .main-img-wrapper {
    width: 100%;
    height: 450px;
    border-radius: 20px;
    overflow: hidden;
    position: relative;
    box-shadow: 0 20px 50px rgba(0,0,0,0.3);
    border: 1px solid rgba(255,255,255,0.08);
  }
  
  .main-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s ease;
  }
  
  .main-img-wrapper:hover .main-img {
    transform: scale(1.08);
  }
  
  .category-pill {
    display: inline-block;
    background: rgba(255,69,0,0.15);
    border: 1px solid rgba(255,69,0,0.3);
    color: #ff4500;
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.82rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin-bottom: 20px;
  }
  
  .product-title {
    font-size: 2.6rem;
    font-weight: 900;
    margin-bottom: 12px;
    line-height: 1.2;
  }
  
  .product-desc {
    color: rgba(255,255,255,0.5);
    font-size: 1.05rem;
    line-height: 1.8;
    margin-bottom: 24px;
  }
  
  .price-large {
    font-size: 2.4rem;
    font-weight: 900;
    background: linear-gradient(135deg, #ff4500, #ffd700);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 32px;
  }
  
  .qty-selector {
    display: flex;
    align-items: center;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 14px;
    width: max-content;
    padding: 4px;
    margin-bottom: 32px;
  }
  
  .qty-btn {
    width: 44px;
    height: 44px;
    border: none;
    background: transparent;
    color: rgba(255,255,255,0.6);
    font-size: 1.2rem;
    cursor: pointer;
    border-radius: 10px;
    transition: all 0.3s;
  }
  
  .qty-btn:hover {
    background: rgba(255,69,0,0.15);
    color: #ff4500;
  }
  
  .qty-input {
    width: 60px;
    text-align: center;
    background: transparent;
    border: none;
    color: white;
    font-size: 1.1rem;
    font-weight: 700;
    outline: none;
  }
  
  .features-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin-top: 40px;
    padding-top: 32px;
    border-top: 1px solid rgba(255,255,255,0.08);
  }
  
  .feature-item {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  
  .f-icon {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    background: rgba(255,255,255,0.05);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
  }
  
  .f-text {
    font-size: 0.85rem;
    color: rgba(255,255,255,0.6);
    font-weight: 500;
  }
</style>

<div class="product-details-page">
  <div class="container">
    
    <!-- Breadcrumb -->
    <nav style="display:flex;gap:8px;align-items:center;font-size:0.85rem;color:rgba(255,255,255,0.4);margin-bottom:32px;">
      <a href="${pageContext.request.contextPath}/" style="color:#ff4500;text-decoration:none;">Home</a>
      <i class="fas fa-chevron-right" style="font-size:0.7rem;"></i>
      <a href="${pageContext.request.contextPath}/products" style="color:#ff4500;text-decoration:none;">Menu</a>
      <i class="fas fa-chevron-right" style="font-size:0.7rem;"></i>
      <span>Details</span>
    </nav>
    
    <div class="details-card">
      <div class="row g-5 align-items-center">
        
        <!-- Image Left -->
        <div class="col-lg-5">
          <div class="main-img-wrapper animate__animated animate__fadeInLeft">
            <img src="${pageContext.request.contextPath}/images/${product.image}"
                 onerror="this.src='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&q=80'"
                 alt="${product.name}" class="main-img">
            
            <c:if test="${product.available}">
              <div style="position:absolute;top:20px;left:20px;background:rgba(40,167,69,0.9);backdrop-filter:blur(5px);color:white;padding:6px 16px;border-radius:20px;font-size:0.8rem;font-weight:700;">
                ✅ In Stock
              </div>
            </c:if>
            <c:if test="${not product.available}">
              <div style="position:absolute;top:20px;left:20px;background:rgba(220,53,69,0.9);backdrop-filter:blur(5px);color:white;padding:6px 16px;border-radius:20px;font-size:0.8rem;font-weight:700;">
                ❌ Out of Stock
              </div>
            </c:if>
          </div>
        </div>
        
        <!-- Details Right -->
        <div class="col-lg-7 animate__animated animate__fadeInRight">
          
          <div class="category-pill">
            <c:choose>
              <c:when test="${product.category != null}">${product.category.name}</c:when>
              <c:otherwise>Special Menu</c:otherwise>
            </c:choose>
          </div>
          
          <h1 class="product-title">${product.name}</h1>
          
          <div style="display:flex;align-items:center;gap:12px;margin-bottom:24px;">
            <div style="display:flex;color:#ffd700;font-size:1rem;">
              <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
            </div>
            <span style="color:rgba(255,255,255,0.4);font-size:0.9rem;">(128 Reviews)</span>
          </div>
          
          <p class="product-desc">${product.description}</p>
          
          <div class="price-large">₹${product.price}</div>
          
          <form action="${pageContext.request.contextPath}/cart" method="get">
            <!-- Simulated Form -->
            <input type="hidden" name="productId" value="${product.id}">
            
            <div class="qty-selector">
              <button type="button" class="qty-btn" onclick="updateQ(-1)">−</button>
              <input type="number" id="qtyInput" name="quantity" class="qty-input" value="1" min="1" max="20" readonly>
              <button type="button" class="qty-btn" onclick="updateQ(1)">+</button>
            </div>
            
            <div style="display:flex;gap:16px;flex-wrap:wrap;">
              <c:if test="${product.available}">
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/cart'" class="btn-primary-premium" style="padding:16px 40px;font-size:1.05rem;">
                  <i class="fas fa-shopping-cart"></i> Add to Cart
                </button>
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/checkout'" class="btn-outline-premium" style="padding:16px 40px;font-size:1.05rem;background:rgba(255,255,255,0.05);">
                  <i class="fas fa-bolt text-warning"></i> Buy Now
                </button>
              </c:if>
              
              <c:if test="${not product.available}">
                <button type="button" disabled class="btn-primary-premium" style="background:rgba(255,255,255,0.1);color:rgba(255,255,255,0.4);box-shadow:none;cursor:not-allowed;padding:16px 40px;font-size:1.05rem;">
                  Currently Unavailable
                </button>
              </c:if>
            </div>
          </form>
          
          <!-- Features -->
          <div class="features-grid">
            <div class="feature-item">
              <div class="f-icon text-success"><i class="fas fa-leaf"></i></div>
              <div class="f-text">100% Fresh<br>Ingredients</div>
            </div>
            <div class="feature-item">
              <div class="f-icon text-danger"><i class="fas fa-fire"></i></div>
              <div class="f-text">Hot & Fresh<br>Delivery</div>
            </div>
            <div class="feature-item">
              <div class="f-icon text-warning"><i class="fas fa-clock"></i></div>
              <div class="f-text">30 Mins<br>Fast Delivery</div>
            </div>
            <div class="feature-item">
              <div class="f-icon text-info"><i class="fas fa-shield-alt"></i></div>
              <div class="f-text">Safe & Secure<br>Packaging</div>
            </div>
          </div>
          
        </div>
      </div>
    </div>
    
  </div>
</div>

<script>
function updateQ(delta) {
  const input = document.getElementById('qtyInput');
  let val = parseInt(input.value) + delta;
  if(val < 1) val = 1;
  if(val > 20) val = 20;
  input.value = val;
}
</script>

<%@ include file="../common/footer.jsp"%>
