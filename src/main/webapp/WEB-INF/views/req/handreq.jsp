<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/dropzone/dist/min/dropzone.min.css">
<style>
.dz-error-mark {
  display: none !important;
}
.dz-error-message  {
  display: none !important;
}
.dz-remove  {
  margin-top: 5px;
}

#myTable td {
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
				
		        <!-- 컨텐츠 영역 제목 -->		  
			    <div class="card card-body py-3">
			  	<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">🛒 발주
		  	  		 </h4>
			    	</div>
			    </div>
				
		  		<!-- 상단 탭으로 구분되는 Content영역  -->
				<div class="card">
					<div class="card-body">
					  <ul class="nav nav-underline" id="myTab" role="tablist">
						  <li class="nav-item" role="presentation">
						    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
						      <span>업체별 발주</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
						      <span>일괄 발주</span>
						    </a>
						  </li>
					  </ul>
		    		  <div class="tab-content tabcontent-border p-3" id="myTabContent">
		      		  <!-- 첫번째 탭 컨텐츠 영역 -->
		      		  <div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
		      			
						<!-- 폼 시작-->
                        <form id="requestForm">
                            <div class="outer-repeater">
                            	<div class="d-flex justify-content-end">
                            		<button type="button" class="btn mb-1  d-inline-flex align-items-center justify-content-center p-0" data-repeater-create>
				                      협력 업체 추가
				                      <i class="fs-5 ti ti-circle-plus ms-2"></i>
				                    </button>
                            	</div>
                                <div data-repeater-list="requests">
                                    <div data-repeater-item class="mb-4">
                                    	
                                        <div class="row mb-3">
                                            <div class="col-md-6 d-flex align-items-center gap-2">
                                                <label class="form-label mb-0">협력업체</label>
                                                <span class="suplrName text-primary fw-bold"></span>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-md-3">
                                                <input type="text" class="form-control form-control-sm suplrCode" name="suplrCode" readonly>
                                            </div>
                                            <div class="col-md-3">
                                                <button type="button" class="btn btn-primary btn-sm select-supplier">
                                                	<i class="fs-5 ti ti-search"></i>
                                                	검색
                                               	</button>
                                            </div>
                                            <div class="col-md-6 d-flex justify-content-end gap-2">
                                                <button type="button" class="btn btn-danger btn-sm d-flex justify-content-end" data-repeater-delete>
                                                	협력업체 삭제
                                                	<i class="fs-5 ti ti-circle-minus ms-2"></i>
                                               	</button>
                                            </div>
                                        </div>
                                        <hr/>

                                        <div class="product-list">
                                        
<div class="row mb-2">
    <div class="col-md-2">
        <label class="form-label">품목</label>
        <select name="prdlstNo" class="form-control form-control-sm prdlstNo" disabled>
            <option value="">협력업체 선택 후 활성화</option>
        </select>
    </div>
    <div class="col-md-2">
        <label class="form-label">요청 수량</label>
        <input type="number" name="reqQty" class="form-control form-control-sm reqQty" min="1" value="1">
    </div>
    <div class="col-md-2">
        <label class="form-label">단가</label>
        <input type="text" name="unitPrice" class="form-control form-control-sm unitPrice" readonly>
    </div>
    <div class="col-md-2">
        <label class="form-label">합계 금액</label>
        <input type="text" name="totalPrice" class="form-control form-control-sm totalPrice" readonly>
    </div>
    <div class="col-md-2 d-flex justify-content-center align-items-center">
        <button type="button" class="btn btn-danger btn-sm remove-product">
            <i class="fs-5 ti ti-circle-minus"></i>
        </button>
    </div>
    <div class="col-md-2 d-flex justify-content-center align-items-center">
        <button type="button" class="btn btn-success btn-sm add-product">
            <i class="fs-5 ti ti-circle-plus"></i>
        </button>
    </div>
</div>

                                        </div>
                                    </div>
                                </div>
                            </div>
				      	  <hr/>
                        </form>
						
						<!--  -->
						<div id="grandTotalDisplay" style="position: fixed; bottom: 20px; right: 20px; background: #fff; border: 1px solid #ccc; padding: 10px; box-shadow: 2px 2px 6px rgba(0,0,0,0.2);">
  총 합계: <span id="grandTotal">0.00</span>
