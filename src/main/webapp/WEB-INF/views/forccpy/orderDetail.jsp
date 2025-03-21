<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">
<style>
#orders td {
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
		  <sec:authentication property="principal.memberVO.ccpyVO" var="ccpy" />
			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">${order.ordrNo }</h4>
			    	</div>
			    </div>
				
				<div class="card">
					<div class="px-4 py-3 border-bottom d-flex align-items-center justify-content-between">
				    	<h4 class="card-title mb-0">📑 상세</h4>
					</div>
					<div class="card-body">
						<h4 class="card-title">발주 정보</h4>
	    				<p class="text-black"><strong>날짜</strong> - ${order.ordrDate }</p>
	    				<p class="text-black"><strong>요청 사원</strong> - ${order.reqstrNm }</p>
	    				<hr/>
						<h4 class="card-title">품목 정보</h4>
	    				<div class="table-responsive mb-4 rounded-1">
    <table id="orders" class="table text-nowrap mb-0 align-middle">
    	<thead class="text-dark fs-4">
    		<tr>
    			<th>상세 번호</th>
    			<th>품목명</th>
    			<th>금액</th>
    			<th>🕗 입고일</th>
    		</tr>
    	</thead>
    	<tbody>
	    <c:forEach var="prdlst" items="${detailList}">
	    	<tr>
	    		<td>
	    			${prdlst.orderDeNo }
			    	<c:choose>
	    				<c:when test="${prdlst.deSttus eq '1' }">
					    	<span class="badge bg-secondary ms-2">입고대기</span>
	    				</c:when>
	    				<c:when test="${prdlst.deSttus eq '2' }">
					    	<span class="badge bg-success ms-2">입고완료</span>
	    				</c:when>
	    				<c:when test="${prdlst.deSttus eq '3' }">
					    	<span class="badge bg-danger ms-2">취소</span>
	    				</c:when>
	    			</c:choose>
	    		</td>
	    		<td>
	    			${prdlst.prdlstNm }
    			</td>
	    		<td>${prdlst.totalPrice }</td>
	    		<td>
	    			<c:choose>
	    				<c:when test="${empty prdlst.receivedDate}">
	    					-
	    				</c:when>
	    				<c:otherwise>
			    			<fmt:formatDate value="${prdlst.receivedDate}" pattern="yyyy-MM-dd (HH:mm)"/>
	    				</c:otherwise>
	    			</c:choose>
	    		</td>
	    	</tr>
	    </c:forEach>
	    </tbody>
<tfoot>
  <tr>
    <!-- 앞 2개 열을 합치고, 3번째 열에 총금액을 표시 -->
    <th colspan="3" class="text-end">총금액</th>
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
	$("#orders").DataTable({
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
			  var pageTotal = api
			    .column(2, { page: 'current' }) // 인덱스 2 (금액 열)
			    .data()
			    .reduce(function(a, b) {
			      return (parseFloat(a) || 0) + (parseFloat(b) || 0);
			    }, 0);
			  $(api.column(3).footer()).html(pageTotal.toLocaleString());
			}

		  
		});	
	
})
function formatDateTime(dateString) {
    if (!dateString) return "-"; // 빈 값 처리

    const date = new Date(dateString);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0"); // 월 보정 (+1) 및 2자리 변환
    const day = String(date.getDate()).padStart(2, "0");

    let hours = date.getHours(); // 24시간제 변환
    const minutes = String(date.getMinutes()).padStart(2, "0");

    // ✅ 0시는 "00"으로 처리
    const formattedHours = hours === 0 ? "00" : String(hours).padStart(2, "0");

    return `\${year}-\${month}-\${day} (\${formattedHours}:\${minutes})`;
}
</script>
</body>
</html>