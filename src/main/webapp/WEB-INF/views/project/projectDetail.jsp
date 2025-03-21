<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../module/head.jsp" %>

<style>
.process-fieldset {
    border: 1px solid #f1f1f1;  
    border-radius: 5px;  
    position: relative;
    padding: 20px;
}
#previous-step {
    transition: none; 
    color : white;
}
#previous-step:hover {
    color: white; 
}
.overlay {
    display: none; 
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.2); 
    z-index: 999; 
}
.modal {
    display: none; 
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000; 
}
.modal-content {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
}
#managerSelectionModal .modal-content {
    background-color: white;
    width: 40%;
    margin: 10% auto;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
    position: relative;
    max-height: 500px;
    overflow-y: auto;
}
#managerSelectionModal .modal-content table {
    width: 100%;
    border-collapse: collapse;
}
#managerSelectionModal .modal-content th,
#managerSelectionModal .modal-content td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}
#managerSelectionModal .modal-content th {
    background-color: #f2f2f2;
}
#managerSelectionModal .modal-content .btn {
    padding: 8px 12px;
    cursor: pointer;
    margin: 5px;
}
#managerSelectionModal .clickable {
    cursor: pointer;
    color: blue;
    text-decoration: underline;
}
#managerSelectionModal .clickable:hover {
    font-weight: bold;
}
#managerSelectionModal .btn {
    border: 1px solid #ccc;   
    border-radius: 6px;
}
#managerSelectionModal .btn:hover {
	background-color: #eaeaea;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
}
/* 체크리스트 모달 관련 기본 스타일 */
#checklistModal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
    background-color: white;
    border-radius: 8px;
    width: 50%;
    max-height: 80vh;
    overflow-y: auto;
}
.close-button {
    position: absolute;
    top: 15px; 
    right: 20px; 
    background: none;  
    border: none;      
    font-size: 22px;  
    font-weight: bold;
    cursor: pointer;
}
.detail-container {
    padding: 20px;
}
.detail-header {
    margin-bottom: 20px;
}
.detail-header h3 {
    margin: 0;
}
.detail-list {
    margin-top: 20px;
}
.detail-list ul {
    list-style-type: disc;
    margin-left: 20px;
}
#checklistDetailDiv th {
    text-align: center !important;
    vertical-align: middle !important;
}
.btn-custom {
  padding: 0.5rem 1rem;  /* 원하는 여백으로 조정 */
  font-size: 1rem;       /* 글자 크기 조정 */
  white-space: nowrap;   /* 텍스트가 한 줄에 나오도록 */
}
</style>

