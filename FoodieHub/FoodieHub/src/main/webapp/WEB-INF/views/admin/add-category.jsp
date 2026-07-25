<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="position:sticky; top:0; z-index:98; background:rgba(13,13,20,0.85); backdrop-filter:blur(25px); -webkit-backdrop-filter:blur(25px); padding:24px 32px 16px 32px; margin:-32px -32px 24px -32px; border-bottom:1px solid rgba(255,255,255,0.04); box-shadow: 0 10px 40px rgba(0,0,0,0.3);">
      <div class="admin-page-header" style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Add New <span class="text-gradient">Category</span></h2>
        <p style="color:rgba(255,255,255,1.0);font-size:0.85rem;margin:6px 0 0;">Create a new category for products</p>
      </div>
      <a href="${pageContext.request.contextPath}/viewCategory" class="btn-outline-premium">
        <i class="fas fa-list"></i> View Categories
      </a>
      </div>
    </div>

    <div style="background:rgba(18,18,26,0.7);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:36px;backdrop-filter:blur(25px);-webkit-backdrop-filter:blur(25px);box-shadow:0 15px 35px rgba(0,0,0,0.4);position:relative;overflow:hidden;max-width:600px;">
      <div style="position:absolute;top:-50px;right:-50px;width:200px;height:200px;background:rgba(255,193,7,0.08);border-radius:50%;filter:blur(40px);pointer-events:none;"></div>
      <div style="position:relative;z-index:2;">
      <form action="${pageContext.request.contextPath}/saveCategory" method="post">
        
        <div class="row g-4">
          <div class="col-12">
            <label class="form-label-premium">Category Name *</label>
            <div style="position:relative;">
              <i class="fas fa-tag" style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:rgba(255,255,255,1.0);font-size:0.85rem;"></i>
              <input type="text" name="name" class="form-premium w-100" style="padding-left:40px !important;" placeholder="e.g. Pizza, Burger" required>
            </div>
          </div>
          
          <div class="col-12">
            <label class="form-label-premium">Description *</label>
            <textarea name="description" class="form-premium w-100" style="resize:none;height:100px;" placeholder="Describe the category..." required></textarea>
          </div>
          
          <div class="col-12">
            <div style="display:flex;gap:12px;margin-top:10px;">
              <button type="submit" class="btn-primary-premium" style="padding:12px 30px;">
                <i class="fas fa-save"></i> Save Category
              </button>
              <a href="${pageContext.request.contextPath}/viewCategory" class="btn-outline-premium" style="padding:11px 24px;">
                <i class="fas fa-times"></i> Cancel
              </a>
            </div>
          </div>
        </div>
        
      </form>
      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
