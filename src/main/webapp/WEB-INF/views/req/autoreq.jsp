<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<style>
#prdlstTable td {
  color: black !important;
}
#resultInfoArea p {
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
		  	  		<h4 class="mb-4 mb-sm-0 card-title">🛒 자동 발주 설정</h4>
			    	</div>
			    </div>
				
				
				
				
				
				
				
				
				<div class="card">
					
					<div class="card-body">
		              	<button id="startBtn" class="btn btn-primary" onclick="openSelectPrdlstModal()">🚩 시작</button>
	     	            <div id="seletedPrdlstInfoArea1" class="mt-3 text-black">
	          				<!-- 선택된 품목 정보  -->
	         			</div>
					</div>
				
						
						
<div id="stepByStep" class="card-body wizard-content" style="display:none;">
        <form id="autoOrderWizard" class="tab-wizard wizard-circle wizard">
          <!-- Step 1 -->
          <h6>안전 재고 설정</h6>
          <section>
            <div class="row">
              <div class="col-md-3">
              </div>
              <div class="col-md-6">
                <input type="hidden" id="prdlstNo" name="prdlstNo" />
                <label for="safeStock" class="form-label">안전 재고량</label>
                <input type="number" class="form-control" id="safeInvntryQy" name="safeInvntryQy" placeholder="예: 100" />
              </div>
            </div>
          </section>

          <!-- Step 2 -->
          <h6>발주 비용 정보</h6>
          <section>
          	<div id="seletedPrdlstInfoArea2">
          	
          	</div>
            <div class="row">
              <div class="col-md-3">
                <label for="annualDemand" class="form-label">일일 소요</label>
                <input type="number" class="form-control" id="dailyDemand" name="dailyDemand" placeholder="ex) 1000" />
              </div>
              <div class="col-md-3">
                <label for="orderCost" class="form-label">리드 타임</label>
                <input type="number" class="form-control" id="leadTime" name="leadTime" placeholder="ex) 7" />
              </div>
              <div class="col-md-3">
                <label for="holdingCost" class="form-label">주문 비용</label>
                <input type="number" class="form-control" id="orderCost" name="orderCost" placeholder="ex) 50" />
              </div>
              <div class="col-md-3">
                <label for="holdingCost" class="form-label">보관비용(단위당)</label>
                <input type="number" class="form-control" id="holdingCost" name="holdingCost" placeholder="ex) 50" />
              </div>
            </div>
          </section>

          <!-- Step 3 -->
          <h6>결과 확인</h6>
          <section>
              <div id="resultInfoArea" class="container">
              </div>
          	  <div class="text-end">
          	  	<p class="mb-9 opacity-75">
                 	<i class="ti ti-alert-circle fs-5"></i>
                   	해당 품목이 이미 자동 발주가 설정되어 있었다면 새로운 발주 정보가 덮어쓰기 됩니다.
                </p>
          	  </div>
          </section>
          
          
        </form>
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
<script src="${pageContext.request.contextPath }/assets/libs/jquery-steps/build/jquery.steps.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/form-wizard.js"></script>

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

