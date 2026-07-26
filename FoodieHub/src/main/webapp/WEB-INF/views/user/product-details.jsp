<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .product-details-page { padding: 40px 0 40px; }
  
  .details-card {
    background: rgba(18,18,26,0.7);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 28px;
    padding: 36px;
    backdrop-filter: blur(25px);
    -webkit-backdrop-filter: blur(25px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    position: relative;
    overflow: hidden;
  }
  .details-card::before {
    content: ''; position: absolute; top: -50px; right: -50px; width: 200px; height: 200px;
    background: rgba(255,94,0,0.15); border-radius: 50%; filter: blur(40px); pointer-events: none; z-index: 0;
  }
  .details-card > * { position: relative; z-index: 2; }
  
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
    
    <!-- Write Review Button -->
    <div style="text-align:center;margin-top:40px;margin-bottom:40px;">
      <button onclick="openReviewModal()" class="btn-primary-premium" style="padding:14px 36px;font-size:1rem;">
        <i class="fas fa-star me-2"></i>Write a Review
      </button>
    </div>

  </div>
</div>

<!-- ===== REVIEW MODAL POPUP ===== -->
<div id="reviewModal" style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.75);backdrop-filter:blur(10px);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:rgba(18,18,26,0.98);border:1px solid rgba(255,255,255,0.1);border-radius:28px;padding:40px;max-width:460px;width:90%;position:relative;box-shadow:0 25px 70px rgba(0,0,0,0.7);overflow:hidden;">
    <div style="position:absolute;top:-40px;right:-40px;width:180px;height:180px;background:rgba(255,94,0,0.15);border-radius:50%;filter:blur(50px);pointer-events:none;"></div>
    <div style="position:absolute;bottom:-40px;left:-40px;width:120px;height:120px;background:rgba(99,102,241,0.1);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>

    <!-- Close Button -->
    <button onclick="closeReviewModal()" style="position:absolute;top:16px;right:20px;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.1);border-radius:50%;width:36px;height:36px;color:rgba(255,255,255,0.6);font-size:1rem;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all 0.3s;" onmouseover="this.style.background='rgba(220,53,69,0.2)'" onmouseout="this.style.background='rgba(255,255,255,0.06)'">✕</button>

    <div style="text-align:center;margin-bottom:28px;position:relative;z-index:2;">
      <div style="font-size:2.5rem;margin-bottom:8px;">⭐</div>
      <h3 style="font-weight:800;font-size:1.4rem;margin:0;background:linear-gradient(135deg,#ff4500,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Rate Your Experience</h3>
      <p style="color:rgba(255,255,255,0.4);font-size:0.85rem;margin-top:6px;">${product.name}</p>
    </div>

    <!-- Star Rating Row -->
    <div style="display:flex;justify-content:center;gap:8px;margin-bottom:12px;position:relative;z-index:2;" id="starRow">
      <span data-val="1" onclick="setRating(1)" onmouseover="hoverRating(1)" onmouseout="resetHover()" style="font-size:2.5rem;cursor:pointer;transition:transform 0.15s;filter:grayscale(0.6);">⭐</span>
      <span data-val="2" onclick="setRating(2)" onmouseover="hoverRating(2)" onmouseout="resetHover()" style="font-size:2.5rem;cursor:pointer;transition:transform 0.15s;filter:grayscale(0.6);">⭐</span>
      <span data-val="3" onclick="setRating(3)" onmouseover="hoverRating(3)" onmouseout="resetHover()" style="font-size:2.5rem;cursor:pointer;transition:transform 0.15s;filter:grayscale(0.6);">⭐</span>
      <span data-val="4" onclick="setRating(4)" onmouseover="hoverRating(4)" onmouseout="resetHover()" style="font-size:2.5rem;cursor:pointer;transition:transform 0.15s;filter:grayscale(0.6);">⭐</span>
      <span data-val="5" onclick="setRating(5)" onmouseover="hoverRating(5)" onmouseout="resetHover()" style="font-size:2.5rem;cursor:pointer;transition:transform 0.15s;filter:grayscale(0.6);">⭐</span>
    </div>
    <div id="ratingLabel" style="text-align:center;font-size:0.88rem;color:rgba(255,255,255,0.35);margin-bottom:20px;position:relative;z-index:2;">Click a star to rate</div>

    <!-- Review Form -->
    <form action="${pageContext.request.contextPath}/addReview" method="post" style="position:relative;z-index:2;">
      <input type="hidden" name="productId" value="${product.id}">
      <input type="hidden" name="rating" id="ratingInput" value="0">
      <textarea name="comment" id="reviewComment" placeholder="Share your experience with this dish... (optional)" rows="4"
        style="width:100%;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:14px;padding:14px 16px;color:white;font-size:0.9rem;resize:none;outline:none;font-family:inherit;transition:border-color 0.3s;box-sizing:border-box;"
        onfocus="this.style.borderColor='rgba(255,69,0,0.5)'" onblur="this.style.borderColor='rgba(255,255,255,0.08)'"></textarea>
      <button type="submit" onclick="return validateReview()" class="btn-primary-premium w-100 justify-content-center" style="margin-top:16px;padding:14px;font-size:1rem;">
        <i class="fas fa-paper-plane me-2"></i>Submit Review
      </button>
    </form>
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

let selectedRating = 0;
const ratingLabels = ['', 'Poor 😞', 'Fair 😐', 'Good 😊', 'Very Good 😄', 'Excellent 🤩'];

function openReviewModal() {
  const modal = document.getElementById('reviewModal');
  modal.style.display = 'flex';
  document.body.style.overflow = 'hidden';
}

function closeReviewModal() {
  const modal = document.getElementById('reviewModal');
  modal.style.display = 'none';
  document.body.style.overflow = 'auto';
}

// Close modal if click outside
document.getElementById('reviewModal').addEventListener('click', function(e) {
  if (e.target === this) closeReviewModal();
});

function hoverRating(n) {
  const stars = document.querySelectorAll('#starRow span');
  stars.forEach((s, i) => {
    s.style.filter = i < n ? 'grayscale(0) saturate(2)' : 'grayscale(0.6)';
    s.style.transform = i < n ? 'scale(1.2)' : 'scale(1)';
  });
}

function resetHover() {
  const stars = document.querySelectorAll('#starRow span');
  stars.forEach((s, i) => {
    s.style.filter = i < selectedRating ? 'grayscale(0) saturate(2)' : 'grayscale(0.6)';
    s.style.transform = i < selectedRating ? 'scale(1.15)' : 'scale(1)';
  });
}

function setRating(n) {
  selectedRating = n;
  document.getElementById('ratingInput').value = n;
  document.getElementById('ratingLabel').textContent = ratingLabels[n];
  document.getElementById('ratingLabel').style.color = '#ffd700';
  resetHover();
}

function validateReview() {
  if (selectedRating === 0) {
    document.getElementById('ratingLabel').textContent = '⚠️ Please select a star rating first!';
    document.getElementById('ratingLabel').style.color = '#dc3545';
    return false;
  }
  return true;
}
</script>

<%@ include file="../common/footer.jsp"%>
