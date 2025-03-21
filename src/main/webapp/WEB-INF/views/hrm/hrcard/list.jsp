<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css">

<script type="text/javascript">
/* document onload-ready */
$(function(){
	console.log("hello!");	
})
</script>

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
			    <h4 class="mb-4 mb-sm-0 card-title">인사카드 관리</h4>
			  </div>
			</div>

			<!-- 검색 필터 영역 -->
	  	    <div class="card">
	              <div class="card-body">
	              	<h4 class="card-title mb-3">검색</h4>
					    <form id="searchForm" action="/batirplan/hrm/hrcard/list" method="get">
					    	<!-- 페이징용 currentPage -->
					    	<input type="hidden" name="currentPage" id="currentPage" value="${pagingVO.currentPage }">
		                	<div class="row">
		                		<div class="col-md-3 mb-3">
			                		<label class="form-label" for="deptCode">부서</label>
							  		<select class="form-select form-select-sm mr-sm-2" name="deptCode" id="deptCode">
										<option value="" >--부서를 선택하세요--</option>
									  	<option value="01" ${searchVO.deptCode eq '01' ? 'selected' : ''}>경영지원        	</option>
										<option value="02" ${searchVO.deptCode eq '02' ? 'selected' : ''}>건축기획        	</option>
										<option value="03" ${searchVO.deptCode eq '03' ? 'selected' : ''}>재무           	</option>
										<option value="04" ${searchVO.deptCode eq '04' ? 'selected' : ''}>자원           	</option>
										<option value="05" ${searchVO.deptCode eq '05' ? 'selected' : ''}>IT           	</option>
						  			</select>
			                	</div>
			                	<div class="col-md-3 mb-3">
			                		<label class="form-label" for="clsfCode">직급</label>
				  					<select class="form-select form-select-sm mr-sm-2" name="clsfCode" id="clsfCode">
										<option value="" >--직급을 선택하세요--</option>
									  	<option value="01" ${searchVO.clsfCode eq '01' ? 'selected' : ''}>사원        	</option>
										<option value="02" ${searchVO.clsfCode eq '02' ? 'selected' : ''}>대리        	</option>
										<option value="03" ${searchVO.clsfCode eq '03' ? 'selected' : ''}>과장        	</option>
										<option value="04" ${searchVO.clsfCode eq '04' ? 'selected' : ''}>차장        	</option>
										<option value="05" ${searchVO.clsfCode eq '05' ? 'selected' : ''}>부장        	</option>
				  					</select>
			                	</div>
			                	<div class="col-md-6">
			                		<label class="form-label" for="hffcSttus">재직 상태</label>
			                		<div class="d-flex align-items-center justify-content-start gap-3 ">
			                			<div>
			                				<input class="form-check-input" type="radio" id="hffcSttus01" name="hffcSttus" value="01" ${searchVO.hffcSttus eq '01' ? 'checked' : ''}> 재직
			                			</div>
			                			<div>
					        			<input class="form-check-input" type="radio" id="hffcSttus02" name="hffcSttus" value="02" ${searchVO.hffcSttus eq '02' ? 'checked' : ''}> 휴직
					        			</div>
					        			<div>
					        			<input class="form-check-input" type="radio" id="hffcSttus03" name="hffcSttus" value="03" ${searchVO.hffcSttus eq '03' ? 'checked' : ''}> 퇴직
					        			</div>
			                		</div>
			                	</div>
		                	</div>
					    	<div class="row">
			                	<div class="col-md-3">
			                		<label class="form-label" for="emplCode">사원코드</label>
					        		<input class="form-control form-control-sm" type="text" id="emplCode" name="emplCode" value="${searchVO.emplCode}"><br/>
			                	</div>
			                	<div class="col-md-3">
			                		<label class="form-label" for="emplNm">사원명</label>
					        		<input class="form-control form-control-sm" type="text" id="emplNm" name="emplNm" value="${searchVO.emplNm}"><br/>
			                	</div>
			                	<!-- VARCHAR2를 DATE로 -->
			                	<c:if test="${!empty searchVO.hireDateStart }">
				  					<fmt:parseDate var="hireDateStart" value="${searchVO.hireDateStart}" pattern="yyyyMMdd"/>
    								<fmt:formatDate var="formattedHireDateStart" value="${hireDateStart}" pattern="yyyy-MM-dd"/>
				  				</c:if>
			                	<c:if test="${!empty searchVO.hireDateEnd }">
				  					<fmt:parseDate var="hireDateEnd" value="${searchVO.hireDateEnd}" pattern="yyyyMMdd"/>
    								<fmt:formatDate var="formattedHireDateEnd" value="${hireDateEnd}" pattern="yyyy-MM-dd"/>
				  				</c:if>
			                	<div class="col-md-3">
							        <label class="form-label">입사일 (From)</label>
							        <input class="form-control form-control-sm" type="date" id="hireDateStart" name="hireDateStart"  value="${formattedHireDateStart}">
			                	</div>
			                	<div class="col-md-3">
							        <label class="form-label">입사일 (To)</label>
							        <input class="form-control form-control-sm" type="date" id="hireDateEnd" name="hireDateEnd"  value="${formattedHireDateEnd}">
			                	</div>
		                	</div>
					    	<div class="row">
			                	<div class="col-md-3">
			                		<label for="email" class="form-label">이메일</label>
					        		<input class="form-control form-control-sm email-inputmask" type="text" id="email" name="email" value="${searchVO.email}"><br/>
			                	</div>
			                	<div class="col-md-3">
					        		<label class="form-label" for="mbtlnum">휴대폰 번호</label>
					        		<input class="form-control form-control-sm" type="text" id="mbtlnum" name="mbtlnum" value="${searchVO.mbtlnum}"><br/>
			                	</div>
			                	<c:if test="${!empty searchVO.retireDateStart }">
					  				<fmt:parseDate var="retireDateStart" value="${searchVO.retireDateStart}" pattern="yyyyMMdd"/>
	    							<fmt:formatDate var="formattedRetireDateStart" value="${retireDateStart}" pattern="yyyy-MM-dd"/>
					  			</c:if>
								<c:if test="${!empty searchVO.retireDateEnd}">
								    <fmt:parseDate var="retireDateEnd" value="${searchVO.retireDateEnd}" pattern="yyyyMMdd"/>
								    <fmt:formatDate var="formattedRetireDateEnd" value="${retireDateEnd}" pattern="yyyy-MM-dd"/>
								</c:if>
								<div class="col-md-3">
									 <label class="form-label">퇴사일 (From)</label><br/>
					        		<input class="form-control form-control-sm" type="date" id="retireDateStart" name="retireDateStart"  value="${formattedRetireDateStart}">
								</div>
								<div class="col-md-3">
									 <label class="form-label">퇴사일 (To)</label>
							        <input class="form-control form-control-sm" type="date" id="retireDateEnd" name="retireDateEnd"  value="${formattedRetireDateEnd}"><br/>
								</div>
		                	</div>
					        
							
					        <div class="text-end">
					        	<button type="button" class="btn btn-primary" id="searchFormSubmitBtn"><i class="ti ti-search fs-5"></i>
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
	<div class="card-body">
	<h4 class="card-title mb-3">결과</h4>
