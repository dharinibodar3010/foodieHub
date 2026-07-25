<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<style>
  .stat-card {
    border-radius: 24px !important;
    padding: 24px !important;
    position: relative !important;
    overflow: hidden !important;
    backdrop-filter: blur(10px) !important;
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) !important;
    z-index: 1 !important;
  }
  .stat-card::before {
    content: '';
    position: absolute;
    top: -30px;
    right: -30px;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    filter: blur(35px);
    z-index: -1;
    opacity: 0.4;
    transition: all 0.5s ease;
  }
  
  .stat-revenue { background: linear-gradient(135deg, rgba(255,94,0,0.1), rgba(255,94,0,0.02)) !important; border: 1px solid rgba(255,94,0,0.15) !important; }
  .stat-revenue::before { background: #FF5E00; }
  .stat-revenue:hover { border-color: rgba(255,94,0,0.5) !important; box-shadow: 0 15px 35px rgba(255,94,0,0.2) !important; transform: translateY(-8px); }
  .stat-revenue:hover::before { transform: scale(1.4); opacity: 0.7; }

  .stat-orders { background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(99,102,241,0.02)) !important; border: 1px solid rgba(99,102,241,0.15) !important; }
  .stat-orders::before { background: #6366f1; }
  .stat-orders:hover { border-color: rgba(99,102,241,0.5) !important; box-shadow: 0 15px 35px rgba(99,102,241,0.2) !important; transform: translateY(-8px); }
  .stat-orders:hover::before { transform: scale(1.4); opacity: 0.7; }

  .stat-users { background: linear-gradient(135deg, rgba(40,167,69,0.1), rgba(40,167,69,0.02)) !important; border: 1px solid rgba(40,167,69,0.15) !important; }
  .stat-users::before { background: #28a745; }
  .stat-users:hover { border-color: rgba(40,167,69,0.5) !important; box-shadow: 0 15px 35px rgba(40,167,69,0.2) !important; transform: translateY(-8px); }
  .stat-users:hover::before { transform: scale(1.4); opacity: 0.7; }

  .stat-products { background: linear-gradient(135deg, rgba(255,193,7,0.1), rgba(255,193,7,0.02)) !important; border: 1px solid rgba(255,193,7,0.15) !important; }
  .stat-products::before { background: #ffc107; }
  .stat-products:hover { border-color: rgba(255,193,7,0.5) !important; box-shadow: 0 15px 35px rgba(255,193,7,0.2) !important; transform: translateY(-8px); }
  .stat-products:hover::before { transform: scale(1.4); opacity: 0.7; }
</style>

<div style="display:flex;">

  <!-- Sidebar -->
  <div style="width:260px;flex-shrink:0;">
    <%@ include file="../common/sidebar.jsp"%>
  </div>

  <!-- Main Content -->
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="position: sticky; top: 0; z-index: 100; background: rgba(13,13,20,0.85); backdrop-filter: blur(25px); -webkit-backdrop-filter: blur(25px); padding: 24px 32px; margin: -32px -32px 32px -32px; border-bottom: 1px solid rgba(255,255,255,0.04); box-shadow: 0 10px 40px rgba(0,0,0,0.3);">
      <!-- Page Header -->
      <div class="admin-page-header" style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:16px;">
        <div>
        <h2 style="font-weight:800;font-size:1.6rem;margin-bottom:4px;">
          Welcome, <span style="background:linear-gradient(135deg,#FF5E00,#ffd700);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">Admin</span> 👋
        </h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.88rem;margin:0;">
          <i class="fas fa-calendar me-2" style="color:#FF5E00;"></i>
          <span id="dashboard-date"></span> — FoodieHub Dashboard
          <script>
            const today = new Date();
            const options = { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' };
            document.getElementById('dashboard-date').innerText = today.toLocaleDateString('en-GB', options);
          </script>
        </p>
      </div>
      <div style="display:flex;gap:10px;">
        <button onclick="window.location.reload()" style="background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:10px 16px;color:rgba(255,255,255,1.0);cursor:pointer;font-size:0.82rem;transition:all 0.3s;" onmouseover="this.style.background='rgba(255,94,0,0.1)';this.style.color='#FF5E00'" onmouseout="this.style.background='rgba(255,255,255,0.05)';this.style.color='rgba(255,255,255,1.0)'">
          <i class="fas fa-sync-alt me-1"></i> Refresh
        </button>
        <a href="${pageContext.request.contextPath}/products" class="btn-primary-premium" style="padding:10px 20px;font-size:0.85rem;">
          <i class="fas fa-eye"></i> View Store
        </a>
      </div>
    </div>

    <!-- Stats Grid -->
    <div class="row g-4 mb-4">

      <div class="col-xl-3 col-md-6">
        <div class="stat-card stat-revenue">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(255,94,0,0.15);color:#FF5E00;">
              <i class="fas fa-shopping-bag"></i>
            </div>
            <span style="background:rgba(255,94,0,0.1);border:1px solid rgba(255,94,0,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#FF5E00;">+12% ↑</span>
          </div>
          <div class="stat-number">₹${totalRevenue}</div>
          <div class="stat-label">Total Revenue</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card stat-orders">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(99,102,241,0.15);color:#818cf8;">
              <i class="fas fa-clipboard-list"></i>
            </div>
            <span style="background:rgba(99,102,241,0.1);border:1px solid rgba(99,102,241,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#818cf8;">+8% ↑</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#6366f1,#8b5cf6);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">${totalOrders}</div>
          <div class="stat-label">Total Orders</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card stat-users">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(40,167,69,0.15);color:#28a745;">
              <i class="fas fa-users"></i>
            </div>
            <span style="background:rgba(40,167,69,0.1);border:1px solid rgba(40,167,69,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#28a745;">+25% ↑</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#28a745,#20c997);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">${totalUsers}</div>
          <div class="stat-label">Total Users</div>
        </div>
      </div>

      <div class="col-xl-3 col-md-6">
        <div class="stat-card stat-products">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
            <div class="stat-icon" style="background:rgba(255,193,7,0.15);color:#ffc107;">
              <i class="fas fa-boxes"></i>
            </div>
            <span style="background:rgba(255,193,7,0.1);border:1px solid rgba(255,193,7,0.2);border-radius:8px;padding:3px 10px;font-size:0.7rem;font-weight:700;color:#ffc107;">Active</span>
          </div>
          <div class="stat-number" style="background:linear-gradient(135deg,#ffc107,#fd7e14);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">${totalProducts}</div>
          <div class="stat-label">Total Products</div>
        </div>
      </div>
    </div>
    </div> <!-- End Sticky Top Section -->

    <div class="row g-4 mb-4">

      <!-- Recent Orders -->
      <div class="col-lg-8">
        <div style="background:rgba(18,18,26,0.7);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:28px;backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);box-shadow:0 15px 35px rgba(0,0,0,0.4);position:relative;overflow:hidden;">
          <div style="position:absolute;bottom:-50px;left:-50px;width:200px;height:200px;background:rgba(99,102,241,0.08);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>
          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;position:relative;z-index:2;">
            <h6 style="font-weight:800;font-size:1rem;margin:0;">Recent Orders</h6>
            <a href="${pageContext.request.contextPath}/adminOrders" style="color:#FF5E00;text-decoration:none;font-size:0.82rem;font-weight:600;">View All <i class="fas fa-arrow-right ms-1"></i></a>
          </div>

          <div style="overflow-x:auto; overflow-y:auto; max-height:350px; padding-right:5px;">
            <table style="width:100%;border-collapse:separate;border-spacing:0;">
              <thead style="box-shadow: 0 2px 5px rgba(0,0,0,0.5);">
                <tr style="background:rgba(255,94,0,0.08);">
                  <th style="position: sticky; top: 0; background: #1a1a24; z-index: 10; padding:12px 14px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Order ID</th>
                  <th style="position: sticky; top: 0; background: #1a1a24; z-index: 10; padding:12px 14px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Customer</th>
                  <th style="position: sticky; top: 0; background: #1a1a24; z-index: 10; padding:12px 14px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Amount</th>
                  <th style="position: sticky; top: 0; background: #1a1a24; z-index: 10; padding:12px 14px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Payment</th>
                  <th style="position: sticky; top: 0; background: #1a1a24; z-index: 10; padding:12px 14px;text-align:left;font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.95);border-bottom:1px solid rgba(255,255,255,0.06);">Status</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="o" items="${recentOrders}">
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#FF5E00;font-size:0.88rem;">#FH-${o.id}</td>
                    <td style="padding:12px 14px;">
                      <div style="font-weight:600;font-size:0.88rem;color:#ffffff;">${o.user != null ? o.user.name : 'Guest'}</div>
                      <div style="font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;">${o.user != null ? o.user.email : ''}</div>
                    </td>
                    <td style="padding:12px 14px;font-weight:700;font-size:0.88rem;color:white;">₹${o.totalAmount}</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">
                      <c:choose>
                        <c:when test="${o.payment != null and fn:contains(o.payment.paymentMode, 'Razorpay')}">
                          <div style="display:flex;align-items:center;gap:6px;">
                            <span style="background:rgba(99,102,241,0.15);color:#818cf8;padding:3px 8px;border-radius:6px;font-weight:600;font-size:0.75rem;">Razorpay (Paid)</span>
                            <c:set var="razorpayId" value="${fn:substringAfter(o.payment.paymentMode, ' - ')}" />
                            <c:if test="${not empty razorpayId}">
                              <i class="fas fa-copy" style="cursor:pointer;color:rgba(255,255,255,0.5);transition:color 0.2s;" onmouseover="this.style.color='white'" onmouseout="this.style.color='rgba(255,255,255,0.5)'" title="Copy ID" onclick="navigator.clipboard.writeText('${razorpayId}'); alert('Razorpay ID Copied: ${razorpayId}')"></i>
                            </c:if>
                          </div>
                        </c:when>
                        <c:when test="${o.payment != null}">
                          ${o.payment.paymentMode}
                        </c:when>
                        <c:otherwise>
                          <span style="color:rgba(255,255,255,0.5);">N/A</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td style="padding:12px 14px;">
                      <c:choose>
                        <c:when test="${o.status == 'Delivered'}">
                          <span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">Delivered</span>
                        </c:when>
                        <c:when test="${o.status == 'Cancelled'}">
                          <span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.4);color:#dc3545;">Cancelled</span>
                        </c:when>
                        <c:otherwise>
                          <span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(255,94,0,0.15);border:1px solid rgba(255,94,0,0.4);color:#FF5E00;">${o.status}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>

                <!-- Demo rows if no data -->
                <c:if test="${empty recentOrders}">
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#FF5E00;">#FH-1001</td>
                    <td style="padding:12px 14px;">
                      <div style="font-weight:600;font-size:0.88rem;color:#ffffff;">Ravi Patel</div>
                      <div style="font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;">ravi@example.com</div>
                    </td>
                    <td style="padding:12px 14px;font-weight:700;">₹1,256</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">
                      <div style="display:flex;align-items:center;gap:6px;">
                        <span style="background:rgba(99,102,241,0.15);color:#818cf8;padding:3px 8px;border-radius:6px;font-weight:600;font-size:0.75rem;">Razorpay (Paid)</span>
                        <i class="fas fa-copy" style="cursor:pointer;color:rgba(255,255,255,0.5);" title="Copy ID"></i>
                      </div>
                    </td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(255,94,0,0.15);border:1px solid rgba(255,94,0,0.4);color:#FF5E00;">Placed</span></td>
                  </tr>
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#FF5E00;">#FH-1002</td>
                    <td style="padding:12px 14px;">
                      <div style="font-weight:600;font-size:0.88rem;color:#ffffff;">Priya Shah</div>
                      <div style="font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;">priya@example.com</div>
                    </td>
                    <td style="padding:12px 14px;font-weight:700;">₹599</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">COD</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">Delivered</span></td>
                  </tr>
                  <tr style="border-bottom:1px solid rgba(255,255,255,0.04);" onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#FF5E00;">#FH-1003</td>
                    <td style="padding:12px 14px;">
                      <div style="font-weight:600;font-size:0.88rem;color:#ffffff;">Karan Mehta</div>
                      <div style="font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;">karan@example.com</div>
                    </td>
                    <td style="padding:12px 14px;font-weight:700;">₹849</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">UPI</td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.4);color:#dc3545;">Cancelled</span></td>
                  </tr>
                  <tr onmouseover="this.style.background='rgba(255,94,0,0.04)'" onmouseout="this.style.background='transparent'">
                    <td style="padding:12px 14px;font-weight:700;color:#FF5E00;">#FH-1004</td>
                    <td style="padding:12px 14px;">
                      <div style="font-weight:600;font-size:0.88rem;color:#ffffff;">Anita Joshi</div>
                      <div style="font-size:0.75rem;color:rgba(255,255,255,0.6);margin-top:2px;">anita@example.com</div>
                    </td>
                    <td style="padding:12px 14px;font-weight:700;">₹1,450</td>
                    <td style="padding:12px 14px;font-size:0.82rem;color:rgba(255,255,255,0.95);">
                      <div style="display:flex;align-items:center;gap:6px;">
                        <span style="background:rgba(99,102,241,0.15);color:#818cf8;padding:3px 8px;border-radius:6px;font-weight:600;font-size:0.75rem;">Razorpay (Paid)</span>
                        <i class="fas fa-copy" style="cursor:pointer;color:rgba(255,255,255,0.5);" title="Copy ID"></i>
                      </div>
                    </td>
                    <td style="padding:12px 14px;"><span style="padding:4px 12px;border-radius:12px;font-size:0.72rem;font-weight:700;background:rgba(40,167,69,0.15);border:1px solid rgba(40,167,69,0.4);color:#28a745;">Delivered</span></td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Quick Actions & Stats -->
      <div class="col-lg-4" style="position: sticky; top: 220px; z-index: 90; align-self: flex-start;">

        <!-- Revenue Chart (Simple) -->
        <div style="background:rgba(18,18,26,0.7);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:28px;backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);box-shadow:0 15px 35px rgba(0,0,0,0.4);margin-bottom:20px;position:relative;overflow:hidden;">
          <div style="position:absolute;top:-50px;right:-50px;width:180px;height:180px;background:rgba(255,94,0,0.08);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>
          <h6 style="font-weight:800;font-size:0.95rem;margin-bottom:24px;position:relative;z-index:2;">Weekly Revenue</h6>
          <div style="height:250px;position:relative;z-index:2;width:100%;">
            <canvas id="revenueChart"></canvas>
          </div>
          <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
          <script>
            (function() {
              var ctx = document.getElementById('revenueChart').getContext('2d');
              var rawData = ${weeklyRevenueData != null ? weeklyRevenueData : '[0,0,0,0,0,0,0]'};
              var sum = rawData.reduce(function(a, b) { return a + b; }, 0);
              
              var isDemo = false;
              if (sum === 0) {
                  rawData = [450, 650, 350, 800, 550, 900, 700]; // Demo data
                  isDemo = true;
              }

              var gradient = ctx.createLinearGradient(0, 0, 0, 250);
              gradient.addColorStop(0, 'rgba(255, 94, 0, 0.6)');
              gradient.addColorStop(1, 'rgba(255, 94, 0, 0.01)');

              new Chart(ctx, {
                  type: 'line',
                  data: {
                      labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                      datasets: [{
                          label: isDemo ? 'Revenue (Demo)' : 'Revenue',
                          data: rawData,
                          borderColor: '#FF5E00',
                          backgroundColor: gradient,
                          borderWidth: 3,
                          pointBackgroundColor: '#12121a',
                          pointBorderColor: '#FF5E00',
                          pointBorderWidth: 2,
                          pointRadius: 4,
                          pointHoverRadius: 6,
                          fill: true,
                          tension: 0.4
                      }]
                  },
                  options: {
                      responsive: true,
                      maintainAspectRatio: false,
                      plugins: {
                          legend: { display: false },
                          tooltip: {
                              backgroundColor: 'rgba(18,18,26,0.9)',
                              titleColor: '#fff',
                              bodyColor: '#ffd700',
                              borderColor: 'rgba(255,94,0,0.3)',
                              borderWidth: 1,
                              padding: 10,
                              displayColors: false,
                              callbacks: {
                                  label: function(context) { return '₹' + context.parsed.y; }
                              }
                          }
                      },
                      scales: {
                          x: {
                              grid: { display: false, drawBorder: false },
                              ticks: { color: 'rgba(255,255,255,0.6)', font: { size: 11, family: "'Poppins', sans-serif" } }
                          },
                          y: {
                              grid: { color: 'rgba(255,255,255,0.05)', drawBorder: false, borderDash: [5, 5] },
                              ticks: { 
                                  color: 'rgba(255,255,255,0.6)', 
                                  font: { size: 10, family: "'Poppins', sans-serif" },
                                  callback: function(value) { return '₹' + value; },
                                  maxTicksLimit: 6
                              },
                              beginAtZero: true
                          }
                      }
                  }
              });
            })();
          </script>
        </div>



      </div>
    </div>

  </div>
</div>

</body>
</html>
