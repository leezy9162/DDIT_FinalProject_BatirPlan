<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<style>
#reqTable td {
  color: black !important;
}
#orderTable td {
  color: black !important;
}
#rejectedTable td {
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
		  		<%-- ${ccpy } --%>
				
  			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">발주 조회</h4>
			    	</div>
			    </div>

		  		<!-- 상단 탭으로 구분되는 Content영역  -->
				<div class="card">
					<div class="px-4 py-3 border-bottom">
						<h4 class="card-title mb-0">📑 발주 리스트</h4>
					</div>
					<div class="card-body">
					  <ul class="nav nav-underline" id="myTab" role="tablist">
						  <li class="nav-item" role="presentation">
						    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
						      <span>미승인</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
						      <span>승인</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="test-tab" data-bs-toggle="tab" href="#test" role="tab" aria-controls="test" aria-selected="false" tabindex="-1">
						      <span>반려</span>
						    </a>
						  </li>
					  </ul>
		    		  <div class="tab-content tabcontent-border p-3" id="myTabContent">
		      		  <!-- 첫번째 탭 컨텐츠 영역 -->
		      		  <div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
 					  	<div class="d-flex justify-content-between align-items-center mb-3">
						  <h5>📝 바티르앤코 발주 목록</h5>
						  <div class="flex-grow-1 d-flex justify-content-end">
		      		  		<button class="btn btn-primary" id="permitBtn">승인</button>
		      		  		<button class="btn btn-danger  ms-2" id="rejectBtn">반려</button>
						  </div>
					     </div>
		      		  
  					    <div class="table-responsive mb-4 border rounded-1">
					      <table id="reqTable" class="table text-nowrap mb-0 align-middle">
					        <thead class="text-dark fs-4">
					            <tr>
					            	<th><input type="checkbox" id="checkAll1"></th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0" >[구분]발주번호</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">발주자</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">🕗 주문일자(시간)</h6>
					                </th>
					            </tr>
					        </thead>
					        <tbody id="reqList">
					        	<!-- DataTableArea  -->
					        	
					        </tbody>
					    </table>
					</div>						
						
					<div class="d-flex justify-content-between align-items-center mt-3">
						<div class="flex-grow-1 d-flex justify-content-center">
							<div id="pagingArea1" style="margin-top: 10px; text-align: center;">
							
							</div>
						</div>
					</div>
		      		  
		      		  
					  </div>
					  <div class="tab-pane fade" id="profile5" role="tabpanel" aria-labelledby="profile-tab">
					  
					  <div class="d-flex justify-content-between align-items-center mb-3">
						  <h5>✅ 승인된 목록</h5>
					     </div>
					  
  					    <div class="table-responsive mb-4 border rounded-1">
					      <table id="orderTable" class="table text-nowrap mb-0 align-middle">
					        <thead class="text-dark fs-4">
					            <tr>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0" >[구분]발주번호</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">발주자</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">🕗 승인일(시간)</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">🕗 입고일(시간)</h6>
					                </th>
					            </tr>
					        </thead>
					        <tbody id="orderList">
					        	<!-- DataTableArea  -->
					        	
					        </tbody>
					    </table>
					</div>						
						
					<div class="d-flex justify-content-between align-items-center mt-3">
						<div class="flex-grow-1 d-flex justify-content-center">
							<div id="pagingArea2" style="margin-top: 10px; text-align: center;">
							
							</div>
						</div>
					</div>					  
					  </div>
					  <div class="tab-pane fade" id="test" role="tabpanel" aria-labelledby="test-tab">
						<div class="d-flex justify-content-between align-items-center mb-3">
							<h5>❌ 반려된 목록</h5>
						</div>
						
						
						
						
						<div class="table-responsive mb-4 border rounded-1">
					      <table id="rejectedTable" class="table text-nowrap mb-0 align-middle">
					        <thead class="text-dark fs-4">
					            <tr>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0" >[구분]발주번호</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">발주자</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">🕗 주문일자(시간)</h6>
					                </th>
					            </tr>
					        </thead>
					        <tbody id="rejectedList">
					        	<!-- DataTableArea  -->
					        	
					        </tbody>
					    </table>
					  </div>						
						
					  <div class="d-flex justify-content-between align-items-center mt-3">
						<div class="flex-grow-1 d-flex justify-content-center">
							<div id="pagingArea3" style="margin-top: 10px; text-align: center;">
							
							</div>
						</div>
					  </div>
						  
						  
						  
						  
						  	
					  </div>
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
<script src="${pageContext.request.contextPath }/assets/libs/sweetalert2/dist/sweetalert2.all.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/sweet-alert.init.js"></script>
<!-- TinyMCE 초기화 -->
<script src="${pageContext.request.contextPath }/assets/libs/tinymce/tinymce.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/tinymce-init.js"></script>
<script type="text/javascript">
$(function(){
	
	getReqListByLogin(1);
	getOrderListByLogin(1);
	getRejectedListByLogin(1);
	
    // 전체 체크박스 클릭 이벤트 핸들러
    $(document).on("click", "#checkAll1", function(){
        $(".row-check").prop("checked", $(this).is(":checked"));
    });	
	
    
    $("#permitBtn").on("click", function(){
    	
    	let checkedReqNos = [];
    	$(".row-check:checked").each(function(){
            checkedReqNos.push($(this).data("reqno"));
        });
    	
    	// 유효성 검사
    	if (checkedReqNos.length === 0) {
		    Swal.fire({
		        icon: "warning",
		        title: "발주 선택 필요",
		        text: "승인할 발주를 선택하세요.",
		        confirmButtonText: "확인"
		    });
		    return;
		}
    	
    	$.ajax({
    		url: "/batirplan/forccpy/req/permitreq",
    		type: "post",
    		contentType: "application/json; charseet=utf-8",
    		data: JSON.stringify(checkedReqNos),
    		dataType: "json",
    		success: function(res){
    			Swal.fire({
                    title: '성공!',
                    text: "발주 요청 " + res + "건이 승인처리 되었습니다.",
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                	getReqListByLogin(1);
                });
    			console.log(res);
    		},
    		error: function(err){
				console.log(err);    			
    		}
    	})
    })
    
    $("#rejectBtn").on("click", function() {
	    let checkedReqNos = [];
	    $(".row-check:checked").each(function() {
	        checkedReqNos.push($(this).data("reqno"));
	    });
	
	    // 유효성 검사
	    if (checkedReqNos.length === 0) {
	        Swal.fire({
	            icon: "warning",
	            title: "발주 선택 필요",
	            text: "반려할 발주를 선택하세요.",
	            confirmButtonText: "확인"
	        });
	        return;
	    }
	
	    openRejectModal(checkedReqNos);
	});
    
    $("#submitRejectBtn").on("click", function (){
    	submitRejection();
    })
})

