<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">

<style>
#prjtAllTable td {
  color: black !important;
}
#myPrjtAllTable td {
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
		  	  		<h4 class="mb-4 mb-sm-0 card-title">프로젝트 관리</h4>
			    	</div>
			    </div>
				
				<div class="card">
	 	 			<div class="px-4 py-3 border-bottom d-flex justify-content-between align-items-center">
	              		<h4 class="card-title mb-0">🔍 검색</h4>
	              		<div class="mt-2">
		              		<i class="ti ti-alert-circle fs-5"></i> 검색 결과는 전체 조회만 반영됩니다.
	              		</div>
	           		</div>
					<div class="card-body">
						<form id="searchForm">
							<div class="row mb-3">
								<div class="col-md-4">
									<label class="form-label">프로젝트명</label>
									<input type="text" class="form-control form-control-sm d-flex align-items-center" name="prjctNm" id="prjctNm" />
								</div>
								<div class="col-md-4">
									<label class="form-label">담당자명</label>
									<input type="text" class="form-control form-control-sm" name="chargerNm" id="chargerNm" />
								</div>
								<div class="col-md-4">
			                		<label class="form-label" for="hffcSttus">진행 상태</label>
			                		<div class="d-flex align-items-center justify-content-start gap-3 ">
			                			<div>
			                				<input class="form-check-input" type="radio" id="prjctProgrsSttus" name="prjctProgrsSttus" value="02"> 진행중
			                			</div>
			                			<div>
					        				<input class="form-check-input" type="radio" id="prjctProgrsSttus" name="prjctProgrsSttus" value="03"> 완공
					        			</div>
			                		</div>
			                	</div>
							</div>
						</form>
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
					</div>
				</div>
				
				<div class="card">
					<div class="px-4 py-3 border-bottom">
						<h4 class="card-title mb-0">진행중인 프로젝트</h4>
					</div>
					<div class="card-body">
					  <ul class="nav nav-underline" id="myTab" role="tablist">
						  <li class="nav-item" role="presentation">
						    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
						      <span>전체</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
						      <span>내 프로젝트</span>
						    </a>
						  </li>
					  </ul>	
  		    		  <div class="tab-content tabcontent-border p-3" id="myTabContent">
  		    		  
  		    		  
   		  			  	<div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
   		  			  		<!-- 전체 & 검색 프로젝트 #계획중은 제외# -->
   		  			  		<div class="table-responsive mb-4 rounded-1">
   		  			  			<table id="prjtAllTable" class="table text-nowrap mb-0 align-middle" style="width: 100%;"> 
							        <thead class="text-dark fs-4">
							            <tr>
							            	<th>
							                    <h6 class="fs-4 fw-semibold mb-0" >프로젝트 이름</h6>
						            		</th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0" >카테고리</h6>
							                </th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0">담당자</h6>
							                </th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0">🕗 일정(시작~종료)</h6>
							                </th>
							            </tr>
							        </thead>
							        <tbody id="prjtAllList">
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
  		    		  		<!-- 내 프로젝트 -->
   		  			  		<div class="table-responsive mb-4 rounded-1">
   		  			  			<table id="myPrjtAllTable" class="table text-nowrap mb-0 align-middle" style="width: 100%;">
							        <thead class="text-dark fs-4">
							            <tr>
							            	<th>
							                    <h6 class="fs-4 fw-semibold mb-0" >프로젝트 이름</h6>
						            		</th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0" >카테고리</h6>
							                </th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0">담당자</h6>
							                </th>
							                <th>
							                    <h6 class="fs-4 fw-semibold mb-0">🕗 일정(시작~종료)</h6>
							                </th>
							            </tr>
							        </thead>
							        <tbody id="myPrjtAllList">
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

