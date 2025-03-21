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
		  	<div class="card card-body py-3">
			  <div class="row align-items-center">
			    <h4 class="mb-4 mb-sm-0 card-title">아이디 발급</h4>
			  </div>
			</div>
			
			<div class="card">
				<div id="emplArea" class="card-body">
					<h4 class="card-title mb-3">미발급 사원</h4>
					<div class="text-end">
						<button id="emplAutoIdProcessBtn" type="button" class="btn btn-primary mb-2" onclick="emplProcess()">발급</button>
					</div>
					<div class="table-responsive mb-4 border rounded-1">
						<table id="emplListTable" class="table text-nowrap mb-0 align-middle">
	  						<thead class="text-dark fs-4">
						    	<tr>
						        	<th>
						            	<input id="checkAllEmpl" class="form-check-input" type="checkbox" value="" >
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">사원명</h6>
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">부서-직급</h6>
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">입사일</h6>
						          	</th>
						      	</tr>
						    </thead>
						  	<tbody id="emplDataArea">
								<!-- 데이터 테이블 영역 -->					  		
						  	</tbody>
						</table>
					</div>
					
					<div  id="emplPagingArea" class="d-flex justify-content-center">
					
					</div>
					
				</div>
			</div>
			
			
			<div class="card">
				<div id="ccpyArea" class="card-body">
					<h4 class="card-title mb-3">미발급 협력업체</h4>
					<div class="text-end">
						<button id="ccpyAutoIdProcessBtn" type="button" class="btn btn-primary mb-2" onclick="ccpyProcess()">발급</button>
					</div>
					<div class="table-responsive mb-4 border rounded-1">
						<table id="ccpyListTable" class="table text-nowrap mb-0 align-middle">
	  						<thead class="text-dark fs-4">
						    	<tr>
						        	<th>
						            	<input id="checkAllCcpy" class="form-check-input" type="checkbox" value="" >
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">업체명</h6>
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">업체 전화번호</h6>
						          	</th>
						          	<th>
						            	<h6 class="fs-4 fw-semibold mb-0">담당자</h6>
						          	</th>
						      	</tr>
						    </thead>
						  	<tbody id="ccpyDataArea">
								<!-- 데이터 테이블 영역 -->					  		
						  	</tbody>
						</table>
					</div>	
					
					
					<div  id="ccpyPagingArea" class="d-flex justify-content-center">
					
					</div>
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
$(function(){
    // 초기 로딩: 각 목록의 1페이지 호출
    loadEmployeeList(1);
    loadCcpyList(1);
    
    $("#emplArea").on("click", ".page-link", function(e) {
        e.preventDefault();
        let page = $(this).data("page");
        loadEmployeeList(page);
    });
    
    $("#ccpyArea").on("click", ".page-link", function(e) {
        e.preventDefault();
        let page = $(this).data("page");
        loadCcpyList(page);
    });
    
    // 사원 테이블 전체 선택/해제
    $(document).on("change", "#checkAllEmpl", function(){
        var isChecked = $(this).prop("checked");
        $("#emplListTable tbody input[type='checkbox']").prop("checked", isChecked);
    });

    // 협력업체 테이블 전체 선택/해제
    $(document).on("change", "#checkAllCcpy", function(){
        var isChecked = $(this).prop("checked");
        $("#ccpyListTable tbody input[type='checkbox']").prop("checked", isChecked);
    });
});

function loadEmployeeList(currentPage) {
	   $.ajax({
	        url: "/batirplan/servicem/acntm/empllist.do",
	        type: "get",
	        dataType: "json",
	        data: { currentPage: currentPage },
	        success: function(res) {
        		var emplDataHTML = "";
	        	if(res.empList.length == 0){
	        		emplDataHTML += "<tr><td class='text-center' colSpan='4'>조회된 데이터가 없습니다.</td></tr>"
	        	} else {
		            $.each(res.empList, function(i, empl) {
		                var deptName = "";
		                switch(empl.deptCode) {
		                    case "01": 
		                        deptName = "경영지원"; 
		                        break;
		                    case "02": 
		                        deptName = "건축기획"; 
		                        break;
		                    case "03": 
		                        deptName = "재무"; 
		                        break;
		                    case "04": 
		                        deptName = "자원"; 
		                        break;
		                    case "05": 
		                        deptName = "IT"; 
		                        break;
		                    default: 
		                        deptName = "기타";
		                }
		                var clsfName = "";
		                switch(empl.clsfCode) {
		                    case "01": 
		                        clsfName = "사원"; 
		                        break;
		                    case "02": 
		                        clsfName = "대리"; 
		                        break;
		                    case "03": 
		                        clsfName = "과장"; 
		                        break;
		                    case "04": 
		                        clsfName = "차장"; 
		                        break;
		                    case "05": 
		                        clsfName = "부장"; 
		                        break;
		                    default: 
		                        clsfName = "기타";
		                }
		                emplDataHTML += 
		                	"<tr data-emplcode='" + empl.emplCode + "'>" +
	                               "<td><input class='form-check-input' type='checkbox'/></td>" +
	                               "<td class='title-column'><h6 class='fw-normal'>" + empl.emplNm + "(" + empl.emplCode + ")</h6></td>" +
	                               "<td>" + deptName + " - " + clsfName + "</td>" +
	                               "<td>" + empl.encpn + "</td>" +
	                         "</tr>";
		            });
	        	}
	            // 사원 목록 및 페이징 영역 갱신
	            $("#emplDataArea").html(emplDataHTML);
	            $("#emplPagingArea").html(res.pagingHTML);
	        },
	        error: function(e) {
	            Swal.fire({
	                icon: "error",
	                title: "오류 발생!",
	                text: "시스템 에러 발생, IT팀에 문의하세요!",
	                confirmButtonText: "확인"
	            });
	        }
	    });
}