/* 반려 모달 여는 함수  */
function openRejectModal(param) {
  let rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));
  $("#rejectModal").data("reqNos", param);
  rejectModal.show();
}

function submitRejection(){
	let reason = tinymce.get('mymce').getContent(); 
	console.log($("#rejectModal").data("reqNos"));
	console.log(reason);
	
	let param = {
       reqNos: $("#rejectModal").data("reqNos"),   // List<String>
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
                text: "발주 요청 " + res + "건이 반려처리 되었습니다.",
                icon: 'success',
                confirmButtonText: '확인'
            }).then(() => {
    			getReqListByLogin(1);
    			getRejectedListByLogin(1);
    			// 2) 모달 닫기
                let rejectModal = bootstrap.Modal.getInstance(document.getElementById('rejectModal'));
                rejectModal.hide();

                // 3) 반려 사유 입력창 초기화(선택)
                tinymce.get('mymce').setContent("");
            });
		},
		error: function(err){
			console.log(err);    			
		}
	})
}

function getReqListByLogin(page){
	
	$.ajax({
		url: "/batirplan/forccpy/req/reqdatalist",
		type: "get",
		data: {currentpage: page},
		dataType: "json",
		success: function(res){
			console.log(res.dataList);
			console.log(res.paging);
			
			
			// 1) 기존 테이블 내용 초기화
            $("#reqList").empty();

            // 2) 결과 목록을 테이블에 추가
            if(res.dataList && res.dataList.length > 0){
                $.each(res.dataList, function(i, item){
                    // 예: { reqNo, suplrNm, reqstrNm, reqDate, ... }
                	var rowHtml = "<tr>"
                        + "<td><input type='checkbox' class='row-check' data-reqno='" + (item.reqNo || "") + "'></td>"
                		+ "<td>"
                	      + "<a href='/batirplan/forccpy/req/reqdetail?reqno=" + (item.reqNo || "") + "'>";
               	    if(item.reqType == 1) {
               	    	rowHtml += "[수동]"
               	    } else{
               	    	rowHtml += "[자동]"
               	    }
               	    rowHtml += (item.reqNo || "");
               	    if(item.reqSttus ==1){
               	    	rowHtml += "<span class='badge bg-secondary ms-2 me-0'>승인대기중</span>";
               	    } else if(item.reqSttus ==2){
               	    	rowHtml += "<span class='badge bg-primary ms-2 me-0'>발주승인</span>";
               	    } else if(item.reqSttus ==3){
               	    	rowHtml += "<span class='badge bg-succes ms-2 me-0'>입고완료</span>";
               	    } else{
               	    	rowHtml += "<span class='badge bg-danger ms-2 me-0'>반려</span>";
               	    }
                	rowHtml += "</a>"
                	    + "</td>";
                	    
                	if(item.reqstrNm == null){
                		rowHtml += ("<td>" + "-" + "</td>");
                	} else {
                		rowHtml += ("<td>" + (item.reqstrNm  || "") + "</td>");
                	}
               	    rowHtml += "<td>" + formatDateTime(item.reqDate) + "</td>"
                	    + "</tr>";
                    $("#reqList").append(rowHtml);
                });
            } else {
                // 데이터가 없는 경우
                $("#reqList").append("<tr><td colspan='4' class='text-center'>데이터가 없습니다.</td></tr>");
            }

            // 3) 페이징 영역 반영
            $("#pagingArea1").html(res.paging || "");
		},
		error: function(err){
			console.log(err);
		}
	})
}

