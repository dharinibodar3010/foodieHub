<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="hideNavbar" value="true" scope="request" />
<%@ include file="../common/header.jsp"%>

<div style="display:flex;">
  <div style="width:260px;flex-shrink:0;"><%@ include file="../common/sidebar.jsp"%></div>
  <div style="flex:1;padding:32px;min-height:calc(100vh - 70px);">

    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:16px;">
      <div>
        <h2 style="font-weight:800;font-size:1.5rem;margin:0;">Registered <span class="text-gradient">Users</span></h2>
        <p style="color:rgba(255,255,255,0.4);font-size:0.85rem;margin:6px 0 0;">Customer database</p>
      </div>
    </div>

    <div style="background:rgba(255,255,255,0.02);border:1px solid rgba(255,255,255,0.06);border-radius:24px;overflow:hidden;">
      <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;">
          <thead>
            <tr style="background:rgba(40,167,69,0.08);border-bottom:1px solid rgba(40,167,69,0.15);">
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">ID</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Name</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Email</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Mobile</th>
              <th style="padding:14px 16px;text-align:left;font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:rgba(255,255,255,0.5);">Address</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="u" items="${list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);transition:background 0.2s;" onmouseover="this.style.background='rgba(40,167,69,0.04)'" onmouseout="this.style.background='transparent'">
                <td style="padding:14px 16px;color:rgba(255,255,255,0.4);font-size:0.85rem;">${u.id}</td>
                <td style="padding:14px 16px;font-weight:700;font-size:0.92rem;color:white;">
                  <div style="display:flex;align-items:center;gap:10px;">
                    <div style="width:30px;height:30px;border-radius:50%;background:rgba(40,167,69,0.15);color:#28a745;display:flex;align-items:center;justify-content:center;font-size:0.8rem;font-weight:700;">
                      ${u.name.substring(0,1).toUpperCase()}
                    </div>
                    ${u.name}
                  </div>
                </td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.6);">${u.email}</td>
                <td style="padding:14px 16px;font-size:0.85rem;color:rgba(255,255,255,0.6);">${u.mobile}</td>
                <td style="padding:14px 16px;font-size:0.82rem;color:rgba(255,255,255,0.45);max-width:250px;">${u.address}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty list}">
              <tr style="border-bottom:1px solid rgba(255,255,255,0.04);">
                <td colspan="5" style="text-align:center;padding:30px;color:rgba(255,255,255,0.4);">No users registered yet.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<%@ include file="../common/footer.jsp"%>