// 미발급 협력업체 목록 호출 함수
function loadCcpyList(currentPage) {
    $.ajax({
        url: "/batirplan/servicem/acntm/ccpylist.do",
        type: "get",
        dataType: "json",
        data: { currentPage: currentPage },
        success: function(res) {
            var ccpyDataHTML = "";
        	if(res.ccpyList.length == 0){
        		ccpyDataHTML += "<tr><td class='text-center' colSpan='4'>조회된 데이터가 없습니다.</td></tr>"
        	} else{
	            $.each(res.ccpyList, function(i, ccpy) {
	                ccpyDataHTML += "<tr data-ccpycode='" + ccpy.ccpyCode + "'>" +
	                                    "<td><input class='form-check-input' type='checkbox'/></td>" +
	                                    "<td class='title-column'><h6 class='fw-normal'>" + ccpy.ccpyNm + "(" + ccpy.ccpyCode + ")</h6></td>" +
	                                    "<td>" + ccpy.ccpyTelno + "</td>" +
	                                    "<td>" + ccpy.chargerNm + "(" + ccpy.charger + ")</td>" +
	                                "</tr>";
	            });
        	}
            // 협력업체 목록 및 페이징 영역 갱신
            $("#ccpyDataArea").html(ccpyDataHTML);
            $("#ccpyPagingArea").html(res.pagingHTML);
        },
        error: function(e) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "시스템 에러 발생, IT팀에 문의하세요!",
                confirmButtonText: "확인"
            });
        }
    });
}

function emplProcess(){
    var selectedEmpCodes = [];
    // #emplArea 내의 모든 체크된 체크박스를 순회
    $("#emplArea input[type='checkbox']:checked").each(function(){
        // 가장 가까운 tr에서 data-emplCode 값을 가져옴
        var empCode = $(this).closest("tr").data("emplcode");
        
        if(empCode != null){
	        selectedEmpCodes.push(empCode);
        }
    });
    
    // JSON 문자열로 변환 후 콘솔에 출력
    console.log("선택된 사원 코드:", JSON.stringify(selectedEmpCodes));
    
    $.ajax({
        url: "/batirplan/servicem/acntm/emplidporcess.do",
        type: "post",
        data: JSON.stringify(selectedEmpCodes),
        dataType: "json",
        contentType: "application/json",
        success: function(res){
            Swal.fire({
                icon: "success",
                title: "발급 완료!",
                text: res + "건이 성공적으로 발급되었습니다.",
                confirmButtonText: "확인"
            }).then(() => {
                loadEmployeeList(1);
            });
        },
        error: function(e){
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "시스템 에러 발생, IT팀에 문의하세요!",
                confirmButtonText: "확인"
            });
            console.log(e);
        }
    });
}

function ccpyProcess(){
    var selectedCcpyCodes = [];
    // #ccpyArea 내의 모든 체크된 체크박스를 순회
    $("#ccpyArea input[type='checkbox']:checked").each(function(){
        // 가장 가까운 tr에서 data-emplCode 값을 가져옴
        var ccpyCode = $(this).closest("tr").data("ccpycode");
        
        if(ccpyCode != null){
        	selectedCcpyCodes.push(ccpyCode);
        }
    });
    
    // JSON 문자열로 변환 후 콘솔에 출력
    console.log("선택된 업체 코드:", JSON.stringify(selectedCcpyCodes));
    
    $.ajax({
        url: "/batirplan/servicem/acntm/ccpyidporcess.do",
        type: "post",
        data: JSON.stringify(selectedCcpyCodes),
        dataType: "json",
        contentType: "application/json",
        success: function(res){
            Swal.fire({
                icon: "success",
                title: "발급 완료!",
                text: res + "건이 성공적으로 발급되었습니다.",
                confirmButtonText: "확인"
            }).then(() => {
                loadCcpyList(1);
            });
        },
        error: function(e){
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "시스템 에러 발생, IT팀에 문의하세요!",
                confirmButtonText: "확인"
            });
            console.log(e);
        }
    });
}
</script>

</html>