<div class="table-responsive mb-4 border rounded-1">
    <table id="hrcardTable" class="table text-nowrap mb-0 align-middle">
        <thead class="text-dark fs-4">
            <tr>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 " >사원코드</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">사원명</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">부서-직급</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">이메일</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">휴대폰번호</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">입사일</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0">퇴사일</h6>
                </th>
            </tr>
        </thead>
        <tbody>
			<c:choose>
	               <c:when test="${empty pagingVO.dataList}">
	                   <tr>
	                       <td colspan="7" class="text-center">조회 결과가 없습니다.</td>
	                   </tr>
	               </c:when>
	               <c:otherwise>
	                   <c:forEach var="empl" items="${pagingVO.dataList}">
	                       <tr>
	                           <td>
	                           		<span class="fw-normal">${empl.emplCode}</span>
                           	   </td>
	                           <td class="title-column">
	                           		<a href="/batirplan/hrm/hrcard/detail?emplCode=${empl.emplCode}">
	                           			${empl.emplNm}
	                           			
	                           			
	                           			<c:choose>
			                           		<c:when test="${empl.hffcSttus eq '02'}">
			                           			(휴직)
			                           		</c:when>
			                           		<c:when test="${empl.hffcSttus eq '03'}">
			                           			(퇴직)
			                           		</c:when>
			                           	</c:choose>
	                           		</a>
	                           </td>
	                           <td>
	                           	<c:choose>
	                           		<c:when test="${empl.deptCode eq '01'}">
	                           			경영지원
	                           		</c:when>
	                           		<c:when test="${empl.deptCode eq '02'}">
	                           			건축기획
	                           		</c:when>
	                           		<c:when test="${empl.deptCode eq '03'}">
	                           			재무
	                           		</c:when>
	                           		<c:when test="${empl.deptCode eq '04'}">
	                           			자원
	                           		</c:when>
	                           		<c:when test="${empl.deptCode eq '05'}">
	                           			IT
	                           		</c:when>
	                           		<c:otherwise>
	                           			기타
	                           		</c:otherwise>
	                           	</c:choose>
	                           	-
	                           	<c:choose>
	                           		<c:when test="${empl.clsfCode eq '01'}">
	                           			사원
	                           		</c:when>
	                           		<c:when test="${empl.clsfCode eq '02'}">
	                           			대리
	                           		</c:when>
	                           		<c:when test="${empl.clsfCode eq '03'}">
	                           			과장
	                           		</c:when>
	                           		<c:when test="${empl.clsfCode eq '04'}">
	                           			차장
	                           		</c:when>
	                           		<c:when test="${empl.clsfCode eq '05'}">
	                           			부장
	                           		</c:when>
	                           		<c:otherwise>
	                           			기타
	                           		</c:otherwise>
	                           	</c:choose>
	                           </td>
	                           <td>${empl.email}</td>
	                           <td>
	                           		${fnc:substring(empl.mbtlnum, 0, 3)}-${fnc:substring(empl.mbtlnum, 3, 7)}-${fnc:substring(empl.mbtlnum, 7, 11)}
	                           </td>
	                           <td>
	                           	<c:if test="${not empty empl.encpn}">
							        <fmt:parseDate var="encpnDate" value="${empl.encpn}" pattern="yyyyMMdd" />
							        <fmt:formatDate value="${encpnDate}" pattern="yyyy-MM-dd" />
							    </c:if>
	                           </td>
	                           <td>
	                           	<c:choose>
							        <c:when test="${empty empl.retireDe}">
							            -
							        </c:when>
							        <c:otherwise>
							            <fmt:parseDate var="retireDate" value="${empl.retireDe}" pattern="yyyyMMdd" />
							            <fmt:formatDate value="${retireDate}" pattern="yyyy-MM-dd" />
							        </c:otherwise>
							    </c:choose>
	                           </td>
	                       </tr>
	                   </c:forEach>
	               </c:otherwise>
	           </c:choose>
        </tbody>
    </table>
