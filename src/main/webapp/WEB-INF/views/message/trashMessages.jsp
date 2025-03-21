<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../module/head.jsp" %>
<body class="link-sidebar">
  <%@ include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@ include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
      <%@ include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">
          <!-- 작업 영역 Start -->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
          
          <!-- 제목 영역 -->
          <div class="card card-body py-3">
            <div class="d-flex align-items-center">
              <h4 class="mb-0 card-title">
                <i class="fa-solid fa-trash me-2" style="color: #6c757d;"></i> 휴지통
              </h4>
            </div>
          </div>
          
          <!-- 검색 및 페이지 이동 영역 -->
          <div class="card">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <!-- 페이지 이동 버튼 그룹 (왼쪽) -->
                <div>
                  <a href="${pageContext.request.contextPath}/batirplan/message/received" class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn">받은쪽지함</a>
                  <a href="${pageContext.request.contextPath}/batirplan/message/sent" class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn">보낸쪽지함</a>
                  <a href="${pageContext.request.contextPath}/batirplan/message/trash" class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn">휴지통</a>
                </div>
                <!-- 검색 폼 (오른쪽) -->
                <form method="get" class="d-flex align-items-center">
                  <select name="searchFilter" class="form-select me-2" style="width: 150px;">
                    <option value="">-- 검색 필터 --</option>
                    <option value="emplCode" <c:if test="${searchFilter=='emplCode'}">selected</c:if>>발/수신자명</option>
                    <option value="content" <c:if test="${searchFilter=='content'}">selected</c:if>>내용</option>
                  </select>
                  <input type="text" class="form-control me-2" name="searchKeyword" 
                         value="${searchKeyword}" placeholder="검색어 입력..." style="width: 250px;">
                  <button type="submit" class="btn btn-primary">검색</button>
                </form>
              </div>
              
              <!-- 복구/영구 삭제 기능 포함 폼 -->
              <form method="post">
                <div class="table-responsive">
                  <table class="table search-table align-middle text-nowrap">
                    <thead class="header-item">
                      <tr>
                        <th>
                          <div class="n-chk align-self-center text-center">
                            <div class="form-check">
                              <input type="checkbox" class="form-check-input primary" id="contact-check-all">
                              <label class="form-check-label" for="contact-check-all"></label>
                            </div>
                          </div>
                        </th>
                        <th>발/수신자</th>
                        <th>내용</th>
                        <th>송/수신일</th>
                        <!-- "쪽지 상태" 열 제거 -->
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="row" items="${pageInfo.list}">
                        <tr class="search-items">
                          <td>
                            <div class="n-chk align-self-center text-center">
                              <div class="form-check">
                                <input type="checkbox" class="form-check-input contact-chkbox primary" name="selectedRows" value="${row.BOX_TYPE}_${row.UNIQUE_ID}">
                                <label class="form-check-label"></label>
                              </div>
                            </div>
                          </td>
                          <td>${row.SENDER}</td>
                          <td>
                            <a href="${pageContext.request.contextPath}/batirplan/message/detail?mssageNo=${row.MSSAGE_NO}">
                              ${row.truncatedContent}
                            </a>
                          </td>
                          <td>${row.SEND_RECEIVE_DATE}</td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
                
                <!-- 페이지네이션 영역 -->
                <nav aria-label="페이지 탐색">
                  <ul class="pagination justify-content-center">
                    <c:if test="${pageInfo.hasPreviousPage}">
                      <li class="page-item">
                        <a class="page-link link" href="?pageNum=${pageInfo.prePage}&pageSize=${pageInfo.pageSize}&searchFilter=${searchFilter}&searchKeyword=${searchKeyword}" aria-label="이전">
                          <span aria-hidden="true"><i class="ti ti-chevrons-left fs-4"></i></span>
                        </a>
                      </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${pageInfo.pages}">
                      <li class="page-item <c:if test='${i == pageInfo.pageNum}'>active</c:if>">
                        <a class="page-link link" href="?pageNum=${i}&pageSize=${pageInfo.pageSize}&searchFilter=${searchFilter}&searchKeyword=${searchKeyword}">${i}</a>
                      </li>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                      <li class="page-item">
                        <a class="page-link link" href="?pageNum=${pageInfo.nextPage}&pageSize=${pageInfo.pageSize}&searchFilter=${searchFilter}&searchKeyword=${searchKeyword}" aria-label="다음">
                          <span aria-hidden="true"><i class="ti ti-chevrons-right fs-4"></i></span>
                        </a>
                      </li>
                    </c:if>
                  </ul>
                </nav>
                
                <!-- 버튼 영역 -->
                <div class="d-flex justify-content-start mt-3">
                  <a href="${pageContext.request.contextPath}/batirplan/message/send" class="btn btn-primary me-2">쪽지쓰기</a>
                  <button type="submit" class="btn btn-warning me-2" formaction="${pageContext.request.contextPath}/batirplan/message/restoreMultiple">복구</button>
                  <button type="submit" class="btn btn-danger" formaction="${pageContext.request.contextPath}/batirplan/message/permanentDeleteMultiple">영구 삭제</button>
                </div>
              </form>
            </div>
          </div>
          <!-- 작업 영역 End -->
        </div>
      </div>
    </div>
  </div>
  
  <%@ include file="../module/footerScript.jsp" %>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function () {
      // 전체 선택/해제
      $("#contact-check-all").click(function () {
        $(".contact-chkbox").prop("checked", this.checked);
      });
      
      // 개별 체크박스 클릭 시 전체 선택 여부 업데이트
      $(".contact-chkbox").click(function () {
        if ($(".contact-chkbox:checked").length === $(".contact-chkbox").length) {
          $("#contact-check-all").prop("checked", true);
        } else {
          $("#contact-check-all").prop("checked", false);
        }
      });
      
      // 삭제/복구/영구 삭제 버튼 클릭 시 체크박스 선택 여부 확인
      $("button[type='submit']").on("click", function (e) {
    	    let actionType = $(this).attr("formaction");

    	    if (actionType && $(".contact-chkbox:checked").length === 0) {
    	        e.preventDefault(); // 폼 제출 방지

    	        let message = actionType.includes("restoreMultiple")
    	            ? "복구할 항목을 선택해주세요!"
    	            : "삭제할 항목을 선택해주세요!";

    	        Swal.fire({
    	            icon: "warning",
    	            title: "항목 선택 필요",
    	            text: message,
    	            confirmButtonText: "확인"
    	        });
    	    }
    	});
    });
  </script>
</body>
</html>