</div>
						
						<!--  -->
						
						
						<button type="button" class="btn btn-primary" id="submitReq">발주</button>
	      	  <!-- 폼 끝-->
		      </div>
		      
		      <!-- 두번쩨 탭 컨텐츠 영역  -->
		      <div class="tab-pane fade" id="profile5" role="tabpanel" aria-labelledby="profile-tab">
		      
		      

<form action="/batirplan/resrce/req/excelupload" 
      class="dropzone" 
      id="excelDropzone"
      method="POST"
      enctype="multipart/form-data">
  <div class="dz-default dz-message">
    <span>엑셀 파일을 드래그하거나 클릭하여 업로드</span>
  </div>
</form>
				<div id="afterUploadText" style="display:none;">
					<h4  class="card-title mt-3">업로드 결과</h4>
					<hr/>
					<div id="uploadedArea">
					
					</div>
  <div class="d-flex justify-content-end">
    <!-- ▼ 새로 추가한 초기화 버튼 -->
    <button type="button" id="resetDropzoneBtn" class="btn btn-secondary me-2">
      초기화
    </button>
    <!-- 기존 발주 버튼 -->
    <button type="button" id="submiExcelReq" class="btn btn-success" style="display:none;">
      발주
    </button>
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


<!-- 협력 업체 찾기 모달 -->
<div id="ccpyModal" class="modal fade" tabindex="-1" aria-labelledby="ccpyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
    <div class="modal-content">

      <!-- 모달 헤더: 제목 왼쪽, 검색창+닫기 버튼 오른쪽 -->
      <div class="modal-header d-flex align-items-center justify-content-between">
        <h4 class="modal-title" id="ccpyModalLabel">협력업체 검색</h4>
        <!-- 검색 영역 -->
        <div class="d-flex gap-2">
          <select name="searchType" class="form-select form-select-sm">
            <option value="all">--미선택--</option>
            <option value="ccpyNm">업체명</option>
            <option value="ccpyCode">협력업체 코드</option>
          </select>
          <input type="text" class="form-control form-control-sm" id="searchWord" name="searchWord" />
          <button type="button" class="btn btn-primary btn-sm" id="ccpySearchBtn" onclick="ccpySearch()">검색</button>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
      </div>

      <!-- 모달 바디: 검색 결과 + 페이지네이션 -->
      <div class="modal-body">
        <div id="ccpyResultContainer"></div>
        <div id="ccpyPagination" class="mt-3 d-flex justify-content-center"></div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn bg-danger-subtle text-danger" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 협력 업체 찾기 모달 끝 -->    
<%@include file="../module/footerScript.jsp" %>

<script src="${pageContext.request.contextPath }/assets/libs/jquery.repeater/jquery.repeater.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/repeater-init.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/dropzone/dist/min/dropzone.min.js"></script>