<script type="text/javascript">
$(function(){
	
	$.fn.dataTable.ext.errMode = 'none';
	
	prjtAllTable = $("#prjtAllTable").DataTable({
        paging: false,
        searching: false,
        info: false,
        ordering: true,
        language: {
            emptyTable: "내 프로젝트가 없습니다."
        }, 
        columnDefs: [
            { width: '40%', targets: 0 }, // 첫 번째 열
            { width: '20%', targets: 1 }, // 두 번째 열
            { width: '20%', targets: 2 },  // 세 번째 열
            { width: '20%', targets: 3 }  // 세 번째 열
        ]
    });
	
    myPrjtAllTable = $("#myPrjtAllTable").DataTable({
        paging: false,
        searching: false,
        info: false,
        ordering: true,
        language: {
            emptyTable: "내 프로젝트가 없습니다."
        }, 
        columnDefs: [
            { width: '40%', targets: 0 }, // 첫 번째 열
            { width: '20%', targets: 1 }, // 두 번째 열
            { width: '20%', targets: 2 },  // 세 번째 열
            { width: '20%', targets: 3 }  // 세 번째 열
        ]
    });
	
	getAllPrjtDataList(1); 
	getMyPrjtDataList(1);
	
	$("#searchFormSubmitBtn").on("click", function(){
		getAllPrjtDataList(1); // 첫 페이지부터 검색
    });
	

})

function getAllPrjtDataList(page){
	
    var paramObj = {
	    currentPage: page,
	    prjctNm: $("#prjctNm").val(),       // 프로젝트명
	    chargerNm: $("#chargerNm").val(),   // 담당자명 (이름 수정)
	    prjctProgrsSttus: $("input[name='prjctProgrsSttus']:checked").val()  // 진행상태
    };
	
    $.ajax({
        url: "/batirplan/project/projectmanage/list",  // 컨트롤러에 매핑된 URL (필요에 따라 변경)
        type: "POST",
        data: JSON.stringify(paramObj),
        dataType: "json",
        contentType: "application/json",
        success: function(res) {
            console.log("검색 결과:", res);
            prjtAllTable.clear();

            if (res.dataList && res.dataList.length > 0) {
                const rowData = [];
                $.each(res.dataList, function(index, item) {
                    const prjctNo = item.prjctNo || "";
                    const prjctNm = item.prjctNm || "";

                    const prjctNameLink = `<a href="/batirplan/project/projectmanage/detail?prjctNo=\${prjctNo}">\${prjctNm}</a>`;

                    rowData.push([
                        prjctNameLink,
                        item.prjctCtgry || "",
                        item.chargerNm || "",
                        (item.prjctBgnde || "") + " ~ " + (item.prjctEndde || "")
                    ]);
                });
                prjtAllTable.rows.add(rowData);
            }

            prjtAllTable.draw();         
			$("#pagingArea1").html(res.paging);
        },
        error: function(xhr, status, error) {
            console.error("에러 발생:", error);
        }
    });
}

function getMyPrjtDataList(page){
	
	$.ajax({
		url: "/batirplan/project/projectmanage/mylist",
		type: "get",
		data: { currentPage: page },
		dataType: "json",
		contentType: "application/json",
		success: function(res){
			console.log(res);
            myPrjtAllTable.clear();

            if (res.dataList && res.dataList.length > 0) {
                const rowData = [];
                $.each(res.dataList, function(index, item) {
                    const prjctNo = item.prjctNo || "";
                    const prjctNm = item.prjctNm || "";
                    const prjctNameLink = `<a href="/batirplan/project/projectmanage/detail?prjctNo=\${prjctNo}">\${prjctNm}</a>`;

                    rowData.push([
                        prjctNameLink,
                        item.prjctCtgry || "",
                        item.chargerNm || "",
                        (item.prjctBgnde || "") + " ~ " + (item.prjctEndde || "")
                    ]);
                });
                myPrjtAllTable.rows.add(rowData);
            }

            myPrjtAllTable.draw();
			$("#pagingArea2").html(res.paging);
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
    getAllPrjtDataList(page);
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
    getMyPrjtDataList(page);
});

$('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
    prjtAllTable.columns.adjust();
    myPrjtAllTable.columns.adjust();
});
</script>
</body>
</html>