<body class="link-sidebar">
<%@ include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper">
	
	<%@ include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@ include file="../module/navBar.jsp" %>
      	<div class="body-wrapper">
      		<div class="container-fluid">
      			<!-- 작업 영역 Start -->
      			
      			<div class="card card-body py-3">
      				<div class="row align-items-center">
      					<h4 class="mb-4 mb-sm-0 card-title">프로젝트 상세정보</h4>
   					</div>
				</div>
				
				<div class="card">
					<div class="card-body wizard-content">
						<!-- 탭 네비게이션 (두 개 탭) -->
	                    <ul class="nav nav-underline" role="tablist">
	                        <li class="nav-item" role="presentation">
	                            <a class="nav-link active" data-bs-toggle="tab" href="#tab1" role="tab" aria-selected="true">
	                                <span>프로젝트 상세</span>
	                            </a>
	                        </li>
	                        <li class="nav-item" role="presentation">
	                            <a class="nav-link" data-bs-toggle="tab" href="#tab2" role="tab" aria-selected="false" tabindex="-1">
	                                <span>계획 정보</span>
	                            </a>
	                        </li>
	                    </ul>
	                    
						<!-- 탭 내용 영역 -->
                    <div class="tab-content">
                        <!-- 첫번째 탭: 프로젝트 상세 정보 -->
                        <div class="tab-pane active" id="tab1" role="tabpanel">
                            
                            <!-- 프로젝트 상세 정보 출력 -->
                            <div class="project-detail-info mt-4">
                            
                                <div class="table-responsive mb-4 border rounded-1">
                                <table class="table text-nowrap mb-0 align-middle" style="width: 100%; table-layout: fixed;">
                                    <tr>
                                        <th>
                                        	<h6 class="fs-4 fw-semibold mb-0">프로젝트명</h6>
                                       	</th>
                                        <td colspan="5" style="white-space: normal; overflow-wrap: break-word;">
                                        	<h6 class="fs-4 fw-normal mb-0">${project.prjctNm}(${project.prjctCtgry})</h6>
                                       	</td>
                                    </tr>
                                    <colgroup>
								        <col style="width: 10%;">
								        <col style="width: 15%;">
								        <col style="width: 10%;">
								        <col style="width: 20%;">
								        <col style="width: 10%;">
								        <col style="width: 35%;">
								    </colgroup>
                                    <tr>
                                        <th>
                                        	<h6 class="fs-4 fw-semibold mb-0">담당자</h6>
                                       	</th>
                                        <td>
                                        	<h6 class="fs-4 fw-normal mb-0">${project.charger}</h6>
                                       	</td>
                                       	<th>
                                        	<h6 class="fs-4 fw-semibold mb-0">예산</h6>
                                       	</th>
                                        <td>
                                        	<h6 class="fs-4 fw-normal mb-0">
                                        		<fmt:formatNumber value="${project.prjctBudget }"/>원
                                        	</h6>
                                       	</td>
                                       	<th>
                                        	<h6 class="fs-4 fw-semibold mb-0">일정</h6>
                                       	</th>
                                        <td>
                                        	<h6 class="fs-4 fw-normal mb-0">
	                                            ${fnc:substring(project.prjctBgnde, 0, 4)}-${fnc:substring(project.prjctBgnde, 4, 6)}-${fnc:substring(project.prjctBgnde, 6, 8)}
	                                            ~ 
	                                            ${fnc:substring(project.prjctEndde, 0, 4)}-${fnc:substring(project.prjctEndde, 4, 6)}-${fnc:substring(project.prjctEndde, 6, 8)}
                                        	</h6>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="white-space: normal; overflow-wrap: break-word;">
                                        	<h6 class="fs-4 fw-normal mb-0">${project.prjctCn}</h6>
                                       	</td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" style="padding: 0;">
                                            <div id="map" style="width:100%; height:500px;"></div>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                                <hr/>
                                
                                <h4>현장 담당자</h4>
                                
                                <!-- 현장 담당자 배정 영역 -->
                                <div class="d-flex align-items-center justify-content-between mt-3">
								  <!-- 왼쪽: 아이콘 및 담당자 정보 -->
								  <div class="d-flex align-items-center">
								      <i class="ti ti-users text-success display-6" style="margin-left: 10px;"></i>
								    <div class="ms-4">
								      <div style="display: flex; align-items: center;">
								  <h4 class="card-title text-dark" style="font-size: 15px; margin:0;">담당자&ensp;:&ensp;</h4>
								  <span id="siteManagerStatus" data-id="${project.sptMngr}" style="font-size: 15px; margin:0;">
								    ${project.sptMngr != null && !project.sptMngr.isEmpty() ? project.sptMngr : '(담당자 설정이 필요합니다)'}
								  </span>
								</div>
								
								      <div id="siteManagerDetails" style="font-size: 15px; display: flex; align-items: center;">
								        <c:if test="${siteManager != null}">
								          <h4 class="card-title text-dark" style="font-size: 15px; margin:0;">부서(직급)&ensp;:&ensp;</h4>
								          <c:choose><c:when test="${siteManager.deptCode == '01'}">경영지원</c:when><c:when test="${siteManager.deptCode == '02'}">건축기획</c:when><c:when test="${siteManager.deptCode == '03'}">재무</c:when><c:when test="${siteManager.deptCode == '04'}">자원</c:when><c:when test="${siteManager.deptCode == '05'}">IT</c:when><c:otherwise>${siteManager.deptCode}</c:otherwise></c:choose>(<c:choose><c:when test="${siteManager.clsfCode == '01'}">사원</c:when><c:when test="${siteManager.clsfCode == '02'}">대리</c:when><c:when test="${siteManager.clsfCode == '03'}">과장</c:when><c:when test="${siteManager.clsfCode == '04'}">차장</c:when><c:when test="${siteManager.clsfCode == '05'}">부장</c:when><c:when test="${siteManager.clsfCode == '06'}">이사</c:when><c:when test="${siteManager.clsfCode == '07'}">부사장</c:when><c:when test="${siteManager.clsfCode == '08'}">사장</c:when><c:otherwise>${siteManager.clsfCode}</c:otherwise></c:choose>)&ensp;|&ensp;
								          <h4 class="card-title text-dark" style="font-size: 15px; margin:0;">이메일&ensp;:&ensp;</h4>${siteManager.email}&ensp;|&ensp;
								          <h4 class="card-title text-dark" style="font-size: 15px; margin:0;">전화번호&ensp;:&ensp;</h4>${fnc:substring(siteManager.mbtlnum, 0, 3)}-${fnc:substring(siteManager.mbtlnum, 3, 7)}-${fnc:substring(siteManager.mbtlnum, 7, 11)}
								        </c:if>
								      </div>
								    </div>
								  </div>
								  <!-- 오른쪽: 버튼 영역 -->
								  <div class="d-flex align-items-center">
								    <button type="button" id="setSiteManagerBtn" class="btn btn-primary">설정</button>
								    <button type="button" id="deleteSiteManagerBtn" class="btn btn-danger ms-1" style="display: ${project.sptMngr eq '(담당자 설정이 필요합니다)' ? 'none' : 'inline-block'};">
								      삭제
								    </button>
								  </div>
								</div>
                            </div>
                        </div>
                        
                        <!-- 두번째 탭: 계획 정보 (현장 담당자, 공정별 계획 등) -->
                        <div class="tab-pane" id="tab2" role="tabpanel">
                        	
                        	<!-- 계획 진척도 영역 -->
                            <fieldset class="process-fieldset mt-4">
                                <form action="#" class="tab-wizard wizard-circle wizard clearfix" role="application" id="steps-uid-5">
                                    <div class="steps clearfix">
                                        <ul role="tablist" id="stepList">
                                            <li role="tab">
                                                <a aria-controls="steps-uid-5-p-1">
                                                    <span class="step">1</span> 기초 품목 신고 완료
                                                </a>
                                            </li>
                                            <li role="tab">
                                                <a aria-controls="steps-uid-5-p-2">
                                                    <span class="step">2</span> 업체 선정 완료
                                                </a>
                                            </li>
                                            <li role="tab">
                                                <a aria-controls="steps-uid-5-p-3">
                                                    <span class="step">3</span> 체크리스트 배정 완료
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </form>
                                <hr/>
                        	
                                <h5 class="card-title mb-3">공정별 계획</h5>
                                
                                <div class="row mt-3">
                                    <!-- 왼쪽: 수직 네비게이션 -->
                                    <div class="col-md-3 mb-3">
                                        <div class="nav flex-column nav-pills mb-4 mb-md-0" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                                            <c:forEach var="process" items="${processes}" varStatus="status">
                                                <a class="nav-link ${status.first ? 'active' : ''}" 
                                                   id="v-pills-process-${process.procsNo}-tab" 
                                                   data-bs-toggle="pill" 
                                                   href="#v-pills-process-${process.procsNo}" 
                                                   role="tab" 
                                                   aria-controls="v-pills-process-${process.procsNo}" 
                                                   aria-selected="${status.first ? 'true' : 'false'}">
                                                    <span>${process.procsOrdr}. ${process.procsNm}</span>
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <!-- 오른쪽: 탭 콘텐츠 -->
                                    <div class="col-md-9" style="position: relative;">
                                        <div class="tab-content" id="v-pills-tabContent">
                                            <c:forEach var="process" items="${processes}" varStatus="status">
                                                <div class="tab-pane fade ${status.first ? 'active show' : ''}"
                                                     id="v-pills-process-${process.procsNo}"
                                                     role="tabpanel"
                                                     aria-labelledby="v-pills-process-${process.procsNo}-tab">
                                                    
                                                    <!-- 공정별 상태 및 버튼 영역 -->
                                                    <div style="display: flex; align-items: center; justify-content: space-between;">
                                                        <div style="display: flex; align-items: center; height: 100%;">
                                                            <c:choose>
                                                                <c:when test="${process.procsOrdr == 1}">
                                                                	<c:choose>
                                                                        <c:when test="${process.progrsSttus == '01'}">
                                                                            <span style="color: black; font-size: 17px;"><i class="ti ti-alert-circle text-danger fs-8" style="vertical-align: middle;"></i> 기초 품목 신고 필요</span>
                                                                        </c:when>
                                                                        <c:when test="${process.progrsSttus == '02'}">
                                                                            <span style="color: black; font-size: 17px;"><i class="ti ti-circle-check text-primary fs-8" style="vertical-align: middle;"></i> 기초 품목 신고 완료</span>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${process.progrsSttus == '03'}">
                                                                            <span style="color: black; font-size: 17px;"><i class="ti ti-alert-circle text-danger fs-8" style="vertical-align: middle;"></i> 입찰 공고 미작성</span>
                                                                        </c:when>
                                                                        <c:when test="${process.progrsSttus == '04'}">
                                                                            <span style="color: black; font-size: 17px;">
                                                                                <i class="ti ti-circle-check text-primary fs-8" style="vertical-align: middle;"></i> 입찰 공고 작성 완료 &emsp;
                                                                                <i class="ti ti-alert-circle text-danger fs-8" style="vertical-align: middle;"></i> 업체 미선정
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${process.progrsSttus == '05'}">
                                                                            <span style="color: black; font-size: 17px;">
                                                                                <i class="ti ti-circle-check text-primary fs-8" style="vertical-align: middle;"></i> 입찰 공고 작성 완료 &emsp;
                                                                                <i class="ti ti-circle-check text-primary fs-8" style="vertical-align: middle;"></i> 업체 선정 완료
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span style="color: black; font-size: 17px;">
                                                                                <i class="ti ti-alert-circle text-danger fs-8" style="vertical-align: middle;"></i> 상태 정보 없음
                                                                                <i class="ti ti-alert-circle text-danger fs-8" style="vertical-align: middle;"></i>
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        
                                                        <!-- 버튼 영역 -->
                                                        <div>
                                                            <c:choose>
                                                                <c:when test="${process.procsOrdr == 1}">
                                                                    <c:choose>
                                                                        <c:when test="${process.progrsSttus == '01'}">
                                                                            <button class="btn btn-info" id="btn${process.procsNo}"
                                                                                    onclick="declarationWriteForm(${project.prjctNo})">
                                                                                기초 품목 신고
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button class="btn btn-warning" id="btn${process.procsNo}_confirm"
                                                                                    onclick="location.href='/batirplan/project/declaration/detail/${declaration.dclrtNo}'">
                                                                                신고 품목 확인
                                                                            </button>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <c:when test="${process.progrsSttus == '03'}">
                                                                            <button class="btn btn-info" id="btn${process.procsNo}"
                                                                                    onclick="location.href='/batirplan/project/bid/write/${project.prjctNo}/${process.procsNo}'">
                                                                                입찰 공고 작성
                                                                            </button>
                                                                        </c:when>
                                                                        <c:when test="${process.progrsSttus == '04'}">
                                                                            <c:set var="bidForProcess" value="${bidMap[process.procsNo]}" />
                                                                            <c:if test="${not empty bidForProcess}">
                                                                                <button class="btn btn-warning" id="btn${process.procsNo}_bid"
                                                                                        onclick="location.href='/batirplan/project/bid/detail/${bidForProcess.pblancNo}'">
                                                                                    입찰 공고 확인
                                                                                </button>
                                                                            </c:if>
                                                                        </c:when>
                                                                        <c:when test="${process.progrsSttus == '05'}">
                                                                            <c:set var="bidForProcess" value="${bidMap[process.procsNo]}" />
                                                                            <c:if test="${not empty bidForProcess}">
                                                                                <button class="btn btn-warning" id="btn${process.procsNo}_bid"
                                                                                        onclick="location.href='/batirplan/project/bid/detail/${bidForProcess.pblancNo}'">
                                                                                    입찰 공고 확인
                                                                                </button>
                                                                            </c:if>
                                                                            <c:if test="${not empty approvedQuotationMap[process.procsNo]}">
                                                                                <button class="btn btn-warning" id="btn${process.procsNo}_quote"
                                                                                        onclick="location.href='/batirplan/project/bid/quotation/detail/${approvedQuotationMap[process.procsNo].prqudoNo}'">
                                                                                    견적서 확인
                                                                                </button>
                                                                            </c:if>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <!-- 필요시 추가 처리 -->
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <hr/>
                                                    
                                                    <!-- 공정 상세 내용 영역 -->
                                                    <div class="process-detail-display" style="margin-top: 10px;">
                                                        <c:if test="${not empty process.procsCn}">
                                                        	<h5 class="mb-3">공정 정보</h5>
                                                            <div style="background: #f9f9f9; border: 1px solid #e0e0e0; border-radius: 4px; padding: 10px; margin-bottom: 10px;">
                                                                <p style="margin: 0; color: #555;">
                                                                    <span>
                                                                        <fmt:formatDate value="${process.procsBgnde}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${process.procsEndde}" pattern="yyyy-MM-dd" />
                                                                    </span>
                                                                </p>
                                                                <hr style="margin: 8px 0; border: none; border-top: 1px solid #ddd;" />
                                                                <div style="font-size: 0.9rem; color: #444;">
                                                                    ${process.procsCn}
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${empty process.procsCn}">
                                                            <div id="afterUpdate_${process.procsNo}" class="process-input">
                                                                <h5 class="mb-3">공정 정보</h5>
                                                                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 5px;">
                                                                    <label class="form-label" for="a_${process.procsNo}" style="margin: 0;">시작일</label>
                                                                    <input id="a_${process.procsNo}" type="date" class="form-control form-control-sm process-start" style="width: 20%;">&nbsp;
                                                                    <label class="form-label" for="b_${process.procsNo}" style="margin: 0;">종료일</label>
                                                                    <input id="b_${process.procsNo}" type="date" class="form-control form-control-sm process-end" style="width: 20%;">
                                                                </div>
                                                                <textarea id="mymce_${process.procsNo}" class="form-control process-content mt-3" placeholder="공정 내용을 입력하세요" style="margin-bottom: 5px; height: auto;"></textarea>
                                                                <div style="margin-top: 10px; text-align: right;">
                                                                    <button class="btn btn-primary process-submit" data-procs-no="${process.procsNo}">
                                                                        제출
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <!-- 공통 버튼 컨테이너 -->
                                        <div id="common-button-container" style="position: absolute; bottom: 0; right: 15px;"></div>
                                    </div>
                                </div>
                                
                                <hr/>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <h5 class="card-title mb-3">체크리스트</h5>
                                        <c:forEach var="process" items="${processes}">
                                            <div>
                                                <span style="font-size: 15px; color: black;">${process.procsOrdr}. ${process.procsNm}&ensp;:&nbsp;</span>
                                                <c:choose>
                                                    <c:when test="${not empty process.assignedChecklistTitle}">
                                                        <span style="font-size: 15px;">${process.assignedChecklistTitle}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="ti ti-alert-triangle text-warning fs-6" style="vertical-align: middle;"></i>(미배정)
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button type="button" class="btn btn-info" onclick="openChecklistModal()">설정</button>
                                </div>
                            </fieldset>
                        </div>
                    </div>
       					<!-- <button type="button" class="btn btn-secondary" onclick="list()" style="margin-top: 20px; float: right;">목록</button> -->
           			</div>
       			</div>
       			
          		<!-- 작업 영역 End -->
          		
			</div>
		</div>
	</div>
