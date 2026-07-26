<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<c:choose>
  <c:when test="${not empty requestScope.hideNavbar and empty requestScope.isLoginPage}">
    <!-- Force desktop scaling for admin panel on mobile -->
    <meta name="viewport" content="width=1200">
  </c:when>
  <c:otherwise>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </c:otherwise>
</c:choose>
<title>FoodieHub - Fresh Food Delivered Fast</title>
<meta name="color-scheme" content="dark">
<meta name="description" content="FoodieHub - Order your favourite food online. Fast delivery, best quality and amazing offers.">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"/>

<!-- Google Fonts - Poppins -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

<!-- Animate.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<!-- Razorpay Checkout -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<style>
  :root {
    --primary: #FF5E00; /* Glossy Orange */
    --primary-dark: #E65100;
    --primary-light: #FF8A22;
    --secondary: #FFD700; /* Golden Yellow */
    --accent: #FFEA00; /* Bright Golden Yellow */
    --dark: #000000; /* Pure Black Background */
    --dark-card: #111111; /* Slightly lighter black for cards */
    --dark-surface: #222222; 
    --dark-border: rgba(255, 255, 255, 0.1);
    --text-primary: #ffffff; /* Pure White */
    --text-secondary: #cccccc; 
    --text-muted: #999999; 
    --gradient-main: linear-gradient(135deg, #FF5E00 0%, #FFD700 100%);
    --gradient-gold: linear-gradient(135deg, #FFD700 0%, #FFA000 100%);
    --gradient-dark: linear-gradient(135deg, #111111 0%, #000000 100%);
    --glass-bg: rgba(10, 10, 10, 0.7);
    --glass-border: rgba(255, 215, 0, 0.3); /* Glossy gold tinted glass border */
    --shadow-glow: 0 8px 32px rgba(255, 94, 0, 0.4);
    --shadow-card: 0 10px 30px rgba(0, 0, 0, 0.6);
    --radius-lg: 16px;
    --radius-md: 12px;
    --radius-sm: 8px;
  }

  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    font-family: 'Poppins', sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    background: var(--dark) !important;
    color: var(--text-primary) !important;
    min-height: 100vh;
    <c:if test="${empty hideNavbar}">
    padding-top: 76px; /* Space for fixed navbar */
    </c:if>
  }
  
  h1, h2, h3, h4, h5, h6, p, label, li {
    color: var(--text-primary) !important;
  }
  
  .section-subtitle, .product-desc, .text-muted {
    color: var(--text-secondary) !important;
  }

  /* === SCROLLBAR === */
  ::-webkit-scrollbar { width: 6px; }
  ::-webkit-scrollbar-track { background: var(--dark); }
  ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 3px; }

  /* === NAVBAR === */
  .navbar-premium {
    background: rgba(10, 10, 15, 0.95) !important;
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--dark-border);
    padding: 12px 0;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1030;
    box-shadow: 0 4px 30px rgba(255, 69, 0, 0.1);
  }

  .navbar-brand-premium {
    font-size: 1.6rem;
    font-weight: 800;
    background: var(--gradient-main);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-decoration: none;
    letter-spacing: -0.5px;
  }

  .navbar-brand-premium span {
    -webkit-text-fill-color: white;
    color: white;
  }

  .nav-link-premium {
    color: var(--text-secondary) !important;
    font-weight: 500;
    padding: 8px 16px !important;
    border-radius: var(--radius-sm);
    transition: all 0.3s ease;
    position: relative;
    font-size: 0.9rem;
  }

  .nav-link-premium:hover,
  .nav-link-premium.active {
    color: var(--text-primary) !important;
    background: rgba(255, 69, 0, 0.15);
  }

  .nav-link-premium::after {
    content: '';
    position: absolute;
    bottom: 4px;
    left: 50%;
    transform: translateX(-50%);
    width: 0;
    height: 2px;
    background: var(--gradient-main);
    border-radius: 2px;
    transition: width 0.3s ease;
  }

  .nav-link-premium:hover::after { width: 60%; }

  .nav-cart-badge {
    position: relative;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }

  .cart-count {
    position: absolute;
    top: -8px;
    right: -8px;
    background: var(--gradient-main);
    color: white;
    font-size: 0.65rem;
    font-weight: 700;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .btn-nav-login {
    background: var(--gradient-main);
    color: white !important;
    border: none;
    padding: 8px 20px !important;
    border-radius: 25px;
    font-weight: 600;
    font-size: 0.85rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255, 69, 0, 0.3);
  }

  .btn-nav-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255, 69, 0, 0.5);
    color: white !important;
  }

  /* === BUTTONS === */
  .btn-primary-premium {
    background: var(--gradient-main);
    border: none;
    color: #000000; /* Black text for better contrast on gold/orange */
    padding: 12px 30px;
    border-radius: 25px;
    font-weight: 800;
    font-size: 0.95rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 4px 20px rgba(255, 75, 43, 0.4), inset 0 2px 0 rgba(255, 255, 255, 0.4); /* Glossy inset shadow */
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
  }

  .btn-primary-premium:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 30px rgba(255, 69, 0, 0.55);
    color: white;
    text-decoration: none;
  }

  .btn-outline-premium {
    background: transparent;
    border: 1.5px solid var(--primary);
    color: var(--primary);
    padding: 10px 28px;
    border-radius: 25px;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
  }

  .btn-outline-premium:hover {
    background: var(--primary);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 69, 0, 0.4);
    text-decoration: none;
  }

  .btn-danger-premium {
    background: linear-gradient(135deg, #dc3545, #b02a37);
    border: none;
    color: white;
    padding: 8px 20px;
    border-radius: var(--radius-sm);
    font-weight: 600;
    font-size: 0.85rem;
    transition: all 0.3s ease;
    cursor: pointer;
  }

  .btn-danger-premium:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
  }

  /* === CARDS === */
  .card-premium {
    background: var(--glass-bg);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius-lg);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    transition: all 0.4s ease;
    overflow: hidden;
    position: relative;
    display: flex;
    flex-direction: column;
    height: 100%;
  }

  .card-premium:hover {
    border-color: rgba(255, 215, 0, 0.4); /* Gold hover border */
    transform: translateY(-8px);
    box-shadow: 0 12px 35px rgba(255, 75, 43, 0.2);
  }

  .card-premium::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: var(--gradient-main);
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  .card-premium:hover::before { opacity: 1; }

  /* === FORM INPUTS === */
  .form-premium {
    background: var(--glass-bg) !important;
    border: 1.5px solid var(--glass-border) !important;
    border-radius: var(--radius-sm) !important;
    color: var(--text-primary) !important;
    padding: 12px 16px !important;
    font-family: 'Poppins', sans-serif !important;
    transition: all 0.3s ease !important;
    font-size: 0.9rem !important;
  }

  .form-premium:focus {
    border-color: var(--primary) !important;
    box-shadow: 0 0 0 3px rgba(255, 69, 0, 0.15) !important;
    background: rgba(255, 69, 0, 0.05) !important;
    outline: none !important;
  }

  .form-premium::placeholder { color: var(--text-muted) !important; }

  .form-label-premium {
    color: var(--text-secondary);
    font-weight: 500;
    font-size: 0.85rem;
    margin-bottom: 6px;
    display: block;
  }

  select.form-premium option {
    background: var(--dark-card);
    color: var(--text-primary);
  }

  /* === BADGES === */
  .badge-premium {
    background: var(--gradient-main);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
  }

  .badge-success-premium {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
  }

  .badge-warning-premium {
    background: linear-gradient(135deg, #ffc107, #fd7e14);
    color: #000;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
  }

  /* === SECTION HEADERS === */
  .section-title {
    font-size: 2.2rem;
    font-weight: 800;
    line-height: 1.2;
  }

  .section-title span {
    background: var(--gradient-main);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .section-subtitle {
    color: var(--text-secondary);
    font-size: 1rem;
    font-weight: 400;
  }

  /* === ADMIN SIDEBAR === */
  .admin-sidebar {
    background: var(--dark-card);
    border-right: 1px solid var(--dark-border);
    min-height: calc(100vh - 70px);
    padding: 20px 0;
    position: sticky;
    top: 70px;
  }

  .sidebar-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 20px;
    color: var(--text-secondary);
    text-decoration: none;
    font-weight: 500;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    border-left: 3px solid transparent;
    margin: 2px 0;
  }

  .sidebar-item:hover,
  .sidebar-item.active {
    color: var(--text-primary);
    background: rgba(255, 69, 0, 0.1);
    border-left-color: var(--primary);
  }

  .sidebar-item i { width: 20px; text-align: center; }

  /* === TABLES === */
  .table-premium {
    color: var(--text-primary) !important;
  }

  .table-premium thead th {
    background: rgba(255, 69, 0, 0.1);
    border-color: var(--dark-border);
    color: var(--text-secondary);
    font-weight: 600;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 14px 16px;
  }

  .table-premium tbody td {
    border-color: var(--glass-border);
    padding: 14px 16px;
    vertical-align: middle;
    font-size: 0.9rem;
  }

  .table-premium tbody tr {
    transition: background 0.2s ease;
  }

  .table-premium tbody tr:hover {
    background: rgba(255, 69, 0, 0.05) !important;
  }

  /* === ALERTS === */
  .alert-premium {
    background: rgba(255, 69, 0, 0.1);
    border: 1px solid rgba(255, 69, 0, 0.3);
    border-radius: var(--radius-md);
    color: var(--text-primary);
    padding: 14px 18px;
    font-size: 0.9rem;
  }

  .alert-success-premium {
    background: rgba(40, 167, 69, 0.1);
    border: 1px solid rgba(40, 167, 69, 0.3);
    border-radius: var(--radius-md);
    color: #28a745;
    padding: 14px 18px;
    font-size: 0.9rem;
  }

  /* === ADMIN STICKY HEADER === */
  .admin-page-header {
    position: sticky;
    top: 0;
    z-index: 99;
    background: rgba(10, 10, 15, 0.95);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    padding: 24px 32px;
    margin: -32px -32px 32px -32px;
    border-bottom: 1px solid var(--dark-border);
  }

  /* === DIVIDER === */
  .divider-premium {
    height: 1px;
    background: linear-gradient(to right, transparent, var(--primary), transparent);
    margin: 30px 0;
  }

  /* === ANIMATIONS === */
  @keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
  }

  @keyframes pulse-glow {
    0%, 100% { box-shadow: 0 0 20px rgba(255, 69, 0, 0.3); }
    50% { box-shadow: 0 0 40px rgba(255, 69, 0, 0.6); }
  }

  @keyframes shimmer {
    0% { background-position: -200px 0; }
    100% { background-position: calc(200px + 100%) 0; }
  }

  .float-animation { animation: float 3s ease-in-out infinite; }
  .pulse-glow { animation: pulse-glow 2s ease-in-out infinite; }

  /* === PRICE TAG === */
  .price-tag {
    font-size: 1.3rem;
    font-weight: 800;
    background: var(--gradient-main);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  /* === PRODUCT IMAGE WRAPPER === */
  .product-img-wrapper {
    position: relative;
    overflow: hidden;
    border-radius: var(--radius-md) var(--radius-md) 0 0;
    aspect-ratio: 4 / 3;
    height: auto;
  }

  .product-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover !important; /* Ensures grid is uniform */
    display: block;
    object-position: center;
    transition: transform 0.5s ease;
  }

  .card-premium:hover .product-img-wrapper img {
    transform: scale(1.08);
  }

  .img-overlay {
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: linear-gradient(to top, rgba(10,10,15,0.8) 0%, transparent 50%);
  }

  /* === STATS CARD === */
  .stat-card {
    background: var(--glass-bg);
    border: 1px solid var(--glass-border);
    border-radius: var(--radius-lg);
    padding: 24px;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
  }

  .stat-card::after {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    opacity: 0.08;
    background: var(--primary);
  }

  .stat-card:hover {
    border-color: rgba(255, 69, 0, 0.3);
    transform: translateY(-4px);
    box-shadow: var(--shadow-card);
  }

  .stat-number {
    font-size: 2.2rem;
    font-weight: 800;
    background: var(--gradient-main);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    line-height: 1;
  }

  .stat-label {
    color: var(--text-secondary);
    font-size: 0.85rem;
    font-weight: 500;
    margin-top: 6px;
  }

  .stat-icon {
    width: 50px;
    height: 50px;
    border-radius: var(--radius-md);
    background: rgba(255, 69, 0, 0.15);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
    color: var(--primary);
  }

  /* === PAYMENT MODAL === */
  .razorpay-modal-overlay {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.8);
    backdrop-filter: blur(10px);
    z-index: 9999;
    align-items: center;
    justify-content: center;
  }

  .razorpay-modal-overlay.show { display: flex; }

  .payment-modal-box {
    background: var(--dark-card);
    border: 1px solid var(--dark-border);
    border-radius: var(--radius-lg);
    padding: 40px;
    max-width: 480px;
    width: 90%;
    animation: slideUpModal 0.4s ease;
  }

  @keyframes slideUpModal {
    from { transform: translateY(30px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
  }

  /* === RESPONSIVE UTILITIES === */
  .text-gradient {
    background: var(--gradient-main);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .border-gradient {
    border: 1.5px solid transparent;
    background: linear-gradient(var(--dark-card), var(--dark-card)) padding-box,
                var(--gradient-main) border-box;
  }

  .glow-text {
    text-shadow: 0 0 20px rgba(255, 69, 0, 0.6);
  }

  /* === TOAST NOTIFICATION === */
  .toast-premium {
    position: fixed;
    bottom: 30px;
    right: 30px;
    background: var(--dark-card);
    border: 1px solid var(--primary);
    border-radius: var(--radius-md);
    padding: 16px 24px;
    color: white;
    font-weight: 500;
    z-index: 9999;
    display: none;
    animation: slideInRight 0.3s ease;
    box-shadow: var(--shadow-glow);
  }

  @keyframes slideInRight {
    from { transform: translateX(100px); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
  }

  /* === OVERRIDE ALL BLUR/FADED TEXT TO SOLID WHITE === */
  /* This targets any inline style or event handler that tries to set a faded white color */
  [style*="rgba(255,255,255,0."],
  [style*="rgba(255, 255, 255, 0."],
  [onmouseout*="rgba(255,255,255,0."],
  [onmouseout*="rgba(255, 255, 255, 0."] {
      color: #ffffff !important;
  }
  /* === PAGE TRANSITION & PROGRESS BAR === */
  #page-progress-bar {
    position: fixed;
    top: 0;
    left: 0;
    height: 3px;
    width: 0%;
    background: linear-gradient(90deg, #FF5E00, #FFD700, #FF5E00);
    background-size: 200% 100%;
    z-index: 99999;
    transition: width 0.3s ease;
    animation: progress-shimmer 1.5s linear infinite;
    box-shadow: 0 0 10px rgba(255,94,0,0.6);
    display: none;
  }
  @keyframes progress-shimmer {
    0%   { background-position: 200% 0; }
    100% { background-position: -200% 0; }
  }

  /* === MOBILE RESPONSIVE TWEAKS === */
  @media (max-width: 991px) {
    .nav-link-premium::after { display: none !important; }
    .offcanvas-body .nav-link-premium { padding: 12px 16px !important; margin-bottom: 8px; font-size: 1.1rem; border-radius: 8px; }
    .section-title { font-size: 1.7rem; }
    .checkout-page, .payment-page { padding: 30px 0 60px; }
    .card-premium, .stat-card, .checkout-card { padding: 20px; }
    .admin-page-header { padding: 16px 20px !important; margin: -32px -32px 20px -32px !important; }
    .admin-sidebar { position: static; min-height: auto; padding: 10px 0; border-bottom: 1px solid var(--dark-border); }
    .auth-card { padding: 24px 20px; }
    /* Fix excessive spacing on mobile in admin forms */
    div[style*="flex:1;padding:32px;"] { padding: 16px !important; }
    .mobile-offcanvas {
      background: rgba(18,18,26,0.95) !important;
      backdrop-filter: blur(20px) !important;
      border-right: 1px solid rgba(255,255,255,0.1) !important;
    }
    .mobile-offcanvas .offcanvas-body::-webkit-scrollbar {
      display: none !important;
    }
    .mobile-offcanvas .offcanvas-body {
      -ms-overflow-style: none !important;
      scrollbar-width: none !important;
      padding: 24px !important;
    }
    .mobile-offcanvas .navbar-nav {
      gap: 16px !important;
      width: 100%;
    }
    .mobile-offcanvas .nav-item {
      width: 100%;
      text-align: left;
    }
    .mobile-offcanvas .nav-link-premium {
      display: flex;
      align-items: center;
      padding: 12px 16px !important;
      background: rgba(255,255,255,0.03);
      border-radius: 12px;
      font-size: 1.05rem;
    }
    
    /* Admin Layout Overrides for Mobile */
    body > div[style*="display:flex"] {
      flex-direction: column !important;
    }
    body > div[style*="display:flex"] > div[style*="width:260px"] {
      width: 100% !important;
      flex-shrink: 1 !important;
    }
    body > div[style*="display:flex"] > div[style*="flex:1"] {
      width: 100% !important;
      padding: 16px !important;
      min-height: auto !important;
    }
    .admin-page-header { margin: -16px -16px 20px -16px !important; padding: 16px !important; }
  }

  /* Admin Sticky Fixes & Spacing (Desktop) */
  @media (min-width: 992px) {
    body > div[style*="display:flex"] > div[style*="flex:1"] > div[style*="position:sticky"],
    body > div[style*="display:flex"] > div[style*="flex:1"] > div[style*="position: sticky"] {
      top: 0 !important;
      margin-bottom: 0 !important; /* Remove excessive space below header */
    }
    
    /* Reduce padding on the main content wrapper to tighten layout */
    body > div[style*="display:flex"] > div[style*="flex:1"] {
      padding: 16px 32px !important;
    }
  }
</style>
</head>
<body>

<!-- Top Progress Bar -->
<div id="page-progress-bar"></div>

<!-- Splash Screen Loader (Runs once per session) -->
<div id="app-loader" style="position:fixed; top:0; left:0; width:100%; height:100%; background:var(--dark); z-index:99999; display:none; flex-direction:column; align-items:center; justify-content:center; transition:opacity 0.5s ease;">
  
  <!-- Modern CSS Loader -->
  <div style="position:relative; width:80px; height:80px; margin-bottom:10px;">
    <style>
      @keyframes spin-ring { 100% { transform: rotate(360deg); } }
      @keyframes spin-ring-rev { 100% { transform: rotate(-360deg); } }
    </style>
    <div style="position:absolute; width:100%; height:100%; border:4px solid transparent; border-top-color:#FF5E00; border-bottom-color:#FFD700; border-radius:50%; animation:spin-ring 1s linear infinite; box-shadow: 0 0 15px rgba(255,94,0,0.3);"></div>
    <div style="position:absolute; width:60%; height:60%; top:20%; left:20%; border:4px solid transparent; border-left-color:#FFD700; border-right-color:#FF5E00; border-radius:50%; animation:spin-ring-rev 0.8s linear infinite;"></div>
    <i class="fas fa-utensils" style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); color:#FFD700; font-size:1.2rem; filter:drop-shadow(0 0 5px rgba(255,215,0,0.5));"></i>
  </div>
  
  <h2 style="margin-top:30px; font-weight:800; background:var(--gradient-main); -webkit-background-clip:text; -webkit-text-fill-color:transparent; font-size:2.2rem; animation: pulse-glow 2s infinite;">FoodieHub</h2>
  <p style="color:var(--text-secondary); margin-top:5px; font-size:1rem; letter-spacing: 1px;">Preparing your delicious experience...</p>
</div>

<script>
  // === SPLASH SCREEN (only first visit) ===
  var isAdminPanel = ${not empty hideNavbar};
  var sessionKey = isAdminPanel ? 'adminAppLoaded' : 'userAppLoaded';

  if (!sessionStorage.getItem(sessionKey)) {
    document.getElementById('app-loader').style.display = 'flex';
    document.body.style.overflow = 'hidden';

    window.addEventListener('load', function() {
      setTimeout(function() {
        var loader = document.getElementById('app-loader');
        if (loader) {
          loader.style.opacity = '0';
          setTimeout(function() { 
            loader.style.display = 'none'; 
            document.body.style.overflow = 'auto';
          }, 300);
        }
        sessionStorage.setItem(sessionKey, 'true');
      }, 3000); // 3 seconds splash
    });
  }

  // Removed page fade logic
  window.addEventListener('load', function() {
    // Done
  });
</script>

<c:if test="${empty requestScope.hideNavbar}">
  <%@ include file="navbar.jsp"%>
</c:if>