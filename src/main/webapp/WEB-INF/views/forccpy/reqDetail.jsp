<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">
<style>
#reqs td {
  color: black !important;
}
#reason,
#reason * {
  color: black !important;
}
</style> 
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBarForCcpy.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBarForCcpy.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->
  			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">${reqInfo.reqNo }</h4>
		  	  		<input type="hidden" name="reqNo" id="reqNo" value="${reqInfo.reqNo }"/>
			    	</div>
			    </div>
				
<div class="card">
  <div class="px-4 py-3 border-bottom d-flex align-items-center justify-content-between">
    <!-- 왼쪽 영역 -->
    <h4 class="card-title mb-0">📑 상세</h4>
    <!-- 오른쪽 영역 -->
    <c:if test="${status eq '3'}">
      <p class="mb-0 ms-3 text-danger">
        <i class="ti ti-alert-circle fs-5"></i>
        반려 발주
      </p>
    </c:if>
  </div>

  <div class="card-body">
  	<c:choose>
  		<c:when test="${status ne '3'}">
	    	<h4 class="card-title">발주 정보</h4>
	    	<div class="row mt-3">
	    		<p class="text-black"><strong>날짜</strong> - ${reqInfo.reqDate }</p>
	    		<p class="text-black"><strong>요청 사원</strong> - ${reqInfo.reqstrNm }</p>
	    	</div>
	    	    <div class="row">
    	<div class="d-flex justify-content-end">
    		<c:if test="${status ne '3' }">
	    		<button class="btn btn-primary" id="permitBtn">승인</button>
	    		<button class="btn btn-danger ms-2" id="rejectBtn">반려</button>
    		</c:if>
    	</div>
    </div>
	  		<hr/>
  		</c:when>
  		<c:otherwise>
	    	<div class="row" id="reason">
		  		${reqInfo.cancelReason }
		  		<div class="text-center mb-3">
			  		- ${reqInfo.suplrNm } - 	
		  		</div>
		  	</div>
  		</c:otherwise>
  	</c:choose>
  	

  	
  	

  	
  	

  	<h4 class="card-title">품목 정보</h4>
    <!-- 여기에 반복문 등 필요한 내용 -->
    <div class="table-responsive mb-4 rounded-1">
    <table id="reqs" class="table text-nowrap mb-0 align-middle">
    	<thead class="text-dark fs-4">
    		<tr>
    			<th>상세 번호</th>
    			<th>품목명</th>
    			<th>요청 수량</th>
    			<th>단가</th>
    			<th>금액</th>
    		</tr>
    	</thead>
    	<tbody>
	    <c:forEach var="prdlst" items="${detailList}">
	    	<tr>
	    		<td>${prdlst.reqDeNo }</td>
	    		<td>${prdlst.prdlstNm }</td>
	    		<td>${prdlst.reqQty }</td>
	    		<td>${prdlst.unitPrice }</td>
	    		<td>${prdlst.totalPrice }</td>
	    	</tr>
	    </c:forEach>
	    </tbody>
	    <tfoot>
    <tr>
      <!-- 총 5개의 열 중, 앞 4개를 합쳐서 '총금액' 셀로 사용 -->
      <th colspan="4" class="text-end">총금액</th>
      <!-- 실제 합계가 들어갈 셀 (마지막 열) -->
      <th class="text-end"></th>
    </tr>
  </tfoot>
    </table>
    
    
    </div>
  </div>
</div>

				
				
				

		  		<!-- 작업 영역 End -->
	  		</div>
  		</div>
	</div>