function getRejectedListByLogin(page){
	
	$.ajax({
		url: "/batirplan/forccpy/req/rejecteddatalist",
		type: "get",
		data: {currentpage: page},
		dataType: "json",
		success: function(res){
			console.log(res.dataList);
			console.log(res.paging);
			
			
			// 1) 기존 테이블 내용 초기화
            $("#rejectedList").empty();

            // 2) 결과 목록을 테이블에 추가
            if(res.dataList && res.dataList.length > 0){
                $.each(res.dataList, function(i, item){
                    // 예: { reqNo, suplrNm, reqstrNm, reqDate, ... }
                	var rowHtml = "<tr>"
                		+ "<td>"
                	      + "<a href='/batirplan/forccpy/req/reqdetail?reqno=" + (item.reqNo || "") + "'>";
               	    if(item.reqType == 1) {
               	    	rowHtml += "[수동]"
               	    } else{
               	    	rowHtml += "[자동]"
               	    }
               	    rowHtml += (item.reqNo || "");
               	    if(item.reqSttus ==1){
               	    	rowHtml += "<span class='badge bg-secondary ms-2 me-0'>승인대기중</span>";
               	    } else if(item.reqSttus ==2){
               	    	rowHtml += "<span class='badge bg-primary ms-2 me-0'>발주승인</span>";
               	    } else if(item.reqSttus ==3){
               	    	rowHtml += "<span class='badge bg-succes ms-2 me-0'>입고완료</span>";
               	    } else{
               	    	rowHtml += "<span class='badge bg-danger ms-2 me-0'>반려</span>";
               	    }
                	rowHtml += "</a>"
                	    + "</td>";
                	    
                	if(item.reqstrNm == null){
                		rowHtml += ("<td>" + "-" + "</td>");
                	} else {
                		rowHtml += ("<td>" + (item.reqstrNm  || "") + "</td>");
                	}
               	    rowHtml += "<td>" + formatDateTime(item.reqDate) + "</td>"
                	    + "</tr>";
                    $("#rejectedList").append(rowHtml);
                });
            } else {
                // 데이터가 없는 경우
                $("#rejectedList").append("<tr><td colspan='4' class='text-center'>데이터가 없습니다.</td></tr>");
            }

            // 3) 페이징 영역 반영
            $("#pagingArea3").html(res.paging || "");
		},
		error: function(err){
			console.log(err);
		}
	})
}

