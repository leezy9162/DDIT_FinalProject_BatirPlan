<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">
<style>
#prdlstTable td {
  color: black !important;
}
</style>


<body class="link-sidebar">
  <%@include file="../../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper" >
    <%@include file="../../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
    <%@include file="../../module/navBar.jsp" %>
	    <div class="body-wrapper">
	      <div class="container-fluid">
		  <!-- 작업 영역 Start -->
		  
	        <div class="card card-body py-3">
			  <div class="row align-items-center">
			    <h4 class="mb-4 mb-sm-0 card-title">품목 조회</h4>
			  </div>
			</div>

			<!-- 검색 필터 Area Start -->
	  	    <div class="card">
 	 			<div class="px-4 py-3 border-bottom">
	              <h4 class="card-title mb-0">🔍 검색</h4>
	            </div>
	  	    
	              <div class="card-body">
					    <form id="searchForm">
					    	<!-- 페이징용 currentPage -->
					    	<input type="hidden" name="currentPage" id="currentPage" value="">
					    	
					    	<div class="row mb-3">
					    		<div class="col-md-4">
					    			<label class="form-label" for="level1Select">대분류</label>
						    		<!-- 대분류 -->
									<select class="form-control form-control-sm" name="level1Select" id="level1Select">
									    <option value="">-- 대분류 선택 --</option>
									    <c:forEach var="cat" items="${levelOneCtgryList}">
									        <!-- value에 카테고리 번호 -->
									        <option value="${cat.ctgryNo}">${cat.ctgryNm}</option>
									    </c:forEach>
									</select>
								</div>
					    		<div class="col-md-4">
					    			<label class="form-label" for="level2Select">중분류</label>
									<!-- 중분류  -->
									<select class="form-control form-control-sm" name="level2Select" id="level2Select">
									    <option value="">-- 중분류 선택 --</option>
									</select>
								</div>
					    		<div class="col-md-4">
					    			<label class="form-label" for="ctgryNo">소분류</label>
									<!-- 소분류 -->
									<select class="form-control form-control-sm" name="ctgryNo" id="ctgryNo">
									    <option value="">-- 소분류 선택 --</option>
									</select>
					    		</div>
					    	</div>
					    	
					    	<div class="row">
			                	<div class="col-md-4">
			                		<label class="form-label" for="prdlstNm">품목명</label>
					        		<input class="form-control form-control-sm" type="text" id="prdlstNm" name="prdlstNm" value=""/>
			                	</div>
			                	<div class="col-md-4">
			                		<label class="form-label" for="ccpyNm">담당업체명</label>
					        		<input class="form-control form-control-sm" type="text" id="ccpyNm" name="ccpyNm" value=""/>
			                	</div>
			                	<div class="col-md-4">
			                		<label class="form-label" for="prdlstStndrd">품목 규격</label>
							  		<input class="form-control form-control-sm mb-3" type="text" name="prdlstStndrd" id="prdlstStndrd" value="" />
			                	</div>
		                	</div>
					    	<div class="row">
			                	<div class="col-md-4">
			                		<label class="form-label" for="prdlstUnit">품목 단위</label>
						  			<!-- 공통 코드에 따라 품목 단위 동적으로 그리기  -->
						  			<select class="form-select form-select-sm" name="prdlstUnit">
						  				<option value="">--선택--</option>
									    <c:forEach var="unit" items="${unitList}" varStatus="status">
									        <option value="<fmt:formatNumber value='${status.index + 1}' pattern='00'/>">
									           ${unit}
									        </option>
									    </c:forEach>
									</select>
			                	</div>
								<div class="col-md-4">
									 <label class="form-label" for="prdlstPrice">단가 (From)</label>
							  			<input class="form-control form-control-sm" type="text" name="prdlstPriceStart" id="prdlstPriceStart" value="" />
								</div>
								<div class="col-md-4">
									 <label class="form-label" for="prdlstPrice">단가 (To)</label>
							  		<input class="form-control form-control-sm" type="text" name="prdlstPriceEnd" id="prdlstPriceEnd" value="" />
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
				  <!-- 검색 필터 Area End -->
	              
	              <!-- 테이블 카드 Area Start  -->
					<div class="card">
						 	 			<div class="px-4 py-3 border-bottom">
	              <h4 class="card-title mb-0">📑 결과</h4>
	            </div>
					
						<div class="card-body">
					<div class="table-responsive mb-4 border rounded-1">
					    <table id="prdlstTable" class="table text-nowrap mb-0 align-middle">
					        <thead class="text-dark fs-4">
					            <tr>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0" >품목명</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">담당 협력업체</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">단가</h6>
					                </th>
					                <th>
					                    <h6 class="fs-4 fw-semibold mb-0">규격(단위)</h6>
					                </th>
					            </tr>
					        </thead>
					        <tbody id="prdlstList">
					        	<!-- DataTableArea  -->
					        	
					        </tbody>
					    </table>
					</div>


					<div class="d-flex justify-content-between align-items-center mt-3">
						<button type="button" class="btn btn-primary" onclick="location.href='/batirplan/resrce/prdlst/register'">신규</button>
						
						<div class="flex-grow-1 d-flex justify-content-center">
							<div id="pagingArea" style="margin-top: 10px; text-align: center;">

							</div>
						</div>
					</div>
				
				</div>
			</div>		              
            <!-- 테이블 카드 Area End  -->
	              
	        </div>
		</div>
	</div>
  </div>
  <%@include file="../../module/footerScript.jsp" %>
  <script src="${pageContext.request.contextPath }/assets/libs/inputmask/dist/jquery.inputmask.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/forms/mask.init.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/datatable/datatable-api.init.js"></script>