</div>

<div id="overlay" class="overlay"></div>
<div id="managerSelectionModal" class="modal">
    <div class="modal-content">
    	<input type="hidden" id="prjctNo" value="${project.prjctNo}">
    	
        <button type="button" class="close-button" onclick="closeSelectionModal()">
            &times;
        </button>
    
        <h4>현장 담당자 선택</h4>
        <table>
            <thead>
                <tr>
                    <th>부서</th>
                    <th>직급</th>
                    <th>이름</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="prevDept" value="" />

                <c:forEach var="employee" items="${employeeList}">
                    <c:set var="count" value="0" />
                    <c:forEach var="emp" items="${employeeList}">
                        <c:if test="${emp.deptCode eq employee.deptCode}">
                            <c:set var="count" value="${count + 1}" />
                        </c:if>
                    </c:forEach>

                    <tr>
                        <c:if test="${employee.deptCode != prevDept}">
                            <td rowspan="${count}" style="font-weight: bold;">
                                <c:choose>
                                    <c:when test="${employee.deptCode == '01'}">경영지원</c:when>
                                    <c:when test="${employee.deptCode == '02'}">건축기획</c:when>
                                    <c:when test="${employee.deptCode == '03'}">재무</c:when>
                                    <c:when test="${employee.deptCode == '04'}">자원</c:when>
                                    <c:when test="${employee.deptCode == '05'}">IT</c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </td>
                            <c:set var="prevDept" value="${employee.deptCode}" />
                        </c:if>
                        
                        <td>
                            <c:choose>
                                <c:when test="${employee.clsfCode == '01'}">사원</c:when>
                                <c:when test="${employee.clsfCode == '02'}">대리</c:when>
                                <c:when test="${employee.clsfCode == '03'}">과장</c:when>
                                <c:when test="${employee.clsfCode == '04'}">차장</c:when>
                                <c:when test="${employee.clsfCode == '05'}">부장</c:when>
                                <c:when test="${employee.clsfCode == '06'}">이사</c:when>
                                <c:when test="${employee.clsfCode == '07'}">부사장</c:when>
                                <c:when test="${employee.clsfCode == '08'}">사장</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </td>

                        <!-- 사원 이름을 클릭할 수 있게 설정 -->
                        <td class="clickable" data-id="${employee.emplCode}" data-name="${employee.emplNm}">
                            ${employee.emplNm}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <button type="button" class="btn" onclick="closeSelectionModal()">취소</button>
    </div>
