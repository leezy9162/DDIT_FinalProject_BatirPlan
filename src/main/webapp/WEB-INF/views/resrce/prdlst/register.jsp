<%-- <%@page import="kr.or.batirplan.resrce.product.vo.PrdlstVO"%> --%>
<%@page import="kr.or.batirplan.resrce.product.vo.PrdlstVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<style>
#myTable td {
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
		  
		  <c:set property="등록" var="stts" />
		  <c:if test="${!empty prdlstVO }">
		  		<c:set property="수정" var="stts" />
		  </c:if>
		  
	      <!-- 컨텐츠 영역 제목 -->		  
		  <div class="card card-body py-3">
			<div class="row align-items-center">
	  			<h4 class="mb-4 mb-sm-0 card-title">품목
	  			 <c:choose>
	  			 	<c:when test="${status eq 'u' }">
	  			 		<c:set value="수정" var="stts" />
	  			 	</c:when>
	  			 	<c:otherwise>
	  			 		<c:set value="등록" var="stts" />
	  			 	</c:otherwise>
	  			 </c:choose>
	  			 ${stts }
	  			 </h4>
		  	</div>
		  </div>
			
		  <!-- 상단 탭으로 구분되는 Content영역  -->
		<div class="card">
		<div class="card-body">
		  <ul class="nav nav-tabs" id="myTab" role="tablist">
		    <li class="nav-item" role="presentation">
		      <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
		        <span>개별 등록</span>
		      </a>
		    </li>
		    <li class="nav-item" role="presentation">
		      <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
		        <span>일괄 등록</span>
		      </a>
		    </li>
		    </ul>
		    <div class="tab-content tabcontent-border p-3" id="myTabContent">
		      <!-- 첫번째 탭 컨텐츠 영역 -->
		      <div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
				  <form id="prdlstForm">
					<input type="hidden" name="prdlstCode" id="prdlstNo" value="${prdlstVO.prdlstNo }">		  
				  	<div class="row">
				  	
				  		<div class="mb-3 col-md-3">
				  			<label class="form-label" for="imgFile">품목 이미지</label>
						  	<img class="img-fluid rounded-4 mb-3" id="prdImg" alt="prd profile picture" 
						  		src="
						  		<c:if test="${empty prdlstVO.prdlstImageCours }">
						  			${pageContext.request.contextPath}/assets/images/blog/blog-img1.jpg
						  		</c:if>
						  		<c:if test="${!empty prdlstVO.prdlstImageCours }">
						  			${prdlstVO.prdlstImageCours} 
						  		</c:if>
						  		" 
						  		width="250" height="300">
				  			<input class="form-control" type="file" name="imgFile" id="imgFile">
				  		</div>
				  		
				  		<div class="col-md-9">
				  		
				  			<div class="row">
						  		<div class="mb-3 col-md-3">
						  			<label class="form-label" for="prdlstNm">품목명</label>
							  		<input class="form-control form-control-sm mb-3" type="text" name="prdlstNm" id="prdlstNm" value="${prdlstVO.prdlstNm }" />
						  		</div>
						  		<div class="mb-3 col-md-3">
						  			<label class="form-label" for="mbtlnum">협력 업체</label>
							  		<button type="button" class="btn btn-sm" onclick="openSelectCcpyModal()" >협력업체 찾기</button>
						  			<input class="form-control form-control-sm" id="ccpyCode" name="ccpyCode" value="${prdlstVO.ccpyCode }" disabled/>
						  		</div>
						  		<div class="mb-3 col-md-3">
						  			<label class="form-label" for="prdlstStndrd">품목 규격</label>
							  		<input class="form-control form-control-sm mb-3" type="text" name="prdlstStndrd" id="prdlstStndrd" value="${prdlstVO.prdlstStndrd }" />
						  		</div>
						  		<div class="mb-3 col-md-3">
						  			<label class="form-label" for="prdlstUnit">품목 단위</label>
						  			<!-- 공통 코드에 따라 품목 단위 동적으로 그리기  -->
						  			<select class="form-select form-select-sm" name="prdlstUnit">
									    <c:forEach var="unit" items="${unitList}" varStatus="status">
									        <option value="<fmt:formatNumber value='${status.index + 1}' pattern='00'/>"
									        	${status.index+1 eq  prdlstVO.prdlstUnit ? 'selected' : ''}
									        >
									           ${unit}
									        </option>
									    </c:forEach>
									</select>
									
						  		</div>
						  		<div class="mb-3 col-md-3">
						  			<label class="form-label" for="prdlstPrice">품목 계약 단가</label>
							  		<input class="form-control form-control-sm" type="text" name="prdlstPrice" id="prdlstPrice" value="${prdlstVO.prdlstPrice }" />
						  		</div>
						  						  				<div class="col-md-3">
						  			<label class="form-label" for="prdlstPrice">대분류</label>
									<select class="form-control form-control-sm" name="level1" id="level1Select">
									    <option value="">-- 대분류 선택 --</option>
									    <c:forEach var="cat" items="${levelOneCtgryList}">
									        <!-- value에 카테고리 번호 -->
									        <option value="${cat.ctgryNo}">${cat.ctgryNm}</option>
									    </c:forEach>
									</select>
				  				</div>
				  				<div class="col-md-3">
						  			<label class="form-label" for="prdlstPrice">중분류</label>
									<select class="form-control form-control-sm" name="level2" id="level2Select">
									    <option value="">-- 중분류 선택 --</option>
									</select>
				  				</div>
				  				<div class="col-md-3">
						  			<label class="form-label" for="prdlstPrice">소분류</label>
									<select class="form-control form-control-sm" name="ctgryNo" id="ctgryNo">
									    <option value="">-- 소분류 선택 --</option>
									</select>
				  				</div>
				  			</div>
				  			
				  			

			  			</div>
				  	</div>
				  </form>
			  	  <div class="text-end" id="btnArea">
			  	  	  <button class="btn" id="dataInsertBtn">데이터 삽입</button>
		 			  <button type="button" class="btn btn-primary" onclick="history.back()"><i class="ti ti-x fs-4 me-2"></i>취소</button>
		 			  <button type="button" class="btn btn-primary" id="submitBtn"><i class="ti ti-send fs-4 me-2"></i>${stts }</button>
				  </div>
		      </div>
		      <!-- 두번쩨 탭 컨텐츠 영역  -->
		      <div class="tab-pane fade" id="profile5" role="tabpanel" aria-labelledby="profile-tab">
		        <p>
		        </p>
		      </div>
		    </div>
		  </div>
		</div>		  
		  
		  <!-- 컨텐츠 영역 본문1 끝  -->
		  
	  	  	
		  <!-- 작업 영역 End -->
		  </div>
	    </div>
    </div>
    </div>
  <%@include file="../../module/footerScript.jsp" %>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/jquery.repeater/jquery.repeater.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/forms/repeater-init.js"></script>