<script type="text/javascript">
$(function(){
	
	$("#autoOrderWizard").steps({
		  headerTag: "h6",
		  bodyTag: "section",
		  transitionEffect: "fade",
		  titleTemplate: '<span class="step">#index#</span> #title#',
		  labels: {
		    finish: "완료",
		    next: "다음",
		    previous: "이전"
		  },
		  onStepChanging: function(event, currentIndex, newIndex) {
		    // Step 1 -> Step 2: 안전 재고량 유효성 검사
		    if (currentIndex === 0 && newIndex === 1) {
		      var safeInvntryQy = $('#safeInvntryQy').val();
		      if (!safeInvntryQy || parseFloat(safeInvntryQy) <= 0) {
		    	    Swal.fire({
		    	        icon: "warning",
		    	        title: "입력 필요",
		    	        text: "안전 재고량을 입력해 주세요.",
		    	        confirmButtonText: "확인"
		    	    });
		    	    return false;
		    	}
		    }
		    // Step 2 -> Step 3: 발주 비용 정보 유효성 검사
		    if (currentIndex === 1 && newIndex === 2) {
		      var dailyDemand = $('#dailyDemand').val();
		      var leadTime = $('#leadTime').val();
		      var orderCost = $('#orderCost').val();
		      var holdingCost = $('#holdingCost').val();
		      if (!dailyDemand || !leadTime || !orderCost || !holdingCost) {
		    	    Swal.fire({
		    	        icon: "warning",
		    	        title: "입력 필요",
		    	        text: "모든 발주 비용 정보를 입력해 주세요.",
		    	        confirmButtonText: "확인"
		    	    });
		    	    return false;
		    	}
		      calc();
		    }
		    return true;
		  },
		  onFinished: function(event, currentIndex) {
			    console.log($("#prdlstNo").val());
			    console.log($("#safeInvntryQy").val());
			    console.log($("#dailyDemand").val());
			    console.log($("#leadTime").val());
			    console.log($("#orderCost").val());
			    console.log($("#holdingCost").val());
			    
			    Swal.fire({
			        title: "자동 발주 시작",
			        text: "해당 정보를 기반으로 자동 발주를 시작하겠습니까?",
			        icon: "warning",
			        showCancelButton: true,
			        confirmButtonText: "시작",
			        cancelButtonText: "취소"
			    }).then((result) => {
			        if (result.isConfirmed) {
			            console.log("서버에 요청을 보냅니다.");

			            var formData = {
			                prdlstNo: $("#prdlstNo").val(),
			                prdlstNm: $("#selectedPrdlstNm").text(),
			                safeInvntryQy: $("#safeInvntryQy").val(),
			                dailyDemand: $("#dailyDemand").val(),
			                leadTime: $("#leadTime").val(),
			                orderCost: $("#orderCost").val(),
			                holdingCost: $("#holdingCost").val()
			            };

			            console.log("전송 데이터:", formData);

			            // Ajax를 통해 서버에 POST 요청
			            $.ajax({
			                url: '/batirplan/resrce/req/autoreq', // 실제 서버 요청 URL로 변경하세요.
			                type: 'POST',
			                contentType: 'application/json; charset=utf-8',
			                data: JSON.stringify(formData),
			                success: function(res) {
			                    console.log("서버 응답:", res);
			                    Swal.fire({
			                        icon: "success",
			                        title: "설정 완료",
			                        text: res + "\n자동 발주 설정 완료!",
			                        confirmButtonText: "확인"
			                    });
			                },
			                error: function(xhr, status, error) {
			                    console.error("Ajax 통신 에러:", error);
			                }
			            });
			        }
			    });
			}
		});

	
    $("#searchFormSubmitBtn").on("click", function(){
        getTableData(1); // 첫 페이지부터 검색
    });
    
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
});


function calc(){
    // Step 2에서 입력된 값들 가져오기
    var dailyDemand = parseFloat($('#dailyDemand').val());  // 일일 소요량
    var annualDemand = dailyDemand * 365;  // 연간 소요량
    var leadTime = parseFloat($('#leadTime').val());        // 리드 타임 (일)
    var orderCost = parseFloat($('#orderCost').val());      // 주문 비용
    var holdingCost = parseFloat($('#holdingCost').val());  // 보관 비용 (단위당)
    var safeStock = parseFloat($('#safeInvntryQy').val());   // 안전 재고량

    // EOQ(경제적 발주량) 계산 공식: EOQ = sqrt((2 * D * S) / H)
    var eoq = Math.sqrt((2 * annualDemand * orderCost) / holdingCost);

    // ROP(재주문 시점) 계산: ROP = (일일 소요량 * 리드 타임) + 안전 재고량
    var rop = dailyDemand * leadTime + safeStock;
	
    
    console.log($("#selectedPrice").text());
    
    // resultInfoArea에 설명문 동적 출력
    var explanation = "<p calss='d-flex justify-content-center'>계산된 재주문 시점(ROP)은 <strong style='color: blue;'>" + Math.round(rop) + "</strong> 단위입니다. " +
                      "즉, 현재 재고가 " + Math.round(rop) + " 단위 이하로 떨어지면 자동으로 발주가 진행됩니다.</p>" +
                      "<p calss='d-flex justify-content-center'>경제적 발주량(EOQ)은 <strong style='color: blue;'>" + Math.round(eoq) + "</strong> 단위로 계산되었습니다. " +
                      "이 값은 주문 비용과 보관 비용의 균형을 고려하여, 총 재고 관련 비용을 최소화하는 최적의 주문량입니다.</p>" +
                      "<p calss='d-flex justify-content-center'>따라서, 재고가 <strong style='color: blue;'>" + Math.round(rop) + "</strong> 단위 이하가 되면, " +
                      "자동으로 약 <strong style='color: blue;'>" + Math.round(eoq) + "</strong> 단위를 발주합니다.</p>" +
                      "<p calss='d-flex justify-content-center'>발주시에는 <strong style='color: blue;'>" + parseInt($("#selectedPrice").text()) * Math.round(eoq) + "</strong>원이 소요됩니다.</p>";
                      
    $('#resultInfoArea').html(explanation);
}