</div>

<sec:authentication property="principal.memberVO.empVO.emplCode" var="emplCode" />
<input type="hidden" id="currentEmplCode" value="${emplCode}" />

<!-- 체크리스트 모달 -->
<div id="checklistModal" class="modal">
  <div class="modal-content">
    <button type="button" class="close-button" onclick="closeChecklistModal()">&times;</button>
    
    <!-- 체크리스트 목록 DIV (초기 노출) -->
    <div id="checklistListDiv">
      <h5 class="mb-3" style="text-align: center;">체크리스트 목록</h5>
      <table class="table table-bordered">
        <thead>
          <tr>
            <th style="text-align: center;">번호</th>
            <th>제목</th>
            <th style="text-align: center;">작성일</th>
          </tr>
        </thead>
        <tbody>
          <!-- checklistList는 컨트롤러에서 전달받은 체크리스트 목록 -->
          <c:forEach var="checklist" items="${checklistList}">
            <tr>
              <td>${checklist.chklstNo}</td>
              <td>
                <!-- detail로 직접 이동 대신, 클릭 시 자바스크립트 함수 호출 -->
                <a href="javascript:void(0);" onclick="viewChecklistDetail(${checklist.chklstNo})">
                  ${checklist.chklstSj}
                </a>
              </td>
              <td>
				  ${fnc:substring(checklist.writngDe, 0, 4)}-${fnc:substring(checklist.writngDe, 4, 6)}-${fnc:substring(checklist.writngDe, 6, 8)}
				</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div class="text-center">
		  <button type="button" class="btn btn-secondary" onclick="showNewChecklistForm()">체크리스트 작성</button>
		  <button type="button" class="btn btn-primary" onclick="showAssignChecklistForm()">체크리스트 배정</button>
		</div>
    </div>
    
    <!-- 새 체크리스트 작성 폼 DIV (초기 숨김) -->
    <div id="newChecklistFormDiv" style="display:none;">
      <h5 class="mb-3" style="text-align: center;">새 체크리스트 작성</h5>
      <form id="newChecklistForm" method="post" action="/batirplan/project/safetyCheckList/save">
        <!-- 체크리스트 제목 -->
        <div class="mb-3">
          <input type="text" id="chklstSj" name="chklstSj" class="form-control" placeholder="제목을 입력하세요." required>
        </div>
        
        <!-- 세부 항목 입력 컨테이너 -->
        <div id="detailItemsContainer">
          <!-- 첫번째 항목 (기본 한 줄, 우측 버튼은 "+" 버튼) -->
          <div class="row mb-3 detail-item">
            <div class="col-sm-11">
              <input type="text" class="form-control" name="detailItems[]" placeholder="세부 항목을 입력하세요." required>
            </div>
            <div class="col-sm-1" style="padding-right: 15px;">
              <button type="button" class="btn btn-success btn-sm" onclick="addDetailItem(this)" style="width: 100%; height: 100%;">
                <i class="ti ti-circle-plus"></i>
              </button>
            </div>
          </div>
        </div>
        
        <!-- 제출 및 목록 보기 버튼 -->
        <div class="text-center">
		  <button type="submit" class="btn btn-primary">저장</button>
		  <button type="button" class="btn btn-secondary" onclick="showChecklistList()">목록</button>
		</div>
      </form>
    </div>
    
    <!-- 체크리스트 상세보기 DIV (초기 숨김) -->
    <div id="checklistDetailDiv" style="display:none;">
	  <h5 class="mb-3">체크리스트 상세보기</h5>
	  
	  <!-- 테이블로 변경 -->
	  <table class="table table-bordered">
	    <tbody>
	      <!-- 제목 -->
	      <tr>
	        <th style="width: 20%;">제목</th>
	        <td id="detailTitle" style="width: 80%;"></td>
	      </tr>
	      
	      <!-- 작성일 -->
	      <tr>
	        <th>작성일</th>
	        <td id="detailDate"></td>
	      </tr>
	      
	      <!-- 작성자 -->
	      <tr>
	        <th>작성자</th>
	        <td id="detailWriter"></td>
	      </tr>
	      
	      <!-- 세부 항목 (하나의 행에 합쳐서 표시) -->
	      <tr>
	        <th>세부 항목</th>
	        <td>
	          <ul id="detailItemsList"></ul>
	        </td>
	      </tr>
	    </tbody>
	  </table>
	  
	  <!-- 목록으로 돌아가기 버튼 -->
	  <button type="button" class="btn btn-secondary" onclick="showChecklistList()">
	    목록
	  </button>
	</div>
	
	<div id="assignChecklistDiv" style="display:none;">
      <h5 class="mb-3" style="text-align: center;">체크리스트 배정</h5>
      <!-- 공정 선택 영역 -->
		<!-- 체크리스트 배정 영역 -->
		<div class="mb-3">
		  <table class="table table-bordered">
		    <thead>
		      <tr>
		        <th style="width: 30%; text-align: center;">공정</th>
		        <th style="width: 50%; text-align: center;">체크리스트 선택</th>
		        <th style="width: 20%; text-align: center;">배정</th>
		      </tr>
		    </thead>
		    <tbody>
		      <!-- processes: 공정 목록 -->
		      <c:forEach var="proc" items="${processes}">
			    <tr>
			        <td style="vertical-align: middle;"><strong>${proc.procsOrdr}. ${proc.procsNm}</strong></td>
			        <td>
			            <select class="form-select assign-checklist-select"
			                    data-procs-no="${proc.procsNo}">
			                <option value="">- 체크리스트를 선택하세요 -</option>
			                <c:forEach var="checklist" items="${checklistList}">
			                    <option value="${checklist.chklstNo}">${checklist.chklstSj}</option>
			                </c:forEach>
			            </select>
			        </td>
			        <td>
					  <div style="display: flex; gap: 5px; align-items: center;">
						  <button type="button" class="btn btn-primary btn-custom" onclick="assignChecklist(${proc.procsNo})">
						    배정
						  </button>
						  <button type="button" class="btn btn-danger btn-custom" onclick="deleteAssignedChecklist(${proc.procsNo})">
						    삭제
						  </button>
						</div>
					</td>
			    </tr>
			</c:forEach>
		    </tbody>
		  </table>
		</div>
      <div class="text-center">
		  <button type="button" class="btn btn-secondary" onclick="showChecklistList()">목록</button>
		</div>
    </div>
  </div>
</div>


