<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->

<style>
th.no-sort:before,
th.no-sort:after {
	display: none !important;
}
.quantity-input::-webkit-outer-spin-button,
.quantity-input::-webkit-inner-spin-button {
	-webkit-appearance: none;
  	margin: 0;
}
.quantity-input {
	-moz-appearance: textfield;
}
.btn-danger {
	width: 100%;
	font-size: 15px;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">
  
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
		  				<h4 class="mb-4 mb-sm-0 card-title">신고서 작성</h4>
					</div>
			  	</div>
			  	
			  	<div class="card">
			  		<div class="card-body">
			  			<input type="hidden" id="prjctNo" value="${prjctNo}" />
			  			<!-- 신고서 제목 입력 -->
					    <div class="row mb-3 align-items-center">
					    	<div class="col-auto d-flex align-items-center">
					    		<h4 class="card-title">제목</h4>
						  	</div>
						  	<div class="col">
						    	<input type="text" class="form-control" id="dclrtSj" name="dclrtSj" placeholder="제목을 입력하세요">
						  	</div>
						</div>
					
					    <!-- 선택된 품목 영역 -->
					    <div class="row mb-3 align-items-center">
					    	<div class="col-auto">
					    		<h4 class="card-title mb-0">선택 품목</h4>
					  		</div>
						  	<div class="col text-end">
							  	<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" onclick="openSelectPrdlstModal()">
							  		품목 선택
							    </button>
						  	</div>
						</div>
						
						<div class="table-responsive mb-3 border rounded-1">
							<table class="table text-nowrap mb-0 align-middle" id="selectedItemsTable" style="table-layout: fixed; width: 100%;">
								<colgroup>
									<col style="width: 35%;">  <!-- 품목명 -->
							    	<col style="width: 15%;">  <!-- 단가 -->
							    	<col style="width: 25%;">  <!-- 수량 -->
							    	<col style="width: 15%;">  <!-- 총합 금액 -->
							    	<col style="width: 10%;">  <!-- 삭제 -->
							  	</colgroup>
							  	<thead class="text-dark fs-4" style="text-align: center;">
							  		<tr>
							  			<th>
							  				<h6 class="fs-4 fw-semibold mb-0">품목명</h6>
								  		</th>
							      		<th>
							      			<h6 class="fs-4 fw-semibold mb-0">단가</h6>
							      		</th>
							      		<th>
							      			<h6 class="fs-4 fw-semibold mb-0">수량</h6>
							      		</th>
							      		<th>
							      			<h6 class="fs-4 fw-semibold mb-0">금액</h6>
							      		</th>
							      		<th>
							      			<h6 class="fs-4 fw-semibold mb-0">삭제</h6>
							      		</th>
							    	</tr>
							  	</thead>
							  	<tbody style="text-align: center;">
					            	<!-- 여기에 선택된 품목 행이 추가됩니다. 예시 행 -->
					            </tbody>
				        	</table>
				      	</div>
					    
					    <!-- 신고서 제출 버튼 -->
					    <div class="row mb-3">
					    	<div class="col-auto">
					    		<button type="button" class="btn btn-primary" onclick="submitDeclaration()">
						      		신고서 제출
					      		</button>
					      		<button type="button" class="btn btn-info" onclick="goBack()">
						      		뒤로가기
					      		</button>
						  	</div>
						  	<div class="col text-end">
						  		<span id="totalAmount" class="fs-5 fw-semibold">총합 금액: 0</span>
						  	</div>
						</div>
			  		</div>
		  		</div>

		  		<!-- 작업 영역 End -->
	  		</div>
  		</div>
	</div>
</div>

<!-- 품목 찾기 모달 -->
<div id="prdlstModal" class="modal fade" tabindex="-1" aria-labelledby="prdlstModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center">
				<h4 class="modal-title" id="prdlstModalLabel">품목 검색</h4>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>

      		<!-- 모달 바디: 검색 + 결과 + 페이지네이션 -->
      		<div class="modal-body">
        		<!-- 검색 영역 -->
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
		
        			<div class="text-end mt-3 mb-3">
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

		        <!-- 결과 리스트 영역 (테이블 or div) -->
		        <div id="prdlstResultContainer">
        
        		</div>

		        <!-- 페이지네이션 영역 -->
		        <div id="prdlstPagination" class="mt-3 d-flex justify-content-center">
        
        		</div>
        	</div>
        	
      		<div class="modal-footer">
      			<button type="button" class="btn btn-primary" id="prdlstModalConfirmBtn">확인</button>
        		<button type="button" class="btn bg-danger-subtle text-danger" data-bs-dismiss="modal">닫기</button>
      		</div>
    	</div>
	</div>
</div>

<%@include file="../module/footerScript.jsp" %>

</body>

<script src="${pageContext.request.contextPath }/assets/libs/inputmask/dist/jquery.inputmask.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/mask.init.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/datatable/datatable-api.init.js"></script>
<script type="text/javascript">
let selectedItems = [];
let selectedItemsInModal = [];

// 검색 폼 관련 이벤트
$(function(){
    $("#searchFormSubmitBtn").on("click", function(){
        getTableData(1); // 첫 페이지부터 검색
    });
    
    $("#level1Select").on("change", function(){
        let selectedVal = $(this).val();
        if(!selectedVal) {
            $("#level2Select").empty().append("<option value=''>-- 중분류 선택 --</option>");
            $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
            return;
        }
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
    
    $("#level2Select").on("change", function(){
        let selectedVal = $(this).val();
        if(!selectedVal) {
            $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
            return;
        }
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
        document.getElementById("searchForm").reset();
        $("#level2Select").empty().append("<option value=''>-- 중분류 선택 --</option>");
        $("#ctgryNo").empty().append("<option value=''>-- 소분류 선택 --</option>");
        getTableData(1);
    });
});

// 품목 검색 결과 테이블 생성
function getTableData(page){
    var paramObj = {
        currentPage: page,
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

    $.ajax({
        url: "/batirplan/resrce/prdlst/data",
        type: "POST",
        contentType: "application/json; charset=utf-8", 
        data: JSON.stringify(paramObj),
        dataType: "json",
        success: function(res) {
            var tableHtml = '<table id="prdlstTable" class="table table-responsive mb-4 border rounded-1" style="table-layout: fixed; width: 100%;">';
            tableHtml += '<colgroup>';
            tableHtml += '<col style="width: 5%;">';    // 체크박스 열
            tableHtml += '<col style="width: 40%;">';   // 품목명
            tableHtml += '<col style="width: 21%;">';   // 담당 업체
            tableHtml += '<col style="width: 12%;">';   // 단가
            tableHtml += '<col style="width: 12%;">';   // 규격
            tableHtml += '<col style="width: 10%;">';   // 단위
            tableHtml += '</colgroup>';
            tableHtml += '  <thead>';
            tableHtml += '    <tr>';
            tableHtml += '      <th><input type="checkbox" id="checkAll"></th>';
            tableHtml += '      <th>품목명</th>';
            tableHtml += '      <th>담당 업체</th>';
            tableHtml += '      <th>단가</th>';
            tableHtml += '      <th>규격</th>';
            tableHtml += '      <th>단위</th>';
            tableHtml += '    </tr>';
            tableHtml += '  </thead>';
            tableHtml += '  <tbody>';
    
            for(var i = 0; i < res.dataList.length; i++){
                var item = res.dataList[i];
                tableHtml += '    <tr>';
                tableHtml += '      <td><input type="checkbox" name="prdlstCheck" value="' + item.prdlstNo + '"></td>';
                tableHtml += '      <td>' + (item.prdlstNm || '') + '</td>';
                tableHtml += '      <td>' + (item.ccpyNm || '') + '</td>';
                tableHtml += '      <td>' + (item.prdlstPrice || '') + '</td>';
                tableHtml += '      <td>' + (item.prdlstStndrd || '') + '</td>';
                tableHtml += '      <td>' + (item.prdlstUnit || '') + '</td>';
                tableHtml += '    </tr>';
            }
    
            tableHtml += '  </tbody>';
            tableHtml += '</table>';
    
            $("#prdlstResultContainer").html(tableHtml);
            
            if ($.fn.DataTable.isDataTable('#prdlstTable')) {
                $('#prdlstTable').DataTable().destroy();
            }
    
            $("#prdlstTable").DataTable({
                paging: false,
                searching: false,
                info: false,
                ordering: true,
                autoWidth: false,
                columnDefs: [
                    { orderable: false, targets: 0, className: 'no-sort' }
                ]
            });
    
            $("#prdlstPagination").html(res.paging);
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

$(document).on('change', '#checkAll', function() {
    var checked = $(this).prop('checked');
    $('#prdlstTable tbody input[name="prdlstCheck"]').prop('checked', checked).trigger('change');
});

$('#prdlstTable thead').on('change', '#checkAll', function() {
    var checked = $(this).prop('checked');
    $('#prdlstTable tbody input[name="prdlstCheck"]').each(function(){
        $(this).prop('checked', checked);
        $(this).trigger('change');
    });
});

//모달 열기
function openSelectPrdlstModal() {
    let prdlstModal = new bootstrap.Modal(document.getElementById('prdlstModal'));
    getTableData(1);
    prdlstModal.show();
}

$(document).on("click", "#prdlstPagination .page-link", function(e){
    e.preventDefault();
    var page = $(this).data("page");
    getTableData(page);
});

//품목 선택 시 체크박스 상태만 업데이트 (모달 내에서)
$(document).on('change', 'input[name="prdlstCheck"]', function() {
    var prdlstNo = $(this).val();
    var $row = $(this).closest('tr');
    var prdlstName = $row.find('td').eq(1).text().trim();
    var prdlstPriceText = $row.find('td').eq(3).text().trim();
    var prdlstPrice = parseFloat(prdlstPriceText.replace(/,/g, '')) || 0;

    // 모달에서만 사용할 배열에 선택 품목을 추가/제거
    if (this.checked) {
        // 이미 selectedItemsInModal에 추가된 품목인지 체크
        if (!selectedItemsInModal.find(item => item.prdlstNo === prdlstNo)) {
            selectedItemsInModal.push({ prdlstNo, prdlstName, prdlstPrice, prdlstQty: 1 }); // 기본 수량을 1로 설정
        }
    } else {
        // 체크 해제 시, 해당 품목을 selectedItemsInModal에서 제거
        selectedItemsInModal = selectedItemsInModal.filter(item => item.prdlstNo !== prdlstNo);
    }
});

//"확인" 버튼 클릭 시 모달 내에서 선택된 품목을 페이지에 추가
$("#prdlstModalConfirmBtn").on("click", function() {
    // 현재 테이블의 수량값 보존
    preserveQuantities();
    
    // 모달에서 선택한 품목을 selectedItems 배열에 추가 (이미 있으면 그대로 둠)
    selectedItemsInModal.forEach(function(item) {
        let existingItem = selectedItems.find(existingItem => existingItem.prdlstNo === item.prdlstNo);
        if (!existingItem) {
            selectedItems.push(item);
        }
    });

    // 테이블 새로고침
    updateSelectedItemsTable();
    updateTotalAmount();

    // 모달 닫기
    let modalEl = document.getElementById('prdlstModal');
    let modalInstance = bootstrap.Modal.getInstance(modalEl);
    modalInstance.hide();
});

//모달에서 품목을 선택한 후 확인하지 않으면 품목이 페이지에 추가되지 않도록 처리
$("#prdlstModal").on('hidden.bs.modal', function () {
    selectedItemsInModal = []; // 모달을 닫을 때 선택한 품목을 초기화
});

//품목 삭제 시
function removeItem(prdlstNo) {
    selectedItems = selectedItems.filter(function(item) {
        return item.prdlstNo !== prdlstNo;
    });
    updateSelectedItemsTable();
    updateTotalAmount();
}

//선택된 품목 테이블 갱신 함수
function updateSelectedItemsTable() {
    // 먼저 현재 테이블의 수량 값을 보존
    preserveQuantities();

    var tbody = $("#selectedItemsTable tbody");
    tbody.empty();
    if (selectedItems.length === 0) {
        tbody.append(
            '<tr>' +
                '<td colspan="5" class="text-center">' +
                    '<h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다</h6>' +
                '</td>' +
            '</tr>'
        );
    } else {
        selectedItems.forEach(function (item) {
            tbody.append(
                '<tr data-prdlstno="' + item.prdlstNo + '" data-unitprice="' + item.prdlstPrice + '">' +
                    '<td><h6 class="fs-4 fw-normal mb-0">' + item.prdlstName + '</h6></td>' +
                    '<td><h6 class="fs-4 fw-normal mb-0">' + parseFloat(item.prdlstPrice).toLocaleString() + '</h6></td>' +
                    '<td>' +
                        '<div class="input-group">' +
                            '<button type="button" class="btn btn-outline-secondary btn-quantity-down">-</button>' +
                            '<input type="number" class="form-control text-center quantity-input" value="' + item.prdlstQty + '" min="1">' +
                            '<button type="button" class="btn btn-outline-secondary btn-quantity-up">+</button>' +
                        '</div>' +
                    '</td>' +
                    '<td class="total-amount"><h6 class="fs-4 fw-normal mb-0">' + (item.prdlstPrice * item.prdlstQty).toLocaleString() + '</h6></td>' +
                    '<td><button type="button" class="btn btn-danger btn-sm" onclick="removeItem(\'' + item.prdlstNo + '\')">삭제</button></td>' +
                '</tr>'
            );
        });
    }
}

//현재 테이블의 각 행에서 입력된 수량 값을 selectedItems 배열에 업데이트
function preserveQuantities() {
    $("#selectedItemsTable tbody tr").each(function() {
        // .data("prdlstno") 대신 .attr("data-prdlstno") 사용
        let prdlstNo = $(this).attr("data-prdlstno");
        let qty = parseInt($(this).find(".quantity-input").val(), 10) || 1;
        let item = selectedItems.find(i => i.prdlstNo === prdlstNo);
        if (item) {
            item.prdlstQty = qty;
        }
    });
}

$(document).on('input', '.quantity-input', function() {
    var $input = $(this);
    var quantity = parseInt($input.val(), 10) || 1;  // 수량 값 가져오기
    var $row = $input.closest('tr');
    var prdlstNo = $row.data('prdlstno');  // 품목 번호
    var unitPrice = parseFloat($row.data('unitprice')) || 0; // 단가 가져오기

    // selectedItems 배열에서 해당 품목을 찾아 수량 업데이트
    var item = selectedItems.find(function(it) {
        return it.prdlstNo === prdlstNo;
    });

    if (item) {
        item.prdlstQty = quantity;  // 수량 업데이트
    }

    // 총합 금액 계산
    var total = unitPrice * quantity;
    $row.find('.total-amount').html('<h6 class="fs-4 fw-normal mb-0">' + total.toLocaleString() + '</h6>');

    // 총합 금액 업데이트
    updateTotalAmount();  // 총합 금액 업데이트 함수 호출
});

//품목 수량 변경 시
$(document).on('click', '.btn-quantity-up', function(){
    var $input = $(this).siblings('.quantity-input');
    var currentVal = parseInt($input.val(), 10) || 1;
    $input.val(currentVal + 1).trigger('input');
});

$(document).on('click', '.btn-quantity-down', function(){
    var $input = $(this).siblings('.quantity-input');
    var currentVal = parseInt($input.val(), 10) || 1;
    if(currentVal > 1){
       $input.val(currentVal - 1).trigger('input');
    }
});

//총합 금액을 계산하고 표시하는 함수
function updateTotalAmount() {
    let totalAmount = 0;

    // 테이블의 각 금액을 더해서 총합 금액을 구함
    $("#selectedItemsTable .total-amount").each(function() {
        var amountText = $(this).text().trim(); // 금액 텍스트 가져오기
        var amount = parseFloat(amountText.replace(/,/g, '')); // 천단위 구분기호 제거하고 숫자로 변환
        if (!isNaN(amount)) {
            totalAmount += amount;  // 금액을 더함
        }
    });

    // 총합 금액을 화면에 표시
    $("#totalAmount").text("총합 금액: " + totalAmount.toLocaleString());
}

//첫 번째 공정 번호를 동적으로 가져오는 함수 (Promise 사용)
function getFirstProcessNo(prjctNo) {
    return new Promise(function(resolve, reject) {
        $.ajax({
            url: '/batirplan/project/projectpm/getFirstProcessNo', // 첫 번째 공정 번호를 가져오는 URL
            type: 'GET',
            data: { prjctNo: prjctNo },
            success: function(response) {
                if (response.success) {
                    resolve(response.procsNo);  // 첫 번째 공정 번호 반환
                } else {
                    reject('첫 번째 공정 번호 조회 실패');
                }
            },
            error: function() {
                reject('첫 번째 공정 번호를 가져오는 중 오류가 발생했습니다.');
            }
        });
    });
}

function submitDeclaration() {
    const dclrtSj = $("#dclrtSj").val();  // 제목
    const totalAmount = $("#totalAmount").text().replace('총합 금액: ', '').replace(/,/g, '');  // 총합 금액
    const selectedProductIds = [];  // 선택된 품목 번호들
    const quantities = [];  // 각 품목의 수량들
    
    // 선택된 품목들의 ID와 수량을 배열에 담기
    $("#selectedItemsTable tbody tr").each(function() {
        const prdlstNo = $(this).data('prdlstno'); // 품목 번호
        const qty = $(this).find('.quantity-input').val(); // 품목 수량
        selectedProductIds.push(prdlstNo);
        quantities.push(qty);
    });
    
    const prjctNo = $('#prjctNo').val();

    // 제출할 데이터 준비
    const data = {
        prjctNo: prjctNo,  // 페이지에서 전달받은 프로젝트 번호
        dclrtSj: dclrtSj,
        totalAmount: totalAmount,
        selectedProductIds: selectedProductIds,
        quantities: quantities
    };

    // 신고서 제출을 위한 AJAX 호출
    $.ajax({
        url: '/batirplan/project/declaration/submit',  // 신고서 제출 URL
        type: 'POST',  // POST 방식
        data: data,  // 서버로 보낼 데이터
        success: function(res) {
            if (res === 'success') {
                Swal.fire({
                    icon: "success",
                    title: "제출 완료",
                    text: "신고서 제출이 완료되었습니다.",
                    confirmButtonText: "확인"
                }).then(() => {
                    // 첫 번째 공정 상태를 "02"로 업데이트
                    getFirstProcessNo(prjctNo).then(function(procsNo) {
                        $.ajax({
                            url: '/batirplan/project/projectpm/updateProcessStatus',  // 공정 상태 업데이트 URL
                            type: 'POST',
                            data: {
                                procsNo: procsNo,  // 첫 번째 공정 번호
                                progrsSttus: '02'  // 공정 상태 "02"로 업데이트
                            },
                            success: function(response) {
                                if (response.success) {
                                    console.log('첫 번째 공정 상태가 업데이트되었습니다.');
                                    
                                    // 상태 업데이트 후 프로젝트 진척도 상태 업데이트
                                    updateProjectProgress(prjctNo, '01');  // 진척도를 '01'로 업데이트
                                } else {
                                    Swal.fire({
                                        icon: "warning",
                                        title: "업데이트 실패",
                                        text: "공정 상태 업데이트에 실패했습니다.",
                                        confirmButtonText: "확인"
                                    });
                                }
                            },
                            error: function() {
                                Swal.fire({
                                    icon: "error",
                                    title: "오류 발생",
                                    text: "공정 상태 업데이트 중 오류가 발생했습니다.",
                                    confirmButtonText: "확인"
                                });
                            }
                        });
                    }).catch(function(error) {
                        Swal.fire({
                            icon: "error",
                            title: "오류 발생",
                            text: error,
                            confirmButtonText: "확인"
                        });
                    });
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "제출 실패",
                    text: "신고서 제출에 실패했습니다.",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function() {
            Swal.fire({
                icon: "error",
                title: "서버 오류",
                text: "서버에 오류가 발생했습니다.",
                confirmButtonText: "확인"
            });
        }
    });
}

function updateProjectProgress(prjctNo, planStatus) {
    $.ajax({
        url: '/batirplan/project/projectpm/updatePlanStatus',
        type: 'POST',
        data: {
            prjctNo: prjctNo,
            planStatus: planStatus
        },
        success: function(response) {
            console.log(response);
            if (response.success) {
                console.log('프로젝트 진척도 상태가 업데이트되었습니다.');
                updateStepDisplay(planStatus);
                window.location.href = '/batirplan/project/projectpm/detail/' + prjctNo;
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "업데이트 실패",
                    text: "프로젝트 진척도 상태 업데이트에 실패했습니다.",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error:", error);
            Swal.fire({
                icon: "error",
                title: "오류 발생",
                text: "프로젝트 진척도 상태 업데이트 중 오류가 발생했습니다.",
                confirmButtonText: "확인"
            });
        }
    });
}

// 진척도 상태를 화면에 반영하는 함수
function updateStepDisplay(planStatus) {
    const steps = document.querySelectorAll(".steps li");

    // 계획 상태에 맞는 진척도 색상 변경
    steps.forEach((step, index) => {
        if (index === 0 && planStatus === '01') {
            step.classList.add("done");  // 첫 번째 단계 완료 표시
        } else if (index === 1 && planStatus === '02') {
            step.classList.add("done");  // 두 번째 단계 완료 표시
        } else if (index === 2 && planStatus === '03') {
            step.classList.add("done");  // 세 번째 단계 완료 표시
        } else {
            step.classList.remove("done");  // 완료되지 않은 단계는 색상 초기화
        }
    });
}

function goBack() {
	window.history.back(); 
}

$(document).ready(function(){
    updateSelectedItemsTable();
    updateTotalAmount();
});
</script>

</html>