//품목 검색 결과 테이블 생성
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
        	console.log(res);
            renderTableData(res.dataList);
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

function renderTableData(resultList){
    // 결과 컨테이너 초기화
    var container = $("#prdlstResultContainer");
    container.empty();
    
    var units = <%= sb.toString() %>;
    
    // 결과 테이블 생성 (필요에 따라 다른 구조도 가능)
    var table = $("<table id='prdlstTable' class='table table-bordered'></table>");
    var thead = $("<thead><tr><th>품목번호</th><th>품목명</th><th>업체명</th><th>규격</th><th>단위</th><th>단가</th><th>선택</th></tr></thead>");
    var tbody = $("<tbody></tbody>");
    
    $.each(resultList, function(index, item){
        var row = $("<tr></tr>");
        row.append("<td>" + item.prdlstNo + "</td>");
        row.append("<td>" + item.prdlstNm + "</td>");
        row.append("<td>" + item.ccpyNm + "</td>");
        row.append("<td>" + item.prdlstStndrd + "</td>");
        row.append("<td>" + units[item.prdlstUnit-1] + "</td>");
        row.append("<td>" + item.prdlstPrice + "</td>");
        // 선택 버튼에 데이터 속성으로 품목 정보를 전달
        var selectBtn = $("<button class='btn btn-sm btn-primary'>선택</button>");
        selectBtn.on("click", function(){
            selectProduct(item);
        });
        row.append($("<td></td>").append(selectBtn));
        tbody.append(row);
    });
    
    table.append(thead).append(tbody);
    container.append(table);
}

//모달 열기
function openSelectPrdlstModal() {
    let prdlstModal = new bootstrap.Modal($("#prdlstModal"));
    getTableData(1);
    prdlstModal.show();
}

function selectProduct(item){
    let resultArea1 = $("#seletedPrdlstInfoArea1");
    resultArea1.empty();
    
    // 폼 생성 (필요한 hidden 인풋 포함)
    var form = $("<form id='prdlstInfoForm'></form>");
    form.append(
        $("<input type='hidden' name='prdlstNo'>").val(item.prdlstNo),
        $("<input type='hidden' name='prdlstNm'>").val(item.prdlstNm),
        $("<input type='hidden' name='safeInvntryQy'>")
    );
    
    var units = <%= sb.toString() %>;
    
    // "[선택 품목]"은 첫 번째 행에 표시, 아래 행에 나란히 품목 정보 표시
    var html = "";
    html += "<div class='row'><div class='col-12 mb-3'><strong>[📦 선택 품목 정보]</strong></div></div>";
    html += "<div class='row'>";
    html +=   "<div id='selectedPrdlstNm' class='col-md-4'><strong>품목명:</strong> " + item.prdlstNm + "</div>";
    html +=   "<div class='col-md-3'><strong>업체명:</strong> " + item.ccpyNm + "</div>";
    html +=   "<div class='col-md-3'><strong>규격(단위):</strong> " + item.prdlstStndrd + " (" + units[item.prdlstUnit-1] + ")</div>";
    html +=   "<div class='col-md-2'><strong>단가:</strong> " + item.prdlstPrice + "</div>"
    html +=   "<div id='selectedPrice' style='display:none;'>" +item.prdlstPrice +"</div>";
    html += "</div>";
    
    // 인풋 태그에 값 넣어놓기
    $("#prdlstNo").val(item.prdlstNo);
    // 결과 영역에 내용과 폼 추가
    resultArea1.append(html);
    resultArea1.append(form);
    
    // 모달 닫기
    var modalEl = $("#prdlstModal");
    var modalInstance = bootstrap.Modal.getInstance(modalEl);
    modalInstance.hide();
    
    $("#stepByStep").css("display","block");
    $("#startBtn").css("display","none");
}



$(document).on("click", "#prdlstPagination .page-link", function(e){
    e.preventDefault();
    var page = $(this).data("page");
    getTableData(page);
});

</script>
</body>
</html>