<%@ include file="../module/footerScript.jsp" %>
<script src="${pageContext.request.contextPath }/assets/libs/jquery.repeater/jquery.repeater.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/repeater-init.js"></script>
<!-- TinyMCE 초기화 -->
<script src="${pageContext.request.contextPath }/assets/libs/tinymce/tinymce.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/forms/tinymce-init.js"></script>

</body>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=126a30d2a46843ee25bc69a141aa9849&libraries=services"></script>
<script type="text/javascript">
//'planStatus' 값에 따라 currentStep 설정
let currentStep = 0;
const planStatus = "${project.planSttus}";  // JSP에서 전달된 project.planSttus 값

if (planStatus === '00') {
    currentStep = -1;  // 기초 단계
} else if (planStatus === '01') {
    currentStep = 0;  // 첫 번째 단계: 기초 품목 신고 완료
} else if (planStatus === '02') {
    currentStep = 1;  // 두 번째 단계: 업체 선정 완료
} else if (planStatus === '03') {
    currentStep = 2;  // 세 번째 단계: 안전 체크리스트 배정 완료
}

function updateStepDisplay() {
    const steps = document.querySelectorAll(".steps li");
    const sections = document.querySelectorAll(".content section");

    // 모든 단계를 완료 표시하거나 초기화
    for (let i = 0; i < steps.length; i++) {
        if (i <= currentStep) {
            steps[i].classList.add("done");
        } else {
            steps[i].classList.remove("done");
        }
    }

    // 각 단계별 섹션 표시 여부 결정
    sections.forEach((section, index) => {
        if (index === currentStep) {
            section.style.display = "block";
        } else {
            section.style.display = "none";
        }
    });

    // 첫 번째 단계에서는 '이전' 버튼 숨기기
    if (currentStep === 0) {
        prevBtn.style.display = "none";
    } else {
        prevBtn.style.display = "inline-block";
    }

    // 마지막 단계에서는 '다음' 버튼 숨기고 '완료' 버튼 보이기
    if (currentStep === steps.length - 1) {
        nextBtn.style.display = "none";
        finishBtn.style.display = "inline-block";
    } else {
        nextBtn.style.display = "inline-block";
        finishBtn.style.display = "none";
    }
}