</div>
<div id="rejectModal" class="modal fade" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header d-flex align-items-center">
        <h4 class="modal-title" id="rejectModalLabel">발주 반려</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디: 검색 + 결과 + 페이지네이션 -->
      <div class="modal-body">
		<textarea class="form-control" id="mymce" rows="4" required>
			<h3 style="text-align: center;" data-mce-style="text-align: center;">&lt반려 사유&gt</h3>
			<hr/>
			<p style="text-align: center;" data-mce-style="text-align: center;"><span id="_mce_caret" data-mce-bogus="1" data-mce-type="format-caret"><span>이곳에 사유를 입력</span></span><br data-mce-bogus="1"></p>
		</textarea>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="submitRejectBtn">제출</button>
      </div>
      </div>
    </div>
  </div>
</div>     
<%@include file="../module/footerScript.jsp" %>
<script src="${pageContext.request.contextPath }/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/datatable/datatable-api.init.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/datatable/datatable-advanced.init.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#permitBtn").on("click", function(){
		let checkedReqNos = [];
		let target = $("#reqNo").val();
		checkedReqNos.push(target);
		
		$.ajax({
    		url: "/batirplan/forccpy/req/permitreq",
    		type: "post",
    		contentType: "application/json; charseet=utf-8",
    		data: JSON.stringify(checkedReqNos),
    		dataType: "json",
    		success: function(res){
    			Swal.fire({
                    title: '성공!',
                    text: "요청 번호 " + target + "이 승인처리 되었습니다.",
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                	location.href="/batirplan/forccpy/req/list";
                });
    			console.log(res);
    		},
    		error: function(err){
				console.log(err);    			
    		}
    	})
	})
	
	
	$("#rejectBtn").on("click", function(){
    	openRejectModal();
    })
    
	$("#submitRejectBtn").on("click", function(){
		let reason = tinymce.get('mymce').getContent(); 
		console.log(reason);
		
		let checkedReqNos = [];
		let target = $("#reqNo").val();
		checkedReqNos.push(target);
		
		let param = {
	       reqNos: checkedReqNos,
	       reason: reason    // String
	    };
		
		$.ajax({
			url: "/batirplan/forccpy/req/rejectreq",
			type: "post",
			contentType: "application/json; charseet=utf-8",
			data: JSON.stringify(param),
			dataType: "json",
			success: function(res){
				Swal.fire({
	                title: '성공!',
	                text: "발주 요청 " + target + "이 반려처리 되었습니다.",
	                icon: 'success',
	                confirmButtonText: '확인'
	            }).then(() => {
	            	location.href="/batirplan/forccpy/req/list";
	            });
			},
			error: function(err){
				console.log(err);    			
			}
		})
    })
	
    
	$("#reqs").DataTable({
		  // dom 설정을 통해 버튼과 테이블의 배치를 커스텀
		  dom: "<'d-flex justify-content-end mb-2'B>t",
		  
		  // 필요에 따라 lengthChange, searching 등 끄기
		  ordering: true,
		  lengthChange: false,
		  searching: false,

		  // 표시할 버튼들
		  buttons: [
		    {
		      extend: 'excelHtml5',
		      text: 'excel'
		    },
		    {
		      extend: 'print',
		      text: '프린트'
		    }
		  ],
		  
		  footerCallback: function ( row, data, start, end, display ) {
		    var api = this.api();

		    // '금액' 열이 테이블에서 index=4(0부터 세었을 때 5번째 열)
		    // reduce를 이용해 이 페이지에 표시된 '금액' 값을 합산
		    var pageTotal = api
		      .column(4, { page: 'current' }) // index 4번 컬럼
		      .data()
		      .reduce(function(a, b) {
		        // a, b는 순차적으로 값이 들어옴 (문자열일 수도 있으므로 숫자 변환)
		        return (parseFloat(a) || 0) + (parseFloat(b) || 0);
		      }, 0);

		    // 합계를 <tfoot> 마지막 셀에 표시
		    // footer() → 해당 컬럼의 푸터 셀
		    $(api.column(4).footer()).html(pageTotal.toLocaleString());
		  }
		  
		});


})
/* 반려 모달 여는 함수  */
function openRejectModal() {
  let rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));
  rejectModal.show();
}
</script>

</body>
</html>