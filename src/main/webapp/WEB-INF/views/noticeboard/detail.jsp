<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
      <%@include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid"> 

          <!--  게시글 상세보기 제목 바 -->
          <div class="card w-100">
            <div class="card-body py-3">
              <div class="row align-items-center">
                <h4 class="mb-4 mb-sm-0 card-title">게시글 상세보기</h4>
              </div>
            </div>
          </div>

          <div class="card w-100 mt-4">
            <div class="card-body">
	
			  <div>
                <h5 class="card-title">${notice.sj}</h5>
           	</div>	
           	<div class="text-end">
           	    바티르플랜 경영지원팀 /
             	<fmt:formatDate value="${notice.writingDt}" pattern="yyyy/MM/dd HH:mm:ss"/>
             </div>
             <div class="card-body border-top p-4">
             	${notice.cn}
             </div>
           	 
           	 <div class="text-end">
                <!--  목록 버튼 (모든 사용자 가능) -->
                <a href="/batirplan/notice/list" class="btn btn-primary">
                목록
                </a>

                <!--  ROLE_DEPT_MNGMT 권한이 있는 경우 수정 및 삭제 -->
                <c:if test="${pageContext.request.isUserInRole('ROLE_DEPT_MNGMT')}">
                  <a href="/batirplan/notice/edit/${notice.bbscttNo}" class="btn btn-warning">수정</a>

                  <!-- 삭제 버튼 -->
                  <form action="/batirplan/notice/delete/${notice.bbscttNo}" method="post" style="display:inline;" id="deleteForm">
					    <button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
					</form>
					
					<script>
					    document.getElementById("deleteButton").addEventListener("click", function() {
					        Swal.fire({
					            title: '정말 삭제하시겠습니까?',
					            text: '삭제된 내용은 복구할 수 없습니다.',
					            icon: 'warning',
					            showCancelButton: true,
					            confirmButtonText: '삭제',
					            cancelButtonText: '취소'
					        }).then((result) => {
					            if (result.isConfirmed) {
					                document.getElementById("deleteForm").submit(); // 폼을 제출하여 삭제 실행
					            }
					        });
					    });
					</script>
                </c:if>
              </div>
				
              <%-- <!--  제목 -->
              <div class="card-body border-top py-3">
                <h5 class="fw-bold">제목</h5>
                <p class="mb-0">${notice.sj}</p>
              </div>

              <!--  작성일 -->
              <div class="card-body border-top py-3">
                <h5 class="fw-bold">작성일</h5>
                <p class="mb-0">
                  <fmt:formatDate value="${notice.writingDt}" pattern="yyyy/MM/dd HH:mm:ss"/>
                </p>
              </div>

              <!--  작성자 -->
              <div class="card-body border-top py-3">
                <h5 class="fw-bold">작성자</h5>
                <p class="mb-0">바티르플랜 경영지원팀</p> 작성자 고정
              </div>

              <!--  내용 -->
              <div class="card-body border-top py-3">
                <h5 class="fw-bold">내용</h5>
                <p class="mb-0" style="white-space: pre-wrap;">${notice.cn}</p> <!-- 개행 유지 -->
              </div>

              <!--  버튼 -->
              <div class="d-flex gap-2 mt-3">
                <!--  목록 버튼 (모든 사용자 가능) -->
                <a href="/batirplan/notice/list" class="btn btn-secondary">목록</a>

                <!--  ROLE_DEPT_MNGMT 권한이 있는 경우 수정 및 삭제 -->
                <c:if test="${pageContext.request.isUserInRole('ROLE_DEPT_MNGMT')}">
                  <a href="/batirplan/notice/edit/${notice.bbscttNo}" class="btn btn-warning">수정</a>

                  <!-- 삭제 버튼 -->
                  <form action="/batirplan/notice/delete/${notice.bbscttNo}" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                  </form>
                </c:if>
              </div> --%>

            </div>
          </div> <!--  카드 닫기 -->

        </div>
      </div>
    </div>
  </div>
  <%@include file="../module/footerScript.jsp" %>
</body>
</html>