</body>
<%
    // unitList를 가져온다고 가정
    List<String> uList = (List<String>) request.getAttribute("unitList");
    // 예: ["kg", "g", "m", "cm" ...]
    
    // 자바스크립트 배열 형태의 문자열 생성
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for (int i = 0; i < uList.size(); i++) {
        sb.append("\"").append(uList.get(i)).append("\"");
        if (i < uList.size() - 1) {
            sb.append(",");
        }
    }
    sb.append("]");
%>
<!-- cardList script -->
<script type="text/javascript">
$(function(){
	console.log('hello!');

	//231312
<%-- 	var units = <%=request.getAttribute("unitList") %>;
	console.log(units[0]); --%>
	
	$.fn.dataTable.ext.errMode = 'none';
	
    prdlstDataTable = $("#prdlstTable").DataTable({
        paging: false,
        searching: false,
        info: false,
        ordering: true
    });
	
	$("#searchFormSubmitBtn").on("click", function(){
        getTableData(1); // 첫 페이지부터 검색
    });
	
	getTableData(1);
	
 	// 대분류 change 이벤트
    $("#level1Select").on("change", function(){
        let selectedVal = $(this).val();
        if(!selectedVal) {
            $("#level2Select").empty().append("<option value=''>-- 중분류 선택 --</option>");
            $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
            return;
        }
        // AJAX로 중분류 목록 로드
        $.ajax({
            url: "/batirplan/resrce/prdlst/getleveltwoctgry",
            type: "GET",
            data: { parentCtgry: selectedVal },
            dataType: "json",
            success: function(data) {
                $("#level2Select").empty().append("<option value=''>-- 중분류 선택 --</option>");
                $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
                $.each(data, function(index, item){
                    $("#level2Select").append("<option value='" + item.ctgryNo + "'>" + item.ctgryNm + "</option>");
                });
                
                // (수정 모드인 경우) 중분류 값이 있으면 여기서 세팅 후 change 트리거
                if(status === 'u' && level2Val) {
                    $("#level2Select").val(level2Val).trigger("change");
                }
            },
            error: function(err){
                console.log(err);
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "중분류를 불러오는 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    });

    // 중분류 change 이벤트
    $("#level2Select").on("change", function(){
        let selectedVal = $(this).val();
        if(!selectedVal) {
            $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
            return;
        }
        // AJAX로 소분류 목록 로드
        $.ajax({
            url: "/batirplan/resrce/prdlst/getlevelthreectgry",
            type: "GET",
            data: { parentCtgry: selectedVal },
            dataType: "json",
            success: function(data) {
            	
                $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
                $.each(data, function(index, item){
                    $("#ctgryNo").append("<option value='" + item.ctgryNo + "'>" + item.ctgryNm + "</option>");
                });
                // (수정 모드인 경우) 소분류 값이 있으면 여기서 세팅
                if(status === 'u' && level3Val) {
                    $("#ctgryNo").val(level3Val);
                }
            },
            error: function(err){
                console.log(err);
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "소분류를 불러오는 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    });
    
    
    $("#searchFormResetBtn").on("click", function(){
        // 1) 폼 전체 리셋 (HTML5 표준 reset)
        //    -> form 태그의 id="searchForm"이 있어야 동작
        document.getElementById("searchForm").reset();

        // 2) 의존 SelectBox(중분류, 소분류)도 기본 옵션만 남기기
        $("#level2Select").empty().append("<option value=''>-- 중분류 선택 --</option>");
        $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");

        // 3) 페이지도 1페이지부터 다시 조회
        getTableData(1);
    });
})

function getTableData(page){
    // 1) 자바스크립트 객체로 파라미터 구성
    var paramObj = {
        currentPage: page,
        // 폼 내의 각 요소에서 값 추출
        level1Select: $("#level1Select").val(),
        level2Select: $("#level2Select").val(),
        ctgryNo: $("#ctgryNo").val(),
        prdlstNm: $("#prdlstNm").val(),
        ccpyNm: $("#ccpyNm").val(),
        prdlstStndrd: $("#prdlstStndrd").val(),
        prdlstUnit: $("select[name='prdlstUnit']").val(),
        prdlstPriceStart: $("#prdlstPriceStart").val(),
        prdlstPriceEnd: $("#prdlstPriceEnd").val()
    };

    // 2) JSON으로 전송
    $.ajax({
        url: "/batirplan/resrce/prdlst/data",
        type: "POST",
        contentType: "application/json; charset=utf-8", 
        data: JSON.stringify(paramObj), // JS 객체 → JSON 문자열로 변환
        dataType: "json",              // 서버 응답을 JSON으로 받음
        success: function(res){
            console.log("응답데이터:", res);
        	
         	var units = <%= sb.toString() %>;
            console.log('units:', units);
            
            let target = $("prdlstList");
            // 1) 기존 테이블 내용 초기화
            prdlstDataTable.clear();

            // 2) res.dataList 반복하며 행 추가
            //    예: 품목명(prdlstNm), 업체명(ccpyNm), 단가(prdlstPrice), 규격-단위(prdlstStndrd + "-" + prdlstUnit)
			$.each(res.dataList, function(index, item) {
			    // item: { prdlstCode, prdlstNm, ccpyNm, prdlstPrice, prdlstStndrd, prdlstUnit, ... }
			
			    // 1) a태그로 감싸기
			    //    예: <a href="/batirplan/resrce/prdlst/detail?prdlstCode=xxx">품목명</a>
			    var linkHtml = "<a href='/batirplan/resrce/prdlst/detail?prdlstNo=" 
			                   + (item.prdlstNo || "") 
			                   + "'>" 
			                   + (item.prdlstNm || "") 
			                   + "</a>";
			
			    // 2) 규격(단위) 표시
			    var unitName = units[item.prdlstUnit - 1] || "";
			    var stndrdUnit = (item.prdlstStndrd || "") + "(" + unitName + ")";
			
			    // 3) DataTables에 row 추가
			    prdlstDataTable.row.add([
			        linkHtml,                     // 품목명(링크)
			        item.ccpyNm || "",           // 담당 협력업체
			        item.prdlstPrice || 0,       // 단가
			        stndrdUnit                   // 규격(단위)
			    ]);
			});


            // 3) 테이블 갱신(draw)
            prdlstDataTable.draw();           
            
            
            $("#pagingArea").html(res.paging);
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
    e.preventDefault();          // a 태그 기본 이동 방지
    var page = $(this).data("page");  // data-page 속성 값
    getTableData(page);               // 해당 페이지로 다시 조회
});

</script>
</html>