<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%@ include file="../common/header.jsp"%>

<style>
  .products-page { padding: 60px 0 80px; }

  .page-hero {
    padding: 60px 0 40px;
    background: linear-gradient(135deg, rgba(255,69,0,0.08) 0%, transparent 60%);
    margin-bottom: 40px;
    border-bottom: 1px solid rgba(255,69,0,0.1);
  }

  .filter-bar {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 16px;
    padding: 20px 24px;
    margin-bottom: 40px;
    display: flex;
    align-items: center;
    gap: 16px;
    flex-wrap: wrap;
  }

  .search-input-wrap {
    flex: 1;
    min-width: 240px;
    position: relative;
  }

  .search-input-wrap i {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(255,255,255,0.35);
  }

  .search-field {
    width: 100%;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 12px 16px 12px 44px;
    color: white;
    font-size: 0.9rem;
    font-family: 'Poppins', sans-serif;
    outline: none;
    transition: all 0.3s;
  }

  .search-field:focus {
    border-color: rgba(255,69,0,0.4);
    background: rgba(255,69,0,0.05);
  }

  .search-field::placeholder { color: rgba(255,255,255,0.3); }

  .filter-select {
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 12px 16px;
    color: white;
    font-size: 0.88rem;
    font-family: 'Poppins', sans-serif;
    outline: none;
    cursor: pointer;
    min-width: 150px;
  }

  .filter-select option { background: #12121a; }

  .product-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.07);
    border-radius: 20px;
    overflow: hidden;
    transition: all 0.4s ease;
    height: 100%;
    position: relative;
  }

  .product-card:hover {
    border-color: rgba(255,69,0,0.3);
    transform: translateY(-8px);
  }

  .product-card:hover .product-card-img {
    transform: scale(1.08);
  }

  .product-card-img-wrap {
    position: relative;
    height: 200px;
    overflow: hidden;
  }

  .product-card-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
  }

  .product-card-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(10,10,15,0.9) 0%, transparent 50%);
  }

  .product-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    background: linear-gradient(135deg, #ff4500, #ff8c00);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.72rem;
    font-weight: 700;
  }

  .product-fav {
    position: absolute;
    top: 12px;
    right: 12px;
    width: 34px;
    height: 34px;
    border-radius: 10px;
    background: rgba(10,10,15,0.7);
    backdrop-filter: blur(10px);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    border: 1px solid rgba(255,255,255,0.1);
    transition: all 0.3s;
  }

  .product-fav:hover { background: rgba(255,69,0,0.2); border-color: rgba(255,69,0,0.4); }
  .product-fav i { color: rgba(255,255,255,1.0); font-size: 0.85rem; transition: color 0.3s; }
  .product-fav:hover i { color: #ff4500; }
  .product-fav.active i { color: #ff4500; }

  .product-body { padding: 20px; }

  .product-category {
    font-size: 0.72rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #ff8c00;
    margin-bottom: 6px;
  }

  .product-name {
    font-weight: 700;
    font-size: 1rem;
    margin-bottom: 8px;
    color: white;
  }

  .product-desc {
    color: rgba(255,255,255,0.45);
    font-size: 0.82rem;
    line-height: 1.6;
    margin-bottom: 16px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .product-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .product-price {
    font-size: 1.25rem;
    font-weight: 800;
    background: linear-gradient(135deg, #ff4500, #ff8c00);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .btn-add-cart {
    background: linear-gradient(135deg, #ff4500, #ff8c00);
    border: none;
    color: white;
    padding: 9px 20px;
    border-radius: 12px;
    font-weight: 600;
    font-size: 0.82rem;
    cursor: pointer;
    transition: all 0.3s;
    display: flex;
    align-items: center;
    gap: 6px;
    text-decoration: none;
  }

  .btn-add-cart:hover {
    transform: scale(1.05);
    box-shadow: 0 6px 20px rgba(255,69,0,0.4);
    color: white;
  }

  .no-products {
    text-align: center;
    padding: 80px 20px;
    color: rgba(255,255,255,0.35);
  }

  .no-products i { font-size: 4rem; margin-bottom: 20px; color: rgba(255,69,0,0.3); }

  .results-count {
    color: rgba(255,255,255,1.0);
    font-size: 0.85rem;
    margin-bottom: 24px;
  }

  .results-count span { color: #ff4500; font-weight: 700; }
</style>

<!-- Page Hero -->
<div class="page-hero">
  <div class="container">
    <div class="d-flex justify-content-between align-items-end flex-wrap gap-3">
      <div>
        <nav aria-label="breadcrumb">
          <div style="display:flex;gap:8px;align-items:center;font-size:0.8rem;color:rgba(255,255,255,1.0);margin-bottom:12px;">
            <a href="${pageContext.request.contextPath}/" style="color:#ff4500;text-decoration:none;">Home</a>
            <i class="fas fa-chevron-right" style="font-size:0.65rem;"></i>
            <span>Menu</span>
          </div>
        </nav>
        <h1 class="section-title">Our <span>Menu</span></h1>
        <p class="section-subtitle mt-2">Explore our carefully curated selection of delicious dishes</p>
      </div>
      <a href="${pageContext.request.contextPath}/cart" class="btn-outline-premium">
        <i class="fas fa-shopping-cart"></i> View Cart
      </a>
    </div>
  </div>
</div>

<div class="container products-page" style="padding-top:0;">

  <!-- Filter Bar -->
  <div class="filter-bar">
    <div class="search-input-wrap">
      <i class="fas fa-search"></i>
      <input type="text" class="search-field" id="searchInput" placeholder="Search dishes..." onkeyup="filterProducts()">
    </div>
    <select class="filter-select" id="categoryFilter" onchange="filterProducts()">
      <option value="">All Categories</option>
      <c:choose>
        <c:when test="${not empty categories}">
          <c:forEach var="c" items="${categories}">
            <option value="${c.name}">
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
            </option>
          </c:forEach>
        </c:when>
      </c:choose>
    </select>
    <select class="filter-select" id="sortFilter" onchange="filterProducts()">
      <option value="default">Sort By</option>
      <option value="price-asc">Price: Low → High</option>
      <option value="price-desc">Price: High → Low</option>
      <option value="name">Name A → Z</option>
    </select>
    <div style="margin-left:auto;display:flex;gap:8px;">
      <button onclick="setView('grid')" id="gridBtn" style="width:36px;height:36px;background:rgba(255,69,0,0.15);border:1px solid rgba(255,69,0,0.3);border-radius:8px;color:#ff4500;cursor:pointer;transition:all 0.3s;" title="Grid View">
        <i class="fas fa-th-large" style="font-size:0.85rem;"></i>
      </button>
      <button onclick="setView('list')" id="listBtn" style="width:36px;height:36px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:8px;color:rgba(255,255,255,1.0);cursor:pointer;transition:all 0.3s;" title="List View">
        <i class="fas fa-list" style="font-size:0.85rem;"></i>
      </button>
    </div>
  </div>

  <p class="results-count">Showing <span id="resultCount">0</span> items</p>

  <!-- Products Grid -->
  <c:choose>
    <c:when test="${not empty products}">
      <div class="row g-4" id="productsGrid">
        <c:forEach var="p" items="${products}">
          <div class="col-lg-3 col-md-4 col-sm-6 product-item"
               data-name="${p.name}"
               data-price="${p.price}"
               data-category="${p.category != null ? p.category.name : ''}">
            <div class="product-card">
              <div class="product-card-img-wrap">
                <img src="${p.image.startsWith('http') ? p.image : pageContext.request.contextPath.concat('/images/').concat(p.image)}"
                     alt="${p.name}" class="product-card-img">
                <div class="product-card-overlay"></div>
                <c:if test="${p.available}">
                  <span class="product-badge">✅ Available</span>
                </c:if>
                <c:if test="${not p.available}">
                  <span class="product-badge" style="background:linear-gradient(135deg,#6c757d,#495057);">❌ Unavailable</span>
                </c:if>
                <div class="product-fav" onclick="toggleFav(this)">
                  <i class="fas fa-heart"></i>
                </div>
              </div>
              <div class="product-body">
                <div class="product-category">
                  <c:choose>
                    <c:when test="${p.category != null}">${p.category.name}</c:when>
                    <c:otherwise>Food</c:otherwise>
                  </c:choose>
                </div>
                <div class="product-name">${p.name}</div>
                <div class="product-desc">${p.description}</div>
                <div class="product-footer">
                  <span class="product-price">₹${p.price}</span>
                  <c:if test="${p.available}">
                    <form action="${pageContext.request.contextPath}/addToCart" method="post" style="margin:0;">
                      <input type="hidden" name="productId" value="${p.id}">
                      <input type="hidden" name="quantity" value="1">
                      <button type="submit" class="btn-add-cart">
                        <i class="fas fa-plus"></i> Add to Cart
                      </button>
                    </form>
                  </c:if>
                  <c:if test="${not p.available}">
                    <button class="btn-add-cart" style="background:linear-gradient(135deg,#6c757d,#495057);cursor:not-allowed;" disabled>
                      Unavailable
                    </button>
                  </c:if>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <div class="no-products">
        <i class="fas fa-utensils"></i>
        <h4 style="font-weight:700;margin-bottom:8px;">No Items Found</h4>
        <p style="font-size:0.9rem;">Products will appear here once added by admin.</p>
        <a href="${pageContext.request.contextPath}/" class="btn-primary-premium mt-3" style="width: 180px; padding: 12px; margin: 0 auto; display: block; text-align: center;">
          <i class="fas fa-home"></i> Go Home
        </a>
      </div>
    </c:otherwise>
  </c:choose>

</div>

<script>
function filterProducts() {
  const search = document.getElementById('searchInput').value.toLowerCase().trim();
  const selectedCat = document.getElementById('categoryFilter').value.toLowerCase();
  const sort = document.getElementById('sortFilter').value;
  
  const itemsArray = Array.from(document.querySelectorAll('.product-item'));
  let count = 0;

  // Sorting
  if (sort !== 'default') {
    itemsArray.sort((a, b) => {
      const priceA = parseFloat(a.getAttribute('data-price'));
      const priceB = parseFloat(b.getAttribute('data-price'));
      const nameA = a.getAttribute('data-name').toLowerCase();
      const nameB = b.getAttribute('data-name').toLowerCase();
      
      if (sort === 'price-asc') return priceA - priceB;
      if (sort === 'price-desc') return priceB - priceA;
      if (sort === 'name') return nameA.localeCompare(nameB);
      return 0;
    });
    
    const grid = document.getElementById('productsGrid');
    if (grid) {
      itemsArray.forEach(item => grid.appendChild(item));
    }
  }

  // Filtering
  itemsArray.forEach(item => {
    const name = item.getAttribute('data-name').toLowerCase();
    const category = item.getAttribute('data-category').toLowerCase();
    
    const matchesSearch = name.includes(search) || category.includes(search);
    const matchesCat = selectedCat === '' || category.includes(selectedCat);
    
    if (matchesSearch && matchesCat) {
      item.style.display = '';
      count++;
    } else {
      item.style.display = 'none';
    }
  });

  document.getElementById('resultCount').textContent = count;
}

function toggleFav(el) {
  el.classList.toggle('active');
  const icon = el.querySelector('i');
  if (el.classList.contains('active')) {
    icon.className = 'fas fa-heart';
    icon.style.color = '#ff4500';
    showToast('Added to wishlist! ❤️');
  } else {
    icon.style.color = 'rgba(255,255,255,1.0)';
    showToast('Removed from wishlist');
  }
}

function setView(type) {
  const grid = document.getElementById('productsGrid');
  const gridBtn = document.getElementById('gridBtn');
  const listBtn = document.getElementById('listBtn');

  if (type === 'list') {
    grid.querySelectorAll('.product-item').forEach(item => {
      item.className = 'col-12 product-item';
    });
    listBtn.style.background = 'rgba(255,69,0,0.15)';
    listBtn.style.borderColor = 'rgba(255,69,0,0.3)';
    listBtn.style.color = '#ff4500';
    gridBtn.style.background = 'rgba(255,255,255,0.05)';
    gridBtn.style.borderColor = 'rgba(255,255,255,0.1)';
    gridBtn.style.color = 'rgba(255,255,255,0.4)';
  } else {
    grid.querySelectorAll('.product-item').forEach(item => {
      item.className = 'col-lg-3 col-md-4 col-sm-6 product-item';
    });
    gridBtn.style.background = 'rgba(255,69,0,0.15)';
    gridBtn.style.borderColor = 'rgba(255,69,0,0.3)';
    gridBtn.style.color = '#ff4500';
    listBtn.style.background = 'rgba(255,255,255,0.05)';
    listBtn.style.borderColor = 'rgba(255,255,255,0.1)';
    listBtn.style.color = 'rgba(255,255,255,0.4)';
  }
}

function showToast(msg) {
  let toast = document.querySelector('.toast-premium');
  if (!toast) {
    toast = document.createElement('div');
    toast.className = 'toast-premium';
    document.body.appendChild(toast);
  }
  toast.textContent = msg;
  toast.style.display = 'block';
  setTimeout(() => { toast.style.display = 'none'; }, 2500);
}

// Initial count and filter from URL
document.addEventListener('DOMContentLoaded', function() {
  const urlParams = new URLSearchParams(window.location.search);
  const categoryParam = urlParams.get('category');
  
  if (categoryParam) {
    const catSelect = document.getElementById('categoryFilter');
    for (let i = 0; i < catSelect.options.length; i++) {
      if (catSelect.options[i].value.toLowerCase() === categoryParam.toLowerCase() || 
          catSelect.options[i].text.toLowerCase().includes(categoryParam.toLowerCase())) {
        catSelect.selectedIndex = i;
        break;
      }
    }
  }
  
  filterProducts(); // Applies filter and updates count
});
</script>

<%@ include file="../common/footer.jsp"%>
