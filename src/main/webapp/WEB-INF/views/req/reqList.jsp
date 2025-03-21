<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<style>
#reqTable td {
  color: black !important;
}
</style> 
  
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBar.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->
				
			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">발주 조회</h4>
			    	</div>
			    </div>
				
				<div class="card">
					<div class="px-4 py-3 border-bottom">
						<h4 class="card-title mb-0">🔍 검색</h4>
					</div>
					<div class="card-body">
						<form id="searchForm">
                            <!-- 페이징용 currentPage -->
                            <input type="hidden" name="currentPage" id="currentPage" value="1" />

                            <div class="row mb-3">
                                <!-- 발주 구분 -->
                                <div class="col-md-4">
                                    <label class="form-label" for="reqType">발주 구분</label>
                                    <select class="form-control form-control-sm" name="reqType" id="reqType">
                                        <option value="">-- 선택 --</option>
                                        <option value="1">수동</option>
                                        <option value="2">자동</option>
                                    </select>
                                </div>
                                <!-- 발주 검색 시작 날짜 -->
                                <div class="col-md-4">
                                    <label class="form-label" for="reqDateS">발주 시작일</label>
                                    <input class="form-control form-control-sm" type="date" id="reqDateS" name="reqDateS" />
                                </div>
                                <!-- 발주 검색 종료 날짜 -->
                                <div class="col-md-4">
                                    <label class="form-label" for="reqDateE">발주 종료일</label>
                                    <input class="form-control form-control-sm" type="date" id="reqDateE" name="reqDateE" />
                                </div>
                            </div>

                            <div class="row mb-3">
                                <!-- 발주자 명 -->
                                <div class="col-md-4">
                                    <label class="form-label" for="reqstrNm">발주자 명</label>
                                    <input class="form-control form-control-sm" type="text" id="reqstrNm" name="reqstrNm" />
                                </div>
                                <!-- 협력업체 명 -->
                                <div class="col-md-4">
                                    <label class="form-label" for="suplrNm">협력업체 명</label>
                                    <input class="form-control form-control-sm" type="text" id="suplrNm" name="suplrNm" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label" for="reqSttus">발주 요청 상태</label>
                                    <select class="form-control form-control-sm" name="reqSttus" id="reqSttus">
                                        <option value="">-- 선택 --</option>
                                        <option value="1">요청중</option>
                                        <option value="2">발주 승인</option>
                                        <option value="3">입고 완료</option>
                                        <option value="4">반려</option>
                                    </select>
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="button" class="btn btn-primary" id="searchFormSubmitBtn">
                                    <i class="ti ti-search fs-5"></i>
                                    <span>검색</span>
                                </button>
                                <button type="button" class="btn btn-primary" id="searchFormResetBtn">
                                    <i class="ti ti-trash fs-5"></i>
                                    <span>초기화</span>
                                </button>
                            </div>
                        </form>
					</div>
				</div>
				
				<div class="card">
					<div class="px-4 py-3 border-bottom">
						<h4 class="card-title mb-0">📑 결과</h4>
					</div>
					<div class="card-body">
						
					<div class="table-responsive mb-4 border rounded-1">
					    <table id="reqTable" class="table text-nowrap mb-0 align-middle">
					        <thead class="text-dark fs-4">
					            <tr>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0" >[구분]발주번호</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">협력업체명</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">발주자</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">주문일자(시간)</h6>
					                </th>
					            </tr>
					        </thead>
					        <tbody id="reqList">
					        	<!-- DataTableArea  -->
					        	
					        </tbody>
					    </table>
					</div>						
						
						<div class="d-flex justify-content-between align-items-center mt-3">
							<button type="button" class="btn btn-primary" onclick="location.href='/batirplan/resrce/req/handreq'">신규</button>
						
							<div class="flex-grow-1 d-flex justify-content-center">
								<div id="pagingArea" style="margin-top: 10px; text-align: center;">
								
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
    
<%@include file="../module/footerScript.jsp" %>
<script type="text/javascript">
$(function(){

	getReqList(1);
	
	$("#searchFormSubmitBtn").on("click", function(){
		getReqList(1); // 첫 페이지부터 검색
    });
	
    $("#searchFormResetBtn").on("click", function(){
        document.getElementById("searchForm").reset();

        getReqList(1);
    });
	
})

function getReqList(page){
    // 1) 자바스크립트 객체로 파라미터 구성
    var paramObj = {
        reqType:     $("#reqType").val(),
        reqDateS:    $("#reqDateS").val(),
        reqDateE:    $("#reqDateE").val(),
        reqstrNm:    $("#reqstrNm").val(),
        suplrNm:     $("#suplrNm").val(),
        reqSttus:    $("#reqSttus").val(),
        currentPage: page
    };
	
	
    $.ajax({
        url: "/batirplan/resrce/req/getreqlist",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(paramObj),
        dataType: "json",
        success: function(res){
            console.log("응답데이터:", res);

            // 1) 기존 테이블 내용 초기화
            $("#reqList").empty();

            // 2) 결과 목록을 테이블에 추가
            if(res.dataList && res.dataList.length > 0){
                $.each(res.dataList, function(i, item){
                	var rowHtml = "<tr>"
                	    + "<td>"
                	      + "<a href='/batirplan/resrce/req/reqdetail?reqno=" + (item.reqNo || "") + "'>";
               	    if(item.reqType == 1) {
               	    	rowHtml += "[수동]"
               	    } else{
               	    	rowHtml += "[자동]"
               	    }
               	    rowHtml += (item.reqNo || "");
               	    
               	    if(item.reqSttus ==1){
               	    	rowHtml += "<span class='badge bg-secondary ms-2 me-0'>요청중</span>";
               	    } else if(item.reqSttus == 2){
               	    	rowHtml += "<span class='badge bg-primary ms-2 me-0'>발주승인</span>";
               	    } else if(item.reqSttus == 3){
               	    	rowHtml += "<span class='badge bg-success ms-2 me-0'>입고완료</span>";
               	    	/* rowHtml += "<span class='badge bg-succes ms-2 me-0'>입고완료</span>"; */
               	    } else{
               	    	rowHtml += "<span class='badge bg-danger ms-2 me-0'>반려</span>";
               	    }
                	rowHtml += "</a>"
                	    + "</td>"
                	    + "<td>" + (item.suplrNm  || "") + "</td>";
                	    
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
                $("#reqList").append("<tr><td colspan='4'>데이터가 없습니다.</td></tr>");
            }

            // 3) 페이징 영역 반영
            $("#pagingArea").html(res.paging || "");
        },
        error: function(err){
            console.log(err);
            Swal.fire({
                icon: "error",
                title: "오류 발생",
                text: "데이터를 불러오는 중 오류가 발생했습니다.",
                confirmButtonText: "확인"
            });
        }
    });
    
}

$(document).on("click", "#pagingArea .page-link", function(e){
    e.preventDefault();
    
    // 클릭한 페이지 링크의 부모 li 태그가 active 클래스인지 확인
    if ($(this).closest("li").hasClass("active")) {
        // 이미 활성화된 페이지이므로, 아무것도 하지 않고 종료
        return false;
    }

    // 활성화된 페이지가 아니라면, data-page 값을 읽어 다시 조회
    var page = $(this).data("page");
    getReqList(page);
});

function formatDateTime(dateString) {
    if (!dateString) return ""; // 빈 값 처리

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