function getOrderListByLogin(page){
	
	$.ajax({
		url: "/batirplan/forccpy/req/orderdatalist",
		type: "get",
		data: {currentpage: page},
		dataType: "json",
		success: function(res){
			console.log(res.dataList);
			console.log(res.paging);
			
			
			// 기존 테이블 내용 초기화
            $("#orderList").empty();

            // 결과 목록을 테이블에 추가
            if(res.dataList && res.dataList.length > 0){
                $.each(res.dataList, function(i, item){
                	
                	var rowHtml = "<tr>"
                		+ "<td>"
                	    + "<a href='/batirplan/forccpy/req/orderdetail?orderno=" + (item.ordrNo || "") + "'>";
               	    if(item.orderType == 1) {
               	    	rowHtml += "[수동]"
               	    } else{
               	    	rowHtml += "[자동]"
               	    }
               	    rowHtml += (item.ordrNo || "");
               	    if(item.ordrSttus ==1){
               	    	rowHtml += "<span class='badge bg-primary ms-2 me-0'>승인완료</span>";
               	    } else if(item.reqSttus ==2){
               	    	rowHtml += "<span class='badge bg-succes ms-2 me-0'>입고완료</span>";
               	    } else if(item.reqSttus ==3){
               	    	rowHtml += "<span class='badge bg-danger ms-2 me-0'>취소</span>";
               	    } else{
               	    	rowHtml += "<span class='badge bg-danger ms-2 me-0'>기타</span>";
               	    }
                	rowHtml += "</a>"
                	    + "</td>";
                	    
                	if(item.reqstrNm == null){
                		rowHtml += ("<td>" + "-" + "</td>");
                	} else {
                		rowHtml += ("<td>" + (item.reqstrNm  || "") + "</td>");
                	}
               	    rowHtml += "<td>" + formatDateTime(item.ordrDate) + "</td>"
                	    + "<td>" + formatDateTime(item.completionDate) + "</td>" + "</tr>";
                    $("#orderList").append(rowHtml);
                });
            } else {
                // 데이터가 없는 경우
                $("#orderList").append("<tr><td colspan='4' class='text-center'>데이터가 없습니다.</td></tr>");
            }

            // 3) 페이징 영역 반영
            $("#pagingArea2").html(res.paging || "");
		},
		error: function(err){
			console.log(err);
		}
	})
}

$(document).on("click", "#pagingArea1 .page-link", function(e){
    e.preventDefault();
    
    // 클릭한 페이지 링크의 부모 li 태그가 active 클래스인지 확인
    if ($(this).closest("li").hasClass("active")) {
        // 이미 활성화된 페이지이므로, 아무것도 하지 않고 종료
        return false;
    }

    // 활성화된 페이지가 아니라면, data-page 값을 읽어 다시 조회
    var page = $(this).data("page");
    getReqListByLogin(page);
});

$(document).on("click", "#pagingArea2 .page-link", function(e){
    e.preventDefault();
    
    // 클릭한 페이지 링크의 부모 li 태그가 active 클래스인지 확인
    if ($(this).closest("li").hasClass("active")) {
        // 이미 활성화된 페이지이므로, 아무것도 하지 않고 종료
        return false;
    }

    // 활성화된 페이지가 아니라면, data-page 값을 읽어 다시 조회
    var page = $(this).data("page");
    getOrderListByLogin(page);
});

$(document).on("click", "#pagingArea3 .page-link", function(e){
    e.preventDefault();
    
    // 클릭한 페이지 링크의 부모 li 태그가 active 클래스인지 확인
    if ($(this).closest("li").hasClass("active")) {
        // 이미 활성화된 페이지이므로, 아무것도 하지 않고 종료
        return false;
    }

    // 활성화된 페이지가 아니라면, data-page 값을 읽어 다시 조회
    var page = $(this).data("page");
    getRejectedListByLogin(page);
});

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