</body>
<script type="text/javascript">
/* 첫번째 탭 */
$(function(){
    // 협력업체별 품목 데이터를 캐시
    let supplierProductCache = {};

	// 바깥쪽 RepeaterForm 리피터 활용(협력업체 단위)
    $('.outer-repeater').repeater({
        initEmpty: false,
        defaultValues: {},
        show: function () {
            $(this).slideDown();
        },
        hide: function (deleteElement) {
            $(this).slideUp(deleteElement);
        }
    });

	// 품목에서 '+' 버튼 클릭
	$(document).on("click", ".add-product", function () {
	    let supplierSection = $(this).closest("[data-repeater-item]");
	    let ccpyCode = supplierSection.find(".suplrCode").val();
	
	    let productHtml = `
	        <div class="row mb-2">
	            <div class="col-md-2">
	                <select name="prdlstNo" class="form-control form-control-sm prdlstNo">
	                    <option value="">품목 선택</option>
	                </select>
	            </div>
	            <div class="col-md-2">
	                <input type="number" name="reqQty" class="form-control form-control-sm reqQty" min="1" value="1">
	            </div>
	            <div class="col-md-2">
	                <input type="text" name="unitPrice" class="form-control form-control-sm unitPrice" readonly>
	            </div>
	            <div class="col-md-2">
	                <input type="text" name="totalPrice" class="form-control form-control-sm totalPrice" readonly>
	            </div>
	            <div class="col-md-2 d-flex justify-content-center align-items-center">
	                <button type="button" class="btn btn-danger btn-sm remove-product">
	                    <i class="fs-5 ti ti-circle-minus"></i>
	                </button>
	            </div>
	            <div class="col-md-2 d-flex justify-content-center align-items-center">
	                <button type="button" class="btn btn-success btn-sm add-product">
	                    <i class="fs-5 ti ti-circle-plus"></i>
	                </button>
	            </div>
	        </div>
	    `;
	
	    let newRow = $(productHtml);
	    supplierSection.find(".product-list").append(newRow);
	
	    // 🔹 기존 품목 리스트 유지 (AJAX 재요청 X, 캐시 사용)
	    if (supplierProductCache[ccpyCode]) {
	        updatePrdlstSelectBox(supplierProductCache[ccpyCode], newRow);
	    }
	});


    // 품목 삭제 버튼 클릭 시
    $(document).on("click", ".remove-product", function () {
        $(this).closest(".row").remove();
    });

 	// 협력업체 검색 버튼 클릭 시
    let selectedSupplierSection = null;
    $(document).on("click", ".select-supplier", function () {
        selectedSupplierSection = $(this).closest("[data-repeater-item]");
        openSelectCcpyModal();
    });

    // 모달에서 업체 선택 시, 해당 협력업체 섹션에 값 반영
    $(document).on("click", ".ccpy-row", function () {
        if (!selectedSupplierSection) return;

        let ccpyCode = $(this).data("ccpy-code");
        let ccpyName = $(this).find("td:nth-child(2)").text();

        selectedSupplierSection.find(".suplrCode").val(ccpyCode);
        selectedSupplierSection.find(".suplrName").text(ccpyName);

        // 협력업체 선택 시 품목 리스트 가져오기
        getPrdlstByCcpyCode(ccpyCode, selectedSupplierSection);

        let modalEl = document.getElementById("ccpyModal");
        let modalInstance = bootstrap.Modal.getInstance(modalEl);
        modalInstance.hide();
    });

    // 품목 선택 시 단가 자동 입력
    $(document).on("change", ".prdlstNo", function () {
        let selectedOption = $(this).find(":selected");
        let unitPrice = selectedOption.data("unit-price") || 0; 

        let row = $(this).closest(".row");
        row.find(".unitPrice").val(unitPrice);
        updateTotalPrice(row);
    });

    // 요청 수량 입력 시 총 금액 자동 계산
    $(document).on("input", ".reqQty", function () {
        let row = $(this).closest(".row");
        updateTotalPrice(row);
    });
    
    /* 협력 업체 찾기 모달 여는 함수  */
    function openSelectCcpyModal() {
      let ccpyModal = new bootstrap.Modal(document.getElementById('ccpyModal'));
      getCcpyList(1, "", "");  // 초기 전체조회
      ccpyModal.show();
    }

    /* 협력 업체 찾기 보내기 */
    function ccpySearch() {
      let sWord = $("#searchWord").val();
      let sType = $("#searchType").val();
      getCcpyList(1, sWord, sType);
    }

    /* 협력 업체 리스트 가져오기 */
    function getCcpyList(page, searchWord, searchType){
      console.log(page, searchWord, searchType);
      $.ajax({
        url: "/batirplan/resrce/prdlst/getcccpylist",
        type: "GET",
        data: { page: page, searchWord: searchWord, searchType: searchType },
        dataType: "json",
        success: function(res){
          console.log(res);
          if(res.dataList !== null){
            console.log("데이터 있음!");
            renderCcpyTable(res.res.dataList);
          } else {
            $("#ccpyResultContainer").html("<p class='text-center my-3'>검색 결과가 없습니다.</p>");
          }
          $("#ccpyPagination").html(res.paging);
        },
        error: function(err){
            console.log(err);
            Swal.fire({
                icon: "error",
                title: "오류 발생",
                text: "협력업체 목록 조회 중 오류가 발생했습니다.",
                confirmButtonText: "확인"
            });
        }
      });
    }

    

    // 협력 업체 페이지 번호 클릭 시
    $(document).on("click", "#ccpyPagination .page-link", function(e){
      e.preventDefault();
      let goPage = $(this).data("page");
      let sWord = $("#searchWord").val();
      let sType = $("#searchType").val();
      getCcpyList(goPage, sWord, sType);
    });

    // 테이블 row 클릭 이벤트 (협력업체 선택)
    $(document).on("click", ".ccpy-row", function() {
        let ccpyCode = $(this).data("ccpy-code");  // 협력업체 코드
        let ccpyName = $(this).find("td:nth-child(2)").text();  // 협력업체명 (2번째 컬럼)

        $("#suplrCode").val(ccpyCode);  // 협력업체 코드 입력 필드에 저장
        $("#suplrName").text(ccpyName); // 협력업체명 표시 영역 업데이트

        let modalEl = document.getElementById('ccpyModal');
        let modalInstance = bootstrap.Modal.getInstance(modalEl);
        modalInstance.hide();
    });

    // 협력업체 선택 후 품목 리스트 가져오기 (AJAX)
    function getPrdlstByCcpyCode(ccpyCode, supplierSection) {
    	
        // 이미 캐시에 있으면 바로 사용
        if (supplierProductCache[ccpyCode]) {
            updatePrdlstSelectBox(supplierProductCache[ccpyCode], supplierSection);
            return;
        }

        $.ajax({
            url: "/batirplan/resrce/req/getprdlstbyccpycode",
            type: "GET",
            data: { ccpyCode: ccpyCode },
            dataType: "json",
            success: function (res) {
                supplierProductCache[ccpyCode] = res; // 🔹 데이터 캐싱
                updatePrdlstSelectBox(res, supplierSection);
            },
            error: function () {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "품목 정보를 가져오는 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    }


    // 품목 리스트를 셀렉트 박스에 추가
    function updatePrdlstSelectBox(prdlstList, supplierSection) {
        let selectBoxes = supplierSection.find(".prdlstNo");

        selectBoxes.each(function () {
            let selectBox = $(this);
            selectBox.empty().append(`<option value="">품목 선택</option>`);

            prdlstList.forEach((item) => {
                selectBox.append(
                    `<option value="` + item.prdlstNo + `" data-unit-price="` + item.prdlstPrice + `">` + item.prdlstNm + `</option>`
                );
            });

            selectBox.prop("disabled", false);
        });
    }

    // 요청 수량 및 단가를 기준으로 총 금액 계산
function updateTotalPrice(row) {
    let qty = parseInt(row.find(".reqQty").val()) || 0;
    let unitPrice = parseFloat(row.find(".unitPrice").val()) || 0;
    let totalPrice = qty * unitPrice;
    row.find(".totalPrice").val(totalPrice.toFixed(2));
    updateGrandTotal(); // 행 변경 시 전체 합계 업데이트
}

    
    
    $("#submitReq").on("click", function(e) {
        e.preventDefault(); // 기본 폼 제출 막기

        var finalData = []; // 최종 보낼 배열

        // 모든 협력업체(outer repeater)
        $(".outer-repeater [data-repeater-item]").each(function() {
            var suplrCode = $(this).find(".suplrCode").val();
            if (!suplrCode) return; // 협력업체 코드가 없으면 스킵

            var details = [];
            // 품목 목록
            $(this).find(".product-list .row").each(function() {
                var prdlstNo = $(this).find(".prdlstNo").val();
                var reqQty = parseInt($(this).find(".reqQty").val()) || 0;
                var unitPrice = parseFloat($(this).find(".unitPrice").val()) || 0;
                var totalPrice = parseFloat($(this).find(".totalPrice").val()) || 0;

                if (prdlstNo) {
                    details.push({
                        prdlstNo: prdlstNo,
                        reqQty: reqQty,
                        unitPrice: unitPrice,
                        totalPrice: totalPrice
                    });
                }
            });

            if (details.length > 0) {
                finalData.push({
                    suplrCode: suplrCode,
                    details: details
                });
            }
        });

        if (finalData.length === 0) {
            Swal.fire({
                icon: "warning",
                title: "발주 내용 없음",
                text: "발주할 내용이 없습니다.",
                confirmButtonText: "확인"
            });
            return;
        }

        console.log("보낼 데이터:", JSON.stringify(finalData));

        // Controller로 전송 (Ajax)
        $.ajax({
            url: "/batirplan/resrce/req/handreq/reqregister", // 실제 컨트롤러 URL
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(finalData),
            success: function(res) {
                Swal.fire({
                    icon: "success",
                    title: "발주 요청 완료",
                    text: "발주 요청 " + res + "건이 성공적으로 전송되었습니다.",
                    confirmButtonText: "확인"
                });
                console.log(res);
            },
            error: function(err) {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "발주 요청 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
                console.log(err);
            }
        });
    });
    
})

    /* 협력 업체 찾기 보내기 */
    function ccpySearch() {
      let sWord = $("#searchWord").val();
      let sType = $("#searchType").val();
      getCcpyList(1, sWord, sType);
    }
/* 협력 업체 리스트 가져오기 */
function getCcpyList(page, searchWord, searchType){
  console.log(page, searchWord, searchType);
  $.ajax({
    url: "/batirplan/resrce/prdlst/getcccpylist",
    type: "GET",
    data: { page: page, searchWord: searchWord, searchType: searchType },
    dataType: "json",
    success: function(res){
      console.log(res);
      if(res.dataList !== null){
        console.log("데이터 있음!");
        renderCcpyTable(res.res.dataList);
      } else {
        $("#ccpyResultContainer").html("<p class='text-center my-3'>검색 결과가 없습니다.</p>");
      }
      $("#ccpyPagination").html(res.paging);
    },
    error: function(err){
        console.log(err);
        Swal.fire({
            icon: "error",
            title: "오류 발생",
            text: "협력업체 목록 조회 중 오류가 발생했습니다.",
            confirmButtonText: "확인"
        });
    }
  });
}
//데이터를 테이블 내용을 그리는 함수
function renderCcpyTable(dataList) {
	  var html =
	    "<table class='table border rounded-1' id='myTable'>" +
	    "<thead>" +
	    "<tr>" +
	    "<th>업체코드</th>" +
	    "<th>업체명</th>" +
	    "<th>연락처</th>" +
	    "<th>이메일</th>" +
	    "<th>주소</th>" +
	    "</tr>" +
	    "</thead>" +
	    "<tbody>";

	  $.each(dataList, function(i, item) {
	    html +=
	      "<tr class='ccpy-row' data-ccpy-code='" + item.ccpyCode + "'>" +
	      "<td>" + item.ccpyCode + "</td>" +
	      "<td>" + item.ccpyNm + "</td>" +
	      "<td>" + (item.ccpyTelno || "") + "</td>" +
	      "<td>" + (item.ccpyEmail || "") + "</td>" +
	      "<td>" + (item.ccpyAdres || "") + " " + (item.ccpyDetailAdres || "") + "</td>" +
	      "</tr>";
	  });

	  html += "</tbody></table>";
	  $("#ccpyResultContainer").html(html);
}
</script>
<script type="text/javascript">
/* 두번째 탭 */
Dropzone.options.excelDropzone = {
  paramName: "excelFile",
  maxFiles: 1,
  acceptedFiles: ".xls,.xlsx",
  autoProcessQueue: true,
  init: function() {
    var myDropzone = this;

    // 업로드 성공 시
    this.on("success", function(file, res) {
	    Swal.fire({
	        icon: "success",
	        title: "엑셀 업로드 성공",
	        text: "엑셀 파일이 성공적으로 업로드되었습니다.",
	        confirmButtonText: "확인"
	    });
	    console.log("서버 응답:", res);
	
	    // JSON 파싱 및 렌더링 (협력업체 코드별 그룹핑)
	    let dataList = res;
	    renderExcelData(groupExcelData(dataList));
	});

    // 업로드 실패 시
    this.on("error", function(file, message) {
	    Swal.fire({
	        icon: "error",
	        title: "업로드 오류",
	        text: "엑셀 업로드 중 오류가 발생했습니다.",
	        confirmButtonText: "확인"
	    });
	    console.log("오류 메시지:", message);
	});

    // ▼ 초기화 버튼 이벤트
    $("#resetDropzoneBtn").on("click", function() {
        // 1) Dropzone 파일 모두 제거
        myDropzone.removeAllFiles(true);

        // 2) 화면 영역 초기화
        $("#afterUploadText").hide();
        $("#uploadedArea").empty();
        $("#submiExcelReq").hide();

        Swal.fire({
            icon: "success",
            title: "초기화 완료",
            text: "업로드 결과가 초기화되었습니다.",
            confirmButtonText: "확인"
        });
    });
  }
};


function groupExcelData(dataList) {
  // 1) 업체코드별로 묶기 (Map)
  let grouped = {};
  dataList.forEach(item => {
    let ccpyCode = item["협력 업체 코드"];
    if (!grouped[ccpyCode]) {
      grouped[ccpyCode] = [];
    }
    let qty = parseInt(item["수량"]) || 0;
    let price = parseInt(item["단가"]) || 0;
    grouped[ccpyCode].push({
      prdlstNo: item["품목 번호"] || "",
      reqQty: qty,
      unitPrice: price,
      totalPrice: qty * price
    });
  });

  // 2) grouped -> List<ReqVO>
  let result = [];
  for (let ccpyCode in grouped) {
    result.push({
      suplrCode: ccpyCode,
      details: grouped[ccpyCode]
    });
  }
  return result;
}

// 엑셀 파일 업로드시 렌더링
function renderExcelData(reqVoList) {
  $("#afterUploadText").show();
  $("#submiExcelReq").show();

  let html = "";
  reqVoList.forEach(reqVO => {
    html += `<h5>협력업체 코드: \${reqVO.suplrCode}</h5>`;
    html += `<table class="table table-bordered">
              <thead>
                <tr><th>품목번호</th><th>수량</th><th>단가</th><th>합계금액</th></tr>
              </thead><tbody>`;

    reqVO.details.forEach(det => {
      html += `<tr>
        <td>\${det.prdlstNo}</td>
        <td>\${det.reqQty}</td>
        <td>\${det.unitPrice}</td>
        <td>\${det.totalPrice}</td>
      </tr>`;
    });
    html += `</tbody></table><hr/>`;
  });

  $("#uploadedArea").html(html);

  // 전역변수나 클로저로 저장해서, "발주" 버튼 클릭 시 사용
  window.excelReqData = reqVoList;
}

$("#submiExcelReq").on("click", function() {
	if (!window.excelReqData || window.excelReqData.length === 0) {
	    Swal.fire({
	        icon: "warning",
	        title: "엑셀 데이터 없음",
	        text: "업로드된 엑셀 데이터가 없습니다.",
	        confirmButtonText: "확인"
	    });
	    return;
	}

	  // 1) @RequestBody List<ReqVO>로 받을 예정이므로 JSON.stringify()
	  let jsonData = JSON.stringify(window.excelReqData);

	  $.ajax({
	    url: "/batirplan/resrce/req/handreq/reqregister", 
	    type: "POST",
	    contentType: "application/json",
	    data: jsonData,
	    success: function(res) {
	        Swal.fire({
	            icon: "success",
	            title: "발주 요청 완료",
	            text: "발주 요청 " + res + "건이 성공적으로 전송되었습니다.",
	            confirmButtonText: "확인"
	        });
	        console.log(res);
	    },
	    error: function(err) {
	        Swal.fire({
	            icon: "error",
	            title: "오류 발생",
	            text: "발주 요청 중 오류가 발생했습니다.",
	            confirmButtonText: "확인"
	        });
	        console.log(err);
	    }
	  });
	});
	
	
	function updateGrandTotal(){
	    let total = 0;
	    $(".totalPrice").each(function(){
	        let value = parseFloat($(this).val()) || 0;
	        total += value;
	    });
	    $("#grandTotal").text(total.toFixed(2));
	}

</script>


</html>