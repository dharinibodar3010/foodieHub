<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  /* Hide the user navbar links in the admin panel */
  #navMenu { display: none !important; }
</style>

<div style="background:#0d0d14; border-right:1px solid rgba(255,69,0,0.15); min-height:calc(100vh - 70px); padding:24px 0; position:sticky; top:70px;">

  <div style="padding:0 16px 20px 16px; border-bottom:1px solid rgba(255,69,0,0.1);">
    <div style="display:flex;align-items:center;gap:10px;">
      <div style="width:42px;height:42px;background:linear-gradient(135deg,#ff4500,#ff8c00);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;box-shadow:0 4px 15px rgba(255,69,0,0.3);">
        👑
      </div>
      <div>
        <div style="font-weight:700;font-size:0.9rem;color:white;">Admin Panel</div>
        <div style="font-size:0.75rem;color:rgba(255,255,255,0.9);">FoodieHub Manager</div>
      </div>
    </div>
  </div>

  <div style="padding:16px 0;">

    <div style="padding:6px 16px 4px; font-size:0.7rem; font-weight:700; text-transform:uppercase; letter-spacing:1.5px; color:rgba(255,255,255,0.9); margin-bottom:4px;">
      Main
    </div>

    <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-tachometer-alt" style="width:20px;text-align:center;color:#ff4500;"></i>
      Dashboard
    </a>

    <div style="padding:6px 16px 4px; font-size:0.7rem; font-weight:700; text-transform:uppercase; letter-spacing:1.5px; color:rgba(255,255,255,0.9); margin:12px 0 4px;">
      Catalogue
    </div>

    <a href="${pageContext.request.contextPath}/addProduct" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-plus-circle" style="width:20px;text-align:center;color:#ff4500;"></i>
      Add Product
    </a>

    <a href="${pageContext.request.contextPath}/viewProducts" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-boxes" style="width:20px;text-align:center;color:#ff4500;"></i>
      View Products
    </a>

    <a href="${pageContext.request.contextPath}/viewCategory" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-tags" style="width:20px;text-align:center;color:#ff4500;"></i>
      Categories
    </a>

    <div style="padding:6px 16px 4px; font-size:0.7rem; font-weight:700; text-transform:uppercase; letter-spacing:1.5px; color:rgba(255,255,255,0.9); margin:12px 0 4px;">
      Management
    </div>

    <a href="${pageContext.request.contextPath}/adminOrders" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-shopping-bag" style="width:20px;text-align:center;color:#ff4500;"></i>
      Orders
      <span style="margin-left:auto;background:rgba(255,69,0,0.2);color:#ff4500;font-size:0.7rem;font-weight:700;padding:2px 8px;border-radius:10px;">New</span>
    </a>

    <a href="${pageContext.request.contextPath}/salesReport" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-chart-line" style="width:20px;text-align:center;color:#ff4500;"></i>
      Sales Report
    </a>

    <a href="${pageContext.request.contextPath}/users" class="sidebar-link" style="display:flex;align-items:center;gap:12px;padding:12px 20px;color:#ffffff;text-decoration:none;font-weight:500;font-size:0.9rem;transition:all 0.3s;border-left:3px solid transparent;margin:2px 0;" onmouseover="this.style.background='rgba(255,69,0,0.1)';this.style.color='white';this.style.borderLeftColor='#ff4500';" onmouseout="this.style.background='transparent';this.style.color='rgba(255,255,255,0.65)';this.style.borderLeftColor='transparent';">
      <i class="fas fa-users" style="width:20px;text-align:center;color:#ff4500;"></i>
      Users
    </a>

    <div style="padding:16px; margin-top:20px;">
      <a href="${pageContext.request.contextPath}/" style="display:flex;align-items:center;gap:10px;background:rgba(220,53,69,0.1);border:1px solid rgba(220,53,69,0.2);border-radius:10px;padding:12px 16px;color:#ffffff;text-decoration:none;font-size:0.85rem;font-weight:500;transition:all 0.3s;" onmouseover="this.style.background='rgba(220,53,69,0.2)';this.style.color='white';" onmouseout="this.style.background='rgba(220,53,69,0.1)';this.style.color='rgba(255,255,255,0.6)';">
        <i class="fas fa-sign-out-alt" style="color:#dc3545;"></i>
        Logout
      </a>
    </div>

  </div>
</div>