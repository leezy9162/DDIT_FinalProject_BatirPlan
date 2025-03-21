<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<!--  TinyMCE 최신 버전 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.6.1/tinymce.min.js"></script>

<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
      <%@include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">  <!--  가로 너비 맞춤 -->

          <div class="card w-100">
            <div class="card-body py-3">
              <div class="row align-items-center">
                <h4 class="mb-4 mb-sm-0 card-title">새 공지사항 작성</h4>
              </div>
            </div>
          </div>

          <div class="card w-100 mt-4">
            <div class="card-body">

              <form id="noticeForm" action="/batirplan/notice/register" method="post">

                <!-- CSRF 토큰 추가 -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <!-- 제목 입력 -->
                <div class="form-group">
                  <label for="sj">제목</label>
                  <input type="text" id="sj" name="sj" class="form-control" required>
                </div>

                <!-- TinyMCE 에디터 적용된 내용 입력 -->
                <div class="form-group">
                  <label for="cn">내용</label>
                  <textarea id="mymce" name="cn" class="form-control" rows="10"></textarea>
                </div>

                <input type="hidden" name="writer" value="${defaultWriter}">

                <input type="hidden" name="clCode" value="01">

                <div class="form-group text-right mt-4">
                  <button type="submit" class="btn btn-primary">등록</button>
                  <a href="/batirplan/notice/list" class="btn btn-secondary">목록</a>
                </div>

              </form>

            </div>
          </div> <!--  카드 닫기 -->

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
          mymce.triggerSave(); // TinyMCE 데이터를 textarea에 반영
      });

      // 폼 제출 후 자동 알림 + 페이지 이동
      function confirmSubmission(event) {
	    event.preventDefault(); // 기본 폼 제출 동작 방지
	
	    Swal.fire({
	        icon: "success",
	        title: "등록 완료",
	        text: "등록되었습니다!",
	        confirmButtonText: "확인"
	    }).then(() => {
	        document.getElementById("noticeForm").submit(); // 폼 제출
	        setTimeout(function() {
	            window.location.href = "/batirplan/notice/list"; // 목록 페이지로 이동
	        }, 500); // 0.5초 후 이동 (submit 실행 후 반영되도록)
	    });
	}

      //  폼 제출 버튼 클릭 시 `confirmSubmission` 실행
      $(document).ready(function () {
          $("#noticeForm").on("submit", confirmSubmission);
      });
  </script>

</body>
</html>
