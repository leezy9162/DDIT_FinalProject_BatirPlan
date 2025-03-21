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
          <!-- 작업 영역 Start -->
          <div class="card">
            <div class="card-body">
              <div class="row align-items-center">
                <h4 class="mb-4 mb-sm-0 card-title">공지사항 수정</h4>
              </div>

              <form id="noticeForm" action="/batirplan/notice/update/${notice.bbscttNo}" method="post">
                
                <!-- CSRF 토큰 추가 -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <!-- 제목 입력 -->
                <div class="form-group">
                  <label for="sj">제목</label>
                  <input type="text" id="sj" name="sj" class="form-control" value="${notice.sj}" required>
                </div>

                <!-- 내용 입력 (TinyMCE 적용) -->
                <div class="form-group">
                  <label for="cn">내용</label>
                  <textarea id="mymce" name="cn" class="form-control" rows="5" required>${notice.cn}</textarea>
                </div>

				<!-- 작성자 (숨김 처리) -->
				<input type="hidden" id="writer" name="writer" value="${notice.writer}">

				<!-- 작성일 (숨김 처리) -->
				<input type="hidden" id="writingDt" name="writingDt"
				       value="<fmt:formatDate value='${notice.writingDt}' pattern='yyyy-MM-dd HH:mm:ss'/>">

				<!--  분류 코드 선택 (숨김 처리) -->
				<input type="hidden" id="clCode" name="clCode" value="${notice.clCode}">


				<!-- 버튼 -->
				<div class="form-group text-right mt-3"> <!--  mt-3 추가 -->
				    <button type="submit" class="btn btn-primary">수정</button>
				    <a href="/batirplan/notice/list" class="btn btn-secondary">목록</a>
				</div>


              </form>
            </div> <!-- card-body -->
          </div> <!-- card -->
          <!-- 작업 영역 End -->
        </div>
      </div>
    </div>
  </div>

  <%@include file="../module/footerScript.jsp" %>

  <!--  TinyMCE 초기화 -->
  <script src="${pageContext.request.contextPath }/assets/libs/tinymce/tinymce.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/forms/tinymce-init.js"></script>

  <script>
      $(function(){
          let mymce = $("#mymce");
          mymce.triggerSave(); //  TinyMCE 데이터를 textarea에 반영
      });

      //  폼 제출 시 TinyMCE 데이터 반영 + 수정 완료 알림 + 페이지 이동
      function submitForm(event) {
	    event.preventDefault(); // 기본 폼 제출 동작 방지
	    tinymce.triggerSave(); // TinyMCE 내용 반영
	
	    Swal.fire({
	        icon: "success",
	        title: "수정 완료",
	        text: "수정되었습니다!",
	        confirmButtonText: "확인"
	    }).then(() => {
	        document.getElementById("noticeForm").submit(); // 폼 제출 실행
	        setTimeout(function() {
	            window.location.href = "/batirplan/notice/list"; // 목록 페이지로 이동
	        }, 500); // 0.5초 후 이동 (submit 실행 후 반영되도록)
	    });
	}

      // 폼 제출 버튼 클릭 시 `submitForm` 실행
      $(document).ready(function () {
          $("#noticeForm").on("submit", submitForm);
      });
  </script>

</body>
</html>
