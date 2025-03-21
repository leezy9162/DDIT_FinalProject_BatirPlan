<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<style>
#stockTable td {
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
		  	  		<h4 class="mb-4 mb-sm-0 card-title">입고</h4>
			    	</div>
			    </div>
				
				
				<div class="card">
					<div class="px-4 py-3 border-bottom">
						<h4 class="card-title mb-0">📦 입고 처리 대기 리스트</h4>
					</div>
					<div class="card-body">
						<h4 class="card-title mb-0">🔍 검색</h4>
						<form id="searchForm">
							<div class="row mt-3 mb-3">
								<div class="col-md-4">
									<label class="form-label" for="ordrNo">발주 번호</label>
									<input id="ordrNo" type="text" class="form-control form-control-sm"/>
								</div>
								<div class="col-md-4">
									<label class="form-label" for="ordrDeNo">발주 상세 번호</label>
									<input id="ordrDeNo" type="text" class="form-control form-control-sm"/>
								</div>
								<div class="col-md-4">
									<label class="form-label" for="prdlstNm">품목명</label>
									<input id="prdlstNm" type="text" class="form-control form-control-sm"/>
								</div>
							</div>
						</form>
						<div class="row">
							<div class="d-flex justify-content-end">
								<button class="btn btn-primary" id="searchBtn">검색</button>
								<button class="btn btn-primary ms-2" id="resetBtn">초기화</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-body">
						<h4 class="card-title mb-0">📑 결과</h4>
						<div class="row">
							<div class="d-flex justify-content-end">
								<button class="btn btn-primary mb-3" id="stockModalBtn">승인</button>
							</div>
						</div>
						<div class="table-responsive mb-4 border rounded-1">
							<table id="stockTable" class="table text-nowrap mb-0 align-middle">
								<thead class="text-dark fs-4">
									<tr>
										<th>
											<input type="checkbox" id="checkAll1">
										</th>
										<th>
											<h6 class="fs-4 fw-semibold mb-0" >발주번호(상세)</h6>
										</th>
										<th>
											<h6 class="fs-4 fw-semibold mb-0" >품목명</h6>
										</th>
										<th>
											<h6 class="fs-4 fw-semibold mb-0" >주문량</h6>
										</th>
									</tr>
								</thead>
								<tbody id="targetList">
								
								
								</tbody>
							</table>
						</div>
						<div class="d-flex justify-content-between align-items-center mt-3">
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
<div id="stockProcessModal" class="modal fade" tabindex="-1" aria-labelledby="stockProcessModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header d-flex align-items-center">
        <h4 class="modal-title" id="stockProcessModal">입고 처리</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <!-- 모달 바디: 검색 + 결과 + 페이지네이션 -->
      <div class="modal-body">
      	<div class="row">
      		<p class="text-black">선택된 항목</p>
      		<div id="selectedItems" class="mb-3">
    			
			</div>
      	</div>
      	<label class="form-label" for="whSelect">창고 선택</label>
      	<select id="whSelect" class="form-select">
      		<option value="">--창고명--</option>
      		<c:forEach items="${whList }" var="wh">
      			<option value="${wh.wrHousCode }">${wh.wrHousNm }</option>
      		</c:forEach>
      	</select>
      	
      
      	<div class="modal-footer">
        	<button type="button" class="btn btn-primary" id="confirmStockBtn">제출</button>
      	</div>
      </div>
    </div>
  </div>
