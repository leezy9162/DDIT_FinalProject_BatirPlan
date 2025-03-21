<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
  
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBar.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->
				
				<sec:authentication property="principal.memberVO.empVO" var="empl"/>

				<div class="card card-body py-3">
      				<div class="row align-items-center">
      					<h4 class="mb-4 mb-sm-0 card-title">입찰공고 작성</h4>
   					</div>
				</div>
				
				<div class="card">
					<div class="card-body wizard-content">
						<form id="bidForm" action="${pageContext.request.contextPath}/batirplan/project/bid/submit" method="post">
						    <input type="hidden" name="prjctNo" value="${prjctNo}">
						    <input type="hidden" name="procsNo" value="${procsNo}">
						    <input type="hidden" name="pblancWrter" value="${empl.emplCode}">
						    
						    <div class="mb-3">
						        <label for="pblancSj" class="form-label">공고 제목</label>
						        <input type="text" class="form-control" id="pblancSj" name="pblancSj" required>
						    </div>
						    
						    <div class="mb-3">
						        <label for="demandCndCn" class="form-label">공고 내용 (수요 조건)</label>
						        <textarea class="form-control" id="demandCndCn" name="demandCndCn" rows="5" required></textarea>
						    </div>
						    
						    <div class="mb-3">
						        <label for="pblancAmount" class="form-label">공고 금액</label>
						        <input type="number" class="form-control" id="pblancAmount" name="pblancAmount" required>
						    </div>
						    
						    <div class="mb-3">
						        <label for="pblancBgnde" class="form-label">시작일</label>
						        <input type="date" class="form-control" id="pblancBgnde" name="pblancBgnde" required>
						    </div>
						    
						    <div class="mb-3">
						        <label for="pblancEndde" class="form-label">종료일</label>
						        <input type="date" class="form-control" id="pblancEndde" name="pblancEndde" required>
						    </div>
						    
						    <button type="submit" class="btn btn-primary">입찰 공고 작성</button>
						    <button type="button" class="btn btn-secondary" onclick="window.history.back()">취소</button>
						</form>
					</div>
				</div>	
		  		<!-- 작업 영역 End -->
	  		</div>
  		</div>
	</div>
</div>
    
<%@include file="../module/footerScript.jsp" %>

</body>

<script type="text/javascript">
$("#bidForm").submit(function(e) {
    e.preventDefault(); // 기본 폼 제출 막기
    $.ajax({
        url: $(this).attr("action"),
        type: "POST",
        data: $(this).serialize(),  // 폼 데이터를 직렬화해서 전송
        dataType: "json", // 응답 데이터가 JSON임을 명시
        success: function(res) {
            if (res.success) {
                // 입찰 공고 작성 성공 시 해당 프로젝트, 공정 번호 가져오기
                var prjctNo = $("input[name='prjctNo']").val();
                var procsNo = $("input[name='procsNo']").val();
                
                // 추가 AJAX 호출로 공정 상태를 "04" (예: 입찰 공고 작성 완료 상태)로 업데이트
                $.ajax({
                    url: '/batirplan/project/projectpm/updateProcessStatus',
                    type: 'POST',
                    data: {
                        procsNo: procsNo,
                        progrsSttus: '04'
                    },
                    dataType: 'json',
                    success: function(resp) {
                        if (resp.success) {
                            Swal.fire({
                                icon: "success",
                                title: "작성 완료",
                                text: "입찰 공고 작성이 완료되었습니다.",
                                confirmButtonText: "확인"
                            }).then(() => {
                                window.location.href = '/batirplan/project/projectpm/detail/' + prjctNo;
                            });
                        } else {
                            Swal.fire({
                                icon: "warning",
                                title: "상태 업데이트 실패",
                                text: "입찰 공고는 작성되었으나, 공정 상태 업데이트에 실패했습니다.",
                                confirmButtonText: "확인"
                            });
                        }
                    },
                    error: function(xhr, status, error) {
                        Swal.fire({
                            icon: "error",
                            title: "오류 발생",
                            text: "공정 상태 업데이트 중 오류가 발생했습니다: " + error,
                            confirmButtonText: "확인"
                        });
                    }
                });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "작성 실패",
                        text: "입찰 공고 작성에 실패했습니다.",
                        confirmButtonText: "확인"
                    });
                }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: "error",
                        title: "오류 발생",
                        text: "입찰 공고 작성 중 오류가 발생했습니다: " + error,
                        confirmButtonText: "확인"
                    });
                }
    });
});
</script>

</html>