//카카오맵을 초기화하고, 주소에 맞는 지도를 표시하는 함수
function displayMap() {
    var address = "${project.prjctLc}"; // 예시: "서울 강남구 역삼동"

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 기본 지도의 중심 좌표
            level: 3 // 지도의 확대 수준
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding: 5px; white-space: nowrap; overflow: hidden; text-align:center; color:black; font-weight:bold;">' + address + '</div>' // 주소 표시
            });
            infowindow.open(map, marker);
            map.setCenter(coords);
        } else {
            Swal.fire({
                title: "주소 검색 실패",
                text: "입력된 주소를 찾을 수 없습니다. 주소를 다시 확인해주세요.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });
}

//현장 담당자 설정 버튼 클릭 시
$(document).on("click", ".clickable", function () {
    const emplName = $(this).data("name");  // 선택된 사원의 이름
    const emplCode = $(this).data("id");      // 선택된 사원의 사원 코드
    const prjctNo = $("#prjctNo").val();      // 프로젝트 번호

    console.log("선택된 사원 코드:", emplCode);  // 확인용 로그

    // 1. 담당자 이름과 정보를 즉시 업데이트
    $('#siteManagerStatus').text(emplName);  // 현장 담당자 이름 업데이트
    $('#siteManagerStatus').data("id", emplCode);  // emplCode 값을 data-id에 설정
    $('#deleteSiteManagerBtn').show();       // 삭제 버튼 표시

    // 2. 사원 정보 조회하여 상세정보를 즉시 업데이트
    $.ajax({
        url: '/batirplan/project/projectpm/updateSiteManager',  // 담당자 업데이트 서버 URL
        type: 'POST',
        dataType: 'json', // 응답을 JSON으로 파싱
        data: {
            emplCode: emplCode,
            emplName: emplName,
            prjctNo: prjctNo
        },
        success: function(response) {
            console.log("응답 성공", response);  // 응답 확인
            
            if (response.success) {
                const employee = response.empl;
                console.log("Employee 객체:", employee);
                
                // 부서 및 직급 매핑 객체
                var deptMapping = {
                    '01': '경영지원',
                    '02': '건축기획',
                    '03': '재무',
                    '04': '자원',
                    '05': 'IT'
                };
                var clsfMapping = {
                    '01': '사원',
                    '02': '대리',
                    '03': '과장',
                    '04': '차장',
                    '05': '부장',
                    '06': '이사',
                    '07': '부사장',
                    '08': '사장'
                };
                // 매핑 적용
                var deptName = deptMapping[employee.deptCode] || employee.deptCode;
                var clsfName = clsfMapping[employee.clsfCode] || employee.clsfCode;
                
                // 전화번호 포맷 (예: "01012345678" → "010-1234-5678")
                var phone = employee.mbtlnum;
                if (phone && phone.length >= 11) {
                    phone = phone.substring(0, 3) + '-' + phone.substring(3, 7) + '-' + phone.substring(7, 11);
                }
                
                // 문자열 연결을 사용해 HTML 생성
                var htmlContent = "<h4 class='card-title text-dark' style='font-size: 15px; margin:0;'>부서(직급)&ensp;:&ensp;</h4>" + deptName + "(" + clsfName + ")&ensp;|&ensp;" +
                                  "<h4 class='card-title text-dark' style='font-size: 15px; margin:0;'>이메일&ensp;:&ensp;</h4>" + employee.email + "&ensp;|&ensp;" +
                                  "<h4 class='card-title text-dark' style='font-size: 15px; margin:0;'>전화번호&ensp;:&ensp;</h4>" + phone;
                
                $('#siteManagerDetails').html(htmlContent);

                // 성공 메시지 추가
                Swal.fire({
                    title: "현장 담당자 설정 완료!",
                    text: emplName + " 님이 현장 담당자로 지정되었습니다.",
                    icon: "success",
                    confirmButtonText: "확인"
                });

            } else {
                console.error("사원 정보 불러오기 실패", response.message);
                $('#siteManagerDetails').html("사원 정보를 불러오는 데 실패했습니다.");
                Swal.fire({
                    title: "오류!",
                    text: "사원 정보를 불러오는 데 실패했습니다.",
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error: ", error);
            Swal.fire({
                title: "서버 오류!",
                text: "서버와의 연결에 실패했습니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });

    // 4. 현장 담당자 설정 후 모달 닫기
    closeSelectionModal();
});

//현장 담당자 삭제 버튼 클릭 시 처리
$(document).on("click", "#deleteSiteManagerBtn", function() {
    const prjctNo = $("#prjctNo").val(); // 프로젝트 번호
    const emplCode = $("#siteManagerStatus").data("id");  // 현장 담당자 사원 코드 가져오기

    console.log("삭제하려는 사원 코드:", emplCode);  // 확인용 로그

    if (!emplCode) {
        Swal.fire("오류!", "담당자 코드가 없습니다.", "error");
        return;
    }

    Swal.fire({
        title: "현장 담당자를 삭제하시겠습니까?",
        text: "삭제 후에는 복구할 수 없습니다!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "삭제",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            deleteSiteManager(emplCode, prjctNo);
        }
    });
});

// 현장 담당자 삭제 함수 (AJAX 요청)
function deleteSiteManager(emplCode, prjctNo) {
    $.ajax({
        url: '/batirplan/project/projectpm/deleteSiteManager',  // 담당자 삭제 서버 URL
        type: 'POST',
        data: { emplCode: emplCode, prjctNo: prjctNo },
        success: function(response) {
            if (response.success) {
                Swal.fire("삭제 완료!", "현장 담당자가 삭제되었습니다.", "success");
                $('#siteManagerStatus').text('(담당자 설정이 필요합니다)');
                $('#siteManagerDetails').html('');  // 현장 담당자 세부 정보 초기화
                $('#deleteSiteManagerBtn').hide();  // 삭제 버튼 숨기기
            } else {
                Swal.fire("삭제 실패!", "담당자 삭제에 실패했습니다.", "error");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error: ", error);
            Swal.fire("오류!", "서버와의 연결에 실패했습니다.", "error");
        }
    });
}

// 현장 담당자 설정 버튼 클릭 시 모달 열기
document.getElementById('setSiteManagerBtn').addEventListener('click', function() {
    $("#managerSelectionModal").fadeIn(); // 모달 열기
    $("#overlay").fadeIn();
    $("body").css("overflow", "hidden");
});

// 모달 닫기 버튼 클릭 시
document.querySelector('.close-button').addEventListener('click', function() {
    closeSelectionModal(); // 모달 닫기
});

// 모달 닫기
function closeSelectionModal() {
    $("#managerSelectionModal").fadeOut(); // 모달 숨기기
    $("#overlay").fadeOut();
    $("body").css("overflow", "auto");
}

//페이지 로드 시, 초기 활성 탭의 버튼 콘텐츠 업데이트
function updateCommonButtons() {
  var activeTabPane = document.querySelector('.tab-pane.active');
  if (activeTabPane) {
    var buttonContent = activeTabPane.querySelector('.button-content');
    if (buttonContent) {
      document.getElementById('common-button-container').innerHTML = buttonContent.innerHTML;
    }
  }
}

// 초기 업데이트
updateCommonButtons();

// Bootstrap 탭 전환 이벤트 리스너 추가
var tabTriggerList = [].slice.call(document.querySelectorAll('#v-pills-tab a.nav-link'));
tabTriggerList.forEach(function(tabTriggerEl) {
  tabTriggerEl.addEventListener('shown.bs.tab', function (event) {
    updateCommonButtons();
  });
});

$(document).on("click", ".process-submit", function(){
    var procsNo = $(this).data("procs-no");
    let editorId = 'mymce_' + procsNo;
    let startId = 'a_' + procsNo;
    let endId = 'b_' + procsNo;

    // 모든 에디터의 내용을 텍스트에리어에 동기화
    tinymce.triggerSave();
    
    // 해당 에디터의 HTML 콘텐츠를 가져옴
    let content = tinymce.get(editorId).getContent({ format: 'html' });
    
    // HTML 태그만 남은 경우 빈 문자열로 처리
    if(content.replace(/<[^>]+>/g, '').trim() === ""){
        content = "";
    }

    // 시작일, 종료일 값을 가져옴
    var startDate = $("#" + startId).val();
    var endDate = $("#" + endId).val();

    console.log("제출 전 내용:", content);
    console.log("시작일:", startDate);
    console.log("종료일:", endDate);

    // 필수 입력값 확인
    if (!startDate || !endDate) {
        Swal.fire({
            title: "입력 오류!",
            text: "시작일과 종료일을 입력해주세요.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    if (content.trim() === "") {
        Swal.fire({
            title: "입력 오류!",
            text: "공정 내용을 입력해주세요.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    // AJAX 요청으로 업데이트 처리
    $.ajax({
       url: '/batirplan/project/process/updateDetails',
       type: 'POST',
       dataType: 'json',
       data: {
         procsNo: procsNo,
         procsCn: content,
         procsBgnde: startDate,
         procsEndde: endDate
       },
       success: function(response){
         if(response.success){
            // 성공 시, 해당 에디터 초기화 및 업데이트된 내용을 디자인에 맞춰 반영
            tinymce.get(editorId).setContent('');
            $("#afterUpdate_" + procsNo).empty();
            let html = "";
            html += "<h5 class='mb-3'>공정 정보</h5>";
            html += "<div style='background: #f9f9f9; border: 1px solid #e0e0e0; border-radius: 4px; padding: 10px; margin-bottom: 10px;'>";
            html += "  <p style='margin: 0; color: #555;'>";
            html += "    <span>" + startDate + " ~ " + endDate + "</span>";
            html += "  </p>";
            html += "  <hr style='margin: 8px 0; border: none; border-top: 1px solid #ddd;' />";
            html += "  <div style='font-size: 0.9rem; color: #444;'>";
            html +=         content;
            html += "  </div>";
            html += "</div>";
            $("#afterUpdate_" + procsNo).html(html);

            // 성공 메시지
            Swal.fire({
                title: "저장 완료!",
                text: "공정 정보가 성공적으로 저장되었습니다.",
                icon: "success",
                confirmButtonText: "확인"
            });

         } else {
           Swal.fire({
               title: "저장 실패!",
               text: response.message,
               icon: "error",
               confirmButtonText: "확인"
           });
         }
       },
       error: function(){
         Swal.fire({
             title: "서버 오류!",
             text: "서버와의 연결에 실패했습니다.",
             icon: "error",
             confirmButtonText: "확인"
         });
       }
    });
});

function openChecklistModal() {
    showChecklistList();
    $("#checklistModal").fadeIn();
    $("#overlay").fadeIn();
    $("body").css("overflow", "hidden");

    let prjctNo = $("#prjctNo").val();
    $.ajax({
        url: '/batirplan/project/safetyCheckList/getAssignedChecklist',
        type: 'GET',
        dataType: 'json',
        data: { prjctNo: prjctNo },
        success: function(response) {
            console.log("Assigned checklist mapping:", response.assignedMap);
            if (response.success) {
                let assignedMap = response.assignedMap;
                for (let procsNo in assignedMap) {
                    if (assignedMap.hasOwnProperty(procsNo)) {
                        console.log("프로세스 번호:", procsNo, "배정된 체크리스트 번호:", assignedMap[procsNo]);
                        let selectBox = $('select.assign-checklist-select[data-procs-no="' + procsNo + '"]');
                        if (selectBox.length > 0) {
                            selectBox.val(assignedMap[procsNo]);
                        }
                    }
                }
            } else {
                console.error("배정 정보 로드 실패: " + response.message);
            }
        },
        error: function() {
            console.error("배정 정보 요청 중 에러 발생");
        }
    });
}

/** 체크리스트 모달 닫기 */
function closeChecklistModal() {
    $("#checklistModal").fadeOut();
    $("#overlay").fadeOut();
    $("body").css("overflow", "auto");
    
}

function showAssignChecklistForm() {
    // 1) 다른 DIV 숨기기
    $("#checklistListDiv").hide();
    $("#newChecklistFormDiv").hide();
    $("#checklistDetailDiv").hide();

    // 2) 배정 DIV 표시
    $("#assignChecklistDiv").fadeIn();

    // 3) 필요하다면, 배정에 필요한 데이터(공정 목록, 체크리스트 목록 등)를 로드
    // loadProcessList();
    // loadChecklistOptions();
}

/** 새 체크리스트 작성 폼 표시 */
function showNewChecklistForm() {
    // 폼 리셋: 모든 입력 필드 초기화하고 detailItemsContainer 초기화
    $("#newChecklistForm")[0].reset();
    $("#detailItemsContainer").empty();

    // 기본 항목 한 줄 추가 (버튼은 "+" 버튼)
    var initialRow = `
      <div class="row mb-3 detail-item">
        <div class="col-sm-11">
          <input type="text" class="form-control" name="detailItems[]" placeholder="세부 항목 입력" required>
        </div>
        <div class="col-sm-1" style="padding-right: 15px;">
          <button type="button" class="btn btn-success btn-sm" onclick="addDetailItem(this)" style="width: 100%; height: 100%;">
            <i class="ti ti-circle-plus"></i>
          </button>
        </div>
      </div>`;
    $("#detailItemsContainer").append(initialRow);

    // 목록 영역 숨기고, 작성 폼 영역 표시
    $("#checklistListDiv").hide();
    $("#checklistDetailDiv").hide();
    $("#assignChecklistDiv").hide();  // 만약 배정 DIV가 있다면 숨김
    $("#newChecklistFormDiv").fadeIn();
}

/** 체크리스트 목록 표시 */
function showChecklistList() {
    // 작성 폼/상세보기/배정 DIV(있다면) 숨기고, 목록만 표시
    $("#newChecklistFormDiv").hide();
    $("#checklistDetailDiv").hide();
    $("#assignChecklistDiv").hide();  // 배정 DIV가 있다면 숨김
    $("#checklistListDiv").fadeIn();

    // 필요 시 목록 갱신
    updateChecklistList();
}

/** 새 체크리스트 저장 (AJAX) */
$("#newChecklistForm").on("submit", function(e) {
    e.preventDefault();

    // 입력값 검증
    let checklistTitle = $("#chklstSj").val().trim();
    let details = $("input[name='detailItems[]']").map(function(){ return $(this).val().trim(); }).get();
    let hasEmptyDetail = details.some(item => item === "");

    if (!checklistTitle) {
        Swal.fire({
            title: "입력 오류!",
            text: "체크리스트 제목을 입력해주세요.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    if (details.length === 0 || hasEmptyDetail) {
        Swal.fire({
            title: "입력 오류!",
            text: "최소 한 개 이상의 세부 항목을 입력해주세요.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    $.ajax({
        url: $(this).attr("action"),   // 예: /batirplan/project/safetyCheckList/save
        type: "POST",
        data: $(this).serialize(),
        success: function(response) {
            if(response.success) {
                // 저장 성공 시 목록 갱신 후 폼 초기화, 목록화면으로 이동
                updateChecklistList();
                $("#chklstSj").val('');
                $("input[name='detailItems[]']").val('');
                showChecklistList();

                // 성공 메시지 표시
                Swal.fire({
                    title: "등록 완료!",
                    text: "체크리스트가 성공적으로 등록되었습니다.",
                    icon: "success",
                    confirmButtonText: "확인"
                });

            } else {
                Swal.fire({
                    title: "등록 실패!",
                    text: "체크리스트 등록에 실패했습니다: " + response.message,
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function() {
            Swal.fire({
                title: "서버 오류!",
                text: "서버와의 통신에 문제가 발생했습니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });
});

function updateChecklistList() {
	  var emplCode = $("#currentEmplCode").val();
	  $.ajax({
	    url: '/batirplan/project/safetyCheckList/list',
	    type: 'GET',
	    data: { emplCode: emplCode },
	    dataType: 'json',
	    success: function(response) {
	      if(response.success) {
	        var checklistList = response.list;

	        // 1) 테이블 갱신
	        var tbody = $("#checklistListDiv tbody");
	        tbody.empty();
	        $.each(checklistList, function(index, checklist) {
	        	var formattedDate = checklist.writngDe.substring(0, 4) + '-' +
                checklist.writngDe.substring(4, 6) + '-' +
                checklist.writngDe.substring(6, 8);
				var row = "<tr>" +
				        "<td style='text-align: center;'>" + checklist.chklstNo + "</td>" +
				        "<td><a href='javascript:void(0);' onclick='viewChecklistDetail(" + checklist.chklstNo + ")'>" 
				            + checklist.chklstSj + "</a></td>" +
				        "<td style='text-align: center;'>" + formattedDate + "</td>" +
				      "</tr>";
				tbody.append(row);
	        });

	        // 2) Select 박스(체크리스트 배정)도 갱신
	        var $assignChecklistSelect = $("#assignChecklistSelect");
	        if ($assignChecklistSelect.length > 0) {
	          $assignChecklistSelect.empty(); 
	          $assignChecklistSelect.append("<option value=''>- 체크리스트를 선택하세요 -</option>");
	          $.each(checklistList, function(i, item) {
	            $assignChecklistSelect.append(
	              "<option value='" + item.chklstNo + "'>" + item.chklstSj + "</option>"
	            );
	          });
	        }

	      } else {
	        console.error("체크리스트 목록 업데이트 실패: " + response.message);
	      }
	    },
	    error: function() {
	      console.error("체크리스트 목록을 가져오는데 실패했습니다.");
	    }
	  });
	}

/** 새 체크리스트 작성 시, 세부 항목 "+" 버튼을 누르면 항목 한 줄 추가 */
function addDetailItem(button) {
    // 현재 버튼을 "+"에서 "-"로 변경하여 삭제 기능으로 전환
    $(button).removeClass('btn-success').addClass('btn-danger btn-sm');
    $(button).html('<i class="ti ti-minus"></i>');
    $(button).attr('onclick', 'removeDetailItem(this)');
    
    // 새로운 항목 행 추가 (우측 버튼은 "+"로 설정)
    var newRow = `
      <div class="row mb-3 detail-item">
        <div class="col-sm-11">
          <input type="text" class="form-control" name="detailItems[]" placeholder="세부 항목 입력" required>
        </div>
        <div class="col-sm-1" style="padding-right: 15px;">
          <button type="button" class="btn btn-success btn-sm" onclick="addDetailItem(this)" style="width: 100%; height: 100%;">
            <i class="ti ti-circle-plus"></i>
          </button>
        </div>
      </div>`;
    $("#detailItemsContainer").append(newRow);
}

/** "-" 버튼을 누르면 항목 한 줄 제거 */
function removeDetailItem(button) {
    // 해당 항목 행 제거
    $(button).closest('.detail-item').remove();
    
    // 남은 항목 중 마지막 행의 버튼을 "+"로 전환
    var rows = $("#detailItemsContainer .detail-item");
    if(rows.length > 0) {
       var lastRowButton = $(rows[rows.length - 1]).find('button');
       lastRowButton.removeClass('btn-danger').addClass('btn-success btn-sm');
       lastRowButton.html('<i class="ti ti-circle-plus"></i>');
       lastRowButton.attr('onclick', 'addDetailItem(this)');
    }
}

/** 체크리스트 상세보기 (AJAX) */
function viewChecklistDetail(chklstNo) {
    $.ajax({
        url: '/batirplan/project/safetyCheckList/detailAjax/' + chklstNo,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                // 1) 목록/작성 영역 숨기기
                $("#checklistListDiv").hide();
                $("#newChecklistFormDiv").hide();
                $("#assignChecklistDiv").hide();  // 배정 DIV 숨기기

                // 2) 데이터 추출
                let data = response.checklist;     // { chklstNo, chklstSj, writngDe, emplCode, ... }
                let items = response.detailItems;  // ["항목1", "항목2", ...]

                // 3) 테이블 형식 HTML 구성
                let detailHtml = "<h5 class='mb-3' style='text-align: center;'>체크리스트 상세보기</h5>";
                detailHtml += "<table class='table table-bordered'><tbody>";

                // 제목
                detailHtml += "<tr>";
                detailHtml += "  <th style='width:20%;'>제목</th>";
                detailHtml += "  <td>" + data.chklstSj + "</td>";
                detailHtml += "</tr>";

                // 작성일 포맷 변경
                var formattedWritngDe = "";
                if (data.writngDe && data.writngDe.length === 8) {
                    formattedWritngDe = data.writngDe.substring(0, 4) + '-' +
                                        data.writngDe.substring(4, 6) + '-' +
                                        data.writngDe.substring(6, 8);
                } else {
                    formattedWritngDe = data.writngDe;
                }

                detailHtml += "<tr>";
                detailHtml += "  <th>작성일</th>";
                detailHtml += "  <td>" + formattedWritngDe + "</td>";
                detailHtml += "</tr>";

                // 작성자
                detailHtml += "<tr>";
                detailHtml += "  <th>작성자</th>";
                detailHtml += "  <td>" + data.emplNm + "</td>";
                detailHtml += "</tr>";

                // 세부 항목
                detailHtml += "<tr>";
                detailHtml += "  <th>세부 항목</th>";
                detailHtml += "  <td><ul style='margin:0;'>";
                for (let i = 0; i < items.length; i++) {
                    detailHtml += "<li>" + items[i] + "</li>";
                }
                detailHtml += "</ul></td>";
                detailHtml += "</tr>";

                detailHtml += "</tbody></table>";

                // 목록 버튼
                detailHtml += "<div style='text-align: center;'>";
                detailHtml += "<button type='button' class='btn btn-secondary' onclick='showChecklistList()'>목록</button>";
                detailHtml += "</div>";

                // 4) #checklistDetailDiv 에 삽입 & 표시
                $("#checklistDetailDiv").html(detailHtml).show();

            } else {
                Swal.fire({
                    title: "조회 실패!",
                    text: "체크리스트 상세 조회에 실패했습니다.",
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function() {
            Swal.fire({
                title: "서버 오류!",
                text: "서버와의 통신에 실패했습니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });
}

function assignChecklist(procsNo) {
    let selectBox = $('select.assign-checklist-select[data-procs-no="' + procsNo + '"]');
    
    if (!selectBox.length) {
        Swal.fire({
            title: "배정 오류!",
            text: "공정 정보를 찾을 수 없습니다.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    let chklstNo = selectBox.val();
    let prjctNo = $("#prjctNo").val();

    if (!chklstNo) {
        Swal.fire({
            title: "배정 오류!",
            text: "배정할 체크리스트를 선택해주세요.",
            icon: "warning",
            confirmButtonText: "확인"
        });
        return;
    }

    $.ajax({
        url: '/batirplan/project/safetyCheckList/assign/process',
        type: 'POST',
        dataType: 'json',
        data: {
            procsNo: procsNo,
            chklstNo: chklstNo,
            prjctNo: prjctNo
        },
        success: function(response) {
            if (response.success) {
                // 체크리스트 배정이 완료되었을 때
                if (response.complete) {
                    Swal.fire({
                        title: "계획 완료!",
                        text: "프로젝트 계획이 완료되었습니다.",
                        icon: "success",
                        confirmButtonText: "확인"
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    updateAssignmentDisplay();
                    Swal.fire({
                        title: "배정 완료!",
                        text: "체크리스트가 공정에 배정되었습니다.",
                        icon: "success",
                        confirmButtonText: "확인"
                    });
                }
            } else {
                Swal.fire({
                    title: "배정 실패!",
                    text: response.message,
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function() {
            Swal.fire({
                title: "서버 오류!",
                text: "서버와의 통신에 실패했습니다.",
                icon: "error",
                confirmButtonText: "확인"
            });
        }
    });
}

function updateAssignmentDisplay() {
	  $.ajax({
	    url: '/batirplan/project/safetyCheckList/getAssignmentStatus',
	    type: 'GET',
	    dataType: 'json',
	    data: { prjctNo: $("#prjctNo").val() },
	    success: function(response) {
	      if(response.success) {
	        // response.assignmentStatus 같은 객체에 공정별 배정 정보가 있다고 가정하고,
	        // 이 정보를 이용해 모달 내부의 assignment 정보를 업데이트합니다.
	        let html = "";
	        $.each(response.assignmentStatus, function(processNo, status) {
	          html += "<div><strong>" + status.order + ". " + status.processName + "</strong> : ";
	          html += status.checklistAssigned ? status.checklistTitle : '<i class="ti ti-alert-circle text-danger fs-6"></i> 체크리스트 미배정';
	          html += "</div>";
	        });
	        $("#assignmentStatusContainer").html(html);
	      }
	    },
	    error: function() {
	      console.error("배정 정보 업데이트 실패");
	    }
	  });
	}

function deleteAssignedChecklist(procsNo) {
    let prjctNo = $("#prjctNo").val();

    Swal.fire({
        title: "배정 삭제 확인",
        text: "해당 체크리스트 배정을 삭제하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "삭제",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: '/batirplan/project/safetyCheckList/deleteAssignment',
                type: 'POST',
                dataType: 'json',
                data: {
                    prjctNo: prjctNo,
                    procsNo: procsNo
                },
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            title: "삭제 완료!",
                            text: "배정이 삭제되었습니다.",
                            icon: "success",
                            confirmButtonText: "확인"
                        });

                        // 삭제 후 select box의 선택값 초기화
                        $('select.assign-checklist-select[data-procs-no="' + procsNo + '"]').val("");
                    } else {
                        Swal.fire({
                            title: "삭제 실패!",
                            text: response.message,
                            icon: "error",
                            confirmButtonText: "확인"
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        title: "서버 오류!",
                        text: "서버와의 통신에 실패했습니다.",
                        icon: "error",
                        confirmButtonText: "확인"
                    });
                }
            });
        }
    });
}

function declarationWriteForm(prjctNo) {
    window.location.href = '/batirplan/project/declaration/write/' + prjctNo;
}

window.onload = function() {
    displayMap(); // 지도 표시 함수 호출
	updateStepDisplay();
}

document.addEventListener("DOMContentLoaded", function() {
    const today = new Date().toISOString().split("T")[0]; // "YYYY-MM-DD" 형식
    document.querySelectorAll('input[type="date"]').forEach(function(input) {
      input.setAttribute('min', today);
    });
  });

tinymce.init({
    selector: 'textarea.process-content',
    forced_root_block: '',
    force_br_newlines: true,
    force_p_newlines: false,
    height: 200,
    menubar: false,
    plugins: [
        'advlist autolink lists link image charmap print preview anchor',
        'searchreplace visualblocks code fullscreen',
        'insertdatetime media table paste code help wordcount'
    ],
    toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help'
});

</script>

</html>