</div>     
<%@include file="../module/footerScript.jsp" %>
<script type="text/javascript">
$(function(){
	
	stockTargetList(1);
	
	$("#stockModalBtn").on("click", function(){
        var checked = $(".row-check:checked");
        if(checked.length === 0) {
            Swal.fire({
                icon: "warning",
                title: "항목 선택",
                text: "입고 처리할 항목을 선택하세요.",
                confirmButtonText: "확인"
            });
            return;
        }
        openstockProcessModal();
	})
	
    $("#searchBtn").on("click", function(){
        stockTargetList(1);
    });
	
    $("#resetBtn").on("click", function(){
        document.getElementById("searchForm").reset();
        stockTargetList(1);
    });
	
    $("#confirmStockBtn").on("click", function(){
        var whCode = $("#whSelect").val();
        if(!whCode) {
            Swal.fire({
                icon: "warning",
                title: "창고 선택",
                text: "창고를 선택하세요.",
                confirmButtonText: "확인"
            });
            return;
        }

        var selectedData = [];
        $(".row-check:checked").each(function(){
            selectedData.push({
                orderDeNo: $(this).data("ordrdeno"),
                prdlstNo: $(this).data("prdlstno"),
                ordrQty:  $(this).data("ordrqty"),
                prdlstNm: $(this).data("prdlstnm")
            });
        });

        $.ajax({
            url: "/batirplan/resrce/stock/confirmStock", // 실제 매핑 URL
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                whCode: whCode,
                items: selectedData
            }),
            dataType: "json",
            success: function(res){
                console.log("입고처리 성공:", res);
                
                let stockProcessModal = bootstrap.Modal.getInstance(document.getElementById('stockProcessModal'));
                stockProcessModal.hide();

                stockTargetList(1);

                Swal.fire({
                    icon: "success",
                    title: "입고 처리 완료",
                    text: "입고처리가 완료되었습니다.",
                    confirmButtonText: "확인"
                });
            },
            error: function(err){
                console.log("입고처리 실패:", err);
                Swal.fire({
                    icon: "error",
                    title: "입고 처리 오류",
                    text: "입고처리 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    });

    
})

/* 반려 모달 여는 함수  */
function openstockProcessModal() {
  // 1) 체크된 항목을 모아서 리스트 HTML 생성
  var checked = $(".row-check:checked");
  var listHtml = "<ul>";
  checked.each(function(){
    var orderDeNo = $(this).data("ordrdeno");
    var prdlstNm  = $(this).data("prdlstnm");
    listHtml += "<li>" + orderDeNo + " / " + prdlstNm + "</li>";
  });
  listHtml += "</ul>";

  // 2) 모달 내부 영역에 삽입
  $("#selectedItems").html(listHtml);

  // 3) 모달 오픈
  let stockProcessModal = new bootstrap.Modal(document.getElementById('stockProcessModal'));
  stockProcessModal.show();
}



function stockTargetList(page){
	
    // 1) 자바스크립트 객체로 파라미터 구성
    var paramObj = {
        ordrNo:     $("#ordrNo").val(),
        ordrDeNo:    $("#ordrDeNo").val(),
        prdlstNm:    $("#prdlstNm").val(),
        currentPage: page
    };
    
    $.ajax({
    	url: "/batirplan/resrce/stock/getStockTargetList",
    	type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(paramObj),
        dataType: "json",
        success: function(res){
        	console.log(res);
        	$("#targetList").empty();
			if(res.dataList && res.dataList.length > 0) {
			    $.each(res.dataList, function(i, item) {
			        var rowHtml = "<tr>";
			        rowHtml += "  <td>"
			                 + "    <input type='checkbox' class='row-check'"
			                 + "           data-ordrdeno='" + (item.orderDeNo || "") + "'"
			                 + "           data-prdlstno='" + (item.prdlstNo || "") + "'"
			                 + "           data-ordrqty='" + (item.ordrQty || 0) + "'"
			                 + "           data-prdlstnm='" + (item.prdlstNm || "") + "'>"  // 품목명도 저장
			                 + "  </td>";
			        rowHtml += "  <td>" + item.ordrNo + "(" + item.orderDeNo + ")"  + "</td>";
			        rowHtml += "  <td>" + (item.prdlstNm || "") + "</td>";
			        rowHtml += "  <td>" + (item.ordrQty || 0) + "</td>";
			        rowHtml += "</tr>";
			
			        $("#targetList").append(rowHtml);
			    });
			} else {
			    $("#targetList").append("<tr><td colspan='4' class='text-center'>데이터가 없습니다.</td></tr>");
			}
        	$("#pagingArea").html(res.paging);
        },
        error: function(err){
        	console.log(err);
        }
    })
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
    stockTargetList(page);
});

//전체선택 체크박스 이벤트
$(document).on("click", "#checkAll1", function(){
    $(".row-check").prop("checked", $(this).is(":checked"));
});

</script>
</body>
</html>