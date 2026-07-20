<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">All <span class="text-gradient">Categories</span></h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:6px 0 0;">Manage your product categories</p>
      </div>
      <a href="${pageContext.request.contextPath}/addCategory" class="btn-primary-premium">
        <i class="fas fa-plus"></i> Add Category
      </a>
    </div>

    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:24px;overflow:hidden;">
      <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;">
          <thead>
            <tr style="background:rgba(255,193,7,0.08);border-bottom:1px solid rgba(255,193,7,0.15);">
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">ID</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Category Name</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Description</th>
              <th style="padding:14px 16px;text-align:center;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,1.0);">Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="c" items="${categories}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(255,193,7,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;color:rgba(255,255,255,1.0);font-size:0.85rem;">${c.id}</td>
                <td style="padding:14px 16px;font-weight:700;font-size:0.92rem;color:#ffc107;">${c.name}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,1.0);">${c.description}</td>
                <td style="padding:14px 16px;text-align:center;">
                  <div style="display:flex;gap:8px;justify-content:center;">
                    <a href="${pageContext.request.contextPath}/editCategory/${c.id}" style="width:34px;height:34px;background:rgba(23,108,232,0.15);border:1px solid rgba(23,108,232,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#4b9aff;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(23,108,232,0.3)'" onmouseout="this.style.background='rgba(23,108,232,0.15)'" title="Edit">
                      <i class="fas fa-edit" style="font-size:0.8rem;"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/deleteCategory/${c.id}" onclick="return confirm('Delete this category?')" style="width:34px;height:34px;background:rgba(220,53,69,0.15);border:1px solid rgba(220,53,69,0.3);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#dc3545;text-decoration:none;transition:all 0.3s;" onmouseover="this.style.background='rgba(220,53,69,0.3)'" onmouseout="this.style.background='rgba(220,53,69,0.15)'" title="Delete">
                      <i class="fas fa-trash" style="font-size:0.8rem;"></i>
                    </a>
                  </div>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty categories}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                <td colspan="4" style="text-align:center;padding:30px;color:rgba(255,255,255,1.0);">No categories found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