</div>


<div class="d-flex justify-content-between align-items-center mt-3">
	<button type="button" class="btn btn-primary" onclick="location.href='/batirplan/hrm/hrcard/register'">신규</button>
	
	<div class="flex-grow-1 d-flex justify-content-center">
		<div id="pagingArea" style="margin-top: 10px; text-align: center;">
		    ${pagingVO.pagingHTML}
		</div>
	</div>
</div>
				
				</div>
			</div>		              
	              
	        </div>
	</div>
</div>


		  <!-- 작업 영역 End -->
		  </div>
  <%@include file="../../module/footerScript.jsp" %>
  <script src="${pageContext.request.contextPath }/assets/libs/inputmask/dist/jquery.inputmask.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/forms/mask.init.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/datatable/datatable-api.init.js"></script>
</body>

<!-- cardList script -->
<script type="text/javascript">
$(function(){
	$.fn.dataTable.ext.errMode = 'none';
	
	$("#hrcardTable").DataTable({
	    paging: false,       // 페이징 비활성화
	    searching: false,    // 검색창 비활성화
	    info: false,         // 정보(몇개 중 몇개) 비활성화
	    ordering: true       // 정렬 기능 활성화 (기본값이 true이긴 하지만 명시)
	});
	
	let pagingArea = $("#pagingArea");
	let searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		let pageNo = $(this).data("page");	// 페이지 번호
		// 검색 영역 안에 들어있는 form을 활용해서 서버 전달
		searchForm.find("#currentPage").val(pageNo);
		searchForm.submit();
	});
});

/* 검색버튼 클릭시 함수 */
$("#searchFormSubmitBtn").on("click", function(){
	$("#currentPage").val("1");
	
	console.log("searchFormSubmitBtn in....");
	let searchForm = $("#searchForm");
	searchForm.submit();
})

/* 리셋버튼 클릭시 이벤트 */
$("#searchFormResetBtn").on("click", function(){
	console.log("searchFormResetBtn in....");
	// input 초기화
    $("#emplCode").val("");
    $("#emplNm").val("");
    $("#deptCode").val("");
    $("#clsfCode").val("");
    $("#email").val("");
    $("#mbtlnum").val("");
    $("#hireDateStart").val("");
    $("#hireDateEnd").val("");
    $("#retireDateStart").val("");
    $("#retireDateEnd").val("");
    // 라디오 버튼도 초기화 (체크 해제)
    $("input[name='hffcSttus']").prop("checked", false);
    // 페이지 번호도 1
    $("#currentPage").val("1");
})

</script>
</html>