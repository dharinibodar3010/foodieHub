<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Edit <span class="text-gradient">Category</span></h2>
      <a href="${pageContext.request.contextPath}/viewCategory" class="btn-outline-premium"><i class="fas fa-arrow-left"></i> Back</a>
    </div>

    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:24px;padding:36px;max-width:600px;">
      <form action="${pageContext.request.contextPath}/updateCategory" method="post">
        <input type="hidden" name="id" value="${category.id}">

        <div class="row g-4">
          <div class="col-12">
            <label class="form-label-premium">Category Name *</label>
            <input type="text" name="name" class="form-premium w-100" value="${category.name}" required>
          </div>
          <div class="col-12">
            <label class="form-label-premium">Description *</label>
            <textarea name="description" class="form-premium w-100" style="resize:none;height:100px;" required>${category.description}</textarea>
          </div>
          <div class="col-12">
            <button type="submit" class="btn-primary-premium" style="padding:12px 30px;"><i class="fas fa-save"></i> Update Category</button>
          </div>
        </div>
      </form>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
