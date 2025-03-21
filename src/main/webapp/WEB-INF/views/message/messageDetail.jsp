<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
      <%@include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">
          <!-- 작업 영역 Start -->

          <!-- 🔹 제목 영역 -->
          <div class="card card-body py-3">
            <h4 class="mb-4 mb-sm-0 card-title">
              <i class="fa-solid fa-envelope-open-text" style="color: #007BFF;"></i> 메시지 상세보기
            </h4>
          </div>

          <!-- 🔹 메시지 상세 내용 -->
          <div class="card">
            <div class="card-body">
              <div class="mb-3">
                <h5><strong>📨 발신자</strong></h5>
                <p class="text-muted">${message.dsptcherName}</p>
              </div>

              <div class="mb-3">
			    <h5><strong>📝 내용</strong></h5>
			    <p class="text-muted">
			        <c:out value="${formattedContent}" escapeXml="false" />
			    </p>
			  </div>


              <div class="mb-3">
                <h5><strong>📅 발송 일시</strong></h5>
                <p class="text-muted">
                  <fmt:formatDate value="${message.sndngDt}" pattern="yyyy년 M월 d일 (E) a h:mm" />
                </p>
              </div>

              <!-- 🔹 버튼 영역 -->
              <div class="d-flex justify-content-between">
                <button class="btn btn-secondary" onclick="history.back()">⬅ 뒤로 가기</button>

                <!-- boxType=S or R 에 따라 삭제 버튼 노출 -->
                <c:choose>
                  <c:when test="${boxType == 'S'}">
                    <form action="${pageContext.request.contextPath}/batirplan/message/deleteFromSent"
                          method="post">
                      <input type="hidden" name="mssageNo" value="${message.mssageNo}" />
                      <button type="submit" class="btn btn-danger">🗑 삭제</button>
                    </form>
                  </c:when>

                  <c:when test="${boxType == 'R'}">
                    <form action="${pageContext.request.contextPath}/batirplan/message/deleteFromReceived"
                          method="post">
                      <input type="hidden" name="recptnNo" value="${recptnNo}" />
                      <button type="submit" class="btn btn-danger">🗑 삭제</button>
                    </form>
                  </c:when>
                </c:choose>
              </div>
            </div>
          </div>

          <!-- 작업 영역 End -->
        </div>
      </div>
    </div>
  </div>

  <%@include file="../module/footerScript.jsp" %>
</body>
</html>