<!-- ModalArea  -->
<!-- 협력업체 모달 -->
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
        <!-- 결과 리스트 영역 (테이블) -->
        <div id="ccpyResultContainer"></div>
        <!-- 페이지네이션 영역 -->
        <div id="ccpyPagination" class="mt-3 d-flex justify-content-center"></div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn bg-danger-subtle text-danger" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</body>
<%
    // 1) request.getAttribute("prdlstVO")로부터 PrdlstVO 객체를 가져온다.
    PrdlstVO prdlst = (PrdlstVO) request.getAttribute("prdlstVO");
    // 2) 가져온 prdlstVO가 null이 아닐 때만 작업하도록 방어 코드 추가 (NPE 방지)
    String statusValue = (String) request.getAttribute("status");
    String levelOneVal = "";
    String levelTwoVal = "";
    String levelThreeVal = "";
    
    if (prdlst != null) {
        levelOneVal   = String.valueOf(prdlst.getLevelOneCtgry());  // ex) 대분류 번호
        levelTwoVal   = String.valueOf(prdlst.getLevelTwoCtgry());  // ex) 중분류 번호
        levelThreeVal = String.valueOf(prdlst.getCtgryNo());        // ex) 소분류 번호
    }
%>
<!-- cardForm script -->
<script type="text/javascript">
$(function() {
	
	$("#dataInsertBtn").on("click", function(){
	    // 품목명 입력 (예: "테스트 품목")
	    $("#prdlstNm").val("양회토건 PVC 파이프");
	    
	    $("#prdlstStndrd").val("Ø100×4M");
	    
	    
	    // 품목 계약 단가 입력 (예: "10000")
	    $("#prdlstPrice").val("3200");
	});

	
	let status = "<%= statusValue %>";
    let level1Val = "<%= levelOneVal %>";
    let level2Val = "<%= levelTwoVal %>";
    let level3Val = "<%= levelThreeVal %>";
    
	console.log(status);
	console.log(level1Val);
	console.log(level2Val);
	console.log(level3Val);
	if (status === 'u') {
        
    }	
	
    let imgFile = $("#imgFile");
    let profileImg = $("#prdImg");
    let submitBtn = $("#submitBtn");

    // 이미지 업로드
    imgFile.on("change", function(event){
        let file = event.target.files[0];
        if(isImageFile(file)){
            let reader = new FileReader();
            reader.onload = function(e){
                profileImg.attr("src", e.target.result);
            };
            reader.readAsDataURL(file);
        } else {
            Swal.fire({
                icon: "warning",
                title: "파일 선택 오류",
                text: "이미지 파일을 선택해주세요!",
                confirmButtonText: "확인"
            });
        }
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

    // 3) 수정 모드면 대분류부터 세팅하고 change 트리거
    if(status === 'u'){
        $("#level1Select").val(level1Val).trigger("change");
    }
	
    
    $("#submitBtn").on("click", function(){
    	console.log("제출 버튼 클릭");
    	let formData = new FormData();
	    let btnText = $('#submitBtn').text();
	    
	    var prdlstNm    = $("#prdlstNm").val().trim();         // 품목명
	    var ccpyCode    = $("#ccpyCode").val().trim();         // 협력업체 코드
	    var prdlstStndrd = $("#prdlstStndrd").val().trim();      // 품목 규격
	    var prdlstPrice = $("#prdlstPrice").val().trim();      // 품목 가격
	    var ctgryNo   = $("#ctgryNo").val();            // 소분류(카테고리) 번호
	    var imgFile     = $("#imgFile")[0].files[0];           // 품목 이미지(Multipart)
	    
	    if(!prdlstNm){
	        Swal.fire({
	            icon: "warning",
	            title: "품목명 입력",
	            text: "품목명을 입력하세요.",
	            confirmButtonText: "확인"
	        });
	        $("#prdlstNm").focus();
	        return;
	    }
	    if(!ccpyCode){
	        Swal.fire({
	            icon: "warning",
	            title: "협력업체 선택",
	            text: "협력업체를 선택하세요.",
	            confirmButtonText: "확인"
	        });
	        return;
	    }

	    if(!prdlstPrice){
	        Swal.fire({
	            icon: "warning",
	            title: "품목 단가 입력",
	            text: "품목 단가를 입력하세요.",
	            confirmButtonText: "확인"
	        });
	        $("#prdlstPrice").focus();
	        return;
	    }

	    // (선택) 가격 숫자 여부 검사
	    if(prdlstPrice && isNaN(prdlstPrice)){
	        Swal.fire({
	            icon: "warning",
	            title: "계약단가 숫자 입력",
	            text: "계약단가는 숫자로 입력해주세요.",
	            confirmButtonText: "확인"
	        });
	        $("#prdlstPrice").focus();
	        return;
	    }

	    if(!ctgryNo){
	        Swal.fire({
	            icon: "warning",
	            title: "카테고리 선택",
	            text: "품목 카테고리를 선택하세요. (소분류)",
	            confirmButtonText: "확인"
	        });
	        return;
	    }
	    
	    // 2) FormData 생성
	    formData.append("prdlstNm",    prdlstNm);
	    formData.append("ccpyCode",    ccpyCode);
	    formData.append("prdlstStndrd", prdlstStndrd);
	    formData.append("prdlstPrice", prdlstPrice);
	    formData.append("ctgryNo",     ctgryNo);   // 소분류 카테고리 번호
	    
	    // (선택) 품목 단위, 품목 코드 등 추가 가능
	    var prdlstUnit = $("select[name='prdlstUnit']").val();
	    formData.append("prdlstUnit",  prdlstUnit);

	    // 이미지 파일이 있다면 FormData에 추가
	    if(imgFile){
	        formData.append("prdlstImage", imgFile);
	    }
	    
	    // 품목 코드(수정 시 필요), hidden input
	    var prdlstNo = $("#prdlstNo").val();
	    if(prdlstNo){
	        formData.append("prdlstNo", prdlstNo);
	    }
    	
	    if(btnText == '수정'){
	    	/* 수정 버튼일때 */
		    $.ajax({
		        url: "/batirplan/resrce/prdlst/modify",
		        type: "post",
		        data: formData,
		        contentType: false,
		        processData: false,
		        success: function(res, textStatus, jqXHR){
		            let statusCode = jqXHR.status;
		            
		            if(statusCode === 200){
		                console.log(res);
		                Swal.fire({
		                    icon: "success",
		                    title: "수정 완료",
		                    text: "품목 수정이 완료되었습니다!",
		                    confirmButtonText: "확인"
		                }).then(() => {
		                    location.href = "/batirplan/resrce/prdlst/detail?prdlstNo=" + res;
		                });
		            } else {
		                Swal.fire({
		                    icon: "warning",
		                    title: "수정 실패",
		                    text: "품목 수정 실패, 다시 시도해주세요!",
		                    confirmButtonText: "확인"
		                });
		            }
		        },
		        error : function(error, status, thrown){
		            console.log("error: " + error.status);
		            console.log("status: " + status);
		            console.log("thrown: " + thrown);
		            Swal.fire({
		                icon: "error",
		                title: "서버 오류",
		                text: "서버 에러 발생, IT팀에게 문의해주세요!",
		                confirmButtonText: "확인"
		            });
		        }
		    });
	    } else{
	    	
	    	$.ajax({
	    		url: "/batirplan/resrce/prdlst/register",
	    		type: "post",
	    		data: formData,
		        contentType: false,
		        processData: false,
		        success: function(res, textStatus, jqXHR){
		            let statusCode = jqXHR.status;
		            
		            if(statusCode === 200){
		                console.log(res);
		                Swal.fire({
		                    icon: "success",
		                    title: "등록 완료",
		                    text: "품목 등록이 완료되었습니다!",
		                    confirmButtonText: "확인"
		                }).then((result)=>{
		                	if(result.isConfirmed){
				                location.href = "/batirplan/resrce/prdlst/detail?prdlstNo=" + res;
		                	}
		                });
		            } else {
		                Swal.fire({
		                    icon: "warning",
		                    title: "등록 실패",
		                    text: "품목 등록 실패, 다시 시도해주세요!",
		                    confirmButtonText: "확인"
		                });
		            }
		        },
		        error : function(error, status, thrown){
		            console.log("error: " + error.status);
		            console.log("status: " + status);
		            console.log("thrown: " + thrown);
		            Swal.fire({
		                icon: "error",
		                title: "서버 오류",
		                text: "서버 에러 발생, IT팀에게 문의해주세요!",
		                confirmButtonText: "확인"
		            });
		        }
	    	})
	    }
	    
    })
    
    
}); 

// 선언 함수 영역---------------------------------------------------------------------------------------------
function openSelectCcpyModal() {
  let ccpyModal = new bootstrap.Modal(document.getElementById('ccpyModal'));
  getCcpyList(1, "", "");  // 초기 전체조회
  ccpyModal.show();
}

function ccpySearch() {
  let sWord = $("#searchWord").val();
  let sType = $("#searchType").val();
  getCcpyList(1, sWord, sType);
}

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

// 데이터를 테이블 내용을 그리는 함수
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

// 페이지 번호 클릭 시
$(document).on("click", "#ccpyPagination .page-link", function(e){
  e.preventDefault();
  let goPage = $(this).data("page");
  let sWord = $("#searchWord").val();
  let sType = $("#searchType").val();
  getCcpyList(goPage, sWord, sType);
});

// 테이블 row 클릭
$(document).on("click", ".ccpy-row", function(){
  let ccpyCode = $(this).data("ccpy-code");
  $("#ccpyCode").val(ccpyCode);
  
  let modalEl = document.getElementById('ccpyModal');
  let modalInstance = bootstrap.Modal.getInstance(modalEl);
  modalInstance.hide();
});

// 이미지 파일인지 체크
function isImageFile(file){
    var ext = file.name.split(".").pop().toLowerCase();
    return ($.inArray(ext,["jpg","jpeg","gif","png"]) === -1) ? false : true;
}
</script>

</html>